<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
<title>책 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h2 class="display-4">책 상세</h2>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12 mb-2">
				<div class="row">
					<div class="col-md-2">
						<label for="title" class="col-form-label">제목</label>
					</div>
					<div class="col-md-10">${book.TITLE}</div>	
				</div>
			</div>
			<div class="col-md-12 mb-2">
				<div class="row">
					<div class="col-md-2">
						<label for="title" class="col-form-label">카테고리</label>
					</div>
					<div class="col-md-10">${book.CATEGORY}</div>
				</div>
			</div>
			<div class="col-md-12 mb-2">
				<div class="row">
					<div class="col-md-2">
						<label for="title" class="col-form-label">가격</label>
					</div>
					<div class="col-md-10">${book.PRICE}</div>	
				</div>
			</div>
			<div class="col-md-12 mb-2">
				<div class="row">
					<div class="col-md-2">
						<label for="title" class="col-form-label">입력일</label>
					</div>
					<div class="col-md-10">
						<fmt:formatDate value="${book.INSERT_DATE}" pattern="yyyy.MM.dd HH:mm:ss"/>
					</div>	
				</div>
			</div>

			<a href="/book/update.do?bookId=${bookId}" class="btn btn-info">수정</a>
			<form action="/book/delete.do" method="post" id="delForm">
				<input type="hidden" name="bookId" value="${bookId}"/>
				<input type="button" class="btn btn-danger" value="삭제" id="delBtn">
			</form>
			<a href="/book/list.do" class="btn btn-primary">목록</a>
		</div>
	</div>
</body>

<script type="text/javascript">
$(function(){
	let delForm = $("#delForm");	// 삭제를 처리하기 위한 Form element
	let delBtn 	= $("#delBtn");		// 삭제를 처리하기 위한 버튼 element
	
	//삭제 버튼 이벤트
	delBtn.on("click",function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			delForm.submit();
		}
	})
	
	
});
</script>
</html>