package Factory;

public class NoSuchToyException extends Exception {
	public static final String NO_SUCH_TOY = "No such toy: [label].";
	
	public NoSuchToyException(String label) {
		super(NoSuchToyException.NO_SUCH_TOY.replace("[label]", label));
	}
}
