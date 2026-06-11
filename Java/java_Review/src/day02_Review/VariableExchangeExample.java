package day02_Review;

public class VariableExchangeExample {
	public static void main(String[] args) {
		int x = 3;
		int y = 5;
		System.out.println("x: " + x + ", y: " + y);
		
		int temp = x;
		x = y;
		y = temp;
		System.out.println("x: " + x + ", y: "+y);

	//위에서 아래로 순차적으로 변환됨
		
	}
}
