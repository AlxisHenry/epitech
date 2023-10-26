public class GreatWhite extends Shark {

	public GreatWhite(String name) {
		super(name);
	}

	@Override
	public boolean canEat(Animal animal) {
		return animal instanceof Canary ? false : super.canEat(animal);
	}

	@Override
	public void eat(Animal animal) {
		if (animal instanceof Shark && !canEat(animal)) {
			System.out.println(this.getName() + ": It's not worth my time.");
		} else if (animal instanceof Canary) {
			System.out.println(this.getName() + ": Next time you try to give me that to eat, I'll eat you instead.");
		} else {
			super.eat(animal);
			if (animal instanceof Shark) {
				System.out.println(getName() + ": The best meal one could wish for.");
			}
		}
	}
}
