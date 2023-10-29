public class AssaultTerminator extends SpaceMarine {

	public AssaultTerminator(String name) {
		super(name, 150, 30);
		System.out.println(this.name + " has teleported from space.");
		PowerFist weapon = new PowerFist();
		this.equip(weapon);
	}

	@Override
	public void receiveDamage(int damage) {
		super.receiveDamage(damage - 3 < 1 ? 1 : damage - 3);
	}
}
