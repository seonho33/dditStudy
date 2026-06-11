<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<%
	String id		=request.getParameter("id");
	String pw		=request.getParameter("pw");
	String pw2		=request.getParameter("pw2");
	String name		=request.getParameter("name");
	String bir		=request.getParameter("bir");
	String email	=request.getParameter("email");
	String email2	=request.getParameter("email2");
	
	request.setAttribute("birth", bir);
	request.setAttribute("email", email+"@"+email2);
	session.setAttribute("SessionInfo", "a001님이 보낸 데이터!");
	
	request.getRequestDispatcher("result.jsp").forward(request, response);
%>

<p class="ddit_text">아이디 :<%= id %></p>
	<p class="ddit_text">비밀번호 : <%= pw %></p>	              
	<p class="ddit_text">이름 : ${param.name }</p>	                  
	<p class="ddit_text">생일 : ${birth }</p>	              
	<p class="ddit_text">이메일 : ${email}</p>
	
</body>
</html>