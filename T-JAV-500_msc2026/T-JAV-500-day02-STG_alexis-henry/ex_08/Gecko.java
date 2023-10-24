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
            System.out.println("Heyyy too sleepy, better take a nap!");
            this.setEnergy(energy + 50);
        } else {
            System.out.println("I'm working T.T");
            this.setEnergy(energy - 9);
        }
    }

    public void notToday() {
        System.out.println("Not today!");
    }

    public void tooTired(String name) {
        System.out.println("Sorry " + name + ", I'm too tired to go out tonight.");
    }

    public void tooTiredReaction() {
        System.out.println("Oh! That's too bad, another time then!");
    }

    public void letsDrink(String name) {
        System.out.println("I'm going to drink with " + name + "!");
    }

    public void fraternize(Gecko gecko) {
        int currentGeckoEnergy = this.getEnergy();
        int geckoEnergy = gecko.getEnergy();
        if (geckoEnergy < 30 && currentGeckoEnergy < 30) {
            this.notToday();
            gecko.notToday();
        } else if (geckoEnergy < 30) {
            gecko.tooTired(this.getName());
            this.tooTiredReaction();
        } else if (currentGeckoEnergy < 30) {
            this.tooTired(gecko.getName());
            gecko.tooTiredReaction();
        } else {
            this.letsDrink(gecko.getName());
            gecko.letsDrink(this.getName());
            gecko.setEnergy(gecko.getEnergy() - 30);
            this.setEnergy(this.getEnergy() - 30);
        }
    }

    public void fraternize(Snake snake) {
        if (this.getEnergy() >= 10) {
            System.out.println("LET'S RUN AWAY!!!");
            this.setEnergy(0);
        } else {
            System.out.println("...");
        }
    }
}
