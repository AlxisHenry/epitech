import java.util.ArrayList;
import java.util.List;

public class Ex03 {
	public static void main(String[] args) {
		printArray(new ArrayList<>(List.of("Volvo", "BMW", "Ford", "Mazda")));
  }

	public static void printArray(ArrayList<String> myArray) {
		for (String str : myArray) {
			System.out.println(str);
		}
	}
}
