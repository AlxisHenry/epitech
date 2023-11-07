import java.util.HashMap;
import java.util.Map;

public class CustomerOrder {
	private final Map<Food, Integer> items = new HashMap<>();
	private final Map<Menu<?, ?>, Integer> menus = new HashMap<>();
	private Stock stock = null;

	public CustomerOrder(Stock stock) {
		this.stock = stock;
	}

	public boolean addItem(Food food) throws NoSuchFoodException {
		if (food != null && this.stock.remove(food.getClass())) {
			this.items.put(food, this.items.getOrDefault(food, 0) + 1);
			return true;
		}
		return false;
	}

	public boolean removeItem(Food food) throws NoSuchFoodException {
		if (food != null && this.items.containsKey(food)) {
			if (this.stock.add(food.getClass())) {
				this.items.put(food, this.items.get(food) - 1);
				return true;
			}
		}
		return false;
	}

	public float getPrice() {
		float price = 0;
		for (Map.Entry<Food, Integer> entry : this.items.entrySet()) {
			price += entry.getKey().getPrice() * entry.getValue();
		}
		for (Map.Entry<Menu<?, ?>, Integer> entry : this.menus.entrySet()) {
			price += entry.getKey().getPrice() * entry.getValue();
		}
		return price;
	}

	public boolean addMenu(Menu<?, ?> menu) throws NoSuchFoodException {
		if (menu != null && this.stock.remove(menu.getDrink().getClass()) && this.stock.remove(menu.getMeal().getClass())) {
			this.menus.put(menu, this.menus.getOrDefault(menu, 0) + 1);
			return true;
		}
		return false;
	}

	public boolean removeMenu(Menu<?, ?> menu) throws NoSuchFoodException {
		if (menu != null && this.menus.containsKey(menu)) {
			if (this.stock.add(menu.getDrink().getClass()) && this.stock.add(menu.getMeal().getClass())) {
				this.menus.put(menu, this.menus.get(menu) - 1);
				return true;
			}
		}
		return false;
	}

	public void printOrder() {
		System.out.println("Your order is composed of:");
		for (Map.Entry<Menu<?, ?>, Integer> entry : this.menus.entrySet()) {
			int quantity = entry.getValue();
			Menu<?, ?> menu = entry.getKey();
			String className = menu.getClass().getSimpleName();
			float price = menu.getPrice();
			Drink drink = (Drink) menu.getDrink();
			Food food = menu.getMeal();
			for (int i = 0; i < quantity; i++) {
				System.out.println("- " + className + " menu (" + price + " euros)");
				System.out.println("-> drink: " + drink.getClass().getSimpleName());
				System.out.println("-> meal: " + food.getClass().getSimpleName());
			}
		}
		for (Map.Entry<Food, Integer> entry : this.items.entrySet()) {
			int quantity = entry.getValue();
			Food food = entry.getKey();
			String className = food.getClass().getSimpleName();
			float price = food.getPrice();
			for (int i = 0; i < quantity; i++) {
				System.out.println("- " + className + " (" + price + " euros)");
			}
		}
		System.out.println("For a total of " + this.getPrice() + " euros.");
	}
}
