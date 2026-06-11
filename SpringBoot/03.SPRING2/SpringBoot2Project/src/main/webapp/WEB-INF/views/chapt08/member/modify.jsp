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
	<h2>Modify</h2>
	
	<form action="/crud/member/modify" method="post" id="member">
		<input type="hidden" name="userNo" value="${member.userNo }">
		<table border="1">
			<tr>
				<td>userId</td>
				<td>
					<input type="text" id="userId" name="userId" value="${member.userId }" readonly="readonly">
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
					<input type="text" name="userName" id="userName" value="${member.userName }">
				</td>
			</tr>
			<tr>
				<td>auth - 1</td>
				<td>
					<select name="authList[0].auth">
						<option value="">--선택해주세요--</option>
						<option value="ROLE_USER" <c:if test="${member.authList[0].auth eq 'ROLE_USER' }">selected</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[0].auth eq 'ROLE_MEMBER' }">selected</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[0].auth eq 'ROLE_ADMIN' }">selected</c:if>>관리자</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>auth - 2</td>
				<td>
					<select name="authList[1].auth">
						<option value="">--선택해주세요--</option>
						<option value="ROLE_USER" <c:if test="${member.authList[1].auth eq 'ROLE_USER' }">selected</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[1].auth eq 'ROLE_MEMBER' }">selected</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[1].auth eq 'ROLE_ADMIN' }">selected</c:if>>관리자</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>auth - 3</td>
				<td>
					<select name="authList[2].auth">
						<option value="">--선택해주세요--</option>
						<option value="ROLE_USER" <c:if test="${member.authList[2].auth eq 'ROLE_USER' }">selected</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[2].auth eq 'ROLE_MEMBER' }">selected</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[2].auth eq 'ROLE_ADMIN' }">selected</c:if>>관리자</option>
					</select>
				</td>
			</tr>
		</table>
		<div>
			<input type="button" id="modifyBtn" value="modifyBtn" />
			<input type="button" id="listBtn" value="List" />
		</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let modifyBtn = $("#modifyBtn");
	let listBtn = $("#listBtn");
	let member = $("#member");
	
	
	//수정 버튼 이벤트
	modifyBtn.on("click", function(){
		console.log("registerBtn click...!");
		
		let userPw = $("#userPw").val();
		let userName = $("#userName").val();
		
		if(userPw==null||userPw==""){
			alert("비밀번호를 입력해주세요!");
			return false
		}
		if(userName==null||userName==""){
			alert("이름을 입력해주세요!");
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