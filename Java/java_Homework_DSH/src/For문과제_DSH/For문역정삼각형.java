package For문과제_DSH;

import java.util.Scanner;

public class For문역정삼각형 {
	public static void main(String[] args) {
		
	Scanner scanner = new Scanner(System.in);
	System.out.println("역정삼각형의 높이 : ");
	int height = scanner.nextInt();

	for(int i=1; i<=height;i++) {
		for(int space = 1; space<i; space++) {
			System.out.print(" ");
		} for(int star = 0; star<((height-i)*2+1); star++) {
			System.out.print("*");
		}
		System.out.println();
	}
		scanner.close();
	}
}
