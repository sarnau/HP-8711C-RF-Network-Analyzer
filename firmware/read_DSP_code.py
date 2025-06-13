#!/usr/bin/env python3

import binascii
import struct
import sys
data = open('08712-80033 C.01.000.bin', 'rb').read()

# 1. find all memory blocks written into the DSP
DSP_MEM_BASE = 0xFFD0_0000
DSP_REG_BASE = 0xC000_0000
dsp_mem = bytearray([0x00]*(0x1_0000_0000 - DSP_MEM_BASE))
BASE = 0x00007558
while True:
	adr,l = struct.unpack('>LL', data[BASE:BASE+8])
	if l == 0xFFFF_FFFF:
		break
	if adr >= DSP_MEM_BASE:
		for i in range(0,l*2,2):
			w = struct.unpack('>H', data[BASE+8+i:BASE+8+i+2])[0]
			dsp_mem[adr - DSP_MEM_BASE + i*8]     = w >> 8
			dsp_mem[adr - DSP_MEM_BASE + i*8 + 1] = w & 0xFF
	elif adr >= DSP_REG_BASE and adr < DSP_REG_BASE + 0x1000:
		DSP_REGS = struct.unpack('>%dH' % l, data[BASE+8:BASE+8+l*2])
	#print('%08Xh:$%04X %s' % (adr,l, binascii.hexlify(data[BASE+8:BASE+8+2*l]).decode('ascii')[:64]))
	BASE += 8 + l*2

#open('DSP_MEM_%08X.bin' % DSP_MEM_BASE, 'wb').write(dsp_mem)

def dsp_read_word(adr):
	return struct.unpack('>H', dsp_mem[adr-DSP_MEM_BASE:adr-DSP_MEM_BASE+2])[0]

def dsp_read_long(adr):
	return dsp_read_word(adr) + (dsp_read_word(adr + 16) << 16)


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
				w = dsp_read_word(FONT_BASE + ((ch+chx) * 32 + h) * 16)
				print("{0:016b}".format(w).replace('0',' ').replace('1','#')[::-1],end='')
			print()

dsp_adr = None

