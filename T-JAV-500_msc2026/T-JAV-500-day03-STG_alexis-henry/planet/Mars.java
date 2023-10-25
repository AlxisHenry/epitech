package planet;

public class Mars {
	private static int id = 0;
	private int instanceId = 0;
	private String landingSite = "";

	public Mars(
		String landingSite
	) {
		this.instanceId = id;
		id++;
		this.landingSite = landingSite;
	}

	public String getLandingSite() {
		return this.landingSite;
	}

	public int getId() {
		return this.instanceId;
	}
}