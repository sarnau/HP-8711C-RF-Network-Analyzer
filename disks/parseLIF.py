#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import binascii
from datetime import datetime
import struct


LIFTYPES = {
    0xa271:"    871XC_rom",
	0xc001:"1650/1_system",
	0xc100:"16500A_system",
	0xc101:"16500X config",
	0xc120:"1650/1_config",
	0xc301:"autoload_file",
	0xc302:"inverse_assem",
	0xc303:"16500A_option",
	0xc304:"1650/1_option",
	0xc305:"  cal_factors",
	0xc306:"    text_file",
	0xc307:"    166xA_rom",
	0xc308:" 166xA_system",
	0xc309:"166xA_analyzr",
	0xc30a:" 166xAS_scope",
	0xc30b:"16[6/7]x_cnfg",
	0xc30c:"inverse_assem",
	0xc30d:"16500B_system",
	0xc30e:"16500B_option",
	0xc30f:" 1664A_system",
	0xc310:"1664A_analyzr",
	0xc311:" 16[6/7]x_rom",
	0xc312:" 16[6/7]x_rom",
	0xc313:"167x_analyzr",
	0xc314:"167x_scope",
	0xc315:"167x_analyzer",
	0xc316:" 16[6/7]x_opt",
	0xc319:"167x_pattgen",
	0xd8f1:"    directory",
	0xd8f2:" volume label",
	0xe94b:"          DOS",
	0xfffe:"LIF_BINARY  ",
	0xffff:"-END-OF-DIR-", # marker for the end of the directory table
	0x0001:"LIF_ASCII   ",
}


def parseFile(filename):
	data = open(filename,'rb').read()
	
	print('%s' % filename)
	print('=' * len(filename))
	
	# LifVolumeHeader https://www.hp9845.net/9845/projects/hpdir
	magicId,volumeLabel,directoryStartRecordPos,lifIdentifier,directorySize,lifVersion,trackCount,headCount,sectorCount,year,month,day,hour,minute,second = struct.unpack('>H6sLH2xL2xHLLL6B', data[:42])
	volumeLabel = volumeLabel.decode('ASCII').strip()
	print('LABEL:"%s" START:$%06X DIRSIZE:%d S#:$%X T#:%d H#:%d DATE:%02x.%02x.%02x %2d:%02d:%02d' % (volumeLabel,directoryStartRecordPos * 0x100,directorySize,sectorCount,trackCount,headCount,day,month,year,hour,minute,second))
	if magicId != 0x8000 or lifIdentifier != 0x1000 or lifVersion != 0:
		return False
	
	endOfDirReached = False
	for soffset in range(directorySize):
		if endOfDirReached:
			break
		offset = (directoryStartRecordPos + soffset) * 0x100
	
		for dindex in range(0x100//0x20):
			dstart = offset+dindex*0x20
			# LifDirectoryEntry
			fileName,fileType,startRecordPos,recordLength,year,month,day,hour,minute,second,volumeRecord,generalPurposeField = struct.unpack('>10sHLL6BHL', data[dstart:dstart+0x20])
			if fileType == 0xFFFF: # last entry
				endOfDirReached = True
				break
			fileName = fileName.decode('ASCII').strip()
			assert volumeRecord == 0x8001
			if fileType in LIFTYPES:
				fileTypeStr = LIFTYPES[fileType]
			else:
				fileTypeStr = '$%04x' % fileType
			print('- "%-10s" TYPE:"%-13s" DATE:%02x.%02x.%02x %2d:%02d:%02d START:$%06x RLEN:$%x' % (fileName,fileTypeStr,day,month,year,hour,minute,second,startRecordPos * 0x100,recordLength))
			fdata = bytearray()
			for recindex in range(recordLength):
				rdata = data[(startRecordPos+recindex)*0x100:(startRecordPos+recindex+1)*0x100]
				fdata += rdata[2:2+rdata[1]]
	

parseFile('HP 08712-10015 Firmware Disk C.04.52.img')
