<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
request.setCharacterEncoding("UTF-8");

//전송데이터 받기
String userId = request.getParameter("id");
String userName = request.getParameter("name");
String userMail = request.getParameter("mail");    

// 역직렬화
// db연결 - crud처리 후 결과값 받기
// 결과값으로 응답데이터를 생성 - json - 직렬화된 데이터

%>

{
	"id" : "<%= userId %>",
	"name" : "<%= userName %>",
	"mail" : "<%= userMail %>"
}

<%-- 주석처리하지말것..<!--> --%>