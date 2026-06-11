package java확인문제.P121;

import java.util.Scanner;

public class Example03 {
	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		
		System.out.println("[필수 정보 입력]");
		System.out.println("1. 이름: _________");
		String str1 = scan.nextLine();
		System.out.println("2. 주민번호 앞 6자리: __________");
		String str2 = scan.nextLine();
		System.out.println("3. 전화번호: ___________");
		String str3 = scan.nextLine();
		
		System.out.println("[입력된 내용]\n1. 이름: "+str1+"\n2.주민번호 앞 6자리: "+str2+"\n3. 전화번호: " + str3);
	
		
	}
}
