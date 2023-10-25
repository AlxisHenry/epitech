class Unit:
	name: str
	credits: int
	grade: str

	def __init__(self, name, credits, grade):
		self.name = name
		self.credits = credits
		self.grade = grade

	def getGradeWeightedCredits(self) -> int:
		grade_weight_mapping = { "A": 4, "B": 3, "C": 2, "D": 1, "E": 0 }
		return grade_weight_mapping[self.grade]

class Student:
	name: str
	academic_year: int
	units: list = []
	total_credit: int = 0
	gpa: int = 0

	def __init__(self, name, academic_year, units):
		self.name = name
		self.academic_year = academic_year
		self.setUnits(units)

	def setUnits(self, units) -> None:
		for unit in units:
			self.total_credit += unit.credits
			self.gpa += unit.getGradeWeightedCredits()
			self.units.append(unit)

	def getTotalCredits(self) -> int:
		return self.total_credit
	
	def getGPA(self) -> int:
		return self.gpa

students = [
	Student("Efg", 2, [
		Unit("Web Development", 15, "A"),
		Unit("Network and System Administration", 1, "B"),
		Unit("Java", 1, "E")
	]),
	Student("Bcd", 1, [
		Unit("Web Development", 25, "B"),
		Unit("Java", 12, "E")
	]),
	Student("Abc", 3, [
		Unit("Java", 1, "E")
	])
]

# students.sort(key=lambda student: student.name)
# students.sort(key=lambda student: student.getGPA(), reverse=True)
# students.sort(key=lambda student: student.getTotalCredits(), reverse=True)

for student in students:
	print(f"{student.name} has a GPA of {student.getGPA()} and {student.getTotalCredits()} credits")