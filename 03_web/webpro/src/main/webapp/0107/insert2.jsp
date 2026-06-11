<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//controller 에서 저장한 값 꺼내기

int result = (int)request.getAttribute("cnt");

if(result>0){
%>
	{
		"flag" : "가입성공"
	}
<%}else{
%>
	{
		"flag" : "가입실패"
	}

<%
}
%>