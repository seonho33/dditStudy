package chap09.sec02.exam03;

import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Window w = new Window();
		Button btn = new Button();
		Button.OnClickListener button4 = new Button.OnClickListener() {
			
			@Override
			public void onClick() {
				System.out.println("종료합니다.");
			}
		};
		
		
		Scanner scanner = new Scanner(System.in);
		System.out.println("기능을 선택하십시오.\n1.전화걸기 2.메시지보내기 3.tv켜기 4.종료");
		int z=scanner.nextInt();
		do {
		switch(z) {
		case 1 :
			w.button1.touch();
			break;
		case 2 : 
			w.button2.touch();
			break;
		case 3 : 
			btn.setOnClickListener(new Button.OnClickListener() {
				
				@Override
				public void onClick() {
					System.out.println("TV를 켭니다.");
				}
			});
			btn.touch();
			break;
		case 4 :
			button4.onClick();
			break;
		}
		} while(z!=4);
		scanner.close();
	}
}
