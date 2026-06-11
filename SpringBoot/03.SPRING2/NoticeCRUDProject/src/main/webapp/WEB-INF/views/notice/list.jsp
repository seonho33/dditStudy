<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./nModule/headerPart.jsp" %>
<style>
@keyframes heartbeat{
	0% {transform: scale(1);}
	25% {transform: scale(1.2);}
	50% {transform: scale(1);}
	75% {transform: scale(1.2);}
	100% {transform: scale(1);}
}
.heartbeat-image{
	animation:heartbeat 1s ease-in-out infinite;
}
</style>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<%@ include file="./nModule/header.jsp" %>

		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>공지사항 게시판</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">DDIT HOME</a></li>
								<li class="breadcrumb-item active">공지사항 게시판</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			<button onclick="collectLawDong()">법정동 데이터 수집</button>
			<button onclick="collectApt()">아파트 데이터 수집</button>


			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-dark card-outline">
								<div class="card-header">
									<div class="card-tools">
										<form class="input-group input-group-sm" id="searchForm" style="width: 440px;">
											<input type="hidden" name="page" id="page">
											<select class="form-control" name="searchType">
												<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
												<option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
											</select>
											<input type="text" name="searchWord" class="form-control float-right" value="${searchWord }" placeholder="Search">
											<div class="input-group-append">
												<button type="submit" class="btn btn-default">
													<i class="fas fa-search"></i>검색
												</button>
											</div>
										</form>
									</div>
									<h3 class="card-title">공지사항</h3>
								</div>
								<div class="card-body">
									<table class="table table-bordered">
										<thead class="table-dark">
											<tr>
												<th style="width: 6%">#</th>
												<th style="width: px">제목</th>
												<th style="width: 12%">작성자</th>
												<th style="width: 12%">작성일</th>
												<th style="width: 10%">조회수</th>
											</tr>
										</thead>
										<tbody id="tbody">
											<fmt:formatDate value="<%=new java.util.Date() %>" pattern="yy-MM-dd" var="now"/>
											<c:set value="${pagingVO.dataList}" var="noticeList"/>
											<c:choose>
												<c:when test="${empty noticeList }">
													<tr>
														<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach items="${noticeList }" var="notice">
														<!-- flag true : 현재 날짜와 같음, false : 현재 날짜가 아님 -->
														<c:set value="false" var="flag"/>
														<c:set value="${notice.boDate }" var="boDate"/>
														<c:choose>
															<c:when test="${fn:split(notice.boDate,' ')[0] eq now }">
																<c:set  value="true" var="flag"/>
																<c:set  value="${fn:split(notice.boDate,' ')[1] }" var="boDate"/>
															</c:when>
														</c:choose>
														<tr>
															<td>${notice.boNo }</td>
															<td>
																<!--  -->
																<a href="" data-no="${notice.boNo }">
																	${notice.boTitle }
																</a>
																<c:if test="${notice.fileCount>0 }">
																	<i class="fas fa-file" style="background-color: white;"></i>
																</c:if>
																<c:if test="${flag }">
																	&nbsp;<img class="heartbeat-image" src="/resources/dist/img/new2.png" width="30px">
																</c:if>
															</td>
															<td>
																<font class="bedge bedge-dark" style="font-size:14px;">
																	${notice.boWriter }
																</font>
															</td>
															<td>${boDate }</td>
															<td>${notice.boHit }</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>	
										</tbody>
									</table>
								</div>
								<div class="card-body" align="right">
									<button type="button" class="btn btn-dark" id="newBtn">등록</button>
								</div>
								<div class="card-footer clearfix" id="pagingArea">
									${pagingVO.pagingHTML }
								</div>
							</div>
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
<script>
function collectLawDong() {
    fetch('/admin/lawdong/collect.do',{
        method: 'POST'
    })
        .then(res => res.text())
        .then(msg => alert(msg));
}

function collectApt() {
    fetch('/admin/collectApt.do',{
    	method: 'POST'
    })
        .then(res => res.text())
        .then(msg => alert(msg))
        .catch(err => console.error(err));
}
</script>
<script type="text/javascript">
$(function(){
	let searchForm = $("#searchForm");
	let pagingArea = $("#pagingArea");
	let newBtn = $("#newBtn");
	
	$("#tbody").on("click","a",function(e){
		e.preventDefault();
		const params =  new URLSearchParams(window.location.search);
		let queryString = "?boNo=" + $(this).data("no");
		if(params.size > 0){
			queryString += "&" + params.toString();
		}
		location.href = "/notice/detail.do" + queryString;
	});
	
	pagingArea.on("click","a",function(e){
		e.preventDefault();
		let pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	
	newBtn.on("click",function(){
		location.href = "/notice/form.do";
	});
})
</script>
</html>
