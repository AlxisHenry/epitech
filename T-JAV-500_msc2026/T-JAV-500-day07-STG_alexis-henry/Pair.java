public class Pair<F, S> {
	private F first;
	private S second;

	public Pair(F first, S second) {
		this.first = first;
		this.second = second;
	}

	public void display() {
		System.out.println("first: " + first + ", second: " + second + ".");
	}

	public F getFirst() {
		return first;
	}

	public S getSecond() {
		return second;
	}
}
