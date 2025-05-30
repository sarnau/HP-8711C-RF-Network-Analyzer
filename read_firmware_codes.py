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

with open('342-0608-A.bin', 'rb') as file:
	data = file.read()

	print(getString(data, 0xCE3))
	BASE = 0xFE0
	while True:
		s = getString(data, BASE)
		for sl in [s[i: i + 16] for i in range(0, len(s), 16)]:
			print(sl)
		BASE += len(s) + 1
		if BASE >= 0x1510:
			break
	
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
		if bootConfig == 0xFFFFFFFF or (bootConfig != invbootConfig ^ 0xFFFFFFFF):
			break
		bf_str = (bf_str.decode('ascii').rstrip('\0') + ' ' * 10)[:11]
		serialNumber = (serialNumber.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		macAdr = (macAdr.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		oc = oc ^ 0xFFFFFFFF
		print('#%2d ADR:%08x => BC:%08x BF:"%s" OC:%08x Serial:"%s" MAC:"%s"' % (r,lpos,bootConfig,bf_str,oc,serialNumber,macAdr))
		bcl = []
		if bootConfig & 1:
			bcl.append('check for terminal before booting')
		if (bootConfig & 6) == 0:
			bcl.append('boot from disk')
		elif (bootConfig & 6) == 2:
			bcl.append('boot to HP-IB monitor')
		elif (bootConfig & 6) == 4:
			bcl.append('boot from rom')
		elif (bootConfig & 6) == 6:
			bcl.append('boot to LAN monitor')
		if bootConfig & 8:
			bcl.append('cache enabled')
		if bootConfig & 0x10:
			bcl.append('rs232 output')
		if bootConfig & 0x20:
			bcl.append('long power-on tests')
		if bootConfig & 0x40:
			bcl.append('power on tests')
		if bootConfig & 0x80:
			bcl.append('monitor reboot upon exception')
		if bootConfig & 0x100:
			bcl.append('abort RAM test on first errorexception')
		if bootConfig & 0x200:
			bcl.append('hp-ib ifc resets')
		if bootConfig & 0x400:
			bcl.append('replace Flash w/ SRAM daugherboard')
		if bootConfig & 0x800:
			bcl.append('moveDataSeg(1)/noMove(0) on hp-ib/disk loads')
		if bootConfig & 0x1000:
			bcl.append('Output test info to RS-232')
		if bootConfig & 0x2000:
			bcl.append('Search floppy for loadable files')
		bcl.append('HP-IB Adr #%d' % ((bootConfig >> 16) & 0x1F))
		bcl.append('HP-IB Disk Adr #%d' % ((bootConfig >> (16+8)) & 0x7))
		bcl.append('HP-IB Disk Unit #%d' % ((bootConfig >> (16+12)) & 0x3))
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