def dsp_disass():
	global dsp_adr

	pc = dsp_adr
	op = dsp_read_word(dsp_adr)
	dsp_adr += 16
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
			return '%c%d' % (rf,r)
		else:
			return 'SP'

	def get_src_reg():
		return get_reg(rs)

	def get_des_reg():
		return get_reg(rd)

	def get_src_des_reg():
		return get_src_reg() + ',' + get_des_reg()

	def get_word_parm():
		global dsp_adr
		res = '%Xh' % dsp_read_word(dsp_adr)
		dsp_adr += 16
		return res

	def get_word_parm_1s_comp():
		global dsp_adr
		res = '%Xh' % (~dsp_read_word(dsp_adr) & 0xFFFF)
		dsp_adr += 16
		return res

	def get_long_parm():
		global dsp_adr
		res = '%Xh' % dsp_read_long(dsp_adr)
		dsp_adr += 32
		return res

	def get_long_parm_1s_comp():
		global dsp_adr
		res = '%Xh' % (~dsp_read_long(dsp_adr) & 0xFFFFFFFF)
		dsp_adr += 32
		return res

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
		global dsp_adr
		res = '%Xh' % (pc + 32 + word_to_signed(dsp_read_word(dsp_adr)) * 16)
		dsp_adr += 16
		return res

	def get_relative_8bit():
		return '%Xh' % (pc + 16 + byte_to_signed(op & 0xFF) * 16)

	def get_relative_5bit():
		ls = (op >> 5) & 0x1F
		if op & 0x0400:
			ls = -ls
		return '%Xh' % (pc + 16 + (ls << 4))

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
		global dsp_adr
		l = dsp_read_word(dsp_adr)
		dsp_adr += 16
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
			return 'REV    ' + get_des_reg()
		elif subop == 0x0100:
			return 'EMU    '
		elif subop == 0x0120:
			return 'EXGPC  ' + get_des_reg()
		elif subop == 0x0140:
			return 'GETPC  ' + get_des_reg()
		elif subop == 0x0160:
			return 'JUMP   ' + get_des_reg()
		elif subop == 0x0180:
			return 'GETST  ' + get_des_reg()
		elif subop == 0x01a0:
			return 'PUTST  ' + get_des_reg()
		elif subop == 0x01c0:
			return 'POPST  '
		elif subop == 0x01e0:
			return 'PUSHST '
	elif om == 0x0200:
		if subop == 0x0100:
			return 'NOP    '
		elif subop == 0x0120:
			return 'CLRC   '
		elif subop == 0x0140:
			return 'MOVEB  @%s,@%s' % (get_long_parm(),get_long_parm())
		elif subop == 0x0160:
			return 'DINT   '
		elif subop == 0x0180:
			return 'ABS    ' + get_des_reg()
		elif subop == 0x01a0:
			return 'NEG    ' + get_des_reg()
		elif subop == 0x01c0:
			return 'NEGB   ' + get_des_reg()
		elif subop == 0x01e0:
			return 'NOT    ' + get_des_reg()
	elif (om == 0x0400) or (om == 0x0600):
		if subop == 0x0100:
			return 'SEXT   ' + get_des_reg() + ',' + get_field()
		elif subop == 0x0120:
			return 'ZEXT   ' + get_des_reg() + ',' + get_field()
		elif (subop == 0x0140) or (subop == 0x0160):
			p1 = op & 0x1f
			if p1 == 0:
				p1 = 0x20
			return 'SETF   %Xh,%X,%s' % (p1,(op >> 5) & 1,get_field())
		elif subop == 0x0180:
			return 'MOVE   %s,@%s,%c' % (get_des_reg(),get_long_parm(),get_field())
		elif subop == 0x01a0:
			return 'MOVE   @%s,%s,%c' % (get_long_parm(),get_des_reg(),get_field())
		elif subop == 0x01c0:
			return 'MOVE   @%s,@%s,%c' % (get_long_parm(),get_long_parm(),get_field())
		elif subop == 0x01e0:
			if op & 0x0200:
				return 'MOVE   @%s,%s' % (get_long_parm(),get_des_reg())
			else:
				return 'MOVB   %s,@%s' % (get_des_reg(),get_long_parm())
	elif om == 0x0800:
		if subop == 0x0100:
			return 'TRAP   %Xh' % (op & 0x1F)
		elif subop == 0x0120:
			return 'CALL   %s' % (get_des_reg())
		elif subop == 0x0140:
			return 'RETI   '
		elif subop == 0x0160:
			if op & 0x1F:
				return 'RETS   %Xh' % (op & 0x1F)
			else:
				return 'RETS   '
		elif subop == 0x0180:
			return 'MMTM   %s,%s' % (get_des_reg(),get_reg_list(True))
		elif subop == 0x01a0:
			return 'MMFM   %s,%s' % (get_des_reg(),get_reg_list(False))
		elif subop == 0x01c0:
			return 'MOVI   %s,%s' % (get_word_parm(),get_des_reg())
		elif subop == 0x01e0:
			return 'MOVI   %s,%s' % (get_long_parm(),get_des_reg())
	elif om == 0x0a00:
		if subop == 0x0100:
			return 'ADDI   %s,%s' % (get_word_parm(),get_des_reg())
		elif subop == 0x0120:
			return 'ADDI   %s,%s' % (get_long_parm(),get_des_reg())
		elif subop == 0x0140:
			return 'CMPI   %s,%s' % (get_word_parm_1s_comp(),get_des_reg())
		elif subop == 0x0160:
			return 'CMPI   %s,%s' % (get_long_parm_1s_comp(),get_des_reg())
		elif subop == 0x0180:
			return 'ANDI   %s,%s' % (get_long_parm_1s_comp(),get_des_reg())
		elif subop == 0x01a0:
			return 'ORI    %s,%s' % (get_long_parm(),get_des_reg())
		elif subop == 0x01c0:
			return 'XORI   %s,%s' % (get_long_parm(),get_des_reg())
		elif subop == 0x01e0:
			return 'SUBI   %s,%s' % (get_word_parm_1s_comp(),get_des_reg())
	elif om == 0x0c00:
		if subop == 0x0100:
			return 'SUBI   %s,%s' % (get_long_parm_1s_comp(),get_des_reg())
		elif subop == 0x0120:
			return 'CALLR  %s' % (get_relative())
		elif subop == 0x0140:
			return 'CALLA  %s' % (get_long_parm())
		elif subop == 0x0160:
			return 'EINT     '
		elif subop == 0x0180:
			return 'DSJ    %s,%s' % (get_des_reg(),get_relative())
		elif subop == 0x01a0:
			return 'DSJEQ  %s,%s' % (get_des_reg(),get_relative())
		elif subop == 0x01c0:
			return 'DSJNE  %s,%s' % (get_des_reg(),get_relative())
		elif subop == 0x01a0:
			return 'SETC   '
	elif om == 0x0e00:
		if subop == 0x0100:
			return 'PIXBLT L,L'
		elif subop == 0x0120:
			return 'PIXBLT L,XY'
		elif subop == 0x0140:
			return 'PIXBLT XY,L'
		elif subop == 0x0160:
			return 'PIXBLT XY,XY'
		elif subop == 0x0180:
			return 'PIXBLT B,L'
		elif subop == 0x01a0:
			return 'PIXBLT B,XY'
		elif subop == 0x01c0:
			return 'FILL   L'
		elif subop == 0x01e0:
			return 'FILL   XY'

	elif om == 0x1000 or om == 0x1200:
		if (op & 0x03e0) != 0x0020:
			return 'ADDK   %s,%s' % (get_constant_1_32(),get_des_reg())
		else:
			return 'INC    %s' % (get_des_reg())
	elif om == 0x1400 or om == 0x1600:
		if (op & 0x03e0) != 0x0020:
			return 'SUBK   %s,%s' % (get_constant_1_32(),get_des_reg())
		else:
			return 'DEC    %s' % (get_des_reg())
	elif om == 0x1800 or om == 0x1a00:
		return 'MOVK   %s,%s' % (get_constant_1_32(),get_des_reg())
	elif om == 0x1c00 or om == 0x1e00:
		return 'BTST   %s,%s' % (get_constant_1s_comp(),get_des_reg())

	elif om == 0x2000 or om == 0x2200:
		return 'SLA    %s,%s' % (get_constant(),get_des_reg())
	elif om == 0x2400 or om == 0x2600:
		return 'SLL    %s,%s' % (get_constant(),get_des_reg())
	elif om == 0x2800 or om == 0x2a00:
		return 'SRA    %s,%s' % (get_constant_2s_comp(),get_des_reg())
	elif om == 0x2c00 or om == 0x2e00:
		return 'SRL    %s,%s' % (get_constant_2s_comp(),get_des_reg())

	elif om == 0x3000 or om == 0x3200:
		return 'RL     %s,%s' % (get_constant(),get_des_reg())
	elif om == 0x3800 or om == 0x3a00 or om == 0x3c00 or om == 0x3e00:
		return 'DSJS   %s,%s' % (get_des_reg(),get_relative_5bit())

	elif om == 0x4000:
		return 'ADD    %s' % (get_src_des_reg())
	elif om == 0x4200:
		return 'ADDC   %s' % (get_src_des_reg())
	elif om == 0x4400:
		return 'SUB    %s' % (get_src_des_reg())
	elif om == 0x4600:
		return 'SUBB   %s' % (get_src_des_reg())
	elif om == 0x4800:
		return 'CMP    %s' % (get_src_des_reg())
	elif om == 0x4a00:
		return 'BTST   %s' % (get_src_des_reg())
	elif om == 0x4c00 or om == 0x4e00:
		if (op & 0x0200) == 0x0000:
			return 'MOVE   %s' % (get_src_des_reg())
		else:
			sstr = get_src_reg()
			if rf == 'A':
				rf = 'B'
			else:
				rf = 'A'
			dstr = get_des_reg()
			return 'MOVE   %s,%s' % (sstr, dstr)

	elif om == 0x5000:
		return 'AND    %s' % (get_src_des_reg())
	elif om == 0x5200:
		return 'ANDN   %s' % (get_src_des_reg())
	elif om == 0x5400:
		return 'OR     %s' % (get_src_des_reg())
	elif om == 0x5600:
		if rs != rd:
			return 'XOR    %s' % (get_src_des_reg())
		else:
			return 'CLR    %s' % (get_des_reg())
	elif om == 0x5800:
		return 'DIVS   %s' % (get_src_des_reg())
	elif om == 0x5a00:
		return 'DIVU   %s' % (get_src_des_reg())
	elif om == 0x5c00:
		return 'MPYS   %s' % (get_src_des_reg())
	elif om == 0x5e00:
		return 'MPYU   %s' % (get_src_des_reg())

	elif om == 0x6000:
		return 'SLA    %s' % (get_src_des_reg())
	elif om == 0x6200:
		return 'SLL    %s' % (get_src_des_reg())
	elif om == 0x6400:
		return 'SRA    %s' % (get_src_des_reg())
	elif om == 0x6600:
		return 'SRL    %s' % (get_src_des_reg())
	elif om == 0x6800:
		return 'RL     %s' % (get_src_des_reg())
	elif om == 0x6a00:
		return 'LMO    %s' % (get_src_des_reg())
	elif om == 0x6c00:
		return 'MODS   %s' % (get_src_des_reg())
	elif om == 0x6e00:
		return 'MODU   %s' % (get_src_des_reg())

	elif om == 0x8000 or om == 0x8200:
		return 'MOVE   %s,*%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x8400 or om == 0x8600:
		return 'MOVE   *%s,%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x8800 or om == 0x8a00:
		return 'MOVE   *%s,*%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x8c00:
		return 'MOVB   %s,*%s' % (get_src_reg(),get_des_reg())
	elif om == 0x8e00:
		return 'MOVB   *%s' % (get_src_des_reg())

	elif om == 0x9000 or om == 0x9200:
		return 'MOVE   %s,*%s+,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x9400 or om == 0x9600:
		return 'MOVE   *%s+,%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x9800 or om == 0x9a00:
		return 'MOVE   *%s+,*%s+,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0x9c00:
		return 'MOVB   *%s,*%s' % (get_src_reg(),get_des_reg())

	elif om == 0xa000 or om == 0xa200:
		return 'MOVE   %s,-*%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0xa400 or om == 0xa600:
		return 'MOVE   -*%s,%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0xa800 or om == 0xaa00:
		return 'MOVE   -*%s,-*%s,%s' % (get_src_reg(),get_des_reg(),get_field())
	elif om == 0xac00:
		return 'MOVB   %s,*%s(%s)' % (get_src_reg(),get_des_reg(),get_word_parm())
	elif om == 0xae00:
		return 'MOVB   *%s(%s),%s' % (get_src_reg(),get_word_parm(),get_des_reg())

	elif om == 0xb000 or om == 0xb200:
		return 'MOVE   %s,*%s(%s),%s' % (get_src_reg(),get_des_reg(),get_word_parm(),get_field())
	elif om == 0xb400 or om == 0xb600:
		return 'MOVE   *%s(%s),%s,%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_field())
	elif om == 0xb800 or om == 0xba00:
		return 'MOVE   *%s(%s),*%s(%s),%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_word_parm(),get_field())
	elif om == 0xbc00:
		return 'MOVB   *%s(%s),*%s(%s)' % (get_src_reg(),get_word_parm(),get_des_reg(),get_word_parm())

	elif om == 0xc000 or om == 0xc200 or om == 0xc400 or om == 0xc600 or om == 0xc800 or om == 0xca00 or om == 0xcc00 or om == 0xce00:
		if (op & 0xFF) == 0x80:
			cs = 'JA'
		else:
			cs = 'JR'
		jrt = ['  ','P ','LS','HI','LT','GE','LE','GT','C ','NC','EQ','NE','V ','NV','N ','NN']
		cs += jrt[(op & 0x0f00) >> 8]
		cs += '   '
		if (op & 0xFF) == 0x00:
			return cs + '%s' % (get_relative())
		elif (op & 0xFF) == 0x80:
			return cs + '%s' % (get_long_parm())
		else:
			return cs + '%s' % (get_relative_8bit())

	elif om == 0xd000 or om == 0xd200:
		return 'MOVE   *%s(%s),*%s+,%s' % (get_src_reg(),get_word_parm(),get_des_reg(),get_field())
	elif om == 0xd400 or om == 0xd600:
		if subop == 0x0000:
			return 'MOVE @%s,*%s+,%s' % (get_long_parm(),get_des_reg(),get_field())
		elif subop == 0x0100:
			return 'EXGF %s,%s' % (get_des_reg(),get_field())
	elif om == 0xde00:
		if subop == 0x0100:
			return 'LINE 0'
		elif subop == 0x0180:
			return 'LINE 1'

	elif om == 0xe000:
		return 'ADDXY  %s' % (get_src_des_reg())
	elif om == 0xe200:
		return 'SUBXY  %s' % (get_src_des_reg())
	elif om == 0xe400:
		return 'CMPXY  %s' % (get_src_des_reg())
	elif om == 0xe600:
		return 'CPW    %s' % (get_src_des_reg())
	elif om == 0xe800:
		return 'CVXYL  %s' % (get_src_des_reg())
	elif om == 0xec00:
		return 'MOVX   %s' % (get_src_des_reg())
	elif om == 0xee00:
		return 'MOVY   %s' % (get_src_des_reg())

	elif om == 0xf000:
		return 'PIXT   %s,*%s,XY' % (get_src_reg(),get_des_reg())
	elif om == 0xf200:
		return 'PIXT   *%s,XY,%s' % (get_src_reg(),get_des_reg())
	elif om == 0xf400:
		return 'PIXT   *%s,XY,*%s,XY' % (get_src_reg(),get_des_reg())
	elif om == 0xf600:
		return 'DRAV   %s' % (get_src_des_reg())
	elif om == 0xf800:
		return 'PIXT   %s,*%s' % (get_src_reg(),get_des_reg())
	elif om == 0xfa00:
		return 'PIXT   *%s' % (get_src_des_reg())
	elif om == 0xfc00:
		return 'PIXT   *%s,*%s' % (get_src_reg(),get_des_reg())

	return '.word    %04Xh' % (op & 0xffff)

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
	return trapName

