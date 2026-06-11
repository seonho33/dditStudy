package day04_Reveiw;

import java.util.Scanner;

public class Sec02Example11 {
	public static void main(String[] args) {
	
	System.out.println("점수를 입력하십시오.");
	Scanner scanner = new Scanner(System.in);
	int score = scanner.nextInt();
	
	String grade = (score>90)?"A":((score>80)?"B":"C");
	System.out.println(score + "점은 " + grade + "등급입니다.");
	scanner.close();
	}
}
