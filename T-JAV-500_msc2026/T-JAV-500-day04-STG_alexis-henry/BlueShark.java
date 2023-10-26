public class BlueShark extends Shark {

	public BlueShark(String name) {
		super(name);
	}

	@Override
	public boolean canEat(Animal animal) {
		return super.canEat(animal) && animal.getType().equals(Type.FISH.toString().toLowerCase());
	}
}
