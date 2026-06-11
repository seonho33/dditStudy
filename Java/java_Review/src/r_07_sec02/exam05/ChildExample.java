package r_07_sec02.exam05;

public class ChildExample {
	public static void main(String[] args) {
		Parent parent = new Child();
		parent.field1 = "data1";
		parent.method1();
		parent.method2();
		Child child = new Child();
		
		System.out.println(child.field1);
		Parent P = child;
		System.out.println(child.field1);
		System.out.println(P.field1);
		
		Child C =(Child) parent;
		System.out.println(parent.field1);
		
		child.field2 = "child";
		
		//System.out.println(parent.field2);
		
		child.method3();
		
	}
}
