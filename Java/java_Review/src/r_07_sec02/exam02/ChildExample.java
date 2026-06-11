package r_07_sec02.exam02;

public class ChildExample {
	public static void main(String[] args) {
		Child child = new Child();
		Parent parent = new Child();
		parent.method1();
		child.method2();
		child.method3();
		parent.method2();
		child.method1();
	}
}
