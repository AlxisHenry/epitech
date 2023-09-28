list = [1,2,3,4,5]
print(list[0]) # task01
print(list[len(list) - 1]) # task02
list.append(6) # task03
# task04
for element in list:
	print(element)
# task05
list = list[:-1]
for element in list:
	print(element)
# task06
list.insert(0, "Beginning")
for element in list:
	print(element)
# task07
# task08
for element in list:
	print(element)
print(list[::2]) # task09
# task10
list = [*list, *[i for i in range(17)]]
print(list)