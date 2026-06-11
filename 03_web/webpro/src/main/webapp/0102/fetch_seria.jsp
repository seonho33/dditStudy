<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page import="kr.or.ddit.vo.SeriaVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
//직렬화된 데이터 json 형식의 문자열데이터 읽기
request.setCharacterEncoding("UTF-8");

BufferedReader reader = request.getReader();
StringBuffer strbuf = new StringBuffer();
String line = null;

while(true){
	line = reader.readLine();
	if(line == null) break;
	
	strbuf.append(line);
}

String reqData = strbuf.toString();
//{"id" : "...", "name" : "...", "mail" : "..."}

//역직렬화 - java객체로 변환 - VO 객체...

//Gson gson = new Gson();
Gson gson = new GsonBuilder().setPrettyPrinting().create();
SeriaVO vo = gson.fromJson(reqData, SeriaVO.class);
//vo.setId("a001") vo.setName("홍길동") vo.setMail("...")

//db연결 - crub 처리 후 결과값 받기
//결과값으로 응답데이터를 생성 - json으로 
String result = gson.toJson(vo);
out.print(result);
out.flush();

%>
<%-- {
	"id" : "<%= vo.getId() %>"",
	"name" : "<%= vo.getName() %>",
	"mail" : "<%= vo.getMail() %>"
} --%>

