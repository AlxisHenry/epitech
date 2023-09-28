my_first_list = [4,5,6]
my_second_list = [1,2,3]
my_first_list.extend(my_second_list) # Merge the second list with the first [4,5,6,1,2,3]
print(my_first_list)

my_first_list = [7,8,9]
my_second_list = [4,5,6]
my_first_list = [*my_first_list , *my_second_list ] # Equivalent of ... in javascript
print(my_first_list)