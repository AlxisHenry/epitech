number = input("Enter an integer : ")

if number.isdigit():
	number = int(number)
	if number < 2:
		print("Number < 2")
	else:
		multiples = []
		for i in range(2, int(number / 2) + 1):
			current = []
			for j in range(1, number):
				if j % i == 0:
					current.append(j)
			current.reverse()
			multiples.append(current)
		for multiple in multiples:
			print(str(multiple).replace("[", "").replace("]", "").replace(",", ""))
else:
	print("Enter an interger please.")