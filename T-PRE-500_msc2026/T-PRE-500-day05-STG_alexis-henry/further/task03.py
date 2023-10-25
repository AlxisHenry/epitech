import random

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
times = ["9:00 AM", "11:00 AM", "1:00 PM", "3:30 PM", "5:00 PM", "7:00 PM", "9:00 PM"]
people = ["Joe", "Bob", "Samantha", "Jane", "Carl", "Bill", "Susan"]

meetings = []
for i in range(25):
		people_in_meeting = []
		for j in range(4):
			choice = random.choice(people)
			while choice in people_in_meeting:
				choice = random.choice(people)
			people_in_meeting.append(choice)
		meetings.append([random.choice(days), random.choice(times), *people_in_meeting])

name = input("Enter a name: ")

for meeting in meetings:
	if name in meeting:
		print(meeting)