def encrypt_vigenere(text: str, keyword: str) -> str:
	text = text.upper()
	keyword = keyword.upper()
	new = ""
	for i in range(len(text)):
		code = ord(text[i])
		if (code >= 65 and code <= 90):
			code += ord(keyword[i % len(keyword)]) - 65
			if code > 90:
				code -= 26
			new += chr(code)
		else:
			new += text[i]
	return new

def decrypt_vigenere(text: str, keyword: str) -> str:
	text = text.upper()
	keyword = keyword.upper()
	new = ""
	for i in range(len(text)):
		code = ord(text[i])
		if (code >= 65 and code <= 90):
			code -= ord(keyword[i % len(keyword)]) - 65
			if code < 65:
				code += 26
			new += chr(code)
		else:
			new += text[i]
	return new

print(encrypt_vigenere("CRYPTOGRAPHIE", "MATHWEB"))
print(decrypt_vigenere(encrypt_vigenere("CRYPTOGRAPHIE", "MATHWEB"), "MATHWEB"))