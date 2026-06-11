<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.ZipVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
//controller 에서 저장하고 보낸값 꺼내기
List<ZipVO> listzv = (List<ZipVO>)request.getAttribute("memberDong");

//직렬화 데이터 생성(Gson)
//Json형식의 직렬화 데이터로 응답결과를 생성
Gson gson = new GsonBuilder().setPrettyPrinting().create();
String result = gson.toJson(listzv);

//fetch비동기전송의 then or async 의 await 메소드의 콜백 function으로 전달
out.print(result);
out.flush();

%>