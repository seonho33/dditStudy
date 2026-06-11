<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						로그인을 처리하기 위한 페이지입니다.
						
						1. 로그인 처리를 진행해주세요.
						2. 일반회원 및 관리자 계정으로 접속 시, 게시판 목록으로 이동해주세요.
							> 넘겨받은 아이디, 비밀번호가 총 3개의 계정과 일치하는 정보가 있다면 로그인 성공
						3. 일치하지 않는 정보라면 다시 login.jsp로 이동해 여러 에러 메세지를 출력해주세요.
							> '아이디와 비밀번호를 확인해 주세요!' 메세지를 출력해주세요.
						4. 로그인 성공 시, session에 로그인 정보를 등록해주세요.
							> 세션명은 "SessionInfo"로 해주세요.
					-->
					<%
						request.setCharacterEncoding("UTF-8");
					
						Map<String, String[]> users = new HashMap<>();
						String[] user1 = {"a001","a1234"};
						String[] user2 = {"b001","b1234"};
						String[] admin = {"admin","adm1234"};
						
						users.put("a001", user1);
						users.put("b001", user2);
						users.put("admin", admin);
						
						String id = request.getParameter("memId");
						String pw = request.getParameter("memPw");
						
						String goPage = "";
						String[] user = users.get(id);	// id 값을 key로 map에서 값 가져와서 user에 담기 
						if(user != null){
							if(user[0].equals(id) && user[1].equals(pw)){//담은 user[] 에서 pw와 같은지 확인
								//담긴 정보는 String[] {id값, pw값}
								session.setAttribute("SessionInfo", user);
								goPage = "boardList.jsp";
							}else{
								goPage = "login.jsp?error=1";	//아이디, 비밀번호가 일치하지 않을경우
							}
						}else{
							goPage = "login.jsp?error=1";	// 아이디를 입력하지 않았을경우
						}
						
						response.sendRedirect(goPage);	//session 에 담고 페이지 이동
					%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>