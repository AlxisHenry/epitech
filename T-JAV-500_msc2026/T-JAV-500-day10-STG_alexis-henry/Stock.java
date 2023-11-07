import java.util.HashMap;
import java.util.Map;

public class Stock {

	private final Map<Class<? extends Food>, Integer> stock = new HashMap<>();

	public Stock() {
		stock.put(FrenchBaguette.class, 100);
		stock.put(SoftBread.class, 100);
		stock.put(HamSandwich.class, 100);
		stock.put(Panini.class, 100);
		stock.put(Cookie.class, 100);
		stock.put(CheeseCake.class, 100);
		stock.put(AppleSmoothie.class, 100);
		stock.put(Coke.class, 100);
	}

	public int getNumberOf(Class<? extends Food> food) throws NoSuchFoodException {
		if (stock.containsKey(food)) {
			return stock.get(food);
		} else {
			throw new NoSuchFoodException(food.getName());
		}
    }

	public boolean add(Class<? extends Food> food) throws NoSuchFoodException {
		if (stock.containsKey(food)) {
			stock.put(food, stock.get(food) + 1);
			return true;
		} else {
			throw new NoSuchFoodException(food.getName());
		}
    }

	public boolean remove(Class<? extends Food> food) throws NoSuchFoodException {
		if (stock.containsKey(food)) {
			if (stock.get(food) == 0) {
				return false;
			}
			int currentStock = stock.get(food);
			int newStock = currentStock > 0 ? currentStock - 1 : 0;
			stock.put(food, newStock);
			return true;
		} else {
			throw new NoSuchFoodException(food.getName());
		}
	}
}
