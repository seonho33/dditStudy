package kr.or.ddit.basic;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/*
	파일읽기 예제
*/

public class T05FileStreamTest {
	public static void main(String[] args) throws IOException {
		
		FileInputStream fis = null;
		
		File f1 = new File("d:/D_Other/test3.txt");
		
		try {
			fis = new FileInputStream("d:/D_Other/test3.txt");
			
			int data = 0;
			
			while((data = fis.read()) != -1) {
				System.out.print((char)data);
			}
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}