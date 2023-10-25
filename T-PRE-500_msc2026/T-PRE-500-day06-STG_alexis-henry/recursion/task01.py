import string

def is_palindrome(s, recursive=True):
		s = ''.join(c for c in s if c not in string.punctuation and c != ' ').lower()
		if len(s) <= 1:
			return True
		if recursive:
			if s[0] != s[-1]:
				return False
			else:
				return is_palindrome(s[1:-1])
		else:
			return s == s[::-1]
	
print(is_palindrome("kayak", recursive=False))  # True
print(is_palindrome("never odd or even"))  # True
print(is_palindrome("Was it a car or a cat I saw?", recursive=False))  # True
print(is_palindrome("hello world"))  # False