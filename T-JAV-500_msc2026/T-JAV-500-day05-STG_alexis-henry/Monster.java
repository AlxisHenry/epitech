public abstract class Monster extends Unit {
	protected int damage; 
	protected int apcost;
  protected boolean isInArena = false;

	public Monster(String name, int hp, int ap) {
		super(name, hp, ap);
		this.damage = 0;
		this.apcost = 0;
	}

	public int getDamage() {
		return this.damage;
	}

	public int getApcost() {
		return this.apcost;
	}

	public boolean equip(Weapon weapon) {
		System.out.println("Monsters are proud and fight with their own bodies.");
		return true;
	}

	public boolean attack(Fighter fighter) {
		if (fighter.getHp() > 0 && this.getHp() > 0) {
			if (!targetIsClose) {
				System.out.println(this.getName() + ": I'm too far away from " + fighter.getName() + ".");
				moveCloseTo(fighter);
				return true;
			}
			if (this.getAp() >= apcost) {
				System.out.println(this.getName() + " attacks " + fighter.getName() + ".");
				fighter.receiveDamage(damage);
				this.ap -= apcost;
				return true;
			}
		}
		return false;
	}

	public boolean getIsInArena() {
    return isInArena;
  }

  public void setIsInArena(boolean isInArena) {
    this.isInArena = isInArena;
  }
}
