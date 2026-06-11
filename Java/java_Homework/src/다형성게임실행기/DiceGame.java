package 다형성게임실행기;

import java.util.Scanner;

public class DiceGame implements GameInterface {

	Scanner scanner = new Scanner(System.in);
	@Override
	public void GameBlock() {
		
		while(true) {
		System.out.println("========================");
		System.out.println("주사위 맞추기 게임을 시작합니다.");
		System.out.println("========================");
		System.out.println(" 1~6 중의 숫자를 적어주십시오.");
		int i = Integer.parseInt(scanner.nextLine());
		int computer = (int)(Math.random()*6)+1;
			if(i!=1 && i!=2 && i!=3 && i!=4 && i!=5 && i!=6) {
			System.out.println("1~6 중의 숫자만 적어주십시오");
			continue;
			}
		System.out.println("주사위의 숫자는 " + computer + "입니다.");
		if(i==computer) {
		System.out.println("축하합니다 정답입니다.");	
		}else {
			System.out.println("아쉽습니다 틀렸습니다.");
		}break;
		}
	}
	
	
	@Override
	public void GameExit() {
		System.out.println("종료합니다.");
	}
}