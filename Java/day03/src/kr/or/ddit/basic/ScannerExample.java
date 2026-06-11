package kr.or.ddit.basic;

import java.util.Scanner;

public class ScannerExample {
	public static void main(String[] args) throws Exception {
		@SuppressWarnings("resource")
		Scanner scannerdate = new Scanner(System.in);
		String inputData;
		
		while (true) {
			//사용자가 콘솔에 입력한 문자열을 엔터키(Line)까지 읽어온다.
			inputData = scannerdate.nextLine();
			System.out.println("입력된 문자열: \"" + inputData + "\"");
			if(inputData.equals("q")){
				break;
			}
		}
		System.out.println("종료합니다.");
	}
}