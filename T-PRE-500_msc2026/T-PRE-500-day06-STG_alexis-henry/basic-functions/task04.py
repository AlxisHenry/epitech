from sandwiches import *

def make(number, veggie = False):
	if number < 0 or isinstance(number, int) == False:
		print("I can't do this")
		return
	for i in range(number):
		if veggie:
			veggieSandwich()
		else:
			doubleHamSandwich()

make(2, veggie = True)