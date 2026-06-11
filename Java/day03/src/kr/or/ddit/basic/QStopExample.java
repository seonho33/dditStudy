package kr.or.ddit.basic;

import java.io.IOException;

public class QStopExample {
	public static void main(String[] args) throws IOException {
		int keyCode;
		System.out.println("시작합니다.");
		while (true) {
			keyCode = System.in.read();
			System.out.println("keyCode: " + keyCode);
			if (keyCode == 113) {
				break;
			}
		}		
		System.out.println("종료합니다.");
	}
}