package kr.or.ddit;

import java.util.Properties;

public class Test02_파일목록조회 {
	
	public static void main(String[] args) {
		
		// 프로젝트 루트 
		String path = "D:\\";
		
		Properties properties = System.getProperties();
		for(Object o : properties.keySet()) {
			System.out.println(o+":"+properties.getProperty((String)o));
		}
	}
}