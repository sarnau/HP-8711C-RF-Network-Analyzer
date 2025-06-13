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

with open('08712-80033 C.01.000.bin', 'rb') as file:
	data = file.read()

	# Copyright string of ROM
	print(getString(data, 0xCE3))

	if True: # Internal greetings
		BASE = 0xFE0
		while True:
			s = getString(data, BASE)
			for sl in [s[i: i + 16] for i in range(0, len(s), 16)]:
				print(sl)
			BASE += len(s) + 1
			if BASE >= 0x1510:
				break

	if True: # Debugger help
		BASE = 0x21B44
		while True:
			s = getString(data, BASE)
			print(s)
			BASE += len(s) + 1
			if BASE >= 0x22B75:
				break
