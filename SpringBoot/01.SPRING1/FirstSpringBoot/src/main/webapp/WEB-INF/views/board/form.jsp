<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/headers.css">
<title>일반게시판 등록/수정</title>
</head>
<style>
.bi {
	vertical-align: -.125em;
	fill: currentColor;
}
</style>
<body>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="bootstrap" viewBox="0 0 118 94">
    <title>Bootstrap</title>
    <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
  </symbol>
  <symbol id="home" viewBox="0 0 16 16">
    <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
  </symbol>
  <symbol id="grid" viewBox="0 0 16 16">
    <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
  </symbol>
</svg>
<main>
	<%@ include file="../module/header.jsp" %>

	<div class="position-relative overflow-hidden p-3 p-md-8 m-md-8 text-center bg-white">
		<div class="col-md-8 p-lg-8 mx-auto my-5">
			<h4 class="display-4 fw-normal">일반게시판</h4>
			<p class="lead fw-normal">일반게시판 CRUD를 작성해주세요.</p>
		</div>
		<div class="product-device shadow-sm d-none d-md-block"></div>
		<div
			class="product-device product-device-2 shadow-sm d-none d-md-block"></div>
	</div>
	
	<c:set value="등록" var="name"/>
	<c:if test="${status eq 'u' }">
		<c:set value="수정" var="name"/>
	</c:if>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="card-body">
						<form method="post" action="/board/insert.do" id="boardForm" class="form-horizontal">
							<c:if test="${status eq 'u' }">
								<input type="hidden" name="boNo" value="${board.boNo }">
							</c:if>
							<div class="form-group row">
								<label class="col-sm-2 control-label" >제목</label>
								<div class="col-sm-10">
									<input id="boTitle" name="boTitle" type="text" class="form-control" value="${board.boTitle }" placeholder="제목을 입력해주세요.">
								</div>
							</div>
							<div class="form-group row mt-4">
								<label class="col-sm-2 control-label" >내용</label>
								<div class="col-sm-10">
									<textarea name="boContent" cols="50" rows="5" class="form-control" placeholder="content" id="boContent">${board.boContent }</textarea>
								</div>
							</div>
							<div class="form-group row mt-4">
								<div class="col-sm-offset-2 col-sm-12 ">
									<input type="button" value="${name }" class="btn btn-primary float-right" id="addBtn">
									<c:if test="${status eq 'u' }">
										<input type="button" value="취소" class="btn btn-danger float-right" id="cancelBtn">
									</c:if>
									<c:if test="${status ne 'u' }">
										<input type="button" value="목록" class="btn btn-success float-right" id="listBtn">
									</c:if>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-12"><br/><br/><br/></div>
		</div>
	</div>
</main>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("boContent");
	
	let addBtn = $("#addBtn");
	let cancelBtn = $("#cancelBtn");
	let listBtn = $("#listBtn");
	let boardForm = $("#boardForm");
	
	//등록 버튼 이벤트
	addBtn.on("click",function(){
		//제목 내용 데이터 기본 유효성 검사
		let title = $("#boTitle").val();
		//일반적인 textarea 태그에 입력된 데이터를 가져오는 방법
		//let content = $("#boContent").val();
		//CKEditor 로 설정된 content 역역의 값을 가져올때는 getData() 메소드를 활용한다.
		let content = CKEDITOR.instances.boContent.getData();
		
		if(title==null||title==""){
			alert("제목을 입력해주세요!!");
			$("#boTitle").focus();
			return false;
		}
		
		// 내용 기본 유효성 검사
		if(content==null||content==""){
			alert("내용을 입력해주세요!!");
			$("#boContent").focus();
			return false;
		}
		
		if($(this).val() == "수정"){
			boardForm.attr("action","/board/update.do");
		}
		
		boardForm.submit();
	});
	
	//취소 버튼 이벤트
	cancelBtn.on("click",function(){
		location.href = "/board/detail.do?boNo=${board.boNo}"
	});
	
	//목록 버튼 이벤트
	listBtn.on("click",function(){
		location.href = "/board/list.do";
	});
	
});
</script>
</html>
