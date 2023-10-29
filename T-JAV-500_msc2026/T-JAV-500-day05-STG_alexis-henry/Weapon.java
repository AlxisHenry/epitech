public abstract class Weapon {
	protected String name;
	protected int apcost;
	protected int damage;
	protected boolean melee;
	protected SpaceMarine owner;

	protected Weapon(
		String name,
		int apcost,
		int damage,
		boolean melee
	) {
		this.name = name;
		this.apcost = apcost;
		this.damage = damage;
		this.melee = melee;
		this.owner = null;
	}

	public String getName() {
		return this.name;
	}

	public int getApcost() {
		return this.apcost;
	}

	public int getDamage() {
		return this.damage;
	}

	public boolean isMelee() {
		return this.melee;
	}

	public SpaceMarine getOwner() {
		return this.owner;
	}

	public void setOwner(SpaceMarine owner) {
		this.owner = owner;
	}

	public abstract void attack();
}