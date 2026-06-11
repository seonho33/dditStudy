package kr.or.ddit.basic;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class URLConnectionTest {
	public static void main(String[] args) throws IOException {
		
		// URLConnection => 애플리케이션과 URL간의 통신연결을
		// 위한 추상 클래스
		
		// 네이버 서버에 연결하여 index.html문서 가져오기
		URL url = new URL("https://www.naver.com/index.html");
		
		// URLConnection 객체 생성하기
		URLConnection urlConn = url.openConnection();
		
		System.out.println("Content-Type: " + urlConn.getContentType());
		System.out.println("Encoding: " + urlConn.getContentEncoding());
		System.out.println("Content: " + urlConn.getContent());
		System.out.println();
		
		//전체 헤더 정보 출력
		Map<String, List<String>> headerMap = urlConn.getHeaderFields();
		
		Iterator<String> iterator = headerMap.keySet().iterator();
		while(iterator.hasNext()) {
			String key = iterator.next();
			System.out.println(key + " : " + headerMap.get(key));
		}
		System.out.println("------------------------------------");

	// 해당 호스트의 페이지 내용 가져오기...
	
	InputStream is = url.openConnection().getInputStream();
	
	InputStreamReader isr = new InputStreamReader(is);
	
	int data = 0;
	
	while((data = isr.read())!=-1) {
		System.out.print((char) data);
	}
	
	isr.close(); //사용한 
	}
}