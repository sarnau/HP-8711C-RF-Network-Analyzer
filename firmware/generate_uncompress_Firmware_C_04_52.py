#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import gzip
import lhafile
import struct
import sys

# 1. extract the LHA's SFX 2.13S file
file = open('c-04-52.exe','rb')
file.seek(file.read().find(b'-lh')-2)
lha = lhafile.LhaFile(file)
fileDict = {}
for n in lha.infolist():
	fileDict[n.filename] = lha.read(n.filename)

# 2. extract the gzip firmware and merge them
data = bytearray()
for idx in range(7):
	name = 'C871XC_%d' % idx
	if name not in fileDict:
		break
	block = gzip.decompress(fileDict[name])
	versionA,headerVersion = struct.unpack('>HH', block[:4])
	headerSize = 0x40
	if headerVersion == 0x010B or headerVersion == 0x010D or headerVersion == 0x010E:
		headerSize = 0x1000 # This seems only to be used during development for RAM based firmware
	data += block[headerSize:]

# 3. write the uncompressed firmware as a single file
open('C871XC_ROM_C_04_52.bin', 'wb').write(data)
