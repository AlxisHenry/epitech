import java.util.ArrayList;
import java.util.List;
import java.lang.reflect.*;

public class Inspector<T> {
	private Class<T> inspectedClass;
	public Inspector(Class<T> inspectedClass) {
		this.inspectedClass = inspectedClass;
	}
	public void displayInformations() {
		System.out.println("Information of the \"" + inspectedClass.getName() + "\" class:");
		System.out.println("Superclass: " + inspectedClass.getSuperclass().getName());
		Method[] methods = inspectedClass.getDeclaredMethods();
		System.out.println(methods.length + " methods:");
		for (Method method : methods) {
			System.out.println("- " + method.getName());
		}
		Field[] fields = inspectedClass.getDeclaredFields();
		System.out.println(fields.length + " fields:");
		for (Field field : fields) {
			System.out.println("- " + field.getName());
		}
	}

	public T createInstance() throws Exception {
		try {
			Constructor<T> defaultConstructor = inspectedClass.getDeclaredConstructor();
			defaultConstructor.setAccessible(true);
			return defaultConstructor.newInstance();
		} catch (Exception e) {
			throw e;
		}
	}

}
