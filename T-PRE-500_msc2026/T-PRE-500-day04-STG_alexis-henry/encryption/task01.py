message = input('Enter your message : ')
key = input('Enter your key : ')

def encrypt(message, key):
	key = int(key)
	new = ""
	for l in message:
		code = ord(l)
		if (code >= 65 and code <= 90) or (code >= 97 and code <= 122):
			code += key
			if code > 122:
				code -= 26
			elif code > 90 and code < 97:
				code -= 26
			new += chr(code)
		else:
			new += l
	return new

if key.isdigit():
	key = int(key)
	print(encrypt(message, key))
else:
	print('Please provide integer to the key.')