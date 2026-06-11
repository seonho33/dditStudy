package For문과제_DSH;

import java.util.Scanner;

public class For문정렬삼각형 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("삼각형의 층 수 : ");
		
		int height = scanner.nextInt();
		
		for(int i=1; i<=height;i++) {
			for(int k=1; k<=height-i;k++) {
				System.out.print(" ");
			}
			for(int j=1; j<=i;j++) {
				System.out.print("*");}
			System.out.println();
		}
	scanner.close();
	}
}