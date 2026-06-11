package kr.or.ddit.basic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Arrays;

public class T03ByteArrayIOTest {
	public static void main(String[] args) {
		
		byte[] inSrc = {0,1,2,3,4,5,6,7,8,9};
		byte[] outSrc = null;
	
	
		// 스트림 객체 생성하기
		ByteArrayInputStream bais = new ByteArrayInputStream(inSrc);
		ByteArrayOutputStream baos	= new ByteArrayOutputStream();
	
		int data = 0;	// 읽어온 바이트 데이터를 저장하기 위한 변수
		
		//read 메서드 => byte 단위로 데이터를 가져온다.
		//			=> 더이상 읽을 바이트 데이터가 없으면 -1을 리턴한다.
		
		while((data = bais.read()) != -1) {
			baos.write(data);
		}
		
		//출력된 값을 배열로 반환하는 메서드 호출하기
		outSrc = baos.toByteArray();
		
		System.out.println(Arrays.toString(outSrc));
	}
}