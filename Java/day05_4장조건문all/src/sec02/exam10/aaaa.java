package sec02.exam10;

import java.util.Scanner;

public class aaaa {
	public static void main(String[] args) throws Exception {
		
		
		Scanner scan = new Scanner(System.in);
		
		String num;
	
		
		do {System.out.println("다음 메뉴중에서 골라주세요");
			System.out.println("1.짬뽕, 2.짜장");
			
			num = scan.nextLine();
			
			switch(num) {
		case "짬뽕":
		case "1":
			System.out.println("짬뽕을 선택하셨네요.");
			break;
		case "짜장":
		case "2":
			System.out.println("짜장을 선택하셨네요.");
			break;
		default:
			System.out.println("짬뽕이나 짜장 중에 선택해 주세요.");
			break;
		}
	}while(!(num.equals("짬뽕")|| num.equals("짜장")||num.equals("1")||num.equals("2")));
		scan.close();
	}
}
