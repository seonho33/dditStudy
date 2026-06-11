package 다형성게임실행기;

import java.util.Scanner;

public class GameSetting {
	
	public static int GameSelect() {
	Scanner scanner = new Scanner(System.in);
	System.out.println("=============================");
	System.out.println("      게임을 선택해 주십시오.");
	System.out.println("=============================");
	System.out.println(" 1.홀짝 2.주사위맞추기 3.가위바위보");

	int i = Integer.parseInt(scanner.nextLine());
	if(i!=1 && i!=2 && i!=3) {
		System.out.println("숫자만 입력해 주십시오.");
		GameSelect();
	}
	return i;
}
}