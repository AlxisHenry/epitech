import chocolate.*;
import planet.*;

public class Astronaut {
	private static int id = 0;

	private int instanceId = 0;
	private String name = "";
	private int snacks = 0;
	private String destination = null;

	public Astronaut(
			String name) {
		this.instanceId = id;
		id++;

		this.name = name;
		System.out.println(this.getName() + " ready for launch!");
	}

	public void doActions() {
		System.out.println(this.getName() + ": Nothing to do.");
		this.checkIfAstronautHasDestination();
	}

	public void doActions(planet.Mars mars) {
		System.out.println(this.getName() + ": Started a mission!");
		this.destination = mars.getLandingSite();
	}

	public void doActions(planet.moon.Phobos phobos) {
		System.out.println(this.getName() + ": Started a mission!");
		this.destination = phobos.getLandingSite();
	}

	public void doActions(chocolate.Mars mars) {
		System.out.println(this.getName() + ": Thanks for this mars number " + mars.getId());
		this.snacks++;
		this.checkIfAstronautHasDestination();
	}

	public void checkIfAstronautHasDestination() {
		if (this.destination == null) {
			System.out.println(
					this.getName() + ": I may have done nothing, but I have " + this.getSnacks() + " Mars to eat at least!");
		}
	}

	public String getDestination() {
		return this.destination;
	}

	public int getSnacks() {
		return this.snacks;
	}

	public String getName() {
		return this.name;
	}

	public int getId() {
		return instanceId;
	}
}