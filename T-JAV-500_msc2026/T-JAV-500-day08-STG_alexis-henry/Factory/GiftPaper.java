package Factory;

public class GiftPaper {

	private Toy gift = null;
	
	public void wrap(Toy toy) {
		this.gift = toy;
	}
	
	public Toy unwrap() {
		Toy gift = this.gift;
		this.gift = null;
		return gift;
	}
}
