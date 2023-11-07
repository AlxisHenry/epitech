import java.util.Arrays;

public class HamSandwich extends Sandwich {
	public HamSandwich() {
		super(4.00F, 230);
		this.ingredients.addAll(Arrays.asList("tomato", "salad", "cheese", "ham", "butter"));
	}
}
