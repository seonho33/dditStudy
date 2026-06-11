<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    

<%
//controller에서 저장한 값 꺼내기
List<MemberVO> list = (List<MemberVO>)request.getAttribute("responseList");

//직렬화 데이터 생성(Gson)
Gson gson = new GsonBuilder().setPrettyPrinting().create();

String result = gson.toJson(list);

out.print(result);
out.flush();

%>