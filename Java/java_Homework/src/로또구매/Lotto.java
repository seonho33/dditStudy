package 로또구매;

import java.util.Arrays;
import java.util.Scanner;

public class Lotto {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		Outter : while(true) {
		System.out.println("========================");
		System.out.println("      Lotto 프로그램");
		System.out.println("------------------------");
		System.out.println("1. Lotto 구입");
		System.out.println("2. 프로그램 종료");
		System.out.println("========================");
		System.out.println("메뉴 선택:");
		
		int mod = Integer.parseInt(scanner.nextLine());
		
		switch(mod) {
		case 1:
		System.out.println("     Lotto 구입 시작");
		System.out.println("(1000원에 로또 1장입니다.)");
		System.out.println("금액 입력:");
		int money = Integer.parseInt(scanner.nextLine());
		if(money<1000) {
			System.out.println("금액이 너무 적습니다. 거스름돈 :"+money+"원");
			continue Outter;
		}
		int Game = money/1000;
		int[][] lotto = new int[Game][6];
		
		for(int g=0; g<Game; g++) {
			for(int i=0; i<lotto[g].length;i++) {
				lotto[g][i]=(int)(Math.random()*45+1);
				for(int j=0;j<i;j++) {
					while(true) {
					if(lotto[g][j]==lotto[g][i]) {
						lotto[g][j]=(int)(Math.random()*45+1);
					}else {
						break;
					}
					}
				}
			}
		}
		System.out.println("행운의 번호는 아래와 같습니다.\n");
		for(int i=0;i<Game;i++) {
		System.out.println((i+1)+"번 로또번호"+Arrays.toString(lotto[i]));
		}
		System.out.println("\n받은 금액은 "+money+"이고 거스름돈은 "+(money%1000)+"입니다.");
		
		break;
		
		case 2:
			System.out.println("감사합니다.");
			break Outter;
		}
		}
		
		
		scanner.close();
		
	}
}
