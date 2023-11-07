public abstract class Dessert implements Food {
	private float price;
	private int calories;

	public Dessert(float price, int calories) {
		this.price = price;
		this.calories = calories;
	}

	public float getPrice() {
		return price;
	}

	public int getCalories() {
		return calories;
	}

}
