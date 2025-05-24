#!/usr/bin/env python3

SCRAMBLE_STR = 'AMEGXY3JW9PVSN45DTK62QUCIRH1FZ08BO7L'

# convert a base-36 string into a value, but ignore first character (!!!)
def str_to_value(s):
	val = 0
	for ch in reversed(s[1:]):
		val = (val * 36) + SCRAMBLE_STR.find(ch)
	return val

# convert a value into a base-36 string
def value_to_str(value):
	s = ''
	while value != 0:
		s += SCRAMBLE_STR[int(value % 36)]
		value = int(value / 36)
		if len(s) == 14:
			break
	while len(s) < 10:
		s.append('A')
	return s

# this is the decryption of the value in the device.
def shift_left_xor(value):
	value ^= value << 1
	return value

# the is the encryption, which is a bit more tricky. But it is the inverse of shift_left_xor
def invert_xor_shift_left(value):
    result = 0
    for i in reversed(range(64)):
        bit = (value >> i) & 1
        if i < 63:
            bit ^= (result >> (i + 1)) & 1
        result |= bit << i
    return result >> 1

# generate a code for a specific serial number or decrypt an option code
def encrypt_decrypt(s, encryptFlag=True):
	val = str_to_value(s.upper())
	if encryptFlag:
		val = invert_xor_shift_left(val)
	else:
		val = shift_left_xor(val)
	val &= 0xfffffffffffff
	# for some reason the first character of the serial number is not shuffled
	return s[0] + value_to_str(val)

def calc_option_char(optionMask):
    if optionMask & 1:
    	print("Fault/SRL option")
    if optionMask & 2:
    	print("IBASIC option")
    if optionMask & 4:
    	print("LAN option")
    if optionMask & 8: # I am not sure about the side-effects for this one!
    	print("Convert to a 8730A")
    if optionMask == 0:
    	print("Clear all options")
    # technically A-Z and 0-9 are legal, which allows 36 values, but only the lower 15 are generating a valid input
    # That said: '9' is special, it clear all options and the serial number (sets it to '?????????')
    # I have not dared to try that!
    # The safest option is 7, which results in an 'I' to just enable the 3 options above
    return chr((15 - optionMask) + ord('A'))

SERIALNUMBER = 'US37400653'
print('SERIAL NUMBER = %s' % SERIALNUMBER)
ALL_OPTIONS = calc_option_char(7)

option_keyword = encrypt_decrypt(SERIALNUMBER+ALL_OPTIONS, True)
print('OPTION KEYWORD = %s' % option_keyword)
assert(encrypt_decrypt(option_keyword, False) == SERIALNUMBER+ALL_OPTIONS)
