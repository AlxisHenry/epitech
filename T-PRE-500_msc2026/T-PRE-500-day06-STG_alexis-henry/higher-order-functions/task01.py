from task00 import *

def check_password(method, n, password):
	return method(password, n)

password = "mypassword$$$"
print(check_password(lower, 4, password) and check_password(specials, 2, password))