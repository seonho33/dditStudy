package r_08_sec02.exam05;

public class Example {
	public static void main(String[] args) {
		ImplementationC impl = new ImplementationC();

		impl.methodA();
		impl.methodB();
		impl.methodC();
		System.out.println();
		
		InterfaceA ia = impl;
		ia.methodA();
		System.out.println();
		
		InterfaceB ib = impl;
		ib.methodB();
		System.out.println();
		
		InterfaceC ic = impl;
		ic.methodC();
		ic.methodB();
		ic.methodA();
		System.out.println();
	}
}