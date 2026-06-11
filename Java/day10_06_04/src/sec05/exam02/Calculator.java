package sec05.exam02;

public class Calculator {
	
	double pi = 3.14159;
	
	static int plus(int x, int y) {
		return x + y;
	}
	
	static int minus(int x, int y) {
		return x-y;
	}
	
	void printCircleArea() {
		double result1 = 10*10*pi;
		System.out.println(result1);
	}
}