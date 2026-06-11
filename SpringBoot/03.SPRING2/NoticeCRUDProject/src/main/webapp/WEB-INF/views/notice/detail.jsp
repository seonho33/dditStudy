<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./nModule/headerPart.jsp" %>
<style>

</style>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<%@ include file="./nModule/header.jsp" %>

		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>공지사항 상세보기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">DDIT HOME</a></li>
								<li class="breadcrumb-item active">공지사항 상세보기</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-dark">
								<div class="card-header">
									<h3 class="card-title">${notice.boTitle }</h3>
									<div class="card-tools">${notice.boWriter }${notice.boDate } ${notice.boHit }</div>
								</div>
								<form id="quickForm" novalidate="novalidate">
									<div class="card-body">
										${notice.boContent }
									</div>
									<div class="card-footer bg-white">
										<ul class="mailbox-attachments d-flex align-items-stretch clearfix">
											<c:if test="${not empty notice.noticeFileList }">
												<c:forEach items="${notice.noticeFileList }" var="noticeFile">
													<li>
														<div style="overflow: hidden; margin: 0 auto;">
															<c:choose>
																<c:when test="${fn:startsWith(noticeFile.fileMime, 'image/') }">
																	<span class="mailbox-attachment-icon has-img" >
																		<img src="${pageContext.request.contextPath }/${fn:substring(noticeFile.fileSavepath,3,fn:length(noticeFile.fileSavepath))}" width="100%" style="object-fit:cover;" />
																	</span>
																</c:when>
																<c:otherwise>
																	<span class="mailbox-attachment-icon">
																		<i class="far fa-file-pdf"></i>
																	</span>
																</c:otherwise>
															</c:choose>
														</div>
														<div class="mailbox-attachment-info">
															<a href="#" class="mailbox-attachment-name">
																<i class="fas fa-paperclip"></i> 
																${noticeFile.fileName }
															</a> 
															<span class="mailbox-attachment-size clearfix mt-1"> 
																<span>${noticeFile.fileFancysize }</span> &nbsp;
																<i class ="fas fa-download"></i>&nbsp;${noticeFile.fileDowncount }
																<c:url value="/notice/download.do" var="downloadURL">
																	<c:param name="fileNo" value="${noticeFile.fileNo }" />
																</c:url>
																	<a href="${downloadURL }"> 
																	<span class="btn btn-default btn-sm float-right">
																		<i class="fas fa-download"></i>
																	</span>
																</a>
															</span>
														</div>
													</li>
												</c:forEach>
											</c:if>

										</ul>
									</div>
									
									<!-- 댓글 영역 -->
									<div class="card-footer card-comments" id="cmtArea"></div>
									<!-- 댓글 영역 end -->
									
									<div class="card-footer">
										<div class="img-push pt-3 cmt-sub-text">
											<textarea class="form-control form-control-sm cmtContent"
												 rows="5" cols="20" id="cmtContent" 
												 placeholder="Press enter to post comment" onkeyup="contentLengthCheck(this)"></textarea>
											<div class="text-right pt-2">
												<span class="pt-1"><span class="cmt-sub-size">0</span>/650</span> 
												<button type="button" class="btn btn-sm btn-primary" id="cmtBtn">등록</button>
											</div>
										</div>
									</div>
									
									<c:set value="${sessionScope.SessionInfo }" var="member" />
									<div class="card-footer">
										<button type="button" class="btn btn-secondary" id="listBtn">목록</button>
										<c:if test="${member.memId eq notice.boWriter or member.memId eq 'admin' }">
											<button type="button" class="btn btn-dark" id="updateBtn">수정</button>
											<button type="button" class="btn btn-danger" id="delBtn">삭제</button>
										</c:if>
									</div>
								</form>
							</div>
						</div>
						<div class="col-md-12"></div>
						<form action="/notice/delete.do" method="post" id="delForm">
							<input type="hidden" name="boNo" value="${notice.boNo }">
						</form>
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
	let delForm = $("#delForm");
	let updateBtn = $("#updateBtn");
	let listBtn = $("#listBtn");
	let delBtn = $("#delBtn");
	
	listBtn.on("click",function(){
		//URL에 매핑된 쿼리스트링을 가져온다.
		const params = new URLSearchParams(window.location.search);
		let queryString="";
		// 상세보기 페이지에서 목록으로 이동 시, boNo파라미터가 무조건 설정되어있기 때문에 1보다 큰 값으로 설정
		// 사이즈를 1보다 큰 값으로 설정하고 1보다 크다면 boNo를 포함한 검색 또는 페이징을 진행 하고 넘어온 요청이기 때문에
		if(params.size > 1){
			// boNo 파라미터를 제외하기 위해 boNo다음으로 나오는 '&' 기호를 이용해 index를 구한다.
			let idx = params.toString().indexOf("&");
			queryString += "?" + params.toString().substr(idx+1);
		}
		
		location.href = "/notice/list.do"+queryString;
	});
	
	updateBtn.on("click",function(){
		delForm.attr("action","/notice/update.do");
		delForm.attr("method","get");
		delForm.submit();
	});
	
	delBtn.on("click",function(){
		const swalConfirmBtn = Swal.mixin({
			customClass : {
				confirmButton : "btn btn-success",
				cancelButton : "btn btn-danger"
			},
			buttonStyling : false
		});
		swalConfirmBtn.fire({
			title : "게시글삭제",
			text : "선택하신 게시글을 정말로 삭제하시겠습니까?",
			icon : "warning",
			showCancelButton : true,
			confirmButtonText : "네 그렇습니다!",
			cancelButtonText : "아니오, 취소할게요!",
			reverseButtons : true
		}).then((result)=>{
			if(result.isConfirmed){
				delForm.submit();
			}else{
				swalConfirmBtn.fire({
					title : "삭제 취소!",
					text : "게시글 삭제가 취소되었습니다!",
					icon : "error"
				});
			}
		})
	});
	
	// 댓글 영역
	let cmtBtn = $("#cmtBtn");	//댓글 버튼
	let cmtArea = $("#cmtArea");
	
	// 댓글 등록 버튼 이벤트
	cmtBtn.on("click",function(){
		let comment = $("#cmtContent").val();	// 댓글 내용 값
		
		if(!comment||comment.trim()==""){
			sweetAlert("error","댓글 내용을 입력해주세요!");
			return false;
		}
		
		let data = {
				boNo : "${notice.boNo}",
				cmtContent : comment
		};
		
		$.ajax({
			url : "/notice/insertCmt.do",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(result){
				if(result == "OK"){
					noticeCommentList();
				}else{
					sweetAlert("error","서버에러, 댓글 등록에 실패했습니다!");
				}
				$("#cmtContent").val("");
				
			},
			error : function(error, status, thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});
	
	//답글 버튼 이벤트(답글/답글접기)
	cmtArea.on("click",".cmtReply",function(){
		let html = ``;
		let text = $(this).text();		//버튼의 텍스트를 가져온다(답글/답글접기)
		
		// 댓글 작성 부분이 열려있기 때문에 초기화를 진행
		cmtArea.find(".cmt-sub-area").find(".cmt-sub-text").hide();
		cmtArea.find(".cmtReply").text("답글");
		
		// .cmt-sub-area : 댓글 작성자, 작성일, 답글, 수정, 삭제 요소들이 들어있는 영역
		// .cmt-sub-text : 댓글 내용 아래부분의 div영역 
		
		
		if(text == "답글"){
			html = `
				<div class="img-push pt-3 cmt-sub-text">
					<textarea class="form-control form-control-sm cmtContent"
						 rows="5" cols="20" 
						 placeholder="Press enter to post comment" onkeyup="contentLengthCheck(this)"></textarea>
					<div class="text-right pt-2">
						<span class="pt-1"><span class="cmt-sub-size">0</span>/650</span> 
						<button type="button" class="btn btn-sm btn-primary cmtBtn">등록</button>
					</div>
				</div>
			`;
			$(this).parents(".cmt-sub-area").find(".cmt-sub-write-area").html(html);
			$(this).text("답글 접기");
		
		}else{
			$(this).parents(".cmt-sub-area").find(".cmt-sub-text").hide();
			$(this).text("답글");
		}
	});
	
	
	// 대댓글 등록 버튼 이벤트 
	cmtArea.on("click",".cmtBtn",function(){
		let goPage = "/notice/insertSubCmt.do"
		let cmtNo = $(this).parents(".cmt-sub-area").data("cmt-no");	// 부모댓글 번호 가져오기
		let cmtContent = $(this).parents(".cmt-sub-text").find(".cmtContent").val();
		console.log(cmtNo);
		console.log(cmtContent);
		
		if(cmtContent == null || cmtContent == ""){
			sweetAlert("error","댓글 내용을 입력해주세요!");
			return false;
		}
		
		let data = {
				cmtNo : cmtNo,
				boNo : "${notice.boNo}",
				cmtContent : cmtContent
		}
		
		if($(this).text()=="수정"){
			goPage = "/notice/updateSubCmt.do"
		}
		
		$.ajax({
			url : goPage,
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(result){
				noticeCommentList();
			}
		})
	})
	
	//댓글 수정 버튼
	cmtArea.on("click",".cmtEdit",function(){
		// 답글 버튼을 눌렀다가 다시 수정을 할 수도 있기 때문에 초기화를 진행합니다.
		cmtArea.find(".cmt-sub-area").find(".cmt-sub-text").hide();
		cmtArea.find(".cmtReply").text("답글");
		
		// 수정된 내용을 가져온다.
		let content = $(this).parents(".cmt-sub-area").find(".cmt-sub-content").text();
		let html = `
			<div class="img-push pt-3 cmt-sub-text">
				<textarea class="form-control form-control-sm cmtContent"
					 rows="5" cols="20" 
					 placeholder="Press enter to post comment" onkeyup="contentLengthCheck(this)">\${content}</textarea>
				<div class="text-right pt-2">
					<span class="pt-1"><span class="cmt-sub-size">0</span>/650</span> 
					<button type="button" class="btn btn-sm btn-primary cmtBtn">수정</button>
				</div>
			</div>
		`;
		
		// 댓글 입력하기 위한 textarea 추가
		$(this).parents(".cmt-sub-area").find(".cmt-sub-write-area").html(html);
		
		//수정버튼을 클릭했기 때문에 버튼명을 수정으로 변경한다.
		$(this).parents(".cmt-sub-area").find(".cmtBtn").text("수정");
		//수정하기 위한 텍스트의 길이를 표시한다.
		$(this).parents(".cmt-sub-area").find(".cmt-sub-size").text(content.length);
		
	});
	
	
	//댓글 삭제 버튼
	cmtArea.on("click",".cmtDelete",function(){
		if(confirm("댓글을 삭제하시겠습니까?")){
			let cmtNo = $(this).parents(".cmt-sub-area").data("cmt-no");
			console.log("체킁 : ",cmtNo);
			$.ajax({
				url : "/notice/deleteCmt.do",
				type : "post",
				data : JSON.stringify({cmtNo:cmtNo}),
				contentType : "application/json;charset=utf-8",
				success : function(){
					noticeCommentList();
				}
			})
		}
	})
	
	//댓글 목록 출력
	function noticeCommentList(){
		let data = {
				boNo : "${notice.boNo}"
		};
		
		$.ajax({
			url : "/notice/commentList.do",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(result){
				let html = ``;	//댓글 영역 구성하기 위한 변수
				if(result&& result.length>0){
					result.map(function(v,i){
						let style = "";
						if(v.cmtDepth > 0){
							style = "margin-left:40px;";
						}
						
						html += `
							<div class="card-comment" style="\${style}">
								`;
						if(v.cmtStatus == 'Y'){
							html += `댓글이 삭제되었습니다.`;
						}else{
							html += `
								<img class="img-circle img-sm" src="\${v.memProfileimg}" alt="User Image">
								<div class="comment-text cmt-sub-area" data-cmt-no=\${v.cmtNo}>
									<span class="username"> 
										\${v.cmtWriter}
										<span class="text-muted float-right">
											\${v.cmtDate}
											<button type="button" class="btn btn-tool cmtReply" title="comments">답글</button>`;
											
									if("${member.memId}"==v.cmtWriter){
										html +=`
											<button type="button" class="btn btn-tool cmtEdit" title="update">
												<i class="fas fa-edit"></i>
											</button>
											<button type="button" class="btn btn-tool cmtDelete" title="delete">
												<i class="fas fa-trash"></i>
											</button>`;
									}
									
							html += `
										</span>
									</span>
									<div class="cmt-sub-content">\${v.cmtContent}</div>
									<div class="cmt-sub-write-area"></div>
								</div>
								`;
						}
						
						html +=`</div>`;
					});
					cmtArea.html(html);					
				}
			},
			error : function(error, status, thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
			
		})
	}
	
	noticeCommentList();
});


// 댓글 내용 길이 체크 이벤트
function contentLengthCheck(ele){
	let size = ele.value.length;		//textarea 작성한 텍스트 길이
	let text = ele.value;				//textarea 안에 작성한 텍스트
	
	// 제한 글자 수, 650 자 초과일 때,
	// 제한 글자 수는 내용을 담을 공간의 데이터 사이즈에 맞게 처리(2000byte)
	// 650 * 2 =1300, 630 * 3 = 1950
	if(size > 650){
		sweetAlert("error","더이상 작성 할 수 없습니다.")
		let subText = text.substr(0,650);	// 650 자 텍스트 자르기
		ele.value = subText;				// 텍스트
		
		//제한된 길에 설정
		$(ele).parents(".cmt-sub-text").find(".cmt-sub-size").text(subText.length);
		return false;
	}
	
	$(ele).parents(".cmt-sub-text").find(".cmt-sub-size").text(size);
}

</script>
</html>
