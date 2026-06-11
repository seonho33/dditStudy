<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH17") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
							게시판 등록 페이지 입니다.
							1. 등록 버튼 클릭 시, 게시글 등록 처리를 위해 boardInsert.jsp로 데이터를 전송해주세요.
							2. 목록 버튼 클릭 시, 게시판 목록 페이지(boardList.jsp)로 이동해주세요.
						 -->
						 <% 
						 String error = request.getParameter("error");
						 if(error != null){
							out.println("<div class='alert alert-danger'>");
							out.println("	아이디 및 비밀번호가 일치하지 않습니다!");
							out.println("</div>");
						 }
						 %>
						 
						<h5 class="ddit_chapter">게시글 등록</h5>
						<p class="ddit_text pt-3"></p>
						<form action="boardInsert.jsp" method="post" id="addForm" enctype="multipart/form-data">
							<table class="table table-bordered">
								<tr>
									<td>제목</td>
									<td><input type="text" class="form-control" name="title" id="title" value=""/></td>
								</tr>
								<tr>
									<td>내용</td>
									<td><textarea class="form-control" rows="8" cols="30" id="content" name="content"></textarea></td>
								</tr>
								<tr>
									<td>파일</td>
									<td><input type="file" class="form-control" name="filename" id="fileTd"/></td>
								</tr>
								<tr>
									<td colspan="2">
										<button type="button" class="ddit_btn ddit_btn_outline_primary" id="addBtn">등록</button>
										<button type="button" class="ddit_btn ddit_btn_outline_info" id="listBtn">목록</button>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
<script type="text/javascript">

$(function(){
	let btn = $("button");
	let maxSize = 1*1024*1024; //유효성검사 maxSize 1mb

	if(${error eq 1}){
		alert("사이즈가 너무 큽니다!");
		location.href="boardForm.jsp";
	}	
	
	btn.on("click",function(){
		let goPage = "";
		let elem = $(this).text();
		console.log("버튼 체킁 : ",elem);

		if(elem =="등록"){
			const file = document.querySelector("#fileTd").files[0];
			if(file){
				if(file.size>maxSize){
					alert("파일크기가 1mb 이상인것은 올릴수 없습니다!");
					return false;
				}
			}
			
			$("#addForm").submit();
			return;
		};
		if(elem =="목록"){
			goPage = "boardList.jsp"
		};
		
		location.href=goPage;
	})
	
});

</script>
</body>
</html>