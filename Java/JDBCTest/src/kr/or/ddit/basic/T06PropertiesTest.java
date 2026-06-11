package kr.or.ddit.basic;

import java.io.File;
import java.io.FileInputStream;
import java.util.Enumeration;
import java.util.Properties;

public class T06PropertiesTest {
	public static void main(String[] args) throws Exception {
		
		Properties prop = new Properties();
		
		File file = new File("./res/db.properties");
		
		FileInputStream fis = new FileInputStream(file);
		
		// 파일 내용 가져오기
		prop.load(fis);
		
		// 읽어온 데이터 콘솔에 출력하기
		Enumeration<String> keys = (Enumeration<String>)prop.propertyNames(); 
		
		while(keys.hasMoreElements()) {
			String key = keys.nextElement();
			String value = prop.getProperty(key);
			System.out.println(key = "=" + value);
		}
		System.out.println("출력 끝...");
	}
}