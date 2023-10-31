public class Warrior extends Character {
	public Warrior(String name) {
		super(name, "Warrior");
		this.life = 100;
		this.strength = 10;
		this.agility = 8;
		this.wit = 3;
		System.out.println(name + ": My name will go down in history!");
	}

	@Override
	public void attack(String weapon) throws WeaponException {
		if (weapon.isEmpty()) {
			throw new WeaponException(WeaponException.EMPTY_WEAPON_MESSAGE.replace("[name]", name));
		} else if (weapon.equalsIgnoreCase("hammer") || weapon.equalsIgnoreCase("sword")) {
			super.attack(weapon);
			System.out.println(name + ": I'll crush you with my " + weapon + "!");
		} else {
			throw new WeaponException(
					WeaponException.WRONG_WEAPON_WARRIOR_MESSAGE.replace("[name]", name).replace("[weapon]", weapon));
		}
	}

	@Override
	public void moveRight() {
		System.out.println(name + ": moves right like a bad boy.");
	}

	@Override
	public void moveLeft() {
		System.out.println(name + ": moves left like a bad boy.");
	}

	@Override
	public void moveBack() {
		System.out.println(name + ": moves back like a bad boy.");
	}

	@Override
	public void moveForward() {
		System.out.println(name + ": moves forward like a bad boy.");
	}
}
