def sumOfDigits(n):
	sum = 0
	while n:
		sum += n % 10
		n //= 10
	return sum

print(sumOfDigits(123434565))
print(sumOfDigits(44490320097))