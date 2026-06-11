package sec04.exam05;

import java.util.Scanner;

public class CalculatorExample2 {
	public static void main(String[] args) {
		Calculator myCalcu	= new Calculator()	;
		
		Scanner scanner = new Scanner(System.in);
		
		double result1 = myCalcu.areaRectangle(10);
		System.out.println("한변의 길이가 10인 정사각형의 넓이는 "+ result1+"입니다.");
		
		System.out.println("가로길이를 입력하십시오.");
		double W = scanner.nextDouble();
		System.out.println("세로길이를 입력하십시오.");
		double H = scanner.nextDouble();
		double result2 = myCalcu.areaRectangle(W,H);
		
		System.out.println("입력한 사각형의 넓이는 : " +result2 + "입니다.");
		scanner.close();
	}
}