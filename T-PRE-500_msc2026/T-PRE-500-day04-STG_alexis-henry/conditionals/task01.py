number = input("Enter a number : ")

if number.isdigit():
	print('Correct answer.' if int(number) == 42 else 'Please try again.')
else:
	print('Please provide integer to the input.')