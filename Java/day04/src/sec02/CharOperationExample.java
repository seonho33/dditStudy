package sec02;

public class CharOperationExample {
	public static void main(String[] args) {
		char c1 = 'A' + 1;
		char c2 = 'A';
		//char c3 = c2 + 1; << char 변수도 산술연산에 사용되면 int 로 프로모션
		int c3 = c2 +1 ;
		
		System.out.println("c1: " + c1);
		System.out.println("c2: " + c2);
		System.out.println("c3: " + c3);
		System.out.println("\u0042");
		System.out.println((char)0X0042);
		System.out.println("c3를 char타입으로 변경: " + (char)c3);
		System.out.println(String.valueOf((char)c3));
	}
}