def toLowerCase(str):
	return str.lower()

print(toLowerCase("SALUT"))

low = lambda str: str.lower()

print(low("SALUT"))

def low(str):
	# Using letters list
	# lowercase_letters = "abcdefghijklmnopqrstuvwxyz"
	# for i, uppercase_letter in enumerate("ABCDEFGHIJKLMNOPQRSTUVWXYZ"):
		# str = str.replace(uppercase_letter, lowercase_letters[i])

	# Using ASCII codes
	lowercase = [97, 122]
	uppercase = [65, 90]
	for letter in str:
		code = ord(letter)
		if 65 <= code <= 90:
			c = code - uppercase[0]
			str = str.replace(letter, chr(lowercase[0] + c))

	return str

print(low("SALuT TU vAS BiEN TOI"))