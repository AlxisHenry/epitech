public abstract class SpaceMarine extends Unit {
	private Weapon weapon;
  protected boolean isInArena = false;

	public SpaceMarine(String name, int hp, int ap) {
		super(name, hp, ap);
		weapon = null;
	}

	public Weapon getWeapon() {
		return this.weapon;
	}

	public boolean equip(Weapon weapon) {
		if (weapon.getOwner() != null)
			return false;
		weapon.setOwner(this);
		this.weapon = weapon;
		System.out.println(name + " has been equipped with a " + weapon.getName() + ".");
		return true;
	}

	public boolean attack(Fighter fighter) {
		if (this.getHp() < 0) {
      return false;
    }
		
		if (this.weapon == null) {
			System.out.println(name + ": Hey, this is crazy. I'm not going to fight this empty-handed.");
			return false;
		}

		if (weapon.isMelee() && !getTargetIsClose()) {
			System.out.println(name + ": I'm too far away from " + fighter.getName() + ".");
			moveCloseTo(fighter);
			return true;
		}

		if (ap >= weapon.getApcost()) {
			System.out.println(name + " attacks " + fighter.getName() + " with a " + weapon.getName() + ".");
			fighter.receiveDamage(weapon.getDamage());
			weapon.attack();
			ap -= weapon.getApcost();
			return true;
		} else {
			return false;
		}
	}
	
  public boolean getIsInArena() {
    return isInArena;
  }

  public void setIsInArena(boolean isInArena) {
    this.isInArena = isInArena;
  }

	@Override
	public void recoverAP() {
		ap += 9;
		if (ap > 50) {
			ap = 50;
		}
	}
}
