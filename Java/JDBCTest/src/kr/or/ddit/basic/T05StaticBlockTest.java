package kr.or.ddit.basic;

public class T05StaticBlockTest {
	
	{
		System.out.println("첫번째 instance block 호출됨.");
	}
	
	{
		System.out.println("두번째 instance block 호출됨.");
	}
	
	public T05StaticBlockTest() {
		System.out.println("생성자 호출됨.");
	}
	
	static {
		System.out.println("첫번째 static block 호출됨.");
	}
	static {
		System.out.println("두번째 static block 호출됨.");
	}
	
	
	public static void main(String[] args) {
		/*
			코드블럭 호출되는 순서
			
			1. static block
			2. instance block
			3. 생성자
		*/
		new T05StaticBlockTest();
		new T05StaticBlockTest();
		new T05StaticBlockTest();
	}
}