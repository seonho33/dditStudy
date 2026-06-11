package kr.or.ddit.basic;

import java.io.IOException;

public class KeyCodeExample {
	public static void main(String[] args) throws IOException {
		int keyCode;
		
		keyCode = System.in.read();
		System.out.println("keyCode: " + keyCode);
		
		keyCode = System.in.read();
		System.out.println("keyCode: " + keyCode);
		
		keyCode = System.in.read();
		System.out.println("keyCode: " + keyCode);
	}
}