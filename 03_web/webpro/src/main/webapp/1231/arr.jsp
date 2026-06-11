<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//
//db연결해서 crud 처리 후 결과를 얻는다.

// 결과로 응답데이터를 생성- 
// text기반의 String 형식의 json데이터를 생성(직렬화 데이터)
// 출력

// DB연결로직: 서블릿 -> Service -> DAO -> MAPPER를 이용 -> DB에 CRUD처리


%>

<%-- 주석처리.. HTML처럼 !로 주석처리하면 X --%>
["홍길동","개나리","진달래","무궁화","삼천리","금수강산"]