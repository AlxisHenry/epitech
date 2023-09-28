text = input('Enter the ciphered text : ')
key = input('Enter the key : ')

def decrypt(text, key):
	key = int(key)
	message = ""
	for l in text:
		code = ord(l)
		if (code >= 65 and code <= 90) or (code >= 97 and code <= 122):
			code -= key
			if code < 65:
				code += 26
			elif code < 97 and code > 90:
				code += 26
			message += chr(code)
		else:
			message += l
	return message

if key.isdigit():
	key = int(key)
	print(decrypt(text, key))
else:
	print('Please provide integer to the key.')