package kr.or.ddit.basic;

import java.io.FileOutputStream;
import java.io.IOException;import java.io.OutputStreamWriter;
import java.io.PrintStream;
import java.io.PrintWriter;

public class T14PrintStreamTest {
	public static void main(String[] args) {
	/*
		PrintStream은 모든 자료형을 출력할 수 있는 기능을 제공하는 
		OutputStream의 서브클래스이다.
	*/	
		
		try(FileOutputStream fos = new FileOutputStream("d:/D_Other/print.txt");
			PrintStream out = new PrintStream(fos);	
			){
			
			out.print("안녕하세요. PrintStream 입니다.\n");
			out.println("안녕하세요. PrintStream 입니다2.");
			out.println("안녕하세요. PrintStream 입니다3.");
			out.println(out); // 객체 출력
			out.print(3.14);
			System.out.println("출력 완료...");
		}catch(IOException ex) {
			ex.printStackTrace();
		}
		
		////////////////////////////////////////////////////////////
		/*
			PrintWriter가 보다 향상된 기능을 제공하지만 기존에 쓰던 PrintStream은 계속 사용되고있음.
			
			PrintWriter가 보다 다양한 인코딩 처리를 하는데 적합함.
		*/
		try(FileOutputStream fos = new FileOutputStream("d:/D_Other/printWriter.txt");
			PrintWriter out = new PrintWriter(new OutputStreamWriter(fos,"CP949"));
			) {
			
			out.print("안녕하세요. PrintStream 입니다.\n");
			out.println("안녕하세요. PrintStream 입니다2.");
			out.println("안녕하세요. PrintStream 입니다3.");
			out.println(out); // 객체 출력
			out.print(3.14);
			System.out.println("출력 완료...");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
