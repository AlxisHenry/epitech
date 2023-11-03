package Composite;

import java.util.ArrayList;
import java.util.List;

public class SentenceComposite implements Sentence {
	private List<Sentence> childSentence = new ArrayList<Sentence>();
	
	public void print() {
		for (Sentence sentence : this.childSentence) {
            sentence.print();
        }
	}
	
	public void add(Sentence sentence) {
		this.childSentence.add(sentence);
	}
	
	public void remove(Sentence sentence) {
		this.childSentence.remove(sentence);
	}
}
