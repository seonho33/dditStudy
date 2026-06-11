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
<c:set value="등록" var="name" />
<c:if test="${status eq 'update' }" >
	<c:set value="수정" var="name"/>
</c:if>
	<h2>Register</h2>
	
	<form action="/crud/board/register" method="post" id="board">
		<c:if test="${status eq 'update' }">
			<input type="hidden" name="boardNo" value="${board.boardNo }">		
		</c:if>
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" id="title" name="title" value="${board.title }">
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" id="writer" name="writer" value="${board.writer }">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="10" cols="30" name="content" id="content">${board.content }</textarea>
				</td>
			</tr>
		</table>
		<div>
			<input type="button" id="registerBtn" value="${name }" />
			<input type="button" id="listBtn" value="목록" />
		</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let registerBtn = $("#registerBtn");
	let listBtn = $("#listBtn");
	let board = $("#board");
	
	
	//등록 버튼 이벤트
	registerBtn.on("click", function(){
		console.log("registerBtn click...!");
		
		let title = $("#title").val();
		let writer = $("#writer").val();
		let content = $("#content").val();
		
		if(title==null||title==""){
			alert("제목을 입력해주세요!");
			return false
		}
		if(writer==null||writer==""){
			alert("작성자를 입력해주세요!");
			return false
		}
		if(content==null||content==""){
			alert("내용을 입력해주세요!");
			return false
		}
		if($(this).val() =="수정"){
			board.attr("action","/crud/board/modify");
			board.submit();
		}else{
			board.submit();	// 서버로 전송
		}
	});
	
	//목록 버튼 이벤트
	listBtn.on("click",function(){
		console.log("listBtn click...!");
		
		location.href = "/crud/board/list";
		
	});


})



</script>

</html>