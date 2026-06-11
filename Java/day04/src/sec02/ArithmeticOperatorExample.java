package sec02;

public class ArithmeticOperatorExample {
	public static void main(String[] args) {
		byte v1 = 5;
		byte v2 = 2;
		
		int result1 = v1 + v2; //byte +byte 여도 변수가 산술연산에 사용되면 int로 프로모션
		System.out.println("result1=" + result1);
		
		int result2 = v1 - v2;
		System.out.println("result2=" + result2);
		
		int result3 = v1 * v2;
		System.out.println("result3=" + result3);
		
		int result4 = v1 / v2;
		System.out.println("result4=" + result4);
		
		int result5 = v1 % v2;
		System.out.println("result5=" + result5);
		
		double result6 = (double) v1 / v2;
		System.out.println("result6=" + result6);
	}
}