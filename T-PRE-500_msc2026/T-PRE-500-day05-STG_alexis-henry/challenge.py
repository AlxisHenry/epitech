import time
import random

startingTime = time.time()

randomList = [random.randint(0, 1000000) for i in range(1000000)]
randomList.sort()

print(f"Duration of the program: {time.time() - startingTime} seconds")