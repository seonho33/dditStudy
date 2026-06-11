package kr.or.ddit.basic;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

/*
	입출력 성능 향상을 위한 보조스트림 예제
	(바이트 기반의 BUFFered 스트림 사용 예제)
*/
public class T11BufferedIOTest {
	public static void main(String[] args) {
		
		try(FileOutputStream fos = new FileOutputStream("d:/D_Other/bufferTest.txt");
			//두번째 파라메터로 버퍼의 크기를 지정하지 않으면 기본적으로 버퍼의 크기가 8198byte(8KB)로 설정됨.
			BufferedOutputStream bos = new BufferedOutputStream(fos,5);
			){
			for(char ch='1'; ch<='9';ch++) {
				bos.write(ch);
			}
			bos.flush(); //작업을 종료하기 전에 버퍼에 남아있는 데이터를 모두 출력시킨다.
						//close() 작업시 자동으로 호출됨
			System.out.println("출력작업 끝...");
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
}
