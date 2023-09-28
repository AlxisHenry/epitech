import numpy as np
import matplotlib.pyplot as plt
import math
import tkinter as tk

def chart(points: list) -> None:
	x = []
	y = []
	for point in points:
		x.append(point[0])
		y.append(point[1])
	plt.plot(x,y, 'ro')
	plt.show()

# chart([
# 	[0,12],
# 	[1,32],
# 	[2,42],
# 	[3,52]
# ])

def f(x):
	return x**2 + x*3 + 2

def plt_fct(method,x,y):
	x = np.linspace(x,y,100)
	y = method(x)
	plt.plot(x,y)
	plt.show()	
	
# plt_fct(np.sin, 0, 50)
# plt_fct(f, -100, 200)
# plt_fct(lambda x: x**2, -10, 10)
# plt_fct(lambda x: 1/x, -100, 100)

def window():
	window = tk.Tk()
	window.title("Welcome to LikeGeeks app")
	window.geometry('600x900')
	lbl = tk.Label(window, text="Hello")
	lbl.grid(column=0, row=0)
	input = tk.Entry(window, width=10)
	input.grid(column=1, row=0)
	btn = tk.Button(window, text="Click Me")
	btn.grid(column=2, row=0)
	def clicked():
		print(input.get().upper())
	btn.configure(command=clicked)

	# add a canvas
	canvas = tk.Canvas(window, width=600, height=600)
	canvas.grid(column=0, row=1)
	
	stickmanName = tk.StringVar()
	stickmanName.set("Stickman")
	stickman = tk.Entry(window, width=10, textvariable=stickmanName)
	stickman.grid(column=1, row=1)
	
	# draw a stickman
	canvas.create_oval(100, 100, 200, 200, fill="white")
	canvas.create_line(150, 200, 150, 300, fill="white")
	canvas.create_line(150, 300, 100, 350, fill="white")
	canvas.create_line(150, 300, 200, 350, fill="white")
	canvas.create_line(150, 200, 100, 250, fill="white")
	canvas.create_line(150, 200, 200, 250, fill="white")
	

	window.mainloop()

window()