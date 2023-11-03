import java.lang.reflect.Method;

public class TestRunner {
	public void runTests(Class<?> className) {
		try {
			Object tmp = className.getDeclaredConstructor().newInstance();
			Method[] methods = className.getDeclaredMethods();
			Method beforeClass = null;
			Method before = null;
			Method after = null;
			Method afterClass = null;
			for (Method method : methods) {
				if (method.isAnnotationPresent(BeforeClass.class)) {
					beforeClass = method;
				}
				else if (method.isAnnotationPresent(Before.class)) {
					before = method;
				}
				else if (method.isAnnotationPresent(After.class)) {
					after = method;
				}
				else if (method.isAnnotationPresent(AfterClass.class)) {
					afterClass = method;
				}
			}
			if (!(beforeClass == null)) {
				try {
					beforeClass.invoke(tmp, (Object[]) null);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			for (Method method : methods) {
				if (method.isAnnotationPresent(Test.class)) {
					Test testAnnotation = method.getAnnotation(Test.class);
					if (testAnnotation.enabled()) {
						if (!(before == null)) {
							try {
								before.invoke(tmp, (Object[]) null);
							}
							catch (Exception e) {
								e.printStackTrace();
							}
						}
						System.out.println(method.getAnnotation(Test.class).name());
						try {
							method.invoke(tmp, (Object[]) null);
						}
						catch (Exception e) {
							e.printStackTrace();
						}
						if (!(after == null)) {
							try {
								after.invoke(tmp, ((Object[]) null));
							}
							catch (Exception e) {
								e.printStackTrace();
							}
						}
					}
				}
			}
			if (!(afterClass == null)) {
				try {
					afterClass.invoke(tmp, (Object[]) null);
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
