package chap09.sec01.exam04;

public class Outter {
	//자바 8이후
	public void method2(int arg) {
		int localvariable = 1;
		//arg =100;
		//localVariable = 100;
		class Inner{
			public void method() {
				int result = arg + localvariable;
			}
		}
	}
}