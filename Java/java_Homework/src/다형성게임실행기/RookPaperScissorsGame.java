package 다형성게임실행기;

import java.util.Scanner;

public class RookPaperScissorsGame implements GameInterface {

	
	
	@Override
	public void GameBlock() {
		Scanner scanner = new Scanner(System.in);	
		
		while(true) {
			System.out.println(" 가위, 바위, 보 중 입력하십시오.");
		int Q = (int)(Math.random()*3);
		String A = scanner.nextLine();
		
		System.out.println("\n=== 결과 ===");
		switch(Q) {
		case 0:
			System.out.println("컴퓨터 : 가위");
		break;
		case 1:
			System.out.println("컴퓨터 : 바위" );
		break;
		case 2:
			System.out.println("컴퓨터 : 보");
		break;}

		System.out.println("당 신 : " + A + "\n");
		
		{if(A.equals("가위")){
			if(Q==0) {
				System.out.println("  비겼습니다.");
			}if(Q==1) {
				System.out.println("당신이 졌습니다.");
			}if(Q==2) {
				System.out.println("당신이 이겼습니다.");
			}}
		else if(A.equals("바위")) {
			if(Q==0) {                                
				System.out.println("당신이 이겼습니다.");}
			if(Q==1) {
				System.out.println("  비겼습니다.");}
			if(Q==2) {
				System.out.println("당신이 졌습니다.");}
			}
		else if(A.equals("보")) {
			if(Q==0) {
				System.out.println("당신이 졌습니다.");}
			if(Q==1) {
				System.out.println("당신이 이겼습니다.");}
			if(Q==2) {
				System.out.println("  비겼습니다.");}}
		else{
			continue;
		}}
		break;
		}
	}

	
	
	
	@Override
	public void GameExit() {
		System.out.println("종료합니다.");
	}
}
