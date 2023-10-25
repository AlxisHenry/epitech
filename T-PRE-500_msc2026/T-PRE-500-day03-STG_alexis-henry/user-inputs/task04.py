def extractFirstWordOfEachSentences(str):
	for c in [".", "?", "!", "..."]:
		str = str.replace(c, "##")
	words = []
	for sentence in str.split("##"):
		if len(sentence) > 0:
			words.append(sentence.split())
	new = ""
	for i in words:
		if len(new) > 0:
			new = new + " " + i[0]
		else:
			new = i[0]
	return new

print(extractFirstWordOfEachSentences("Hello is a test. Test it possible to fly? How things come to those who never give up. Are. You?"))


