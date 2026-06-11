package sec02;

public class SignOperatiorExample {
	public static void main(String[] args) {
		int x = -100;
		int result1 = +x;
		int result2 = -x;
		System.out.println("reslut1=" + result1);
		System.out.println("result2=" + result2);
		
		byte b = 100;
		//byte result3 = -b; 부호연산도 변수가 들어가면 int 값으로 변환되므로 컴파일에러
		int result3 = -b;
		System.out.println("result3=" + result3);
		System.out.println(result3);
	}
}
