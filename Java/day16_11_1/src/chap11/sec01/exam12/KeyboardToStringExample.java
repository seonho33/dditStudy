package chap11.sec01.exam12;

import java.io.IOException;

public class KeyboardToStringExample {
	public static void main(String[] args) throws IOException {
		byte[] bytes = new byte[100];
		
		System.out.print("입력: ");
		int readByteNo= System.in.read(bytes);
		
		String str = new String(bytes, 0, readByteNo-2);//enter 의 입력값 2개를 빼준 값 -2;
		System.out.println(str);
	}
}
