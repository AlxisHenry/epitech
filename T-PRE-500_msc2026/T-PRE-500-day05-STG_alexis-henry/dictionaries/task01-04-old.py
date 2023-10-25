student = {
	"name": "John",
	"academic_year": 2,
	"units": [
		{
			"name": "Web Development",
			"credits": 15,
			"grade": "A"
		},
		{
			"name": "Network and System Administration",
			"credits": 1,
			"grade": "B"
		},
		{
			"name": "Java",
			"credits": 1,
			"grade": "E"
		}
	],
	"total_credit": 17,
	"gpa": 7
}

grade_weight_mapping = {
	"A": 4,
	"B": 3,
	"C": 2,
	"D": 1,
	"E": 0
}

student1 = {
	"name": "Me",
	"academic_year": 4,
	"units": [
		{
			"name": "Network and System Administration",
			"credits": 4,
			"grade": "B"
		},
		{
			"name": "Java",
			"credits": 5,
			"grade": "E"
		}
	],
	"total_credit": 9,
	"gpa": 3
}

student2 = {
	"name": "Doe",
	"academic_year": 2,
	"units": [
		{
			"name": "Network and System Administration",
			"credits": 1,
			"grade": "B"
		},
		{
			"name": "Java",
			"credits": 1,
			"grade": "B"
		}
	],
	"total_credit": 2,
	"gpa": 6
}

students = [
	student,
	student1,
	student2
]

students.sort(key=lambda x: x["name"])
for student in students:
	print(student["name"], end=" ")

students.sort(key=lambda x: x["gpa"], reverse=True)
for student in students:
	print(student["gpa"], end=" ")

students.sort(key=lambda x: x["gpa"], reverse=False)
for student in students:
	print(student["gpa"], end=" ")

print("")
