package 학생성적정렬;

import java.util.Scanner;

public class StudentScores {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("학생 수를 입력하십시오.");
		int k = Integer.parseInt(scanner.nextLine());
		Student[] student = new Student[k];

		for(int i=0;i<student.length;i++) {
			student[i] = new Student();
			System.out.println("학생의 이름을 입력하십시오.");
			student[i].setName(scanner.nextLine());
			System.out.println("국어,영어,수학 점수를 입력하십시오.");
			student[i].setKor(scanner.nextInt());
			student[i].setEng(scanner.nextInt());
			student[i].setmath(scanner.nextInt());
			scanner.nextLine();
		}

		for(int i=0;i<student.length-1;i++) {
			for(int j=0;j<student.length-1-i;j++) {
				if(student[j].getsum()<student[j+1].getsum()) {
					
					Student temp = student[j];
					student[j] = student[j+1];
					student[j+1] = temp;
				}
			}
		}
		
		System.out.println("==================================");
		System.out.println("등수 | 이름 | 국어 | 영어 | 수학 | 총점 |");
		for(int r=0;r<student.length;r++) {
		System.out.println("----------------------------------");
		System.out.println(" "+(r+1)+"    "+student[r].getName()+"   "+student[r].getKor()+"    "+student[r].getEng()+"    "+student[r].getmath()+"   "+student[r].getsum());
		System.out.println("----------------------------------");
		}
		System.out.println("==================================");
		scanner.close();
	}
}