public class Lunch<D extends Drink, F extends Sandwich> extends Menu<D, F> {
	public Lunch(D drink, F meal) {
		super(drink, meal);
	}
}
