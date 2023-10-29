public abstract class Unit implements Fighter {
	protected String name;
	protected int hp;
	protected int ap;
	protected Fighter target = null;
	protected boolean targetIsClose = false;

	protected Unit(String name, int hp, int ap) {
		this.name = name;
		this.hp = hp;
		this.ap = ap;
	}

	public String getName() {
		return this.name;
	}

	public int getHp() {
		return this.hp;
	}

	public int getAp() {
		return this.ap;
	}

	public boolean setTargetIsClose(boolean targetIsClose) {
		this.targetIsClose = targetIsClose;
		return true;
	}

	public boolean getTargetIsClose() {
		return this.targetIsClose;
	}

	public void receiveDamage(int damage) {
		if (damage > 0 && this.hp > 0) {
			this.hp -= damage;
			if (this.hp < 0) {
				this.hp = 0;
			}
		}
	}

	public boolean moveCloseTo(Fighter fighter) {
    if (getHp() <= 0) return false;
		if (target != fighter && fighter != this) {
			this.target = fighter;
			System.out.println(this.name + " is moving closer to " + fighter.getName() + ".");
			setTargetIsClose(true);
			return true;
		}
		setTargetIsClose(false);
		return false;
	}

	public void recoverAP() {
		this.ap += 7;
		if (this.ap > 50) {
			this.ap = 50;
		}
	}
}
