<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
    
    //전송 데이터 받기
	//입력한 값 가져오기...
	String userId = request.getParameter("id");
	String userName = request.getParameter("name");
	String userMail = request.getParameter("mail");    
    
	//여기서 역직렬화 한다
	
/* 	
	db연결 - crud처리 후 결과값 받기
	결과값으로 응답데이터를 생성 - json - 직렬화 된 데이터
	
*/
	
%>
{
	"id" : "<%= userId %>",
	"name" : "<%= userName %>",
	"mail" : "<%= userMail %>"
}