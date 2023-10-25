import java.util.ArrayList;

public class Team {
	private String name = "";
	private ArrayList<Astronaut> members = new ArrayList<Astronaut>();
	private int numberOfMembers = 0;

	public Team(String name) {
		this.name = name;
	}

	public void doActions() {
		System.out.println(this.getName() + ": Nothing to do.");
	}

	public void doActions(Object object) {
		for (Astronaut astronaut : members) {
			if (object instanceof planet.Mars) {
				astronaut.doActions((planet.Mars) object);
			} else if (object instanceof planet.moon.Phobos) {
				astronaut.doActions((planet.moon.Phobos) object);
			} else if (object instanceof chocolate.Mars) {
				astronaut.doActions((chocolate.Mars) object);
			}
		}
	}

	public void add(Astronaut astronaut) {
		if (astronaut != null) {
			this.members.add(astronaut);
			this.numberOfMembers++;
		} else {
			System.out.println("No astronaut given.");
		}
	}

	public void remove(Astronaut astronaut) {
		this.members.remove(astronaut);
		this.numberOfMembers--;
	}

	public int countMembers() {
		return this.numberOfMembers;
	}

	public void showMembers() {
		String message = this.getName() + ": ";
		if (this.countMembers() > 0 && this.members != null) {
			for (Astronaut astronaut : members) {
				String activity = (astronaut.getDestination() == null) ? " on standby" : " on mission";
				message += astronaut.getName() + activity;
				if (this.members.indexOf(astronaut) < this.countMembers() - 1) {
					message += ", ";
				} else {
					message += ".";
				}
			}
		}
		System.out.println(message);
	}

	public String getName() {
		return this.name;
	}
}
