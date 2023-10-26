public class Animal {

	private static int numberOfAnimals = 0;
	private static int numberOfMammals = 0;
	private static int numberOfFish = 0;
	private static int numberOfBirds = 0;
	private String name;
	private int legs;
	private Type type;

	protected enum Type {
		MAMMAL, FISH, BIRD
	}

	protected Animal(
			String name,
			int legs,
			Type type) {
		this.name = name;
		this.legs = legs;
		this.type = type;
		this.increment();
		System.out.println("My name is " + this.name + " and I am a " + this.getType() + "!");
	}

	private void increment() {
		numberOfAnimals++;
		switch (type) {
			case MAMMAL:
				numberOfMammals++;
				break;
			case FISH:
				numberOfFish++;
				break;
			case BIRD:
				numberOfBirds++;
				break;
		}
	}

	public String getName() {
		return name;
	}

	public int getLegs() {
		return legs;
	}

	public String getType() {
		return type.toString().toLowerCase();
	}

	private static String format(int count, String word) {
		String fword = (count == 1 ? word : word.equals("fish") ? "fish" : word + "s");

		return "There " + (count == 1 ? "is currently " : "are currently ") + count + " " + fword + " in our world.";
	}

	public static int getNumberOfAnimals() {
		System.out.println(format(numberOfAnimals, "animal"));
		return numberOfAnimals;
	}

	public static int getNumberOfMammals() {
		System.out.println(format(numberOfMammals, Type.MAMMAL.toString().toLowerCase()));
		return numberOfMammals;
	}

	public static int getNumberOfFish() {
		System.out.println(format(numberOfFish, Type.FISH.toString().toLowerCase()));
		return numberOfFish;
	}

	public static int getNumberOfBirds() {
		System.out.println(format(numberOfBirds, Type.BIRD.toString().toLowerCase()));
		return numberOfBirds;
	}

}