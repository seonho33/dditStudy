<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
//controller 에서 저장한 값 꺼내기
String result = (String)request.getAttribute("memberId");

if(result !=null){
%>	
	{
		"flag" : "사용불가능"
	}
<%
}else{
%>
	{
		"flag" : "사용가능"
	}
	
<%	
}
%>