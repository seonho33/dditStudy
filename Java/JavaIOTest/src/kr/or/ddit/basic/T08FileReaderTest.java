package kr.or.ddit.basic;
/*
	문자기반 스트림(FileReader)을 이용한 파일 읽기 예제
*/

import java.io.FileInputStream;
import java.io.FileReader;

public class T08FileReaderTest {
	public static void main(String[] args) {
		
		try(FileReader fr = new FileReader("d:/D_Other/testChar.txt");
			FileInputStream fis = new FileInputStream("d:/D_Other/testChar.txt");	
				) {
			int data = 0;
			
			while((data = fis.read())!=-1) {
				System.out.print((char) data);
			}
			
			System.out.println("--------------------------------");
			while((data = fr.read())!=-1) {
				System.out.print((char) data);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
	}
}
