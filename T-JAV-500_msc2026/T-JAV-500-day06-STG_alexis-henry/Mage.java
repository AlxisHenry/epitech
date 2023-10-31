public class Mage extends Character {
	public Mage(String name) {
		super(name, "Mage");
		this.life = 70;
		this.agility = 10;
		this.strength = 3;
		this.wit = 10;
		System.out.println(name + ": May the gods be with me.");
	}

	@Override
	public void attack(String weapon) {
		if (weapon.equalsIgnoreCase("magic") || weapon.equalsIgnoreCase("wand")) {
			super.attack(weapon);
			System.out.println(name + ": Feel the power of my " + weapon + "!");
		}
	}

	@Override
	public void moveRight() {
		System.out.println(name + ": moves right furtively.");
	}

	@Override
	public void moveLeft() {
		System.out.println(name + ": moves left furtively.");
	}

	@Override
	public void moveBack() {
		System.out.println(name + ": moves back furtively.");
	}

	@Override
	public void moveForward() {
		System.out.println(name + ": moves forward furtively.");
	}
}
