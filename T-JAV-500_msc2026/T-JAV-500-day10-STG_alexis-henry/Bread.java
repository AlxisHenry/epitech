public abstract class Bread implements Food {
	private float price;
	private int calories;
	protected int bakingTime = 0;

	public Bread(float price, int calories) {
		this.price = price;
		this.calories = calories;
	}

	public float getPrice() {
		return price;
	}

	public int getCalories() {
		return calories;
	}

	public int getBakingTime() {
		return bakingTime;
	}
}
