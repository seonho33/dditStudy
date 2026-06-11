package sec01.exam08;

import java.util.Scanner;

public class SwitchStirngExample {
	public static void main(String[] args) {

		System.out.println("직위를 입력하십시오(부장, 과장,사원)");
		Scanner scanner = new Scanner(System.in);
		String position = scanner.nextLine();
				
		switch(position) {
		case "부장":
			System.out.println("700만원");
			break;
		case "과장":
			System.out.println("500만원");
			break;
		default:
			System.out.println("300만원");
		}
	}
}
