sentence = " of age-appropriate beverage on the wall."

count = 99
while count >= 0:
	if count == 0:
		print("No more bottles" + sentence)
		break
	start = str(count)
	if count == 1:
		start += " bottle"
	else:
		start += " bottles"
	print(start + sentence + "\nTake one down, pass it around")

	count -= 1