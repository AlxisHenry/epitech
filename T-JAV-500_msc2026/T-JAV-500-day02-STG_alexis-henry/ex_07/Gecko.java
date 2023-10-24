public class Gecko {

    private String name;
    private int age;
    private int energy = 100;

    public Gecko() {
        this("Unknown", 0);
    }

    public Gecko(String name) {
        this(name, 0);
    }

    public Gecko(String name, int age) {
        this.name = name;
        this.setAge(age);
        this.setEnergy(energy);
        if (name != "Unknown" && !name.isEmpty()) {
            System.out.println("Hello " + name + "!");
        } else {
            System.out.println("Hello!");
        }
    }

    public String getName() {
        return this.name;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(int age) {
        this.age = age;
        return;
    }

    public int getEnergy() {
        return this.energy;
    }

    public void setEnergy(int energy) {
        if (energy < 0) {
            this.energy = 0;
        } else if (energy > 100) {
            this.energy = 100;
        } else {
            this.energy = energy;
        }
    }

    public String status() {
        switch (this.age) {
            case 0:
                return "Unborn Gecko";
            case 1:
            case 2:
                return "Baby Gecko";
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
                return "Adult Gecko";
            case 11:
            case 12:
            case 13:
                return "Old Gecko";
            default:
                return "Impossible Gecko";
        }
    }

    public void hello(String greeting) {
        System.out.println("Hello " + greeting + ", I'm " + this.name + "!");
    }

    public void hello(int times) {
        for (int i = 0; i < times; i++) {
            System.out.println("Hello, I'm " + this.name + "!");
        }
    }

    public void eat(String food) {
        if (food.toLowerCase().equals("meat")) {
            System.out.println("Yummy!");
            this.setEnergy(energy + 10);
        } else if (food.toLowerCase().equals("vegetable")) {
            System.out.println("Erk!");
            this.setEnergy(energy - 10);
        } else {
            System.out.println("I can't eat this!");
        }
    }

    public void work() {
        if (this.energy <= 24) {
            System.out.println("Heyyy I'm too sleepy, better take a nap!");
            this.setEnergy(energy + 50);
        } else {
            System.out.println("I'm working T.T");
            this.setEnergy(energy - 9);
        }
    }
}
