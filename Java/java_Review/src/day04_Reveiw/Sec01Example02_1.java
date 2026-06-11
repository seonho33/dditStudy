package day04_Reveiw;

import java.util.Scanner;

public class Sec01Example02_1 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("점수를 입력하십시오");
		int score = scanner.nextInt();
		
		String grade = (score>=90)?"A등급입니다.":((score>=80) ? "B등급입니다." : "C등급입니다.");

		System.out.println( score + "점은 " + grade);
	
	scanner.close();
	}
}
