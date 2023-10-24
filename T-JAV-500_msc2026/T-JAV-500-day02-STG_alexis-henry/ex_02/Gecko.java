public class Gecko {

    public String name;

    public Gecko() {
        this("Unknown");
    }

    public Gecko(String name) {
        this.name = name;
        if (name != "Unknown" && !name.isEmpty()) {
            System.out.println("Hello " + name + "!");
        } else {
            System.out.println("Hello!");
        }
    }
}