#!/usr/bin/env python3

import binascii
import struct
import sys

def getString(data,offset):
	s = ''
	while data[offset] != 0:
		s += chr(data[offset])
		offset += 1
	return s

with open('08712-80033.bin', 'rb') as file:
	data = file.read()

	# Copyright string of ROM
	#print(getString(data, 0xCE3))
	if False: # Internal greetings
		BASE = 0xFE0
		while True:
			s = getString(data, BASE)
			for sl in [s[i: i + 16] for i in range(0, len(s), 16)]:
				print(sl)
			BASE += len(s) + 1
			if BASE >= 0x1510:
				break

	if False: # Debugger help
		BASE = 0x21B44
		while True:
			s = getString(data, BASE)
			print(s)
			BASE += len(s) + 1
			if BASE >= 0x22B75:
				break
	# The BC is stored in the Master Stack Pointer (MSP) of the 68030.
	
	lpos = 0x40000
	for r in range(256):
		lpos -= 0x40
		license = data[lpos:lpos+0x40]
		bootConfig,bf_str,oc,serialNumber,macAdr,invbootConfig = struct.unpack('>L10sL12s2x16s12xL',license)
		# check if the bootConfig is matching the inverse one.
		if bootConfig != 0xFFFFFFFF and (bootConfig != invbootConfig ^ 0xFFFFFFFF):
			print('%08x => %08x != ~%08x' % (bootConfig, bootConfig ^ 0xFFFFFFFF, invbootConfig))
		if bootConfig == 0xFFFFFFFF or (bootConfig != invbootConfig ^ 0xFFFFFFFF):
			break
		bf_str = (bf_str.decode('ascii').rstrip('\0') + ' ' * 10)[:11]
		serialNumber = (serialNumber.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		macAdr = (macAdr.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		oc = oc ^ 0xFFFFFFFF
		print('#%2d ADR:%08x => BC:%08x BF:"%s" OC:%08x Serial:"%s" MAC:"%s"' % (r,lpos,bootConfig,bf_str,oc,serialNumber,macAdr))
		bcl = []
		if bootConfig & 1:
			bcl.append('Check for terminal before booting')
		if (bootConfig & 6) == 0:
			bcl.append('Boot from disk')
		elif (bootConfig & 6) == 2:
			bcl.append('Boot to HP-IB monitor')
		elif (bootConfig & 6) == 4:
			bcl.append('Boot from ROM')
		elif (bootConfig & 6) == 6:
			bcl.append('Boot to LAN monitor')
		if bootConfig & 8:
			bcl.append('Cache enabled')
		if bootConfig & 0x10:
			bcl.append('RS232 output')
		if bootConfig & 0x20:
			bcl.append('Long power-on tests')
		if bootConfig & 0x40:
			bcl.append('Power on tests')
		if bootConfig & 0x80:
			bcl.append('Monitor reboot upon exception')
		if bootConfig & 0x100:
			bcl.append('Abort RAM test on first error')
		if bootConfig & 0x200:
			bcl.append('HP-IB ifc resets')
		if bootConfig & 0x400:
			bcl.append('Replace Flash w/ SRAM daugherboard')
		if bootConfig & 0x800:
			bcl.append('moveDataSeg(1)/noMove(0) on hp-ib/disk loads')
		if bootConfig & 0x1000:
			bcl.append('Output test info to RS-232')
		if bootConfig & 0x2000:
			bcl.append('Search floppy for loadable files')
		bcl.append('HP-IB Adr #%d' % ((bootConfig >> (16+0)) & 0x1F))
		bcl.append('HP-IB Disk Adr #%d' % ((bootConfig >> (16+8)) & 0x7))
		bcl.append('HP-IB Disk Unit #%d' % ((bootConfig >> (16+12)) & 0x3))
		# the following two seem to rely on a HW emulator during development
		if bootConfig & 0x80000000:
			bcl.append('HW Emulator')
		if bootConfig & 0x40000000:
			bcl.append('HW Emulator Setup (force 0x1000 option)')
		print('BOOT Config = %s' % ', '.join(bcl))

		ocl = []
		if oc == 0:
			ocl.append('No license')
		else:
			if oc & 0x40000:
				ocl.append('Vector')
			if oc & 0x80000:
				ocl.append('8730A')
			if oc & 0x100000:
				ocl.append('LAN')
			if oc & 0x200000:
				ocl.append('IBASIC')
			if oc & 0x400000:
				ocl.append('Fault/SRL')
		print('License = %s' % ', '.join(ocl))
		print()

def set_bit(value, bit):
    return value | (1<<bit)

def clear_bit(value, bit):
    return value & ~(1<<bit)

d0 = 0x3ffc0
d1 = 15
while True:
	d1 -= 1
	d0 = clear_bit(d0,d1)
	print('%2d %08x %d' % (d1,d0,((0x40000 - d0)//0x40)-1))
	d0 = set_bit(d0,d1)
	if d1 == 6:
		break
