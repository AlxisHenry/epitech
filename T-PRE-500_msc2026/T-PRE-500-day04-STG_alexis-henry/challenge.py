i,s=input(),input()
if i.isdigit():
	if i=="0": quit()
	for l in s: 
		if l in "aeiouy": print(i); quit();
	print(i if int(i)>=42 else s)