def lower(s,n):
	count = 0
	for l in s:
		if l.islower():
			count += 1
	if count >= n:
		return True
	else:
		print("Password must contain at least", n, "lowercase letters.")
		return False

def upper(s,n):
	count = 0
	for l in s:
		if l.isupper():
			count += 1
	if count >= n:
		return True
	else:
		print("Password must contain at least", n, "uppercase letters.")
		return False

def lenght(s,n):
	if len(s) >= n:
		return True
	else:
		print("Password must be at least", n, "characters long.")
		return False

def specials(s,n):
	count = 0
	for l in s:
		if not l.isalnum():
			count += 1
	if count >= n:
		return True
	else:
		print("Password must contain at least", n, "special characters.")
		return False

def numbers(s,n):
	count = 0
	for l in s:
		if l.isdigit():
			count += 1
	if count >= n:
		return True
	else:
		print("Password must contain at least", n, "digits.")
		return False