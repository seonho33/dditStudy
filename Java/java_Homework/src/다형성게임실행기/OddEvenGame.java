package 다형성게임실행기;

import java.util.Scanner;

public class OddEvenGame implements GameInterface {
	Scanner scanner = new Scanner(System.in);
	@Override
	public void GameBlock() {
		while(true) {
		System.out.println("==========================");
		System.out.println("   홀, 짝을 입력해주십시오.");
		System.out.println("==========================");
		String select = scanner.nextLine();
		int k = (int)(Math.random()*2);
		
		if(select.equals("홀")||select.equals("짝")) {
		switch(select) {
		case "홀" :
			if(k%2==0) {
				System.out.println("아쉽습니다 짝수입니다.");
			}else {
				System.out.println("축하합니다 홀수입니다.");
			}
			break;
		case "짝" :
			if(k%2==0) {
				System.out.println("축하합니다 짝수입니다.");
			}else {
				System.out.println("아쉽습니다 홀수입니다.");
			}
			break;
	}
break; }else {
		System.out.println("홀,짝만 입력해주십시오.");
			}
		}
}
	
	
	
	@Override
	public void GameExit() {
		System.out.println("종료합니다.");
	}
}
