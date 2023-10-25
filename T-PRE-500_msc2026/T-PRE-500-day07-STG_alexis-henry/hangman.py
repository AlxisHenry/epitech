import random, os, time

class Hangman:

	def __init__(self: list, words: list):
		os.system("clear")
		if len(words) <= 1: raise Exception("No words in Hangman")
		self.word, self.letters, self.board = self.createBoard(words)
		self.score = 0
		self.error = 0
	
	def createBoard(self, words) -> list:
		word = random.choice(words)
		letters = ["_"] * len(word)
		for letter in word:
			if letter in [" ",",","'","-","’"]:
				letters[word.index(letter)] = letter
		return [word, letters, " ".join(letters)]
	
	def play(self):
		self.startTime =	time.time()
		while not self.win():
			self.printBoard()
			self.guess()

	def guess(self) -> str:
		guess = input("$ Guess a letter or directly the word: ")
		length = len(guess)
		if length == 0 or guess == " ":
			print("Please enter a letter or a word.")
		elif length > 1:
			if guess == self.word:
				self.setScore(len(self.word))
				self.clearBoard()
			else:
				self.updateScore(-1)
				print(f"Incorrect guess, try again! (-1 points)")
		else:
			letter = guess
			if letter in self.letters:
				print(f"Letter {letter} already found, try again! (-1 point)")
				self.updateScore(-1)
			elif letter in self.word: 
				self.updateBoard(letter)
			else:
				self.letterNotFound(letter)

	def updateBoard(self, letter: str) -> None:
		count = 0
		for i in range(len(self.word)):
			if self.word[i] == letter:
				self.letters[i] = letter
				count += 1
		self.letterFound(letter, count)
		self.board = " ".join(self.letters)

	def win(self) -> bool:
		if "_" not in self.board:
			timeForGuess = round(time.time() - self.startTime, 2) 
			print(f"Congratulations, you found the word \"{self.word}\" ! Your score is {self.score} points.")
			print(f"You took {timeForGuess}s seconds to find the word and made {self.error} error(s).")
			return True
		return False

	def printBoard(self) -> None:
		print(f"{self.board} ({self.score} points)")

	def letterFound(self, letter: str, count: int) -> None:
		self.updateScore(count)
		print(f"Found {count} letter(s) \"{letter}\" ! (+{count} points)")

	def letterNotFound(self, letter: str) -> None:
		self.updateScore(-1)
		print(f"Letter {letter} not in word, try again! (-1 point)")

	def updateScore(self, score: int) -> None:
		if score == -1:
			self.error += 1
			if self.error == 8:
				print("You have reached the maximum number of errors, you lose!")
				exit()
		self.score += score

	def setScore(self, score: int) -> None:
		self.score = score
	
	def clearBoard(self) -> None:
		self.board = self.board.replace("_", "")

path = os.path.dirname(__file__) if os.path.dirname(__file__) != "" else "."
f = open(path + "/words.txt", "r")
words = f.read().split("\n")
Hangman(words).play()