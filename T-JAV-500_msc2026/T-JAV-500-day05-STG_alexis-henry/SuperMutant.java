public class SuperMutant extends Monster {
	private static int id = 0;

	public SuperMutant() {
		super("SuperMutant #" + (++id), 170, 20);
		damage = 60;
		apcost = 20;
		System.out.println(this.getName() + ": Roaarrr!");
	}

	@Override
	public void recoverAP() {
		super.recoverAP();
		hp += 10;
		if (hp > 170) {
			hp = 170;
		}
	}

}
