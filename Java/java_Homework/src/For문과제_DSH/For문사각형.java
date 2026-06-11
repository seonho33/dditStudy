package For문과제_DSH;

import java.util.Scanner;

public class For문사각형 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("사각형의 세로길이 : ");
		int H = scanner.nextInt();
		
		System.out.println("사각형의 가로길이 : ");
		int L = scanner.nextInt();
		
		
		int i = 0;
		
		for(i=0;i<H;i++) {
			System.out.println();
			for(int k=0;k<3;k++) {
				System.out.print(" ");
			}
			for(int j=0;j<L;j++) {
				System.out.print("* ");
			}
			scanner.close();
		}
	}
}
