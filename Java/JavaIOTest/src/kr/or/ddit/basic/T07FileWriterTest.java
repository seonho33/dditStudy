package kr.or.ddit.basic;

import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;

public class T07FileWriterTest {
	public static void main(String[] args) {
		/*	
			사용자가 입력한 내용을 그대로 파일로 저장하기
			
			콘솔(표준 입출력장치)과 연결된 입력용 문자 스트림 생성
			InputStreamReader => 바이트기반 스트림을 문자기반 스트림으로
								 변환해 주기 위한 보조스트림...
			
		*/	
		
		try(
			InputStreamReader isr = new InputStreamReader(System.in);
			FileWriter fw = new FileWriter("d:/D_Other/testChar.txt");
			)
		{
			System.out.println("아무거나 입력하세요.");
			
			int data = 0;
			
			//콘솔 입력시 입력 끝 표시는 (컨트롤키 + Z = -1) 누른다.
			while((data = isr.read())!=-1) {
				fw.write(data);				//콘솔에서 입력받은 데이터 파일로 저장...
			}
			
			System.out.println("작업 완료...");

		} catch (Exception e) {

		}
	}
}
