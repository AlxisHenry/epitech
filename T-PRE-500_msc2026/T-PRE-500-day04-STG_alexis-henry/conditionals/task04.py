number = input("Enter a number : ")

if number.isdigit():
	number = int(number)
	if number == 42 or number <= 21 or (number / 2) < 21 or number%2 == 0 or number >= 45:
		print('OK')
		quit()
	else:
		print('You got wrong my poor friend.')
else:
	print('Please provide integer to the input.')