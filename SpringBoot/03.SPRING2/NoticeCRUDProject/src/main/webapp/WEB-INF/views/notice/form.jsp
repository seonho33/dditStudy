<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./nModule/headerPart.jsp" %>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<%@ include file="./nModule/header.jsp" %>


		<div class="content-wrapper">
			<c:set value="등록" var="name"/>
			<c:if test="${status eq 'u' }">
				<c:set value="수정" var="name" />
			</c:if>
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>공지사항 ${name }</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">DDIT HOME</a></li>
								<li class="breadcrumb-item active">공지사항 ${name }</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card card-dark">
							<div class="card-header">
								<h3 class="card-title">공지사항 ${name }</h3>
								<div class="card-tools"></div>
							</div>
							<form role="form" action="/notice/insert.do" method="post" id="noticeForm" enctype="multipart/form-data">
								<c:if test="${status eq 'u' }">
									<input type="hidden" name="boNo" value="${notice.boNo }">
								</c:if>
								<div class="card-body">
									<div class="form-group">
										<label for="boTitle">제목을 입력해주세요</label> 
										<input type="text" id="boTitle" name="boTitle" value="${notice.boTitle }" class="form-control" placeholder="제목을 입력해주세요">
									</div>
									<div class="form-group">
										<label for="boContent">내용을 입력해주세요</label>
										<textarea id="boContent" name="boContent" class="form-control" rows="14">${notice.boContent }</textarea>
									</div>
									<div class="form-group">
										<div class="custom-file">
											<label for="inputDescription">파일 선택</label> 
											<input type="file" class="custom-file-input" name="boFile" id="boFile" multiple="multiple"> 
											<label class="custom-file-label" for="boFile">파일을 선택해주세요</label>
										</div>
									</div>
								</div>
								<c:if test="${status eq 'u' }">
									<div class="card-footer bg-white">
										<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
											<c:if test="${not empty notice.noticeFileList }">
												<c:forEach items="${notice.noticeFileList }" var="noticeFile">
													<li>
														<span class="mailbox-attachment-icon">
															<i class="far fa-file-pdf"></i>
														</span>
														<div class="mailbox-attachment-info">
															<a href="#" class="mailbox-attachment-name">
																<i class="fas fa-paperclip"></i> 
																${noticeFile.fileName }
															</a> 
															<span class="mailbox-attachment-size clearfix mt-1"> 
																<span>${noticeFile.fileFancysize }</span> 
																<span class="btn btn-default btn-sm float-right attachmentFileDel" id="span_${noticeFile.fileNo }">
																	<i class="fas fa-times"></i>
																</span>
															</span>
														</div>
													</li>
												</c:forEach>
											</c:if>

										</ul>
									</div>
								</c:if>
								
								<div class="card-footer bg-white">
									<div class="row">
										<div class="col-12">
											<input type="button" value="${name }" id="formBtn" class="btn btn-secondary float-right">
											<c:if test="${status eq 'u' }">
												<input type="button" id="cancelBtn" value="취소" class="btn btn-dark float-right">
											</c:if>
											<c:if test="${status ne 'u' }">
												<input type="button" id="listBtn" value="목록" class="btn btn-dark float-right">
											</c:if>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@ include file="./nModule/footer.jsp" %>

		<aside class="control-sidebar control-sidebar-dark">
		</aside>
	</div>
	<%@ include file="./nModule/footerPart.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace("boContent",{
		filebrowserUploadUrl: "/imageUpload.do"
	});
	CKEDITOR.config.height = "600px";

	
	let formBtn = $("#formBtn");
	let cancelBtn = $("#cancelBtn");
	let listBtn = $("#listBtn");
	let noticeForm = $("#noticeForm");
	
	formBtn.on("click",function(){
		let title = $("#boTitle").val();
		let content = CKEDITOR.instances.boContent.getData();
		
		if(title == null || title.trim()==""){
			sweetAlert("error","제목을 입력해주세요!");
			return false;
		}
		
		if(content == null || content.trim()==""){
			sweetAlert("error","내용을 입력해주세요!");
			return false;
		}
		
		if($(this).val()=="수정"){
			noticeForm.attr("action","/notice/update.do");
		}
		
		
		noticeForm.submit();
	});
	
	cancelBtn.on("click",function(){
		
	});
	
	listBtn.on("click",function(){
		location.href="notice/list.do"
	});
	
	$(".attachmentFileDel").on("click",function(){
		let id = $(this).prop("id");
		let idx = id.indexOf("_");
		let fileNo = id.substring(idx+1);
		let ptrn = "<input type='hidden' name='delFileNo' value = '%V' />"
		$("#noticeForm").append(ptrn.replace("%V",fileNo));
		$(this).parents("li:first").hide();
	})
	
});
</script>

</html>
