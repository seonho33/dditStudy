package sec02.exam02;

public class ChildExample {
	public static void main(String[] args) {
		D d = new D();
		
		d.method1();
		d.method2();
		d.method3();
		
		Child child = new Child();
		
		child.method1();
		child.method2();
		child.method3();
		
		
		Parent parent = child;
		
		parent.method1();
		parent.method2();
		//parent.method3();
	}
}
