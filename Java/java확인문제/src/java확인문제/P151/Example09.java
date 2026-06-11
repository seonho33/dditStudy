package java확인문제.P151;

import java.util.Scanner;

public class Example09 {
	public static void main(String[] args) throws Exception {
		Scanner scan = new Scanner(System.in);
		
		System.out.println("첫 번째 수: ");
		double a = scan.nextDouble();
		System.out.println("두 번째 수: ");
		double b = scan.nextDouble();
		
		System.out.println("----------------");
		
		if(b==0.0) {
			System.out.println("결과: 무한대");
		}if(b!=0) {
		
		System.out.println("결과: "+ a/b);
		}
	}
}
