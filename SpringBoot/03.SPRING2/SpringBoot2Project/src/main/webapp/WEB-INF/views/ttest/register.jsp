<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>Register</h1>

<form action="/ttest/register" method="post" id="registerForm">
	<table border="1">
		<tr>
			<td>
				아이디
			</td>
			<td>
				<input type="text" name="userId" id="userId">
			</td>
		</tr>
		<tr>
			<td>
				비밀번호
			</td>
			<td>
				<input type="text" name="userPw" id="userPw">
			</td>
		</tr>
		<tr>
			<td>
				이름
			</td>
			<td>
				<input type="text" name="userName" id="userName">
			</td>
		</tr>
	</table>
	<button type="button" id="registerBtn">등록</button>
	<button type="button" id="listBtn">취소</button>
</form>

</body>
<script type="text/javascript">
$(function(){
	let registerForm = $("#registerForm");
	let registerBtn = $("#registerBtn");
	let listBtn = $("#listBtn");
	
	registerBtn.on("click",function(){
		let userId = $("#userId").val();
		let userPw = $("#userPw").val();
		let userName = $("#userName").val();
		
		if(!userId){
			alert("아이디를 입력해주세요!");
			return false;
		}
		
		if(!userPw){
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		
		if(!userName){
			alert("이름을 입력해주세요!");
			return false;
		}
		
		registerForm.submit();
		
	});
	
	listBtn.on("click",function(){
		
		location.href="/ttest/list";
	});
	

})
	
</script>
</html>