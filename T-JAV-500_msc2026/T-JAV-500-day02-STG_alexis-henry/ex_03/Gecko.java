public class Gecko {

    private String name;

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

    public String getName() {
        return this.name;
    } 
}