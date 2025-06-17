#!/usr/bin/env python3

import binascii
import struct
import sys
data = open('08712-80033 C.01.000.bin', 'rb').read()

orig_stdout = sys.stdout
f = open('GSP_MEM.asm', 'w')
sys.stdout = f

LABELS = {}

# 1. find all memory blocks written into the GSP
GSP_MEM_BASE = 0xFFD0_0000
GSP_REG_BASE = 0xC000_0000
gsp_mem = bytearray([0x00]*(0x1_0000_0000 - GSP_MEM_BASE))
BASE = 0x00007558
while True:
	adr,l = struct.unpack('>LL', data[BASE:BASE+8])
	if l == 0xFFFF_FFFF:
		break
	if adr >= GSP_MEM_BASE:
		for i in range(0,l*2,2):
			w = struct.unpack('>H', data[BASE+8+i:BASE+8+i+2])[0]
			gsp_mem[adr - GSP_MEM_BASE + i*8]     = w >> 8
			gsp_mem[adr - GSP_MEM_BASE + i*8 + 1] = w & 0xFF
	elif adr >= GSP_REG_BASE and adr < GSP_REG_BASE + 0x1000:
		GSP_REGS = struct.unpack('>%dH' % l, data[BASE+8:BASE+8+l*2])
	#print('%08Xh:$%04X %s' % (adr,l, binascii.hexlify(data[BASE+8:BASE+8+2*l]).decode('ascii')[:64]))
	BASE += 8 + l*2

#open('GSP_MEM_%08X.bin' % GSP_MEM_BASE, 'wb').write(gsp_mem)

def gsp_read_word(adr):
	return struct.unpack('>H', gsp_mem[adr-GSP_MEM_BASE:adr-GSP_MEM_BASE+2])[0]

def gsp_read_long(adr):
	return gsp_read_word(adr) + (gsp_read_word(adr + 16) << 16)


if False:
	# print the build-in font, which seems to be 256 characters, each 16 wide and 22 pixel tall
	FONT_BASE = 0xffde0800
	CHARS_PER_LINE = 8
	for ch in range(0,256,CHARS_PER_LINE):
		for chx in range(CHARS_PER_LINE):
			print('%02x              ' % (ch+chx),end='')
		print
		for h in reversed(range(10,32)):
			for chx in range(CHARS_PER_LINE):
				w = gsp_read_word(FONT_BASE + ((ch+chx) * 32 + h) * 16)
				print("{0:016b}".format(w).replace('0',' ').replace('1','#')[::-1],end='')
			print()

gsp_adr = None

def get_long_parm():
	global gsp_adr
	adr = gsp_read_long(gsp_adr)
	gsp_adr += 32
	if (adr & 0xFFFF_FFF0) in LABELS:
		if adr & 0xf:
			return LABELS[adr & 0xFFFF_FFF0] + '+%d' % (adr & 0xf)
		else:
			return LABELS[adr & 0xFFFF_FFF0]
	return '%08Xh' % adr

