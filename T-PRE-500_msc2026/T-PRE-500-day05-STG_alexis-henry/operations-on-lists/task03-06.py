# task03
list = list(map(lambda x: x*x, [3,2,6,7,1,1,4])) # Multiplie chaque élément par lui-même
print(list)
# task04
list.sort()
smallest = [list[0]]
biggest = [list[len(list) - 1]]
for k,v in enumerate(list):
	if k != 0 and k != (len(list) - 1):
		if v in smallest:
			smallest.append(v)
		elif v in biggest:
			biggest.append(v)
print(biggest, smallest)
# task05
smaller_than_seven = []
for i in list:
	if i < 7:
		smaller_than_seven.append(i)
print(smaller_than_seven)
# task06
list.sort(reverse=True)
print(list)