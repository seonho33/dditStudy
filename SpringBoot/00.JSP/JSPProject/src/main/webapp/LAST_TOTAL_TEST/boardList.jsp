<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
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
							게시판 목록 화면입니다.
							1. 게시판 목록을 출력해주세요.
								> JSTL을 활용해주세요.
								> 출력할 목록 데이터가 존재하지 않는 경우, '조회하신 게시글이 존재하지 않습니다.'를 출력해주세요.
								> 데이터가 있는 경우엔 번호, 제목, 작성자, 작성일, 조회수를 맞춰서 데이터 목록을 출력해주세요.
							2. 게시글 클릭 시, 해당 게시글 상세보기 페이지(boardView.jsp)로 이동합니다.
								> 상세보기 페이지로 이동할 때, 조회수가 상승합니다.
							3. 게시글 등록하기 클릭 시, 게시글 등록 페이지(boardForm.jsp)로 이동합니다.
							4. 로그아웃 버튼을 클릭 시, 로그아웃 처리(logout.jsp)를 해주세요.
							5. 로그인 하지 않고 등록 버튼 클릭 시, 로그인 페이지로 이동합니다.
								> 이때, 로그인 페이지에서 '로그인 후 시도해주세요!' 메세지를 띄워주세요.
							
							<로그인 후>
							메뉴박스
							[게시판][자료실][로그아웃]
							─────────────────────────────────────────────────────────────────────────────
							
							<로그인 전>
							메뉴박스
							[게시판][자료실][로그인]
							─────────────────────────────────────────────────────────────────────────────
						-->
						<% 
							String insRes = request.getParameter("insRes");
							
							String[] user = (String[])session.getAttribute("SessionInfo");
						
							ArrayList<BoardVO> listOfBoard = new ArrayList<BoardVO>();
							
							BoardRepository boardDao = BoardRepository.getInstance();
							
							listOfBoard = boardDao.selectBoardList();
							
							pageContext.setAttribute("insRes", insRes);
							pageContext.setAttribute("user", user);
							pageContext.setAttribute("listOfBoard", listOfBoard);
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
						<button type="button" style="display: none;" class="ddit_btn ddit_btn_outline_warning">로그인</button>
				
						<p class="ddit_text pt-3"></p>
						
						<h5 class="ddit_chapter">게시판 목록</h5>
						<p class="ddit_text pt-3"></p>	<!-- 한 줄 넣기위해 추가한 p태그 -->
						
						<table border="1" class="table table-bordered">
							<thead>
								<tr>
									<th width="8%">번호</th>
									<th width="px">제목</th>
									<th width="10%">작성자</th>
									<th width="12%">작성일</th>
									<th width="8%">조회수</th>
								</tr>
							</thead>
							<tbody>
								<!-- 
									아래 tr 세트는 데이터 목록이 존재하지 않는 경우라면 첫번째 tr 세트를 이용해서 출력하고
									데이터 목록이 존재한다면 두번째 tr 세트를 이용해서 출력합니다.
								-->
								<c:if test="${fn:length(listOfBoard) == 0 }">
									<tr>
										<td colspan="5">조회하실 게시글이 존재하지 않습니다.</td>
									</tr>	
								</c:if>
								<c:if test="${fn:length(listOfBoard) > 0 }">
									<c:forEach items="${listOfBoard}" var="board">
										<tr>
											<td>${board.no }</td>
											<td><a href="boardView.jsp?no=${board.no }">${board.title }</a></td>
											<td>${board.writer }</td>
											<td>${board.regDate }</td>
											<td>${board.hit }</td>
										</tr>	
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						<button type="button" class="ddit_btn ddit_btn_outline_primary">등록</button>
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
	
	if(${insRes eq 1}){
		alert("등록되었습니다!");
		location.href="boardList.jsp";
	}
	
	btn.on("click",function(){
		let goPage	= "";			//클릭한 버튼의 text() 에 따라 goPage 설정
		let elem = $(this).text();
		console.log("버튼 체킁 : ", elem);
		
		if(elem =="게시판"){
			goPage = "boardList.jsp";
		};
		if(elem =="자료실"){
			goPage = "dropbox.jsp";
		};
		if(elem =="로그아웃"){
			goPage = "logout.jsp?pageNo=boardList";
		};
		if(elem =="로그인"){
			goPage = "login.jsp";
		};
		if(elem =="등록"){
			if(${empty user}){
				alert("로그인 후 사용할 수 있습니다!")
				return false;
			}else{
				goPage = "boardForm.jsp";
			}
		};
		
		if(goPage != "" && goPage !=null){
			location.href=goPage;
		};
	});
	
})

</script>
</body>
</html>