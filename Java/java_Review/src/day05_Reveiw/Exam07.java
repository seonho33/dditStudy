package day05_Reveiw;

import java.util.Scanner;

public class Exam07 {
	public static void main(String[] args) {
		System.out.println("등급을 입력하십시오.A,B,C");
		Scanner scanner = new Scanner(System.in);
		String grade = scanner.nextLine();
		
		switch(grade) {
		case "A":
		case "a":
			System.out.println("우수 회원입니다.");
			break;
		case "B":
		case "b":
			System.out.println("일반 회원입니다.");
			break;
		case "C":
		case "c":
			System.out.println("손님입니다.");
		break;
		
		}
	scanner.close();
	}
}
