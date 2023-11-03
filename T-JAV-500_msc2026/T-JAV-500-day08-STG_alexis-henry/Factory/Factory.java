package Factory;

import java.util.ArrayList;
import java.util.List;

public class Factory {

	
	public Toy create(String label) throws NoSuchToyException {
		if (label.equals("teddy")) {
			return new TeddyBear();
		} else if (label.equals("gameboy")) {
			return new Gameboy();
		}
		
		throw new NoSuchToyException(label);
	}
	
	public List<GiftPaper> getPapers(int count) {
        List<GiftPaper> giftPapers = new ArrayList<>();

        for (int i = 0; i < count; i++) {
            GiftPaper giftPaper = new GiftPaper();
            giftPapers.add(giftPaper);
        }

        return giftPapers;
	}
}
