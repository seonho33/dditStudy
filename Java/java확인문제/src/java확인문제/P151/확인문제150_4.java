/*package day05_Reveiw;

import java.util.Scanner;

public class 확인문제150_4 {
	public static void main(String[] args) throws Exception {
		Scanner scanner = new Scanner(System.in);

		while(true) {
		System.out.println("학생 수: ");
		int students = Integer.parseInt(scanner.nextLine());
		
		System.out.println("연필 수: ");
		int pencils = Integer.parseInt(scanner.nextLine());
		
		//학생 1명이 가지는 연필 개수
		int pencilsPerStudent = pencils/students;
		System.out.println("학생 한명이 가지는 연필 개수:"+pencilsPerStudent);
		System.out.println("남은 연필 개수: " + (int)pencils%students);
		System.out.println("\n\n계속 하시려면 1, 종료 하시려면 2 입력");
		
		
		String ans = scanner.nextLine();
		if(ans.equals("2")) {
		System.out.println("종료합니다.");
		break;}
		if(ans.equals("1")) { 
		System.out.println("계속합니다.");}
		else {
		System.out.println("다시 입력해주십시오.");	
		}
		}
	}	
}
*/
