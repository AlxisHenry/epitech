first_name = ["Jackie", "Bruce ", "Arnold", "Sylvester"]
last_name = ["Stallone", "Schwarzenegger", "Willis", "Chan"]
magic = [*zip(first_name,last_name[::-1])]
# Il assemble les deux tableaux en un seul tableau de tuples, en prenant les éléments dans l'ordre inverse pour le second tableau
print(magic)
