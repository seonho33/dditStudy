package day04_Reveiw;

import java.util.Scanner;

public class Sec01Example01 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("점수를 입력하십시오");
		int score = scanner.nextInt();
		
		if(score>=90) {
			System.out.println("점수가 90보다 큽니다.");
			System.out.println("등급은 A입니다.");
		}
		
		if(score<90) {
			System.out.println("점수가 90보다 작습니다");
			System.out.println("등급은 B입니다");
		}
scanner.close();

	}
}
