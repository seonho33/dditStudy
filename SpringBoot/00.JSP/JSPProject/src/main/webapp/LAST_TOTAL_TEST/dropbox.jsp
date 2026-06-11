<%@page import="java.io.File"%>
<%@page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.functions" prefix="fn"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
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
						자료실 페이지입니다.
						1. 게시판에서 등록했던 게시글에 포함된 모든 파일들을 자료실에서 목록으로 출력해주세요.
						2. 파일 출력
							> 업로드 된 파일이 이미지 파일인경우, 이미지 썸네일을 [이미지]에 출력해주세요.
							> 이미지 파일이 아닌 일반 파일일경우, 확장자에 일치하는 아이콘으로 파일의 이미지를 출력해주세요.
						3. 다운로드를 클릭 하면 다운로드가 가능하게 해주세요. 
					 -->
					 <%
						String[] user = (String[])session.getAttribute("SessionInfo");
						BoardRepository boardDao = BoardRepository.getInstance();	
					 	
						String path = request.getContextPath()+"/resources/images/upload/";
						String iconPath = request.getContextPath()+"/resources/images/fileIcon/";
						
						ArrayList<BoardVO> listOfBoard = boardDao.selectBoardList();
					
						pageContext.setAttribute("user", user);
						pageContext.setAttribute("listOfBoard", listOfBoard);
						pageContext.setAttribute("path", path);
						pageContext.setAttribute("iconPath", iconPath);
					 %>
					 
						<h5 class="ddit_chapter">메뉴 박스</h5>
						<p class="ddit_text pt-3"></p>
					 	<button type="button" class="ddit_btn ddit_btn_outline_primary">게시판</button>
						<button type="button" class="ddit_btn ddit_btn_outline_danger">자료실</button>
						<c:choose>
							<c:when test="${not empty user }">
								<button type="button" class="ddit_btn ddit_btn_outline_warning">로그아웃</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="ddit_btn ddit_btn_outline_warning">로그인</button>
							</c:otherwise>
						</c:choose>
						
						<p class="ddit_text pt-5"></p>
						
						<h5 class="ddit_chapter">자료실</h5>
						<p class="ddit_text pt-3"></p>
						<div class="row">
						<c:if test="${fn:length(listOfBoard)>0 }">
						<c:forEach items="${listOfBoard}" var="board">
								<c:if test="${not empty board.fileVO and (board.fileVO).fileSize > 0 }">
								<div class="col-md-2">
									<div class="card">
										<div class="card-header">
											${(board.fileVO).originalFileName}<br>
										</div>
										<div class="card-body">
											<c:choose>
												<c:when test="${(board.fileVO).contentType eq '.jpg' or (board.fileVO).contentType eq '.jpeg'
														 or (board.fileVO).contentType eq '.png' or (board.fileVO).contentType eq '.webp'}">
													<img onerror="this.src='${iconPath}default.png'" src="${path}${(board.fileVO).fileName}">
												</c:when>
												<c:otherwise>
													<img onerror="this.src='${iconPath}default.png'" src="${iconPath}${fn:substringAfter(board.fileVO.contentType,'.')}.jpg">
												</c:otherwise>
											</c:choose>
											<br><br>
											
											Size : <fmt:formatNumber value="${((board.fileVO).fileSize)/(1024*1024) }" type="number" maxFractionDigits="2"/> Mb
										</div>
										<div class="card-footer">
											<c:choose>
												<c:when test="${user != null }">
														<a href="${path}${(board.fileVO).fileName}" download="${(board.fileVO).originalFileName}">Download</a>
												</c:when>
												<c:otherwise>
														<a onclick="login()" href="">Download</a>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
								</c:if>
							</c:forEach>
						</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
<script type="text/javascript">
	function login(){
		alert("로그인 후 사용할 수 있습니다!");
	};
$(function(){
	let btn = $("button");
	
	
	btn.on("click",function(){
		let goPage = "";
		let elem = $(this).text();
		console.log("버튼 체킁!!(elem) : ", elem);
		
		if(elem == "게시판"){
			goPage = "boardList.jsp";
		};
		
		if(elem == "자료실"){
			goPage = "dropbox.jsp";
		};
		
		if(elem == "로그아웃"){
			goPage = "logout.jsp?pageNo=dropbox";
		};
		
		if(elem == "로그인"){
			goPage = "login.jsp";
		};
		
			location.href=goPage;
	});
	
	
})
</script>
</body>
</html>