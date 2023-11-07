public abstract class Drink implements Food {
	protected boolean aCan = false;
	private float price;
	private int calories;

	public Drink(float price, int calories) {
		this.price = price;
		this.calories = calories;
	}

	public boolean isACan() {
		return this.aCan;
	}

	public float getPrice() {
		return price;
	}

	public int getCalories() {
		return calories;
	}
}
