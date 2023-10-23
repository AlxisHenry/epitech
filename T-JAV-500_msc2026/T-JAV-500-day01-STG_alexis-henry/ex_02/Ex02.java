public class Ex02 {
	public static void main(String[] args) {
		System.out.println(getAngryDog(3));
	}

	public static String getAngryDog(int nbr) {
		String str = "";
		for (int i = 0; i < nbr; i++) {
			str += "woof";
		}
		return str;
	}
}
