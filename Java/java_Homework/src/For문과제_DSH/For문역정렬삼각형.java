package For문과제_DSH;

import java.util.Scanner;

public class For문역정렬삼각형 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("삼각형의 높이 : ");
		int height = scanner.nextInt();
		
		
		for(int i = 1 ; i <= height ; i++) {
			for(int j = 1 ; j<=height-i ; j++) {
				System.out.print(" ");
			}for(int k = 0 ; k < i;k++) {
				System.out.print("*");
			}
			System.out.println();
		}
		scanner.close();
	}
}
