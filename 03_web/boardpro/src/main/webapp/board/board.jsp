<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
#pagelist {
	margin-left: 10%;
}

body * {
	box-sizing: border-box;
}

nav, #write {
	margin: 10px 5%;
}

nav a {
	visibility: hidden;
}

#stype {
	width: 100px;
}

#sword {
	width: 150px;
}

p {
	border: 1px dotted blue;
	padding: 4px;
	margin: 2px;
	word-break: keep-all; /* 줄바꿈: 단어단위로  */
}

.p12 {
	display: flex;
	flex-direction: row;
}

.p1 {
	flex: 70%;
}

.p2 {
	flex: 30%;
	text-align: right;
}

.card-header:hover {
	background: blue;
}

.card-body, .reply-body {
	display: flex;
	flex-direction: column;
}

.reply-body {
	border: 1px solid pink;
	background: #FFDCFF;
	margin: 1px;
	padding: 2px;
}

input[data-name=reply] {
	height: 55px;
	vertical-align: top;
}

textarea {
	width: 70%;
}

label {
	display: inline-block;
	width: 80px;
	height: 30px;
}

#modifyform {
	display: none;
}

#modifyform textarea {
	vertical-align: bottom;
}

#btnok, #btnreset {
	height: 40px;
}
</style>


<script>
	
</script>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- {mem_id}{mem_pass}... -->
<%-- jstl코드의 <c:if>에서 사용하는 로그인 체크변수설정 
    로그인 했을경우 자기글에 삭제 수정버튼 출력시 사용 할  변수선언 
  --%>
<c:set var="vo" value="${sessionScope.loginok}" />


<%--  -------------댓글 수정폼-----------------  --%>
<div id="modifyform">
	<textarea rows="5" cols="50"></textarea>
	<input type="button" value="확인" onclick="modiok()" id="btnok">
	<input type="button" value="취소" onclick="modireset()" id="btnreset">
</div>

<br>
<nav class="navbar navbar-expand-sm navbar-dark bg-primary">
	<div class="container-fluid">
		<input type="button" id="writebtn" value="글쓰기"> <a
			class="navbar-brand" href="javascript:void(0)">Logo</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#mynavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="mynavbar">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link"
					href="javascript:void(0)">Link</a></li>
			</ul>

			<form class="d-flex" id="ff" name="ff" method="post">
				<input type="hidden" name="page" value="1"> <select
					class="form-select" id="stype" name="stype">
					<option value="">전체</option>
					<option value="writer">작성자</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select> <input class="form-control me-2" type="text" id="sword"
					name="sword" placeholder="Search">
				<button id="search" class="btn btn-primary" type="button">Search</button>
			</form>
		</div>
	</div>
</nav>

<br>
<br>

<div class="container mt-3">
	<h2>Accordion Example</h2>

	<div id="accordion">


		<%-- 반복문 게시글 출력 -----------------------------------------------
    get방식으로 BoardList.do를 실행하여  실행결과(게시글 3개)를
    controller서블릿에서 boardList라는 이름으로 저장하고 - request.setAttribute("boardList", "리스트결과")
     view페이지--(현재페이지)--로 포워딩 한다 
 
    여기 view페이지에서 리스트를 꺼내어 출력 
  <%
   List<BoardVO> list = (List<BoardVO>)request.getAttribute("boardList")
   for(int i=0;  i<list.size(); i++){
           BoardVO   blist = list.get(i);
   %>
       //html태그를 이용하여 출력------------
      <div class="card">
       <div class="card-header">
        <a class="btn action subject"><%= blist.getSubject %></a>
   
   <% } %>

  하지만  jstl를 이용하여   ${requestScope.boardList} 직접 접근한다 
   content 출력시 줄바꿈을 위해서 replaceAll안하고 pre태그로 바꿈  
   el jstl 에서는 replaceAll하기 위해서 다른 설정이 필용함 --%>
		----------------------------------------------------------------------------------
		<%-- 게시글 출력  -반복문 시작  
              jstl를 이용하여   controller에서 저장한 값 꺼내기   --%>
		<c:forEach var="blist" items="${requestScope.boardList}">
			<div class="card">
				<div class="card-header">
					<a class="btn action subject" data-idx="${blist.num}" data-name="subject"
						data-bs-toggle="collapse" href="#collapse${blist.num}">
						${blist.subject} </a>
				</div>
				<div id="collapse${blist.num}" class="collapse"
					data-bs-parent="#accordion">
					<div class="card-body">
						<div class="p12">
							<p class="p1">
								작성자:<span class="wr">${blist.writer}</span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 이메일:<span class="em">${blist.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								조회수:<span class="hi">${blist.hit}</span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 날짜 :<span class="da">${blist.wdate}</span>
							</p>
							<p class="p2">

								<%--  //-----자기글인지 체크 ---------<c:if>--------------  --%>
								<c:if test="${not empty vo and vo.mem_name==blist.writer}">
									<input type="button" data-idx="${blist.num}" data-name="delete"
										class="action" value="삭제">
									<input type="button" data-idx="${blist.num}" data-name="modify"
										class="action" value="수정">
									<%-- -----</c:if>-----------------------------------------------  --%>
								</c:if>
							</p>
						</div>
				
						<pre class="wp3 p3"></pre>
						<p class="p4">
							<textarea rows="" cols="50"></textarea>
							<input type="button" data-idx="${blist.num}" data-name="reply" class="action"
								value="등록">
						</p>
					</div>
				</div>
			</div>

		</c:forEach>

	</div>
		<%-- 반복문   끝--%>
</div>

<br>
<br>

<%-- 페이징 처리 출력 
서블릿 controller에서  request.setAttribute("pglist", 페이지리스트결과) 로 저장 후 
뷰페이지로  포워딩. - 현재페이지---
<%  String plist = (String)request.getAttribute("pglist");  %>
<%= plist %> 

el jstl을 이용하여  ${requestScope.pglist} 직접 접근 출력 
이벤트 처리시에는 pagelist 부모요소를 이용해서 이벤트위임방식으로 핸들링 한다
--%>
<div id="pagelist">${requestScope.pglist}</div>


<%-- ----- 글쓰기   The Modal  -------  --%>
<div class="modal" id="wModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">게시글 작성하기</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">

				<form name="wfrom" id="wform">

					<label>이름</label> <input type="text" class="txt" id="writer"
						name="writer"> <br> <label>제목</label> <input
						type="text" class="txt" id="subject" name="subject"> <br>

					<label>메일</label> <input type="text" class="txt" id="mail"
						name="mail"> <br> <label>비밀번호</label> <input
						type="password" class="txt" id="password" name="password">
					<br> <label>내용</label> <br>
					<textarea rows="5" cols="40" class="txt" id="content"
						name="content"></textarea>
					<br> <br> <input type="button" value="전송" id="send">
				</form>

			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>


<%-- ----- 글 수정  The Modal   ----  --%>
<div class="modal" id="uModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">게시글 수정하기</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">

				<form name="ufrom" id="uform">

					<input type="hidden" id="unum" name="num"> <label>이름</label>
					<input type="text" class="txt" id="uwriter" name="writer">
					<br> <label>제목</label> <input type="text" class="txt"
						id="usubject" name="subject"> <br> <label>메일</label>
					<input type="text" class="txt" id="umail" name="mail"> <br>

					<label>비밀번호</label> <input type="password" class="txt"
						id="upassword" name="password"> <br> <label>내용</label>
					<br>
					<textarea rows="5" cols="40" class="txt" id="ucontent"
						name="content"></textarea>
					<br> <br> <input type="button" value="전송" id="usend">
				</form>

			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>
















