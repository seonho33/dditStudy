<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String base64Str = (String) request.getAttribute("base64Str");
/*
	데이터 URI 스킴(Data URI Scheme)에 대하여...
	
	- 외부 자원(이미지 등)을 문서(HTML,CSS,Javascript,SVG등)에 인라인 방식으로
	  데이터를 포함시킬수 있는 방법을 제공하기 위한 표현법

	  형식) data:[<mime-type>],[;charset=<encoding>][;base64],<data>

*/
    
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BASE64로 인코딩된 이미지 출력하기(data URI Scheme)</title>
</head>
<body>
	<img alt="" src="data:;base64,<%=base64Str%>">
</body>
</html>