public class Breakfast<D extends Drink, F extends Bread> extends Menu<D, F> {
	public Breakfast(D drink, F meal) {
		super(drink, meal);
	}
}
