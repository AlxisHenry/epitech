import os

def ls(path):
	for root, dirs, files in os.walk(path):
		print(f'Current Directory: {root}')
	for directory in dirs:
		print(f'Directory: {os.path.join(root, directory)}')
	for file in files:
		print(f'File: {os.path.join(root, file)}')

ls(os.getcwd())

def passage(path):
	for file in os.listdir(path):
		file_path = os.path.join(path, file)
		# if os.path.isdir(file_path):
		# 	passage(file_path)
		# else:
			# print(file_path)
		if os.path.isfile(file_path):
			print(file_path)
		else:
			passage(file_path)

passage(os.getcwd())