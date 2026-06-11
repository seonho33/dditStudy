<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

[
<%
//controller에서 저장한 값 꺼내기
List<MemberVO> list = (List<MemberVO>)request.getAttribute("responseList");
for(int i=0; i<list.size();i++){
	MemberVO mv = list.get(i);
	if(i>0) out.print(",");
%>
	{ 
		"k" : "v",
		"k" : "v",
	}
	
<%
}
%>	
]