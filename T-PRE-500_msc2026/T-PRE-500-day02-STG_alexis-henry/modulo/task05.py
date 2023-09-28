def extractDecimalPart(n):
	return str(n).split(".")[1]
	return n%1

print(extractDecimalPart(12.24))
print(extractDecimalPart(424242.8412))