package Composite;

public class Word implements Sentence {

    private String word;

    public Word(String word) {
        this.word = word;
    }

    public void print() {
        System.out.println(word);
    }
	
}
