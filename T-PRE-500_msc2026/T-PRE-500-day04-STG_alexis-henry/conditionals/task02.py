number = input("Enter a number : ")

if number.isdigit():
	print("The integer is odd" if int(number) % 2 else "The integer is even")
else:
	print('Please provide integer to the input.')