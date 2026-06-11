package 가위바위보게임_DSH;

import java.util.Scanner;

public class 가위바위보과제 {
	public static void main(String[] args) throws Exception {
		
		Scanner scanner = new Scanner(System.in);	
		
		while(true) {
			System.out.println(" 가위, 바위, 보 중 입력하십시오.\n 종료하시려면 \"종료\"라고 입력하십시오.\n");
		int Q = (int)(Math.random()*3);
		String A = scanner.nextLine();
		if(A.equals("종료")) {
			System.out.println("종료합니다.");
			break;
		}
		
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
			System.out.println("**가위, 바위, 보 중에서만 입력해주십시오.**");
		}}
		System.out.println("===========");
		}
	scanner.close();
	}
	}