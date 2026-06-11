<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<h2>Register</h2>

<form action="/testMember/register" method="post" id="registerForm">
	<table border="1">
		<tr>
			<td>userId</td>
			<td>
				<input type="text" name="userId" id="userId">
			</td>
		</tr>
		<tr>
			<td>userPw</td>
			<td>
				<input type="text" name="userPw" id="userPw">
			</td>
		</tr>
		<tr>
			<td>userName</td>
			<td>
				<input type="text" name="userName" id="userName">
			</td>
		</tr>
	</table>
	<button type="button" id="registerBtn" >Register</button>
	<button type="button" id="listBtn">List</button>
</form>

</body>
<script type="text/javascript">
$(function(){
	let registerBtn = $("#registerBtn");
	let listBtn = $("#listBtn");
	let registerForm = $("#registerForm");
	
	registerBtn.on("click",function(){
		let userId =$("#userId").val();
		let userPw =$("#userPw").val();
		let userName =$("#userName").val();
		
		if(userId == null || userId == ""){
			alert("아이디를 입력해주세요");
			return false;
		}
		
		if(userPw == null || userPw == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		if(userName == null || userName == ""){
			alert("이름을 입력해주세요");
			return false;
		}
		
		registerForm.submit();
	});
	
	listBtn.on("click",function(){
		location.href = "/testMember/list"		
	})
	

	
})
</script>

</html>