LABELS = {}
DSP_TRAP_BASE = 0xFFFF_FC00
for trap in range(32):
	trapAdr = DSP_TRAP_BASE + (31-trap) * 32
	trapDest = dsp_read_long(trapAdr)
	#print('%08Xh: %-8s => %08X' % (trapAdr, trapName(trap), trapDest))
	if trapDest not in LABELS:
		LABELS[trapDest] = trapName(trap)

# 3. disassemble the full firmware
TABLE = set()
TABLE.add(0xffdb3fe0)
TABLE.add(0xffdb3220)
TABLE.add(0xffdb32b0)

PRINT_DATA = True

# print the other non-code segments
if PRINT_DATA:
	print('04200000h: .word 0')
	for r in range(len(DSP_REGS)):
		print('%08Xh: .word %04Xh' % (DSP_REG_BASE+r*2*16, DSP_REGS[r]))
	print('ffda0000h: .bss 512*8')

def disass_line():
	global dsp_adr
	pc = dsp_adr
	opcode = dsp_read_word(dsp_adr)
	addLF = True
	while opcode == 0x0000:
		dsp_adr += 16
		opcode = dsp_read_word(dsp_adr)
	if dsp_adr != pc:
		dstr = '.bss     %d*2*8' % ((dsp_adr-pc)//16)
	elif dsp_adr >= 0xffdb29a0 and dsp_adr < 0xffdb3220:
		adr = dsp_read_long(dsp_adr)
		dsp_adr += 32
		if adr >= 0xffdb3220 and adr < 0xffdb44d0:
			TABLE.add(adr)
		dstr = '.long    %08Xh' % (adr)
	elif dsp_adr >= 0xFFDAADD0 and dsp_adr < 0xFFDAAF50:
		adr = dsp_read_long(dsp_adr)
		dsp_adr += 32
		dstr = '.long    %08Xh' % (adr)
	elif dsp_adr in TABLE:
		wc = dsp_read_word(dsp_adr)
		dsp_adr += 16
		ww = ['%04Xh' % (wc)]
		for i in range(wc):
			ww.append('%04Xh' % dsp_read_word(dsp_adr))
			dsp_adr += 16
		dstr = '.word    %s' % ','.join(ww)
	else:
		dstr = dsp_disass()
		addLF = False
		if dstr.startswith('RETS') or dstr.startswith('RETI') or dstr.startswith('JR ') or dstr.startswith('JUMP'):
			addLF = True
	l = dsp_adr - pc
	ww = []
	for i in range(0, l, 16):
		ww.append('%04X' % dsp_read_word(pc + i))
	print('%08Xh: %-24s %s' % (pc, ' '.join(ww)[:24], dstr))
	if addLF:
		print()
	return dstr

dsp_adr = 0xffda8000
while (dsp_adr-0xffda8000)//16 < 0x126a:
	if dsp_adr in LABELS:
		print('=' * 80)
		print('= %s' % LABELS[dsp_adr])
		print('=' * 80)
	disass_line()

# print the other non-code segments
if PRINT_DATA:
	print()
	for r in range(0,0x15C,2):
		adr = 0xffdc8000+r*16
		print('%08Xh: .long %08Xh' % (adr, dsp_read_long(adr)))
	print('ffdd0000h: .bss 256*2*8')
	print('ffdd1000h: .bss 11*2*8')
	print('ffdd8000h: .bss 16*2*8')
	def print_bytes(adr,size):
		bstr = ''
		for r in range(size):
			w = dsp_read_word(adr + r * 16)
			bstr += ',%02xh,%02xh' % (w >> 8, w & 0xFF)
		print('%08Xh: .byte %s' % (adr, bstr[1:]))
	def print_words(adr,size):
		bstr = ''
		for r in range(size):
			w = dsp_read_word(adr + r * 16)
			bstr += ',%04Xh' % (w)
		print('%08Xh: .word %s' % (adr, bstr[1:]))
	
	print_bytes(0xffde0000,32)
	print_bytes(0xffde0200,32)
	print_bytes(0xffde0400,32)
	print_bytes(0xffde0600,32)
	if False:
		print('FONT_DATA:')
		for ch in range(256):
			adr = 0xffde0800 + ch * 32 * 16
			print('CHAR_%02x:' % ch)
			print_words(adr,32)
	for r in range(0xad):
		adr = 0xffec0800+r*16
		print('%08Xh: .word %04Xh' % (adr, dsp_read_word(adr)))
	for r in range(0,6,2):
		adr = 0xffece000+r*16
		print('%08Xh: .long %08Xh' % (adr, dsp_read_long(adr)))
	print_words(0xffece800,0x0683)
	print()
	for trap in range(32):
		trapAdr = DSP_TRAP_BASE + (31-trap) * 32
		trapDest = dsp_read_long(trapAdr)
		print('%08Xh: %-8s => %08X' % (trapAdr, trapName(trap), trapDest))
