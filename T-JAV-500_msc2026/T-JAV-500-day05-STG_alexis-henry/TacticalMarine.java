public class TacticalMarine extends SpaceMarine {

	public TacticalMarine(String name) {
		super(name, 100, 20);
		System.out.println(this.name + " on duty.");
		PlasmaRifle weapon = new PlasmaRifle();
		this.equip(weapon);
	}

	@Override
	public void recoverAP() {
		ap += 12;
		if (ap > 50) {
			ap = 50;
		}
	}
}
