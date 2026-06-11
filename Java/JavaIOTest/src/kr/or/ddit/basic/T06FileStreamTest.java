package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;

public class T06FileStreamTest {
	public static void main(String[] args) throws IOException {

		byte[] temp = new byte[4];
		
		// try with resource 문법
		try(FileOutputStream fos = new FileOutputStream("d:/D_Other/out.txt");){
			for(char ch='A'; ch<='Z'; ch++) {
				fos.write(ch);
			}
			System.out.println("파일 만들기 성공");
		} catch (IOException e) {
			e.printStackTrace();
		  }

		
		/////////////////////////
		FileInputStream fis = new FileInputStream("d:/D_Other/out.txt");
		
		
		int data = 0;
			System.out.print("파일 내용은 ");
		while((data = fis.read())!=-1) {
			System.out.print((char)data);
		}
		
		
		int readBytes = 0;
		
		while((readBytes = fis.read(temp)) !=-1 ) {
			System.out.println("temp: " + Arrays.toString(temp));
			System.out.println("readBytes: " + readBytes);
			
		}
	}
}