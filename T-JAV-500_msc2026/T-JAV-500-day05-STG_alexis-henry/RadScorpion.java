public class RadScorpion extends Monster {
	private static int id = 0;

	public RadScorpion() {
		super("RadScorpion #" + (++id), 80, 50);
		System.out.println(this.getName() + ": Crrr!");
		damage = 25;
		apcost = 8;
	}

	@Override
	public boolean attack(Fighter fighter) {
		if (super.attack(fighter) && fighter instanceof SpaceMarine && !(fighter instanceof AssaultTerminator)) {
			fighter.receiveDamage(damage);
			return true;
		}
		return false;
	}
}
