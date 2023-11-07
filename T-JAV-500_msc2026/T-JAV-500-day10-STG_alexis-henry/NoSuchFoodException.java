public class NoSuchFoodException extends Exception {
	public NoSuchFoodException(String className) {
		super("No such food type: " + className + ".");
	}
}
