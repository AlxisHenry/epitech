from sandwiches import doubleHamSandwich

def make(number):
	if number < 0 or isinstance(number, int) == False:
		print("I can't do this")
		return
	for i in range(number):
		doubleHamSandwich()

make(2)