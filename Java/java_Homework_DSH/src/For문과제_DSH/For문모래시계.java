package For문과제_DSH;

import java.util.Scanner;

public class For문모래시계 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("위쪽 모래시계의 층수 : ");		
		int height = scanner.nextInt();
		
		for(int i = 1; i<=height; i++) { 
			for(int space = 1; space<i; space++) { 		
			System.out.print(" ");
		}	for(int star = 0; star<((height-i)*2+1);star++) {
			System.out.print("*");
		}
		System.out.println();}
			for(int ii = 2; ii<=height; ii++) {
				for(int space1 = 1; space1<=height-ii;space1++) {
					System.out.print(" ");
				}for(int star1 = 0; star1<ii*2-1;star1++) {
					System.out.print("*");
				}
				System.out.println();
			}
	scanner.close();
	}
}