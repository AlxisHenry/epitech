import java.util.ArrayList;

public class Ex05 {

	public static void main(String[] args) {
		System.out.println(myGetArgs(args));
	}

	public static ArrayList<String> myGetArgs(String... var) {
		ArrayList<String> args = new ArrayList<String>();
		for (String arg : var) {
			args.add(arg);
		}
		return args;
	}
}
