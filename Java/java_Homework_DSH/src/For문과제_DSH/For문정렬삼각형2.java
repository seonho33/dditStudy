package For문과제_DSH;

import java.util.Scanner;

public class For문정렬삼각형2 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("삼각형의 높이 : ");
		
		int height = scanner.nextInt();
		
		for(int i=0;i<height;i++) {
			for(int j=0; j<=i;j++) {
				System.out.print("*");
			}
			System.out.println();
		}
	scanner.close();
	}
}
