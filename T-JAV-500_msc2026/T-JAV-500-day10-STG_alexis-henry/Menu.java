public abstract class Menu<D extends Food, F extends Food> {
	final private D drink;
	final private F meal;

	public Menu(D drink, F meal) {
		this.drink = drink;
		this.meal = meal;
	}

	public float getPrice() {
		return (drink.getPrice() + meal.getPrice()) * 0.9f;
	}

	public D getDrink() {
		return drink;
	}

	public F getMeal() {
		return meal;
	}
}
