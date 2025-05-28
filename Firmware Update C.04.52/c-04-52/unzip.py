import gzip
import struct

data = bytearray()
for idx in range(7):
	with gzip.open('C871XC_%d' % idx, 'rb') as f:
		block = bytearray(f.read())
		versionA,headerVersion = struct.unpack('>HH', block[:4])
		headerSize = 0x40
		if headerVersion == 0x010B or headerVersion == 0x10D or headerVersion == 0x010E:
			headerSize = 0x1000 # This seems only to be used during development for RAM based firmware
		data += block

with open('C871XC_0x40000000.bin', 'wb') as output_file:
	output_file.write(data)
