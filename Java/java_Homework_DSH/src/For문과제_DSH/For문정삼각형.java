package For문과제_DSH;

import java.util.Scanner;

public class For문정삼각형 {

	public static void main(String[] args) {
		
	Scanner scanner = new Scanner(System.in);
	
	System.out.println("삼각형의 높이 : "); //1,3,5,7,9 ... 
	int height = scanner.nextInt();
	
	for(int i=1;i<=height;i++) {
		for(int space=0; space < height-i ; space++) {
			System.out.print(" ");
		}
		for(int star = 1 ; star <= (i*2-1) ; star++) {
			System.out.print("*");
		}
		System.out.println();
		}
	scanner.close();
	}
}