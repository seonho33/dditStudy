<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Detail</h2>

	<form action="/testMember/modify" method="get" id="modifyForm">
		<input type="hidden" name="userNo" id="userNo" value="${member.userNo }">
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
				<td>${member.userName }</td>
			</tr>
			<tr align="center">
				<td>userPw</td>
				<td>${member.userPw }</td>
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
			<c:if test="${not empty member.authList }">
				<c:forEach items="${member.authList }" var="memberAuth">
					<tr align="center">
						<td>
							권한
						</td>
						<td>
							<c:choose>
								<c:when test="${memberAuth.auth eq 'ROLE_USER' }">
									사용자
								</c:when>
								<c:when test="${memberAuth.auth eq 'ROLE_MEMBER' }">
									회원
								</c:when>
								<c:when test="${memberAuth.auth eq 'ROLE_ADMIN' }">
									관리자
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button type="button" id="modifyBtn">modify</button>
		<button type="button" id="deleteBtn">delete</button>
		<button type="button" id="listBtn">list</button>
	</form>

</body>

<script type="text/javascript">
$(function(){
	let modifyForm = $("#modifyForm");
	let modifyBtn = $("#modifyBtn");
	let deleteBtn = $("#deleteBtn");
	let listBtn = $("#listBtn");
	
	
	modifyBtn.on("click",function(){
		modifyForm.submit();
	});
	
	listBtn.on("click",function(){
		location.href="/testMember/list"
	});
	
	deleteBtn.on("click",function(){
		if(!confirm("정말로 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url : "/testMember/deleteMember",
			method : "post",
			data : {userNo : $("#userNo").val()},
			success : function(){
				alert("삭제완료");
				location.href = "/testMember/list";
			},
			error : function(err){
				alert("삭제실패");
				console.log(err)
			}
		})
	});
})


</script>
</html>