package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class T09FileEncodingTest {
	/*
		한글 인코딩 방식에 대하여...
		
		한글 인코딩 방식은 크게 UTF-8 과 EUC-KR 방식 두가지로 나누어 볼 수 있다.
		원래 한글 윈도우는 CP949방식을 사용했는데, 윈도우를 개발한 마이크로소프트에서
		EUC-KR 방식에서 확장하여 만들었기 때문에 MS949 라고도 부른다.
		한글 윈도우의 메모장에서 말하는 ANSI인코딩이란 CP949(Code page 949)를
		말한다.
		 - MS949 => 한글 윈도우의 기본 한글 인코딩 방식(ANSI계열)
		 - UTF-8 => 유니코드 UTF-8 인코딩 방식(영문자 및 숫자: 1byte, 한글: 3byte) => 가변적
		 - US-ASCII => 영문전용 인코딩 방식
		 
		 ANSI는 영어를 표기하기 위해 만든 코드로 규격 자체에 한글이 없었다가 나중에 여기에
		 EUC-KR, CP949 이라는 식으로 한그이 포함되었음
		 
		 참고)
		 ASCII => extended ASCII(ISO 8859-1) =>조합형, 완성형(KSC 5601)
		 
		 => 윈도우 계열: CP949(확장 완성형) - 일부문자(8822자)를 추가함.
		 => 유닉스 계열: EUC-KR(확장 유닉스 코드)
		 
		 => ANSI 계열
		 
		 => 유니코드(UTF-8)
	*/
	public static void main(String[] args) {
		/*
			파일 인코딩 정보를 이용하여 읽어오기
			
			형식) new InputStreamReader(바이트기반 스트림 객체, 인코딩방식 지정)
		*/
		try(FileInputStream fis= new FileInputStream("d:/D_Other/test_utf8.txt");
			InputStreamReader isr = new InputStreamReader(fis,"UTF-8");
			InputStreamReader isr2 = new InputStreamReader(new FileInputStream("d:/D_Other/test_ANSI.txt"),"MS949");	
				){
			int data = 0;
			
			while((data=isr2.read())!=-1) {
				System.out.print((char) data );
			}
			
			System.out.println();
			System.out.println("출력 끝...");
			
			}catch(IOException ex) {
				ex.printStackTrace();
			}
	}
}
