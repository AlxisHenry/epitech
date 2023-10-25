import os, random

def hangman():
	os.system("clear")
	path = os.path.dirname(__file__) if os.path.dirname(__file__) != "" else "."
	f = open(path + "/words.txt", "r")
	words = f.read().split("\n")
	word = random.choice(words)
	letters = ["_"] * len(word)
	for letter in word:
		if letter in [" ",",","'","-"]:
			letters[word.index(letter)] = letter
	board = f"{' '.join(letters)}"
	score = 0
	error = 0
	while "_" in board:
		if error == 8:
			print("You lost, you made 8 errors.")
			exit()
		print(f"{board} ({score} points)")
		guess = input("$ Guess a letter or directly the word: ")
		if len(guess) > 1:
			if guess == word:
				score += len(word)
				break
			else:
				score -= 1
				print(f"Incorrect guess, try again! (-1 points)")
		elif len(guess) == 0 or guess == " ":
			print("Please enter a letter or a word.")
		else:
			letter = guess
			if letter in letters:
				print(f"Letter {letter} already found, try again! (-1 point)")
				score -= 1
				error += 1
			elif letter in word:
				count = 0
				for i in range(len(word)):
					if word[i] == letter:
						letters[i] = letter
						count += 1
						score += 1
				print(f"Found {count} letter(s) \"{letter}\" ! (+{count} points)")
				board = f"{' '.join(letters)}"
			else:
				score -= 1
				error += 1
				print(f"Letter {letter} not in word, try again! (-1 point)")
	print(f"Congratulations, you found the word \"{word}\" ! Your score is {score} points.")

hangman()