def gsp_disass():
	global gsp_adr

	pc = gsp_adr
	op = gsp_read_word(gsp_adr)
	gsp_adr += 16
	subop = op & 0x01e0
	rs = (op >> 5) & 0x0f # Source register
	rd = op & 0x0f        # Destination register
	rf = 'AB'[(op & 0x10) >> 4] # Register file
	om = op & 0xfe00

	def byte_to_signed(byte_value):
		if not 0 <= byte_value <= 255:
			raise ValueError("Input must be in range 0-255")
		return byte_value - 256 if byte_value > 127 else byte_value

	def word_to_signed(word_value):
		if not 0 <= word_value <= 0xFFFF:
			raise ValueError("Input must be in range 0-65535 (16-bit unsigned)")
		return word_value - 0x10000 if word_value > 0x7FFF else word_value

	def get_reg(r):
		if r != 0x0f:
			reg = '%c%d' % (rf,r)
			if reg == 'B0':
				reg = 'B0_SADDR'
			elif reg == 'B1':
				reg = 'B1_SPTCH'
			elif reg == 'B2':
				reg = 'B2_DADDR'
			elif reg == 'B3':
				reg = 'B3_DPTCH'
			elif reg == 'B4':
				reg = 'B4_OFFSET'
			elif reg == 'B5':
				reg = 'B5_WSTART'
			elif reg == 'B6':
				reg = 'B6_WEND'
			elif reg == 'B7':
				reg = 'B7_DVDX'
			elif reg == 'B8':
				reg = 'B8_COLOR0'
			elif reg == 'B9':
				reg = 'B9_COLOR1'
			elif reg == 'B10':
				reg = 'B10_COUNT'
			elif reg == 'B11':
				reg = 'B11_INC1'
			elif reg == 'B12':
				reg = 'B12_INC2'
			elif reg == 'B13':
				reg = 'B13_PATTRN'
			elif reg == 'B14':
				reg = 'B14_TEMP'
		else:
			reg = 'SP'
		return reg

	def get_src_reg():
		return get_reg(rs)

	def get_des_reg():
		return get_reg(rd)

	def get_src_des_reg():
		return get_src_reg() + ',' + get_des_reg()

	def get_word_parm():
		global gsp_adr
		res = '%Xh' % gsp_read_word(gsp_adr)
		gsp_adr += 16
		return res

	def get_word_parm_1s_comp():
		global gsp_adr
		res = '%Xh' % (~gsp_read_word(gsp_adr) & 0xFFFF)
		gsp_adr += 16
		return res

	def get_long_parm_1s_comp():
		global gsp_adr
		adr = ~gsp_read_long(gsp_adr) & 0xFFFFFFFF
		gsp_adr += 32
		if adr in LABELS:
			return LABELS[adr]
		return '%Xh' % adr

	def get_constant():
		constant = (op >> 5) & 0x1F
		return '%Xh' % constant

	def get_constant_1_32():
		constant = (op >> 5) & 0x1F
		if constant == 0x00:
			constant = 0x20
		return '%Xh' % constant

	def get_constant_1s_comp():
		constant = (~op >> 5) & 0x1F
		return '%Xh' % constant

	def get_constant_2s_comp():
		constant = 32 - ((op >> 5) & 0x1F)
		return '%Xh' % constant

	def get_relative():
		global gsp_adr
		adr = (pc + 32 + word_to_signed(gsp_read_word(gsp_adr)) * 16)
		gsp_adr += 16
		if adr in LABELS:
			return LABELS[adr]
		return '%Xh' % adr

	def get_relative_8bit():
		adr = (pc + 16 + byte_to_signed(op & 0xFF) * 16)
		if adr in LABELS:
			return LABELS[adr]
		return '%Xh' % adr

	def get_relative_5bit():
		ls = (op >> 5) & 0x1F
		if op & 0x0400:
			ls = -ls
		adr = (pc + 16 + (ls << 4))
		if adr in LABELS:
			return LABELS[adr]
		return '%Xh' % adr

	def get_field():
		return '01'[(op & 0x200) >> 9]

	def get_reg_list_range(first, last):
		if first != -1  and first != last:
			if (last - first) == 1:
				return ',' + get_reg(last)
			else:
				return '-' + get_reg(last)
		return ''
	
	def get_reg_list(rev):
		first = -1
		last = 0
		global gsp_adr
		l = gsp_read_word(gsp_adr)
		gsp_adr += 16
		ret = ''
	
		for i in range(16):
			if rev:
				moved = l & 0x8000
				l <<= 1
			else:
				moved = l & 0x01
				l >>= 1
			if moved:
				if first == -1:
					ret += ',' + get_reg(i)
					first = i
				last = i
			else:
				ret += get_reg_list_range(first, last)
				first = -1
		ret += get_reg_list_range(first, last)
		return ret[1:]

	if om == 0x0000:
		if subop == 0x0020:
			return ('REV', get_des_reg(), 'Find TMS3401 0 revision level')
		elif subop == 0x0100:
			return ('EMU', None, 'Initiate emulation')
		elif subop == 0x0120:
			return ('EXGPC', get_des_reg(), 'Exchange program counter with register')
		elif subop == 0x0140:
			return ('GETPC', get_des_reg(), 'Get program counter into register')
		elif subop == 0x0160:
			return ('JUMP', get_des_reg(), 'Jump indirect')
		elif subop == 0x0180:
			return ('GETST', get_des_reg(), 'Get status register into register')
		elif subop == 0x01a0:
			return ('PUTST', get_des_reg(), 'Copy register into status')
		elif subop == 0x01c0:
			return ('POPST', None, 'Pop status register from stack')
		elif subop == 0x01e0:
			return ('PUSHST', None, 'Push status register onto stack')
	elif om == 0x0200:
		if subop == 0x0100:
			return ('NOP', None, 'No operation')
		elif subop == 0x0120:
			return ('CLRC', None, 'Clear carry')
		elif subop == 0x0140:
			return ('MOVB', '@%s,@%s' % (get_long_parm(),get_long_parm()), 'Move byte, absolute to absolute')
		elif subop == 0x0160:
			return ('DINT', None, 'Disable Interrupts')
		elif subop == 0x0180:
			return ('ABS', get_des_reg(), 'Store absolute value')
		elif subop == 0x01a0:
			return ('NEG', get_des_reg(), 'Negate register')
		elif subop == 0x01c0:
			return ('NEGB', get_des_reg(), 'Negate register with borrow')
		elif subop == 0x01e0:
			return ('NOT', get_des_reg(), 'Complement register')
	elif (om == 0x0400) or (om == 0x0600):
		if subop == 0x0100:
			return ('SEXT', get_des_reg() + ',' + get_field(), 'Sign extend to long')
		elif subop == 0x0120:
			return ('ZEXT', get_des_reg() + ',' + get_field(), 'Zero extend to long')
		elif (subop == 0x0140) or (subop == 0x0160):
			p1 = op & 0x1f
			if p1 == 0:
				p1 = 0x20
			return ('SETF', '%Xh,%X,%s' % (p1,(op >> 5) & 1,get_field()), 'Set field parameters')
		elif subop == 0x0180:
			return ('MOVE', '%s,@%s,%c' % (get_des_reg(),get_long_parm(),get_field()), 'Move field, register to absolute')
		elif subop == 0x01a0:
			return ('MOVE', '@%s,%s,%c' % (get_long_parm(),get_des_reg(),get_field()), 'Move field, absolute to register')
		elif subop == 0x01c0:
			return ('MOVE', '@%s,@%s,%c' % (get_long_parm(),get_long_parm(),get_field()), 'Move field, absolute to absolute')
		elif subop == 0x01e0:
			if op & 0x0200:
				return ('MOVE', '@%s,%s' % (get_long_parm(),get_des_reg()), 'Move field, absolute to register')
			else:
				return ('MOVB', '%s,@%s' % (get_des_reg(),get_long_parm()), 'Move byte, register to absolute')
	elif om == 0x0800:
		if subop == 0x0100:
			return ('TRAP', '%Xh' % (op & 0x1F), 'Software interrupt')
		elif subop == 0x0120:
			return ('CALL', '%s' % (get_des_reg()), 'Call subroutine indirect')
		elif subop == 0x0140:
			return ('RETI', None, 'Return from interrupt')
		elif subop == 0x0160:
			if op & 0x1F:
				return ('RETS', '%Xh' % (op & 0x1F), 'Return from subroutine: *SP+ → PC; SP+32+16N → SP')
			else:
				return ('RETS', None, 'Return from subroutine')
		elif subop == 0x0180:
			return ('MMTM', '%s,%s' % (get_des_reg(),get_reg_list(True)), 'If Register n is in the register list: Rn → -*Rd (repeat for n = 0 to 15)')
		elif subop == 0x01a0:
			return ('MMFM', '%s,%s' % (get_des_reg(),get_reg_list(False)), 'If Register n is in the register list: *Rs+ → Rn (repeat for n = 0 to 15)')
		elif subop == 0x01c0:
			return ('MOVI', '%s,%s' % (get_word_parm(),get_des_reg()), 'Move immediate (16 bits)')
		elif subop == 0x01e0:
			return ('MOVI', '%s,%s' % (get_long_parm(),get_des_reg()), 'Move immediate (32 bits)')
	elif om == 0x0a00:
		if subop == 0x0100:
			return ('ADDI', '%s,%s' % (get_word_parm(),get_des_reg()), 'Add immediate (16 bits)')
		elif subop == 0x0120:
			return ('ADDI', '%s,%s' % (get_long_parm(),get_des_reg()), 'Add immediate (32 bits)')
		elif subop == 0x0140:
			return ('CMPI', '%s,%s' % (get_word_parm_1s_comp(),get_des_reg()), 'Compare immediate (16 bits)')
		elif subop == 0x0160:
			return ('CMPI', '%s,%s' % (get_long_parm_1s_comp(),get_des_reg()), 'Compare immediate (32 bits)')
		elif subop == 0x0180:
			return ('ANDI', '%s,%s' % (get_long_parm_1s_comp(),get_des_reg()), 'AND immediate (32 bits)')
		elif subop == 0x01a0:
			return ('ORI', '%s,%s' % (get_long_parm(),get_des_reg()), 'OR immediate (32 bits)')
		elif subop == 0x01c0:
			return ('XORI', '%s,%s' % (get_long_parm(),get_des_reg()), 'Exclusive OR immediate value (32 bits)')
		elif subop == 0x01e0:
			return ('SUBI', '%s,%s' % (get_word_parm_1s_comp(),get_des_reg()), 'Subtract immediate (16 bits)')
	elif om == 0x0c00:
		if subop == 0x0100:
			return ('SUBI', '%s,%s' % (get_long_parm_1s_comp(),get_des_reg()), 'Subtract immediate (32 bits)')
		elif subop == 0x0120:
			return ('CALLR', '%s' % (get_relative()), 'Call subroutine relative')
		elif subop == 0x0140:
			return ('CALLA', '%s' % (get_long_parm()), 'Call subroutine address')
		elif subop == 0x0160:
			return ('EINT', None, 'Enable Interrupts')
		elif subop == 0x0180:
			return ('DSJ', '%s,%s' % (get_des_reg(),get_relative()), 'Decrement register and skip jump')
		elif subop == 0x01a0:
			return ('DSJEQ', '%s,%s' % (get_des_reg(),get_relative()), 'Conditionally decrement register and skip jump')
		elif subop == 0x01c0:
			return ('DSJNE', '%s,%s' % (get_des_reg(),get_relative()), 'Conditionally decrement register and skip jump')
		elif subop == 0x01a0:
			return ('SETC', None, 'Set carry')
	elif om == 0x0e00:
		if subop == 0x0100:
			return ('PIXBLT', 'L,L', 'Pixel block transfer, linear to linear')
		elif subop == 0x0120:
			return ('PIXBLT', 'L,XY', 'Pixel block transfer, linear to XY')
		elif subop == 0x0140:
			return ('PIXBLT', 'XY,L', 'Pixel block transfer, XY to linear')
		elif subop == 0x0160:
			return ('PIXBLT', 'XY,XY', 'Pixel block transfer, XY to XY')
		elif subop == 0x0180:
			return ('PIXBLT', 'B,L', 'Pixel block transfer, binary to linear')
		elif subop == 0x01a0:
			return ('PIXBLT', 'B,XY', 'Pixel block transfer and expand, binary to XY')
		elif subop == 0x01c0:
			return ('FILL', 'L', 'Fill array with processed pixels, linear')
		elif subop == 0x01e0:
			return ('FILL', 'XY', 'Fill array with processed pixels, XY')

	elif om == 0x1000 or om == 0x1200:
		if (op & 0x03e0) != 0x0020:
			return ('ADDK', '%s,%s' % (get_constant_1_32(),get_des_reg()), 'Add constant (5 bits)')
		else:
			return ('INC', '%s' % (get_des_reg()), 'Increment register')
	elif om == 0x1400 or om == 0x1600:
		if (op & 0x03e0) != 0x0020:
			return ('SUBK', '%s,%s' % (get_constant_1_32(),get_des_reg()), 'Subtract constant (5 bits)')
		else:
			return ('DEC', '%s' % (get_des_reg()), 'Decrement register')
	elif om == 0x1800 or om == 0x1a00:
		return ('MOVK', '%s,%s' % (get_constant_1_32(),get_des_reg()), 'Move constant (5 bits)')
	elif om == 0x1c00 or om == 0x1e00:
		return ('BTST', '%s,%s' % (get_constant_1s_comp(),get_des_reg()), 'Set status on value of: bit K in Rd')

	elif om == 0x2000 or om == 0x2200:
		return ('SLA', '%s,%s' % (get_constant(),get_des_reg()), 'Shift left arithmetic, constant')
	elif om == 0x2400 or om == 0x2600:
		return ('SLL', '%s,%s' % (get_constant(),get_des_reg()), 'Shift left logical, constant')
	elif om == 0x2800 or om == 0x2a00:
		return ('SRA', '%s,%s' % (get_constant_2s_comp(),get_des_reg()), 'Shift right arithmetic, constant')
	elif om == 0x2c00 or om == 0x2e00:
		return ('SRL', '%s,%s' % (get_constant_2s_comp(),get_des_reg()), 'Shift right logical, constant')

	elif om == 0x3000 or om == 0x3200:
		return ('RL', '%s,%s' % (get_constant(),get_des_reg()), 'Rotate left, constant')
	elif om == 0x3800 or om == 0x3a00 or om == 0x3c00 or om == 0x3e00:
		return ('DSJS', '%s,%s' % (get_des_reg(),get_relative_5bit()), 'Decrement register and skip jump short')

	elif om == 0x4000:
		return ('ADD', get_src_des_reg(), 'Add registers')
	elif om == 0x4200:
		return ('ADDC', get_src_des_reg(), 'Add registers with carry')
	elif om == 0x4400:
		return ('SUB', get_src_des_reg(), 'Subtract registers')
	elif om == 0x4600:
		return ('SUBB', get_src_des_reg(), 'Subtract registers with borrow')
	elif om == 0x4800:
		return ('CMP', get_src_des_reg(), 'Compare registers')
	elif om == 0x4a00:
		return ('BTST', get_src_des_reg(), 'Test register bit, register')
	elif om == 0x4c00 or om == 0x4e00:
		if (op & 0x0200) == 0x0000:
			return ('MOVE', get_src_des_reg(), 'Move register to register')
		else:
			sstr = get_src_reg()
			if rf == 'A':
				rf = 'B'
			else:
				rf = 'A'
			dstr = get_des_reg()
			return ('MOVE', '%s,%s' % (sstr, dstr), 'Move register to register')

	elif om == 0x5000:
		return ('AND', get_src_des_reg(), 'AND registers')
	elif om == 0x5200:
		return ('ANDN', get_src_des_reg(), 'AND register with complement')
	elif om == 0x5400:
		return ('OR', get_src_des_reg(), 'OR registers')
	elif om == 0x5600:
		if rs != rd:
			return ('XOR', get_src_des_reg(), 'XOR registers')
		else:
			return ('CLR', get_des_reg(), 'Clear register')
	elif om == 0x5800:
		return ('DIVS', get_src_des_reg(), 'Rd even: Rd:Rd+1/Rs → Rd; Remainder → Rd+1; Rd odd: Rd/Rs → Rd (signed divide)')
	elif om == 0x5a00:
		return ('DIVU', get_src_des_reg(), 'Rd even: Rd:Rd+1/Rs → Rd; Remainder → Rd+1; Rd odd: Rd/Rs → Rd (unsigned divide)')
	elif om == 0x5c00:
		return ('MPYS', get_src_des_reg(), 'Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (signed multiply)')
	elif om == 0x5e00:
		return ('MPYU', get_src_des_reg(), 'Rd even: Rs*Rd → Rd:Rd+1; Rd odd: Rs*Rd → Rd (unsigned multiply)')

	elif om == 0x6000:
		return ('SLA', get_src_des_reg(), 'Shift left arithmetic, register')
	elif om == 0x6200:
		return ('SLL', get_src_des_reg(), 'Shift left logical, register')
	elif om == 0x6400:
		return ('SRA', get_src_des_reg(), 'Shift right arithmetic, register')
	elif om == 0x6600:
		return ('SRL', get_src_des_reg(), 'Shift right logical, register')
	elif om == 0x6800:
		return ('RL', get_src_des_reg(), 'Rotate left. register')
	elif om == 0x6a00:
		return ('LMO', get_src_des_reg(), 'Leftmost one bit')
	elif om == 0x6c00:
		return ('MODS', get_src_des_reg(), 'Modulus signed')
	elif om == 0x6e00:
		return ('MODU', get_src_des_reg(), 'Modulus unsigned')

	elif om == 0x8000 or om == 0x8200:
		return ('MOVE', '%s,*%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. register to indirect')
	elif om == 0x8400 or om == 0x8600:
		return ('MOVE', '*%s,%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. indirect to register')
	elif om == 0x8800 or om == 0x8a00:
		return ('MOVE', '*%s,*%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field, indirect to indirect')
	elif om == 0x8c00:
		return ('MOVB', '%s,*%s' % (get_src_reg(),get_des_reg()), 'Move byte. register to indirect')
	elif om == 0x8e00:
		return ('MOVB', '*%s' % (get_src_des_reg()), 'Move byte. indirect to register')

	elif om == 0x9000 or om == 0x9200:
		return ('MOVE', '%s,*%s+,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. register to indirect (postincrement)')
	elif om == 0x9400 or om == 0x9600:
		return ('MOVE', '*%s+,%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. indirect (postincrement) to register')
	elif om == 0x9800 or om == 0x9a00:
		return ('MOVE', '*%s+,*%s+,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field, indirect (postincrement) to indirect (postincrement)')
	elif om == 0x9c00:
		return ('MOVB', '*%s,*%s' % (get_src_reg(),get_des_reg()), 'Move field, indirect to indirect')

	elif om == 0xa000 or om == 0xa200:
		return ('MOVE', '%s,-*%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. register to indirect (predecrement)')
	elif om == 0xa400 or om == 0xa600:
		return ('MOVE', '-*%s,%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field. indirect (predecrement) to register')
	elif om == 0xa800 or om == 0xaa00:
		return ('MOVE', '-*%s,-*%s,%s' % (get_src_reg(),get_des_reg(),get_field()), 'Move field, indirect (predecrement) to indirect (predecrement)')
	elif om == 0xac00:
		return ('MOVB', '%s,*%s(%s)' % (get_src_reg(),get_des_reg(),get_word_parm()), 'Move byte. register to indirect with offset')
	elif om == 0xae00:
		return ('MOVB', '*%s(%s),%s' % (get_src_reg(),get_word_parm(),get_des_reg()), 'Move byte. indirect with offset to register')

	elif om == 0xb000 or om == 0xb200:
		return ('MOVE', '%s,*%s(%s),%s' % (get_src_reg(),get_des_reg(),get_word_parm(),get_field()), 'Move field, register to indirect with offset')
	elif om == 0xb400 or om == 0xb600:
		return ('MOVE', '*%s(%s),%s,%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_field()), 'Move field, indirect with offset to register')
	elif om == 0xb800 or om == 0xba00:
		return ('MOVE', '*%s(%s),*%s(%s),%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_word_parm(),get_field()), 'Move field, indirect with offset to indirect with offset')
	elif om == 0xbc00:
		return ('MOVB', '*%s(%s),*%s(%s)' % (get_src_reg(),get_word_parm(),get_des_reg(),get_word_parm()), 'Move byte. indirect with offset to indirect with offset')

	elif om == 0xc000 or om == 0xc200 or om == 0xc400 or om == 0xc600 or om == 0xc800 or om == 0xca00 or om == 0xcc00 or om == 0xce00:
		if (op & 0xFF) == 0x80:
			cs = 'JA'
			cmt = 'Jump absolute conditional'
		else:
			cs = 'JR'
			cmt = 'Jump relative conditional'
		jrt = ['  ','P ','LS','HI','LT','GE','LE','GT','C ','NC','EQ','NE','V ','NV','N ','NN']
		cs += jrt[(op & 0x0f00) >> 8]
		cs = cs.strip()
		if (op & 0xFF) == 0x00:
			return (cs, '%s' % (get_relative()), cmt)
		elif (op & 0xFF) == 0x80:
			return (cs, '%s' % (get_long_parm()), cmt)
		else:
			return (cs, '%s' % (get_relative_8bit()), cmt)

	elif om == 0xd000 or om == 0xd200:
		return ('MOVE', '*%s(%s),*%s+,%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_field()), 'Move field, indirect with offset to indirect (postincrement)')
	elif om == 0xd400 or om == 0xd600:
		if subop == 0x0000:
			return ('MOVE', '@%s,*%s+,%s' % (get_long_parm(),get_des_reg(),get_field()), 'Move field, absolute to indirect (postincrement)')
		elif subop == 0x0100:
			return ('EXGF', '%s,%s' % (get_des_reg(),get_field()), 'Exchange field size')
	elif om == 0xde00:
		if subop == 0x0100:
			return ('LINE', '0', 'Perform the inner loop of Bresenham\'s line-drawing algorithm')
		elif subop == 0x0180:
			return ('LINE', '1', 'Perform the inner loop of Bresenham\'s line-drawing algorithm')

	elif om == 0xe000:
		return ('ADDXY', get_src_des_reg(), 'Add registers in XV mode')
	elif om == 0xe200:
		return ('SUBXY', get_src_des_reg(), 'Subtract registers in XY mode')
	elif om == 0xe400:
		return ('CMPXY', get_src_des_reg(), 'Compare X and V halves of registers')
	elif om == 0xe600:
		return ('CPW', get_src_des_reg(), 'Compare point to window')
	elif om == 0xe800:
		return ('CVXYL', get_src_des_reg(), 'Convert XY address to linear address')
	elif om == 0xec00:
		return ('MOVX', get_src_des_reg(), 'Move X half of register')
	elif om == 0xee00:
		return ('MOVY', get_src_des_reg(), 'Move Y half of register')

	elif om == 0xf000:
		return ('PIXT', '%s,*%s,XY' % (get_src_reg(),get_des_reg()), 'Pixel transfer, register to indirect XY')
	elif om == 0xf200:
		return ('PIXT', '*%s,XY,%s' % (get_src_reg(),get_des_reg()), 'Pixel transfer, indirect XY to register')
	elif om == 0xf400:
		return ('PIXT', '*%s,XY,*%s,XY' % (get_src_reg(),get_des_reg()), 'Pixel transfer, indirect XY to indirect XY')
	elif om == 0xf600:
		return ('DRAV', get_src_des_reg(), 'Draw and advance: COLOR1 pixel value → *Rd; RdX+=RsX; RdY+=RsY')
	elif om == 0xf800:
		return ('PIXT', '%s,*%s' % (get_src_reg(),get_des_reg()), 'Pixel transfer, register to indirect')
	elif om == 0xfa00:
		return ('PIXT', '*%s' % (get_src_des_reg()), 'Pixel transfer, indirect to register')
	elif om == 0xfc00:
		return ('PIXT', '*%s,*%s' % (get_src_reg(),get_des_reg()), 'Pixel transfer, indirect to indirect')

	return ('.word', '%04Xh' % (op & 0xffff))

# 2. check all traps of the TI34010
def trapName(trap):
	if trap == 0:
		trapName = 'RESET'
	elif trap == 1:
		trapName = 'INT1'
	elif trap == 2:
		trapName = 'INT2'
	elif trap == 8:
		trapName = 'NMI'
	elif trap == 9:
		trapName = 'HI'
	elif trap == 10:
		trapName = 'DI'
	elif trap == 11:
		trapName = 'WV'
	elif trap == 30:
		trapName = 'ILLOP'
	else:
		trapName = 'TRAP_%d' % (trap)
	return trapName + '_VECTOR'

GSP_TRAP_BASE = 0xFFFF_FC00
for trap in range(32):
	trapAdr = GSP_TRAP_BASE + (31-trap) * 32
	trapDest = gsp_read_long(trapAdr)
	#print('%08Xh: %-8s => %08X' % (trapAdr, trapName(trap), trapDest))
	if trapDest not in LABELS:
		LABELS[trapDest] = trapName(trap)

LABELS[0xC000_0000] = 'HESYNC'
LABELS[0xC000_0010] = 'HEBLNK'
LABELS[0xC000_0020] = 'HSBLNK'
LABELS[0xC000_0030] = 'HTOTAL'
LABELS[0xC000_0040] = 'VESYNC'
LABELS[0xC000_0050] = 'VEBLNK'
LABELS[0xC000_0060] = 'VSBLNK'
LABELS[0xC000_0070] = 'VTOTAL'
LABELS[0xC000_0080] = 'DPYCTL'
LABELS[0xC000_0090] = 'DPYSTRT'
LABELS[0xC000_00A0] = 'DPYINT'
LABELS[0xC000_00B0] = 'CONTROL'
LABELS[0xC000_00C0] = 'HSTDATA'
LABELS[0xC000_00D0] = 'HSTADRH'
LABELS[0xC000_00E0] = 'HSTADRL'
LABELS[0xC000_00F0] = 'HSTCTLL'
LABELS[0xC000_0100] = 'HSTCTLH'
LABELS[0xC000_0110] = 'INTENB'
LABELS[0xC000_0120] = 'INTPEND'
LABELS[0xC000_0130] = 'CONVSP'
LABELS[0xC000_0140] = 'CONVDP'
LABELS[0xC000_0150] = 'PSIZE'
LABELS[0xC000_0160] = 'PMASK'
LABELS[0xC000_0170] = 'REG_0x0170'
LABELS[0xC000_0180] = 'REG_0x0180'
LABELS[0xC000_0190] = 'REG_0x0190'
LABELS[0xC000_01A0] = 'REG_0x01A0'
LABELS[0xC000_01B0] = 'DPYTAP'
LABELS[0xC000_01C0] = 'HCOUNT'
LABELS[0xC000_01D0] = 'VCOUNT'
LABELS[0xC000_01E0] = 'DPYADR'
LABELS[0xC000_01F0] = 'REFCNT'
LABELS[0xFFDA_0000] = 'USERFLAGS'
LABELS[0xFFDD_FDF0] = 'STACK_TOP'

# Command Table
GSP_CMDS = {
2: 'ARC',
4: 'BENCHMARK_TEXT',
6: 'BINARY_MAP',
8: 'CIRCLE',
10: 'COPY_RECTANGLE',
12: 'DOT',
14: 'ERASE_RECTANGLE',
16: 'FILL_CIRCLE',
18: 'FILL_RECTANGLE',
26: 'GRAPHYY_0x1a',
28: 'GRAPHYY_0x1c',
32: 'GRAPHYY_0x20',
36: 'LINE_ABSOLUTE',
38: 'LINE_RELATIVE',
40: 'PIXEL_MAP',
42: 'POLYLINE_ABSOLUTE',
44: 'POLYLINE_RELATIVE',
46: 'TEXT',
48: 'TEXT_UNDERLINE',
50: 'CALL',
52: 'CALL_NOT_USER_FLAG',
54: 'CALL_ON_USER_FLAG',
56: 'JUMP',
58: 'JUMP_NOT_USER_FLAG',
60: 'JUMP_ON_USER_FLAG',
62: 'RETURN',
64: 'SKIP1',
66: 'SKIP2',
68: 'SKIP3',
70: 'SKIP4',
72: 'USER_FLAG_CLEAR',
74: 'USER_FLAG_SET',
76: 'USER_FLAG_TOGGLE ',
78: 'DYNAMIC_FRAME',
80: 'STATIC_FRAME',
82: 'STATIC_FRAME_AND_ERASE',
84: 'GATED_CALL',
86: 'INTERRUPT_HOST',
88: 'NOP',
92: 'SEGMENT_END',
94: 'SEGMENT_END_AND_RETURN',
96: 'SEGMENT_END_AND_JUMP',
98: 'SEGMENT_START',
100: 'STALL',
102: 'SYNC_COPY_STATIC',
104: 'SYNC_DISPLAY_DYNAMIC',
106: 'BENCHMARK_START_0x6a',
108: 'BENCHMARK_START_0x6c',
110: 'CLIP_OFF',
112: 'CLIP_ON',
114: 'CLIP_RECTANGLE',
116: 'MOVE_ABSOLUTE_0x74',
118: 'MOVE_RELATIVE_0x76',
120: 'ORIGIN',
122: 'PEN_BACKGROUND',
124: 'PEN_FOREGROUND',
126: 'PIXEL_OPERATION',
128: 'PIXEL_STRETCH_OFF',
130: 'PIXEL_STRETCH_ON',
132: 'SCALE_FACTOR_0x84',
134: 'SCALE_FACTOR_0x86',
136: 'TEXT_FONT',
138: 'TRANSPARENCY_OFF',
140: 'TRANSPARENCY_ON',
}
LABELS[0x0000_0000] = 'SCREENBASE_0x0000_0000'
LABELS[0x001E_0000] = 'SCREENBASE_0x001E_0000'
LABELS[0x003C_0000] = 'SCREENBASE_0x003C_0000'
LABELS[0xFFDA_86A0] = 'CMD_LOOP'
LABELS[0xFFDA_87A0] = 'ILLEGAL_CMD'
LABELS[0xFFDB_0D50] = 'CLEAR_SCREEN'
LABELS[0xFFDC_8000] = 'CMD_ADR_TABLE'
LABELS[0xFFDD_1000] = 'CMD_STACK'
LABELS[0xFFEC_0800] = 'CURRENT_CMD_PC'
LABELS[0xFFEC_0820] = 'CURRENT_CMD'
LABELS[0xFFEC_08C0] = 'INTERRUPT_HOST_CURRENT_PC'
LABELS[0xFFEC_0920] = 'PIXEL_STRETCH_ENABLED_FLAG'
LABELS[0xFFEC_0940] = 'SCALE_FACTOR_DX_A'
LABELS[0xFFEC_0960] = 'SCALE_FACTOR_DY_A'
LABELS[0xFFEC_0980] = 'SCALE_FACTOR_DX_B'
LABELS[0xFFEC_09A0] = 'SCALE_FACTOR_DY_B'
LABELS[0xFFEC_09E0] = 'ORIGIN_XY'
LABELS[0xFFEC_0A00] = 'CLIP_RECT_XY'
LABELS[0xFFEC_0A20] = 'CLIP_RECT_dXdY'
LABELS[0xFFEC_0A40] = 'CLIP_MIN_XY'
LABELS[0xFFEC_0A60] = 'CLIP_MAX_XY'
LABELS[0xFFEC_0CD0] = 'CURRENT_FONT'
LABELS[0xFFEC_E000] = 'CMD_LIST_PTR'
LABELS[0xFFEC_E800] = 'CMD_BUFFER'

for r in range(0xa9):
	dadr = gsp_read_long(0xffdc8000+r*32)
	if dadr != 0:
		if r in GSP_CMDS:
			LABELS[dadr] = 'COMMAND_%d_%s' % (r,GSP_CMDS[r])
			continue
		if r-1 in GSP_CMDS:
			continue
		if dadr == 0xFFDA_E890:
			LABELS[dadr] = 'COMMAND_IGNORE'
			continue
		if dadr not in LABELS:
			LABELS[dadr] = 'COMMAND_%d' % (r)
		else:
			LABELS[dadr] += '_%d' % (r)

# Font Table
LABELS[0xFFDC_9540] = 'FONTS_TABLES'
LABELS[0xFFDE_0800] = 'FONT_DATA'
for r in range(4):
	dadr = gsp_read_long(0xFFDC9540+r*32)
	if dadr not in LABELS:
		LABELS[dadr] = 'FONT_%d' % (r)

# Input Message
LABELS[0xFFEC_0B80] = 'MSGIN_TABLE'
msgIndex = 0
for r in range(0xad):
	gsp_adr = 0xffec0800+r*16
	if gsp_adr >= 0xFFEC_0B80 and gsp_adr <= 0xFFEC_0C70:
		if (gsp_adr & 0x10) == 0x00:
			dadr = gsp_read_long(gsp_adr)
			if dadr not in LABELS:
				LABELS[dadr] = 'MSGIN_%d' % (msgIndex)
			else:
				LABELS[dadr] += '_%d' % (msgIndex)
			msgIndex += 1

# 3. disassemble the full firmware
TABLE = set()
TABLE.add(0xffdb3fe0)
TABLE.add(0xffdb3220)
TABLE.add(0xffdb32b0)

PRINT_DATA = True

def printAddress(adr):
	if adr in LABELS:
		print('%s:' % LABELS[adr])
	print('%08Xh: ' % adr,end='')

# print the other non-code segments
if PRINT_DATA:
	printAddress(0x04200000)
	print('.word 0')
	for r in range(len(GSP_REGS)):
		printAddress(GSP_REG_BASE+r*16)
		print('.word %04Xh' % (GSP_REGS[r]))
	printAddress(0xffda0000)
	print('.bss 512*8')

def disass_line():
	global gsp_adr
	pc = gsp_adr
	opcode = gsp_read_word(gsp_adr)
	addLF = True
	while opcode == 0x0000:
		gsp_adr += 16
		opcode = gsp_read_word(gsp_adr)
	if gsp_adr != pc:
		dstr = '.bss     %d*2*8' % ((gsp_adr-pc)//16)
	elif gsp_adr >= 0xffdb29a0 and gsp_adr < 0xffdb3220:
		adr = gsp_read_long(gsp_adr)
		gsp_adr += 32
		if adr >= 0xffdb3220 and adr < 0xffdb44d0:
			TABLE.add(adr)
		dstr = '.long    %08Xh' % (adr)
	elif gsp_adr >= 0xFFDAADD0 and gsp_adr < 0xFFDAAF50:
		adr = gsp_read_long(gsp_adr)
		gsp_adr += 32
		dstr = '.long    %08Xh' % (adr)
	elif gsp_adr in TABLE:
		wc = gsp_read_word(gsp_adr)
		gsp_adr += 16
		ww = ['%04Xh' % (wc)]
		for i in range(wc):
			ww.append('%04Xh' % gsp_read_word(gsp_adr))
			gsp_adr += 16
		dstr = '.word    %s' % ','.join(ww)
	else:
		ret = gsp_disass()
		if not isinstance(ret, tuple): # if only a single string is returned, make it a tuple
			ret = (ret,'')
		dstr = '%-7s' % ret[0]
		if ret[1]:
			dstr += '%-20s' % ret[1]
		else:
			dstr += '%-20s' % ''
		if len(ret) >= 3 and ret[2]:
			dstr += ' ; ' + ret[2]
		dstr = dstr.rstrip()
		addLF = False
		if dstr.startswith('RETS') or dstr.startswith('RETI') or dstr.startswith('JR ') or dstr.startswith('JUMP'):
			addLF = True
	l = gsp_adr - pc
	ww = []
	for i in range(0, l, 16):
		ww.append('%04X' % gsp_read_word(pc + i))
	printAddress(pc)
	print('%-24s %s' % (' '.join(ww)[:24], dstr))
	if addLF:
		print()
	return dstr

gsp_adr = 0xffda8000
while (gsp_adr-0xffda8000)//16 < 0x126a:
	if gsp_adr in LABELS:
		print('*' * 80)
		print('* %s' % LABELS[gsp_adr])
		print('*' * 80)
	disass_line()

# print the other non-code segments
if PRINT_DATA:
	print()
	for r in range(0xa9):
		gsp_adr = 0xffdc8000+r*32
		printAddress(gsp_adr)
		print('.long %s' % (get_long_parm()))
	print()

	# Font Table
	for r in range(4):
		gsp_adr = 0xFFDC9540+r*32
		printAddress(gsp_adr)
		print('.long %s' % (get_long_parm()))
	print()
	printAddress(0xffdd0000)
	print('.bss 256*2*8')
	printAddress(0xffdd1000)
	print('.bss 11*2*8')
	printAddress(0xffdd8000)
	print('.bss 16*2*8')
	def print_bytes(adr,size):
		bstr = ''
		for r in range(size):
			w = gsp_read_word(adr + r * 16)
			bstr += ',%02xh,%02xh' % (w >> 8, w & 0xFF)
		printAddress(adr)
		print('.byte %s' % (bstr[1:]))
	def print_words(adr,size):
		bstr = ''
		for r in range(size):
			w = gsp_read_word(adr + r * 16)
			bstr += ',%04Xh' % (w)
		printAddress(adr)
		print('.word %s' % (bstr[1:]))
	print()
	print_bytes(0xffde0000,32)
	print_bytes(0xffde0200,32)
	print_bytes(0xffde0400,32)
	print_bytes(0xffde0600,32)
	print()
	if False:
		for ch in range(256):
			gsp_adr = 0xffde0800 + ch * 32 * 16
			print('CHAR_%02x:' % ch)
			print_words(gsp_adr,32)
	for r in range(0xad):
		gsp_adr = 0xffec0800+r*16
		if gsp_adr >= 0xFFEC_0B80 and gsp_adr <= 0xFFEC_0C70:
			if (gsp_adr & 0x10) == 0x00:
				printAddress(gsp_adr)
				print('.long %s' % (get_long_parm()))
		else:
			printAddress(gsp_adr)
			print('.word %04Xh' % (gsp_read_word(gsp_adr)))
	for r in range(0,6,2):
		gsp_adr = 0xffece000+r*16
		printAddress(gsp_adr)
		print('.long %s' % (get_long_parm()))
	print_words(0xffece800,0x0683)
	print()
	for trap in range(32):
		gsp_adr = GSP_TRAP_BASE + (31-trap) * 32
		printAddress(gsp_adr)
		print('.long %s' % get_long_parm())

sys.stdout = orig_stdout
f.close()
