package kr.or.ddit.basic;

import java.io.BufferedReader;
import java.io.FileReader;

public class T12BufferedIOTest {
	public static void main(String[] args) {
		try(FileReader fr = new FileReader("./src/kr/or/ddit/basic/T11BufferedIOTest.java");
		//이클립스에서 만든 자바프로그램이 실행되는 기본위치는 
		//해당 '프로젝트 폴더'가 기본위치가 된다. => 현재 경로
			BufferedReader br = new BufferedReader(fr);
			){
				/*
				 * int data = 0; while((data=br.read())!=-1) { System.out.print((char) data); }
				 */
		String str= "";
		int cnt = 1;
		while((str = br.readLine())!=null){
			System.out.printf("%4d : %s\n",cnt++,str);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}