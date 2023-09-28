list_with_duplicates = [1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 8]

def remove_duplicates(list):
	for i in list:
		if list.count(i) > 1:
			list.remove(i)
	return list

print(remove_duplicates(list_with_duplicates))