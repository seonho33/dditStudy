<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@page import="kr.or.ddit.ch07.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.ch07.MemberDAO"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH08") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<%
							// 1. ch07_tesst_signin.jsp에서 넘겨받은 아이디, 비밀번호가 MemberDAO의 memberList 공간에 저장된
							//    회원 정보들 중 일치하는 회원이 존재한다면 로그인 처리를 진행해주세요.
							//    회원 정보들 중 일치하는 회원이 존재하지 않다면 에러 정보를 ch07_test_signin.jsp로 전달해 메세지를 출력해주세요.
							// 2. 로그인 처리가 정상적으로 이루어졌다면 ch07_test_memberList.jsp로 이동해주세요.
							
							//DAO 인스턴스 가져오기
							MemberDAO dao = MemberDAO.getInstance();

							ArrayList<MemberVO> memberList = dao.getMemberList();
							
							String id = request.getParameter("id");
							String pw = request.getParameter("pw");
							
							//회원 전체와 전달받은 아이디, 비밀번호를 비교하기 위해서 전체 목록 데이터가
							//있는지 없는지 null 체킹을 진행한다.
							if(memberList !=null&&memberList.size()>0){
								boolean flag = false;	// 회원 존재하지 않음
								for(MemberVO memberVO : memberList){
									// 일치하는 회원정보가 존재 할 때
									if(id.equals(memberVO.getMem_id())&&
											pw.equals(memberVO.getMem_pw())){
										flag=true;
										break;
									}
								}
							if(flag){	//아이디 비밀번호 일치하는 회원정보 존재
								response.sendRedirect(request.getContextPath()+"/ch07/test/ch07_test_memberList.jsp?id="+id);
							}else{		//일치하는 회원 없음
								request.getRequestDispatcher("ch07_test_signin.jsp?error=1").forward(request, response);
								
							}
							}else{
								request.getRequestDispatcher("ch07_test_signin.jsp?error=3").forward(request, response);
							}
							
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