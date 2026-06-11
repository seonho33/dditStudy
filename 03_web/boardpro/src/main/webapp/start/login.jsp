<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%-- <%

MemberVO mvo = (MemberVO)request.getAttribute("loginok");

if(mvo != null){
%>	
	{
		"flag" : "ok"
	}
	
<%	
}else{
%>
	{
		"flag" : "no"
	}
<%	
}
%> --%>


<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.member.vo.MemberVO" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    MemberVO mvo = (MemberVO)session.getAttribute("loginok");

    if(mvo != null){
%>
{"flag":"ok"}
<%
    } else {
%>
{"flag":"no"}
<%
    }
%>
