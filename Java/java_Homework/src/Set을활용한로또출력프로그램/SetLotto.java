package Set을활용한로또출력프로그램;

import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class SetLotto {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		int i;
		while(true) {
		System.out.println("=======================================");
		System.out.println("             Lotto 프로그램");
		System.out.println("---------------------------------------");
		System.out.println("1. Lotto 구입");
		System.out.println("2. 프로그램 종료");
		System.out.println("=======================================");
		System.out.print("메뉴선택 : ");
		try {
			i = scanner.nextInt();}catch(Exception e) {
			System.out.println("숫자만 입력해 주십시오.");
			scanner.nextLine();
			continue;
		}
		switch(i) {
		case 1:
			System.out.println("Lotto 구입 시작");
			System.out.println("(1000원에 로또번호 하나입니다.)");
			System.out.print("금액입력 : ");
			int money = scanner.nextInt();
			if(money<1000) {
				System.out.println("금액이 너무 적습니다.");
				System.out.println("거스름돈 : "+money);
				continue;
			}
			System.out.println("행운의 로또번호는 아래와 같습니다.");
			for(int play=0;play<(int)(money/1000);play++) {
				
				Set<Integer> lottoNum = new HashSet<Integer>();			//for 문 돌때마다 lottoNum 초기화
				
				while(lottoNum.size()<6) {
					int num = (int)(Math.random()*45)+1;
					lottoNum.add(num);
				}
				System.out.println("로또번호"+(play+1)+" : "+lottoNum);
			}
			System.out.println();
			System.out.println("받은 금액은 "+money+"원이고 거스름돈은 "+(money%1000)+"원입니다.");
			break;
		case 2:
			System.out.println("프로그램 종료");
			System.out.println("감사합니다.");
			return;
		
		default:
			System.out.println("1또는 2만 입력해 주십시오.");
			scanner.nextLine();
			break;
			}
		}
	}
}
