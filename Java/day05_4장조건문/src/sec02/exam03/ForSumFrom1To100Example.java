package sec02.exam03;

import java.util.Scanner;

public class ForSumFrom1To100Example {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
	
		System.out.println("숫자를 입력 하십시오.");
		
		int sum = 0;
		int p = Integer.parseInt(scanner.nextLine()) ;
		int i;
		
		for(i=0; i<=p; i++) {
			sum+=i;
		}
		
		System.out.println("1~" + p + "의 합 : " + sum);
	}
}
