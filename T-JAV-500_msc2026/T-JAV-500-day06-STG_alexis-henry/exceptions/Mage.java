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
	public void attack(String weapon) throws WeaponException {
		if (weapon.isEmpty()) {
			throw new WeaponException(WeaponException.EMPTY_WEAPON_MESSAGE.replace("[name]", name));
		} else if (weapon.equalsIgnoreCase("magic") || weapon.equalsIgnoreCase("wand")) {
			super.attack(weapon);
			System.out.println(name + ": Feel the power of my " + weapon + "!");
		} else {
			throw new WeaponException(
					WeaponException.WRONG_WEAPON_MAGE_MESSAGE.replace("[name]", name).replace("[weapon]", weapon));
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
