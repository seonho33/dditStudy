package 로또구매;

import java.util.Arrays;
import java.util.Scanner;

public class Lotto수동 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		int[] Buylotto = new int[6];
		int z = 0;

		
		Outter : while(true) {
			System.out.println("구매하실 로또번호 6자리를 입력하십시오.\n 1~45까지의 숫자만 입력하십시오");
		Buylotto[0] = scanner.nextInt();
		Buylotto[1] = scanner.nextInt();
		Buylotto[2] = scanner.nextInt();
		Buylotto[3] = scanner.nextInt();
		Buylotto[4] = scanner.nextInt();
		Buylotto[5] = scanner.nextInt();
		
		for(int i=0;i<Buylotto.length;i++) {
			for(int j=0;j<i;j++) {
				if(Buylotto[j]==Buylotto[i]){
					System.out.println("다시 입력하십시오.");
					continue Outter;
				}
			}
			
			if(Buylotto[i]<0||Buylotto[i]>45) {
			System.out.println("다시 입력하십시오.");
			continue Outter;
		}
	}
		break;
}	
		int[] lotto = new int[6];
		for(int i=0; i<lotto.length;i++) {
			lotto[i] = (int)(Math.random()*45)+1;
			for(int j=0;j<i;j++) {
				while(true) {
					if(lotto[j]==lotto[i]) {
				lotto[j]=(int)(Math.random()*45)+1;	
					}else {
						break;
					}
				}
			}
		}
		System.out.println("====이번주 로또 번호======");
		System.out.println(Arrays.toString(lotto));
		System.out.println("======================");
		System.out.println(Arrays.toString(Buylotto));
		for(int i=0;i<lotto.length;i++) {
			for(int j=0;j<lotto.length;j++) {
				if(Buylotto[i]==lotto[j]) {
					z++;
				}
		}
	}
	switch(z) {
	case 0:
		System.out.println("낙첨, 당첨된 숫자는 0개입니다.");
		break;
	case 1:
		System.out.println("낙첨, 당첨된 숫자는 1개입니다.");
		break;
	case 2:
		System.out.println("낙첨, 당첨된 숫자는 2개입니다.");
		break;
	case 3:
		System.out.println("낙첨, 당첨된 숫자는 3개입니다.");
		break;
	case 4:
		System.out.println("당첨, 당첨된 숫자는 4개, 3등입니다.");
		break;
	case 5:
		System.out.println("당첨, 당첨된 숫자는 5개, 2등입니다.");
		break;
	case 6:
		System.out.println("당첨, 당첨된 숫자는 6개, 1등입니다.");
		break;
	}
scanner.close();
	}
}