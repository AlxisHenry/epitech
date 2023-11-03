package Decorator;

public class StuffDecorator extends Warrior {
	protected Warrior holder;
	
	@Override
	public int getHp() {
		return this.holder.getHp();
	}
	
	@Override
	public int getDmg() {
		return this.holder.getDmg();
	}
	
}
