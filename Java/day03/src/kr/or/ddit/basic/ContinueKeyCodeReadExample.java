package kr.or.ddit.basic;

import java.io.IOException;

public class ContinueKeyCodeReadExample {
	public static void main(String[] args) throws IOException {
		int keyCode;
		
		while (true) {
			keyCode = System.in.read();
			System.out.println("keyCode: " + keyCode);
		}		
	}
}