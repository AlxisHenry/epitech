package Factory;

import java.util.ArrayList;
import java.util.List;

public class Elf {
	private Toy toy = null;
	private List<GiftPaper> papers = new ArrayList<GiftPaper>();
	private Factory factory;

	public Elf(Factory factory) {
		this.factory = factory;
	}

	public boolean pickToy(String label) {
		if (this.toy != null) {
			System.out.println("Minute please?! I'm not that fast.");
			return false;
		}

		try {
			this.toy = this.factory.create(label);
			System.out.println("What a nice one! I would have liked to keep it...");
			return true;
		} catch (NoSuchToyException exception) {
			System.out.println("I didn't find any " + label + ".");
			return false;
		}
	}

	public boolean pickPapers(int count) {
		this.papers = this.factory.getPapers(count);
		return true;
	}

	public GiftPaper pack() {
		if (this.papers.isEmpty()) {
			System.out.println("Wait... I can't pack it with my shirt.");
			return null;
		}

		GiftPaper giftPaper = this.papers.get(0);

		if (this.toy == null) {
			System.out.println("I don't have any toy, but hey at least it's paper!");
		}  else {
			giftPaper.wrap(this.toy);
			this.toy = null;
			System.out.println("And another kid will be happy!");
		}
		
		this.papers.remove(0);
		return giftPaper;

	}
}
