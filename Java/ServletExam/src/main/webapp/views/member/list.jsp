<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
1. 디렉티브(Directive)에 대하여...

JSP페이지에 대한 설정정보를 저장할 때 사용된다. (page, taglib, include 등)

'<%@'으로 시작하고 그 뒤에 디렉티브 이름이 오고 필요에 따라 속성명이 올수 있으며,
마지막에 '%>'로 끝난다.

ex) <%@ 디렉티브이름 속성명="속성값" ... %>

2. 스크립트 요소에 대하여...

- 표현식(Expression): 값을 출력결과에 포함시키고자 할 때 사용한다. 
 					ex) <%=값 %>
- 스크립트릿(Scriptlet): 자바코드를 작성할 때 사용한다. ex) <% ~~~ %>
- 선언부(Declaration): 스크립트릿이나 표현식에서 사용할 수 있는 메서드를 작성할
                     때 사용한다. ex) <%! ~~~ %>
                     
3. JSP 기본객체와 영역(SCOPE)

- PAGE 영역: 하나의 JSP페이지 처리할 때 사용되는 영역 => pageContext
- REQUEST 영역: 하나의 HTTP요청을 처리할 때 사용되는 영역 => request
- SESSION 영역: 하나의 웹브라우저(사용자)와 관련된 영역 => session
- APPLICATION 영역: 하나의 웹애플리케이션과 관련된 영역 => application                     
                     
 --%>

<%
	List<MemberVO> memList = 
		(List<MemberVO>) request.getAttribute("memList");

	String msg = session.getAttribute("msg") == null ?
			"" : (String) session.getAttribute("msg");
	
	session.removeAttribute("msg");


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>첨부파일ID</th>
		</tr>
<%
	int size = memList.size();
	
	if(size > 0) {

		for(MemberVO mv : memList) {
%>		
		<tr>
			<td><%=mv.getMemId() %></td>
			<td><a href="<%=request.getContextPath() %>/member/detail.do?memId=<%=mv.getMemId() %>"><%=mv.getMemName() %></a></td>
			<td><%=mv.getMemTel() %></td>
			<td><%=mv.getMemAddr() %></td>
			<td><%=mv.getAtchFileId() %></td>
		</tr>
		
<%
		}
	}else{
%>		
		<tr>
			<td colspan="5">회원정보가 존재하지 않습니다.</td>
		</tr>
<%		
	}
%>	
	<tr align="center">
		<td colspan="5"><a href="<%=request.getContextPath() %>/member/insert.do">[회원 등록]</a></td>
	</tr>

	</table>
<%
	if(msg.equals("SUCCESS")) {
%>
<script>
	alert('정상적으로 처리되었습니다.');
</script>
<%
	}
%>
</body>
</html>