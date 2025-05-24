import gzip

data = bytearray()
for idx in range(7):
	with gzip.open('C871XC_%d' % idx, 'rb') as f:
		data += bytearray(f.read())[0x40:]

with open('C871XC_0x40000000.bin', 'wb') as output_file:
	output_file.write(data)
