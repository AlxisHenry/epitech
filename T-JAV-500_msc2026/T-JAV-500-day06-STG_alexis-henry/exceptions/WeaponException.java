public class WeaponException extends Exception {
	public static final String EMPTY_WEAPON_MESSAGE = "[name]: I refuse to fight with my bare hands.";
	public static final String WRONG_WEAPON_WARRIOR_MESSAGE = "[name]: A [weapon]?? What should I do with this?!";
	public static final String WRONG_WEAPON_MAGE_MESSAGE = "[name]: I don't need this stupid [weapon]! Don't misjudge my powers!";

	public WeaponException(String message) {
		super(message);
	}
}