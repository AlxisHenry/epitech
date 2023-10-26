public class Cat extends Animal {

	private String color = "grey";

	public Cat(String name) {
		super(name, 4, Type.MAMMAL);
		System.out.println(this.getName() + ": MEEEOOWWWW");
	}

	public Cat(String name, String color) {
		super(name, 4, Type.MAMMAL);
		this.color = color;
		System.out.println(this.getName() + ": MEEEOOWWWW");
	}

	public void meow() {
		System.out.println(this.getName() + " the " + this.color + " kitty is meowing.");
	}

	public String getColor() {
		return this.color;
	}

}
