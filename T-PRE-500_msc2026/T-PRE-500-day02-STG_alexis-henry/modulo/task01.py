def division(n, d):
	q = 0
	r = n
	while r >= d:
		q += 1
		r -= d
	return n/d, q, r

print(division(42, 4))