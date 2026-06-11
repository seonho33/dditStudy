package 학생성적정렬;

import java.util.Scanner;

public class 버블정렬과제2 {
	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);

		System.out.println("학생 수를 적으십시오.");
		int k = scanner.nextInt();
		Student[] student = new Student[k];
		
		for(int i=0;i<k;i++) {
		System.out.println("학생 이름을 적으십시오.");
		String name = scanner.nextLine();
		System.out.println(name + "학생의 국어점수를 적으십시오.");
		int kor = scanner.nextInt();
		System.out.println(name + "학생의 영어점수를 적으십시오.");
		int eng = scanner.nextInt();
		System.out.println(name + "학생의 java점수를 적으십시오.");
		int java = scanner.nextInt();
		
		student[i].setName(name);
		student[i].setKor(kor);
		student[i].setEng(eng);
		student[i].setJava(java);
		}
		System.out.println(student[0]+" "+ student[1]+ " "+student[2]);
	
	}
}
		
 