#!/usr/bin/env python3

import binascii
import struct

BASE = 0x40000000

def getString(data,offset):
	s = ''
	while data[offset] != 0:
		s += chr(data[offset])
		offset += 1
	return s

with open("C871XC_0x40000000.bin", 'rb') as file:
	data = file.read()
	for offset in range(0x40243954-BASE,0x40243954-BASE+0x1000, 16):
		errors,error_message_table_name,minErr,maxErr = struct.unpack('>LLLL', data[offset:offset+16])
		if errors == 0:
			break
		print()
		print('%s %d-%d' % (getString(data,error_message_table_name-BASE),minErr,maxErr))
		size = (maxErr - minErr + 1) * 12
		for doffset in range(errors-BASE,errors-BASE+size,12):
			err_num,scpi_err,timeout,msg_type,beep,messageText = struct.unpack('>hhhBBL', data[doffset:doffset+12])
			B = '.'
			if beep:
				B = 'B'
			print('%#6x %5d %2d %s %s' % (err_num,scpi_err,timeout,B,getString(data,messageText-BASE).replace('\n','\\n')))
