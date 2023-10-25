import random, os, time, sys, requests, tkinter as tk

class Hangman:

	def __init__(self):
		self.initialize()
		self.show(self.homeScreen)

	def initialize(self) -> None:
		self.score = 0
		self.error = 0
		self.attempts = 0
		self.successRate = 0
		self.bestScore = False
		self.currentScoreIsBestScore = False

	def chooseWord(self) -> str:
		filename = sys.argv[1] if len(sys.argv) > 1 else False
		min = 4 * self.difficulty - 1
		max = 15 * self.difficulty // 3
		if not filename:
			word = requests.get(f"https://random-word-api.herokuapp.com/word?length={random.randint(min, max)}").json()[0]
		else:
			path = f'{os.getcwd()}/{filename}' 
			with open(path, "r") as f:
				words = f.read().split("\n")
			word = random.choice(words)
			if len(word) < min or len(word) > max:
				self.screen.destroy()
				raise Exception(f"Word length must be between {min} and {max}")
		return word

	def createBoard(self) -> list:
		word = self.chooseWord().upper()
		letters = ["_"] * len(word)
		for letter in word:
			if letter in [" ",",","'","-","’"]:
				letters[word.index(letter)] = letter
		return [word, letters, " ".join(letters)]
	
	def play(self, difficulty, timer) -> None:
		self.difficulty = difficulty
		self.timer = timer
		self.word, self.letters, self.board = self.createBoard()
		self.startTime =	time.time()
		self.show(self.gameScreen)

	def show(self, callback) -> None:
		if hasattr(self, "screen"): self.screen.destroy()
		self.screen = tk.Tk()
		self.screen.title("The best Hangman game ever !")
		self.screen.geometry(f"{self.screen.winfo_screenwidth() - 10}x{self.screen.winfo_screenheight() - 80}")
		self.screen.resizable(False, False)
		self.screen.config(bg="#463f5c")
		callback()
		self.screen.mainloop()

	def restart(self) -> None:
		self.initialize()
		self.homeScreen()

	def homeScreen(self) -> None:
		# Title
		title = tk.Label(self.screen, text="HANGMAN", font=("Arial", 50), bg="#463f5c", fg="white")
		title.pack(pady=120)
		configurationFrame = tk.Frame(self.screen, bg="#463f5c")
		configurationFrame.pack()
		# Set the difficulty using a scale
		difficultyLabel = tk.Label(configurationFrame, text="Difficulty: ", font=("Arial", 20), bg="#463f5c", fg="white")
		difficultyLabel.grid(row=0, column=0, padx=10, pady=10)
		difficulty = tk.Scale(configurationFrame, from_=1, to=3, orient="horizontal", bg="#463f5c", fg="white", font=("Arial", 20))
		difficulty.grid(row=0, column=1, padx=10, pady=10)
		# Set the timer using a +/- button
		timerLabel = tk.Label(configurationFrame, text="Timer: ", font=("Arial", 20), bg="#463f5c", fg="white")
		timerLabel.grid(row=1, column=0, padx=10, pady=10)
		timerValue = tk.IntVar()
		timerValue.set(60)
		timer = tk.Scale(configurationFrame, from_=60, to=360, orient="horizontal", bg="#463f5c", fg="white", font=("Arial", 20), variable=timerValue)
		timer.grid(row=1, column=1, padx=10, pady=10)
		# Play button
		playButton = tk.Button(self.screen, text="Play", command=lambda: "")
		playButton.config(width=10, height=2, bg="#463f5c", fg="white", font=("Arial", 20))
		playButton.pack(padx=10, pady=20)
		playButton.bind("<Button-1>", lambda e: self.play(int(difficulty.get()), int(timer.get())))

	def gameScreen(self) -> None:
		self.gameFrame = tk.Frame(self.screen, bg="#463f5c")
		self.gameFrame.pack(side="top", fill="both", expand=True)

		self.scoreFrame = tk.Frame(self.gameFrame, bg="#463f5c")
		self.scoreFrame.pack(side="top", fill="both", expand=True)
		self.scoreLabel = tk.Label(self.scoreFrame, text=f"Score: {self.score}", font=("Arial", 20), bg="#463f5c", fg="white")
		self.scoreLabel.pack(side="left", padx=10, pady=10)
		self.timerLabel = tk.Label(self.scoreFrame, text=f"Timer: {self.timer}", font=("Arial", 20), bg="#463f5c", fg="white")
		self.timerLabel.pack(side="right", padx=10, pady=10)

		# Restart button
		restartButton = tk.Button(self.gameFrame, text="Restart", command=lambda: self.show(self.restart))
		restartButton.config(width=10, height=2, bg="#463f5c", fg="white", font=("Arial", 20))
		restartButton.pack(padx=10, pady=20)

		self.boardFrame = tk.Frame(self.gameFrame, bg="#463f5c")
		self.boardFrame.pack(side="top", fill="both", expand=True)
		self.boardLabel = tk.Label(self.boardFrame, text=self.board, font=("Arial", 50), bg="#463f5c", fg="white")
		self.boardLabel.pack(pady=120)

		self.lettersFrame = tk.Frame(self.gameFrame, bg="#463f5c")
		self.lettersFrame.pack(side="left", fill="both", expand=True, anchor="w")
		self.lettersFrame.pack()
		letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		for i in range(0, len(letters), 5):
			lettersRow = tk.Frame(self.lettersFrame, bg="#463f5c")
			lettersRow.pack(side="top", fill="both", expand=True)
			for j in range(i, i + 5):
				if j < len(letters):
					letterButton = tk.Button(lettersRow, text=letters[j], command=lambda letter=letters[j]: self.guess(letter))
					letterButton.config(width=10, height=2, bg="#463f5c", fg="#fff", font=("Arial", 20))
					letterButton.pack(side="left", padx=10, pady=10)

		self.hangmanFrame = tk.Frame(self.gameFrame, bg="#463f5c")
		self.hangmanFrame.pack(side="right", fill="both", expand=True, anchor="e")
		self.hangmanFrame.pack()
		self.hangman = tk.Canvas(self.hangmanFrame, width=600, height=500, bg="#463f5c", border=0, highlightthickness=0)
		self.hangman.pack(side="left", fill="both", expand=False)

		# Start the timer
		self.timerLabel.after(1000, self.updateTimer)

	def updateTimer(self) -> None:
		self.timer -= 1
		self.timerLabel.config(text=f"Timer: {self.timer}")
		if self.timer == 0:
			self.show(self.loseScreen)
		else:
			self.timerLabel.after(1000, self.updateTimer)

	def endScreen(self) -> None:
		wordLabel = tk.Label(self.screen, text=f"Word: {self.word}", font=("Arial", 20), bg="#463f5c", fg="white")
		wordLabel.pack(pady=10)
		scoreLabel = tk.Label(self.screen, text=f"Score: {self.score}", font=("Arial", 20), bg="#463f5c", fg="white")
		scoreLabel.pack(pady=10)
		errorLabel = tk.Label(self.screen, text=f"Errors: {self.error}", font=("Arial", 20), bg="#463f5c", fg="white")
		errorLabel.pack(pady=10)
		successRate = round((self.attempts - self.error) / self.attempts * 100, 2) if self.attempts > 0 else 0
		successRateLabel = tk.Label(self.screen, text=f"Success rate: {successRate}%", font=("Arial", 20), bg="#463f5c", fg="white")
		successRateLabel.pack(pady=10)
		attemptsLabel = tk.Label(self.screen, text=f"Attempts: {self.attempts}", font=("Arial", 20), bg="#463f5c", fg="white")
		attemptsLabel.pack(pady=10)
		if self.win():
			if self.currentScoreIsBestScore:
				text = f"Best ever!!! You've guessed {self.word} in {self.attempts} attempts."
			else:
				text = f"You've guessed {self.word} in {self.attempts} attempts. The record is {self.bestScore} attempts."
			bestScoreLabel = tk.Label(self.screen, text=text, font=("Arial", 20), bg="#463f5c", fg="white")
			bestScoreLabel.pack(pady=10)
		playAgainButton = tk.Button(self.screen, text="Play again", command=lambda: self.show(self.restart))
		playAgainButton.config(width=10, height=2, bg="#463f5c", fg="white", font=("Arial", 20))
		playAgainButton.pack(pady=10)

	def winScreen(self) -> None:
		timeForGuess = round(time.time() - self.startTime, 2)
		winLabel = tk.Label(self.screen, text="You win !", font=("Arial", 50), bg="#463f5c", fg="white")
		winLabel.pack(pady=120)
		timeLabel = tk.Label(self.screen, text=f"Time: {timeForGuess} second(s)", font=("Arial", 20), bg="#463f5c", fg="white")
		timeLabel.pack(pady=10)
		self.endScreen()

	def loseScreen(self) -> None:
		loseLabel = tk.Label(self.screen, text="You lose !", font=("Arial", 50), bg="#463f5c", fg="white")
		loseLabel.pack(pady=120)
		self.endScreen()

	def updateHangmanCanvas(self) -> None:
		# ["method", [x1, y1, x2, y2], "fill", width, "outline"],
		steps = [
			["line", [0,400,400,400], "#f2f2f2", 10],
			["line", [350,400,350,45], "#f2f2f2", 10],
			["line", [85,75,385,75], "#f2f2f2", 10],
			["line", [280,75,350,145], "#f2f2f2", 8],
			["line", [180,75,180,125], "#f2f2f2", 7],
			["oval", [150,125,210,185], "", 5, "#f2f2f2"],
			["line", [180,185,180,300], "#f2f2f2", 5],
			["line", [180,300,150,350], "#f2f2f2", 5],
			["line", [180,300,210,350], "#f2f2f2", 5],
			["line", [180,200,150,250], "#f2f2f2", 5],
			["line", [180,200,210,250], "#f2f2f2", 5]
		]

		methods = {
			"line": self.hangman.create_line,
			"oval": self.hangman.create_oval
		}

		if len(steps) >= self.error:
			step = steps[self.error - 1]
			methods[step[0]](step[1], fill=step[2], width=step[3], outline=step[4] if len(step) == 5 else None)

	def guess(self, letter: str) -> str:
		if letter in self.letters:
			self.updateScore(-1)
		elif letter in self.word:
			self.updateBoard(letter)
		else:
			self.updateScore(-1)

	def updateBoard(self, letter: str) -> None:
		count = 0
		for i in range(len(self.word)):
			if self.word[i] == letter:	
				self.letters[i] = letter
				count += 1
		self.updateScore(count)
		self.board = " ".join(self.letters)
		self.boardLabel.config(text=self.board)
		if self.win():
			self.timerLabel.destroy()
			self.timeForGuess = round(time.time() - self.startTime, 2)
			self.currentScoreIsBestScore = self.checkBestScore()
			self.show(self.winScreen)

	def checkBestScore(self) -> None:
		path = f'{os.getcwd()}/best_scores.txt'
		with open(path, "r") as f:
			bestScores = f.read().split("\n")
		date = time.strftime("%d/%m/%Y-%H:%M:%S")
		wordFound = False
		for i in range(len(bestScores)):
			log = bestScores[i].split("@")
			if log[0] == self.word:
				self.bestScore = log[1]
				wordFound = True
				if int(self.bestScore) >= self.attempts:
					bestScores[i] = f"{self.word}@{self.attempts}@{date}"
				else:
					return False
		# If the word is not in the file, add it
		if not wordFound: bestScores.append(f"{self.word}@{self.attempts}@{date}")
		# Rewrite the file
		with open(path, "w") as f:
			f.write("\n".join(bestScores))
		return True

	def updateScore(self, score: int) -> None:
		self.attempts += 1
		if score == -1:
			self.error += 1
			self.updateHangmanCanvas()
			if self.error == 11:
				self.timerLabel.destroy()
				self.show(self.loseScreen)
		self.score = max(0, self.score + score)
		self.scoreLabel.config(text=f"Score: {self.score}")

	def win(self) -> bool:
		return "_" not in self.board

Hangman()
