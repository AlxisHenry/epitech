public class Ex06 {
	public static void main(String[] args) {
		sequence(5);
	}

	public static void sequence(int nbr) {
		if (nbr < 0)
			return;

		String prev = "1";
		System.out.println(prev);

		for (int i = 1; i <= nbr; i++) {
			int count = 1;
			StringBuilder current = new StringBuilder();
			int len = prev.length();

			for (int j = 1; j < len; j++) {
				if (prev.charAt(j) == prev.charAt(j - 1)) {
					count++;
				} else {
					current.append(count).append(prev.charAt(j - 1));
					count = 1;
				}
			}

			current.append(count).append(prev.charAt(len - 1));
			System.out.println(current);
			prev = current.toString();
		}
	}
}
