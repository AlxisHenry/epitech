public abstract class Character implements Movable, Comparable<Character> {
	protected String name;
	protected int life;
	protected int agility;
	protected int strength;
	protected int capacity;
	protected int wit;
	protected final String RPGClass;

	public Character(String name, String RPGClass) {
		this.name = name;
		this.RPGClass = RPGClass;
		this.life = 50;
		this.agility = 2;
		this.strength = 2;
		this.capacity = 0;
		this.wit = 2;
	}

	public Character(String name, String RPGClass, int capacity) {
		this(name, RPGClass);
		this.capacity = capacity;
	}

	public String getName() {
		return name;
	}

	public int getLife() {
		return life;
	}

	public int getAgility() {
		return agility;
	}

	public int getStrength() {
		return strength;
	}

	public int getWit() {
		return wit;
	}

	public String getRPGClass() {
		return RPGClass;
	}

	public void attack(String weapon) {
		System.out.println(name + ": Rrrrrrrrr....");
	}

	public void moveRight() {
		System.out.println(name + ": moves right");
	}

	public void moveLeft() {
		System.out.println(name + ": moves left");
	}

	public void moveForward() {
		System.out.println(name + ": moves forward");
	}

	public void moveBack() {
		System.out.println(name + ": moves back");
	}

	public final void unsheathe() {
		System.out.println(name + ": unsheathes his weapon.");
	}

	public int compareTo(Character character) {
		if (this.getClass() == character.getClass()) {
			return this.capacity - character.capacity;
		}
		
		if (character instanceof Mage && this instanceof Warrior) {
			if (this.capacity % character.capacity == 0) {
				return 1;
			} else {
				return -1;
			}
		}
		
		if (character instanceof Warrior && this instanceof Mage) {
			if (character.capacity % this.capacity == 0) {
				return -1;
			} else {
				return 1;
			}
		}

		return 0;
	}

}