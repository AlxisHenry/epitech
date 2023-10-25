package planet.moon;

import planet.Mars;

public class Phobos {
	private Mars mars = null;
	private String landingSite = null;

	public Phobos(
			Mars mars,
			String landingSite) {
		if (mars != null) {
			this.mars = mars;
			this.landingSite = landingSite;
			System.out.println("Phobos placed in orbit.");
		} else {
			System.out.println("No planet given.");
		}
	}

	public String getLandingSite() {
		return this.landingSite;
	}

	public Mars getMars() {
		return this.mars;
	}
}