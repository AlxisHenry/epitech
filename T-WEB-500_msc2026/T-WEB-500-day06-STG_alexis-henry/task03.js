export function countGs(str) {
	let count = 0;
	for (const char of str) {
		if (char === "G") {
			count++;
		}
	}
	return count;
}