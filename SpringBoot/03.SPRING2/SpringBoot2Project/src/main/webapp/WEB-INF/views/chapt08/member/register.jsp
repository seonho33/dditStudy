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
	
	<form action="/crud/member/register" method="post" id="member">
		<table border="1">
			<tr>
				<td>userId</td>
				<td>
					<input type="text" id="userId" name="userId" value="${member.userId }">
				</td>
			</tr>
			<tr>
				<td>userPw</td>
				<td>
					<input type="text" id="userPw" name="userPw" value="${member.userPw }">
				</td>
			</tr>
			<tr>
				<td>userName</td>
				<td>
					<input type="text" name="userName" id="userName">
				</td>
			</tr>
		</table>
		<div>
			<input type="button" id="registerBtn" value="Register" />
			<input type="button" id="listBtn" value="List" />
		</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let registerBtn = $("#registerBtn");
	let listBtn = $("#listBtn");
	let member = $("#member");
	
	
	//등록 버튼 이벤트
	registerBtn.on("click", function(){
		console.log("registerBtn click...!");
		
		let userId = $("#userId").val();
		let userPw = $("#userPw").val();
		let userName = $("#userName").val();
		
		if(userId==null||userId==""){
			alert("아이디를 입력해주세요!");
			$("#userId").focus();
			return false
		}
		if(userPw==null||userPw==""){
			alert("비밀번호를 입력해주세요!");
			$("#userPw").focus();
			return false
		}
		if(userName==null||userName==""){
			alert("이름을 입력해주세요!");
			$("#userName").focus();
			return false
		}
			member.submit();	// 서버로 전송
	});
	
	//목록 버튼 이벤트
	listBtn.on("click",function(){
		console.log("listBtn click...!");
		
		location.href = "/crud/member/list";
		
	})


})



</script>

</html>