package kr.or.ddit.util;

import java.io.BufferedReader;
import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;

public class ObjFromJson {
	
	
	public static String changeData(HttpServletRequest request) {
	
		//전송 데이터 받기 - 9개의 항목
	BufferedReader rd = null;
	String line = null;
	StringBuffer buf = new StringBuffer();

	try {
		rd = request.getReader();
		while(true) {
			line = rd.readLine();
			if(line==null)break;
			buf.append(line);
		}
	} catch (IOException e) {
		e.printStackTrace();
	}
	
	
	String reqData = buf.toString();

	return reqData;
	}
}