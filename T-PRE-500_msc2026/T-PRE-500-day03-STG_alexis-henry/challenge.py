def count(str: str) -> int:
	matches = ["cat", "garden", "mice"]
	# matches = ["cat", "garden", "mice", "ecim", "nedrag", "tac"]
	count = 0
	str = str.lower()
	for _ in matches:
		while str.find(_) != -1:
			count += 1
			str = str.replace(_, "", 1)
	for _ in matches:
		reverse = _[::-1]
		while str.find(reverse) != -1:
			count += 1
			str = str.replace(reverse, "", 1)
	return count

print(count("thE Cat’s tactic wAS tO surpRISE thE mIce iN tHE gArdeN tac cat nedrag"))