package kr.or.ddit.basic;

import java.util.Scanner;

public class DebuggingTest {
	public static void main(String[] args) {
		int a = 10;
		int b = 20;
		Scanner scanner = new Scanner(System.in);
		
		System.out.print("a = ");
		a = scanner.nextInt();
		System.out.println("b = ");
		b = scanner.nextInt();
		
		scanner.close();

		System.out.println("a =" + a + " b = "+b);
		
		int result = 0;
		
		if(a>20) {
			result = add10(a,b);
		}else {
			result = add20(a,b);
		}

		result = sum(result);
		System.out.println("result : " + result);
	}
	private static int add20(int a, int b) {
		int result = a+b+10;
		return result;
	}
	private static int add10(int a, int b) {
		int result = a+b+10;
		return result;
	}
	
	/**
	 * 합계 처리 메서드
	 * @param cnt 합계를 구할 범위 수
	 * @return cnt까지의 합계
	 */
	
		private static int sum(int cnt) {
			
			int sum = 0;
			for (int i = 1; i<=cnt;i++) {
				sum +=1;
			}
			return sum;
		}
}
