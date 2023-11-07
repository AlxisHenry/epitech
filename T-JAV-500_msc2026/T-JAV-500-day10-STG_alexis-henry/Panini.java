import java.util.Arrays;

public class Panini extends Sandwich {
	public Panini() {
		super(3.50F, 120);
		this.vegetarian = true;
		this.ingredients.addAll(Arrays.asList("tomato", "salad", "cucumber", "avocado", "cheese"));
	}
}
