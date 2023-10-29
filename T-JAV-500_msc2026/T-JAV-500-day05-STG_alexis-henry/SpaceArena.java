import java.util.List;
import java.util.ArrayList;

public class SpaceArena {
    protected List<Monster> monsters;
    protected List<SpaceMarine> spaceMarines;

    public SpaceArena() {
        this.monsters = new ArrayList<Monster>();
        this.spaceMarines = new ArrayList<SpaceMarine>();
    }

    public void enlistMonsters(List<Monster> monsters) {
        for (Monster monster : monsters) {
            if (!this.monsters.contains(monster)) {
                this.monsters.add(monster);
            }
        }
    }

    public void enlistSpaceMarines(List<SpaceMarine> spaceMarines) {
        for (SpaceMarine spaceMarine : spaceMarines) {
            if (!this.spaceMarines.contains(spaceMarine)) {
                this.spaceMarines.add(spaceMarine);
            }
        }
    }

    public boolean fight() {
        if (this.monsters.isEmpty()) {
            System.out.println("No monsters available to fight.");
            return false;
        }

        if (this.spaceMarines.isEmpty()) {
            System.out.println("Those cowards ran away.");
            return false;
        }

        while (!this.monsters.isEmpty() && !this.spaceMarines.isEmpty()) {
            SpaceMarine currentSpaceMarine = this.spaceMarines.get(0);
            Monster currentMonster = this.monsters.get(0);

            if (!currentSpaceMarine.getIsInArena()) {
                System.out.println(currentSpaceMarine.getName() + " has entered the arena.");
                currentSpaceMarine.setIsInArena(true);
            }

            if (!currentMonster.getIsInArena()) {
                System.out.println(currentMonster.getName() + " has entered the arena.");
                currentMonster.setIsInArena(true);
            }

            while (currentSpaceMarine.getHp() > 0 && currentMonster.getHp() > 0) {
                if (!currentSpaceMarine.attack(currentMonster)) {
                    if (currentSpaceMarine.getAp() <= currentSpaceMarine.getWeapon().getApcost()) {
                        currentSpaceMarine.recoverAP();
                    }
                }

                if (!currentMonster.attack(currentSpaceMarine)) {
                    if (currentMonster.getAp() <= currentMonster.getApcost()) {
                        currentMonster.recoverAP();
                    }
                }
            }

            if (currentSpaceMarine.getHp() <= 0) {
                this.spaceMarines.remove(0);
                currentMonster.recoverAP();
                currentMonster.setTargetIsClose(false);

                if (!this.spaceMarines.isEmpty()) {
                    currentSpaceMarine = this.spaceMarines.get(0);
                    System.out.println(currentSpaceMarine.getName() + " has entered the arena.");
                    currentSpaceMarine.setIsInArena(true);
                }
            }

            if (currentMonster.getHp() <= 0) {
                this.monsters.remove(0);
                currentSpaceMarine.recoverAP();
                currentSpaceMarine.setTargetIsClose(false);

                if (!this.monsters.isEmpty()) {
                    currentMonster = this.monsters.get(0);
                    System.out.println(currentMonster.getName() + " has entered the arena.");
                    currentMonster.setIsInArena(true);
                }
            }
        }

        String winnerTeam = this.monsters.isEmpty() ? "spaceMarines" : "monsters";
        System.out.println("The " + winnerTeam + " are victorious.");
        return true;
    }
}