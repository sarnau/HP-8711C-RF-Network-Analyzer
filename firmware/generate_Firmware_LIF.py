#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This code reads the Agilent firmware files and generates a LIF disk image
# I then used Greaseweazle to write it to an 3.5" HD floppy disk with this command:
# gw write --format ibm.1440 'HP 08712-10015 Firmware Disk C.04.52.img'

import struct
import binascii
from datetime import datetime, timezone
import lhafile

def align_bytearray_length(data: bytearray, alignment: int = 256, pad_byte: int = 0) -> bytearray:
    padding_needed = (-len(data)) % alignment
    if padding_needed:
        data += bytes([pad_byte] * padding_needed)
    return data

def dec_to_bcd(val):
	return (val // 10) * 0x10 + (val % 10)

# 1. extract the LHA's SFX 2.13S file
file = open('c-04-52.exe','rb')
file.seek(file.read().find(b'-lh')-2)
lha = lhafile.LhaFile(file)
fileDict = {}
for n in lha.infolist():
	fileDict[n.filename] = lha.read(n.filename)

# 2. generate a LIF disk image with the necessary files
sectorSize = 0x100
sectorCount = 0x1680 # 18 sectors of 512 bytes
directoryStartSector = 2
data = struct.pack('>H6sLH2xLH2xLLL6B', 0x8000, 'P8711 '.encode('ascii'),directoryStartSector,0x1000,3,1,1,1,sectorCount,0x98,0x07,0x31,0x11,0x18,0x51)
data = align_bytearray_length(data, alignment=directoryStartSector*sectorSize)
data = align_bytearray_length(data, alignment=sectorCount*sectorSize,pad_byte=0x40)

fileOffset = 0x5
filelist = ['C871XC_0','C871XC_1','C871XC_2','C871XC_3','C871XC_4','C871XC_5','C871XC_6','C_04_52C']
for i in range(len(filelist)):
	filename = filelist[i]
	fileData = fileDict[filename]
	dt = datetime.fromtimestamp(struct.unpack('<L', fileData[4:8])[0], timezone.utc)
	year = dec_to_bcd(dt.year - 1900)
	month = dec_to_bcd(dt.month)
	day = dec_to_bcd(dt.day)
	hour = dec_to_bcd(dt.hour)
	minute = dec_to_bcd(dt.minute)
	second = dec_to_bcd(dt.second)
	fileType = 0xa271 # ROM
	if filename == 'C_04_52C': # This is a textfile
		fileType = 0x0001 # LIF_ASCII
		# encode the file into the correct format. Technically this file is never read,
		# so we could just leave it, but I wanted to create an "original" disk.
		lifText = bytearray()
		for line in fileData.decode('ascii').strip().split('\r\n'):
			ll = line.encode('ascii')
			if len(ll) & 1:
				ll += bytearray(1)
			lifText += struct.pack('>H', len(line)) + ll
		lifText += bytearray([0xFF,0xFF])
		fileData = lifText
	filename = (filename.upper()+' '*10)[:10]
	fileData = align_bytearray_length(fileData)
	fileSize = (len(fileData) + 255)//256
	dirEndRecord = data[directoryStartSector*sectorSize+i*0x20:directoryStartSector*sectorSize+(i+1)*0x20]
	dirEndRecord = dirEndRecord[:10] + bytearray([0xFF,0xFF]) + dirEndRecord[12:]
	dirEntry = struct.pack('>10sHLL6BHL', filename.encode('ascii'),fileType,fileOffset,fileSize,year,month,day,hour,minute,second,0x8001,0)
	data = data[:directoryStartSector*sectorSize + i*0x20] + dirEntry + dirEndRecord + data[directoryStartSector*sectorSize + (i+2)*0x20:]
	data = data[:fileOffset * sectorSize] + fileData + data[(fileOffset + fileSize) * sectorSize:]
	fileOffset += fileSize

open('../disks/HP 08712-10015 Firmware Disk C.04.52.img','wb').write(data)
