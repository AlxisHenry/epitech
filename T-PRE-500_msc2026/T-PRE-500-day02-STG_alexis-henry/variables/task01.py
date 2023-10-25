l=9
power=7
sum=0
c=""

for i in range(1, l+1):
	c += "1" * i
	if i != l:
		c += "+"

sum = eval(c)

print("Sum: {} ({})".format(sum, c))
for i in range(2, power+1):
		print("**{}: {} | length: {} (+{})".format(i, sum**i, len(str(sum**i)), str(len(str(sum**i)) - len(str(sum**(i-1))))))
