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
		bc,bf_str,oc,serialNumber,macAdr,invbc = struct.unpack('>L10sL12s2x16s12xL',license)
		if bc == 0xFFFFFFFF or (bc != invbc ^ 0xFFFFFFFF):
			break
		bf_str = (bf_str.decode('ascii').rstrip('\0') + ' ' * 10)[:11]
		serialNumber = (serialNumber.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		macAdr = (macAdr.decode('ascii').rstrip('\0') + ' ' * 12)[:13]
		oc = oc ^ 0xFFFFFFFF
		print('#%2d ADR:%08x => BC:%08x BF:"%s" OC:%08x Serial:"%s" MAC:"%s"' % (r,lpos,bc,bf_str,oc,serialNumber,macAdr))

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
