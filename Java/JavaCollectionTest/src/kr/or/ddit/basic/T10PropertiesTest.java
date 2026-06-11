package kr.or.ddit.basic;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class T10PropertiesTest {
	public static void main(String[] args) throws IOException {
	/*	
		Properties 는 Map 보다 축소된 기능의 객체라고 할 수 있다.
		Map 은 모든 타입의 객체를 key 와 value 로 사용할 수 있지만,
		Properties 객체는 key 와 value 값으로 String 객체만 사용할 수 있다.
		
		Map 은 put(), get() 을 이용하여 데이터를 입출력하지만,
		Properties 는 setProperty(), getProperty()를 이용한다.
	*/	
		Properties prop = new Properties();
		
		prop.setProperty("name", "홍길동");
		prop.setProperty("tel", "010-1234-5678");
		prop.setProperty("addr", "대전");
		
		String name = prop.getProperty("name");
		String tel = prop.getProperty("tel");
		String addr = prop.getProperty("addr");
		
		System.out.println("이름 : " + name);
		System.out.println("전화번호 : " + tel);
		System.out.println("주소 : " + prop.getProperty("addr"));
		
		//내용을 파일로 저장하기
		
		/*
		 * prop.store(new
		 * FileOutputStream("src/kr/or/ddit/basic/test.properties"),"코멘트 입니다.");
		 */
		//파일 내용을 읽어오기
		prop.load(new FileReader("src/kr/or/ddit/basic/test.properties"));
		
		System.out.println("읽어온 데이터 출력하기");
		System.out.println(prop.getProperty("addr"));
	}
}
