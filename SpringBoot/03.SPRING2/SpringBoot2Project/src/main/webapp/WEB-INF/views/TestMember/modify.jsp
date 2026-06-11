<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h2>Modify</h2>

	<form action="/testMember/modify" method="post" id="modifyForm">
		<input type="hidden" name="userNo" value="${member.userNo }">
		<table border="1">
			<tr align="center">
				<td></td>
				<td>유저정보</td>
			</tr>
			<tr align="center">
				<td>userId</td>
				<td>${member.userId }</td>
			</tr>
			<tr align="center">
				<td>userName</td>
				<td>
					<input type="text" id="userName" name="userName" value="${member.userName }">
				</td>				
			</tr>
			<tr align="center">
				<td>userPw</td>
				<td>
					<input type="text" id="userPw" name="userPw" value="${member.userPw }">
				</td>				
			</tr>
			<tr align="center">
				<td>생성일</td>
				<td>
					<fmt:formatDate value="${member.regDate }" pattern="yyyy년 MM월 dd일"/>
				</td>
			</tr>
			<tr align="center">
				<td>권한 수정일</td>
				<td>
					<fmt:formatDate value="${member.updDate }" pattern="yyyy년 MM월 dd일"/>
				</td>
			</tr>
			<tr align="center">
				<td>
					권한
				</td>
				<td>
					<select name="authList[0].auth">
						<option value="">---선택---</option>
						<option value="ROLE_USER" <c:if test="${member.authList[0].auth eq 'ROLE_USER' }"> selected="selected"</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[0].auth eq 'ROLE_MEMBER' }"> selected="selected"</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[0].auth eq 'ROLE_ADMIN' }"> selected="selected"</c:if>>관리자</option>
					</select>
				</td>
			</tr>
			<tr align="center">
				<td>
					권한
				</td>
				<td>
					<select name="authList[1].auth">
						<option value="">---선택---</option>
						<option value="ROLE_USER" <c:if test="${member.authList[1].auth eq 'ROLE_USER' }"> selected="selected"</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[1].auth eq 'ROLE_MEMBER' }"> selected="selected"</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[1].auth eq 'ROLE_ADMIN' }"> selected="selected"</c:if>>관리자</option>
					</select>
				</td>
			</tr>
			<tr align="center">
				<td>
					권한
				</td>
				<td>
					<select name="authList[2].auth">
						<option value="">---선택---</option>
						<option value="ROLE_USER" <c:if test="${member.authList[2].auth eq 'ROLE_USER' }"> selected="selected"</c:if>>사용자</option>
						<option value="ROLE_MEMBER" <c:if test="${member.authList[2].auth eq 'ROLE_MEMBER' }"> selected="selected"</c:if>>회원</option>
						<option value="ROLE_ADMIN" <c:if test="${member.authList[2].auth eq 'ROLE_ADMIN' }"> selected="selected"</c:if>>관리자</option>
					</select>
				</td>
			</tr>
		</table>
		<button type="button" id="modifyBtn">modify</button>
		<button type="button" id="listBtn">list</button>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let modifyForm = $("#modifyForm");
	let modifyBtn = $("#modifyBtn");
	let listBtn = $("#listBtn");
	
	modifyBtn.on("click",function(){
		
		modifyForm.submit();
	});
	
	listBtn.on("click",function(){
		
		location.href="/testMember/list"
	})
	
	
})

</script>

</html>