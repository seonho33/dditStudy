<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
	//memberList.jsp가 view 페이지...
	//controller 에서 저장한 값 꺼내기
	List<MemberVO> list = (List<MemberVO>)request.getAttribute("responseList");
%>

<table border="1" class="table table-dark table-hover">
	<tr>
		<th>No.</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>우편번호</th>
		<th>생일</th>
		<th>주소</th>
		<th>상세주소</th>
		<th>전화번호</th>
		<th>메일</th>
	</tr>

<% 
	for(int i=0; i<list.size(); i++){
		MemberVO vo = list.get(i);
%>	
	<tr>
		<td><%= i+1 %></td>
		<td><%= vo.getMem_id() %></td>
		<td><%= vo.getMem_pass() %></td>
		<td><%= vo.getMem_name() %></td>
		<td><%= vo.getMem_zip() %></td>
		<td><%= vo.getMem_bir() %></td>
		<td><%= vo.getMem_add1() %></td>
		<td><%= vo.getMem_add2() %></td>
		<td><%= vo.getMem_hp() %></td>
		<td><%= vo.getMem_mail() %></td>
	</tr>
<%
	}
%>	

</table>

</body>
</html>