<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.io.File"%>
<%@page import="kr.or.ddit.ch07.MemberVO"%>
<%@page import="kr.or.ddit.ch07.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
						<!--
							1. 회원가입 처리를 진행해주세요.
								- 회원가입 시, 등록에 필요한 항목 모두를 이용해 가입을 진행해주세요.
								  > MemberDAO의 insertMember() 메소드를 활용하여 가입을 진행해주세요.
								- 프로필 이미지가 있기 때문에 파일 처리도 함께 해주세요.
								- 가입 완료 후, 로그인 페이지로 이동해주세요.
								
							2. 프로필 이미지를 업로드 할 때, 파일 크기가 1MB를 넘어가는 경우 "파일 크기가 초과되어 회원가입을 진행할 수 없습니다." 라는 
							   에러 메세지를 회원가입 페이지(ch07_test_signup.jsp)에서 출력해주세요.
						-->

						
						<%
							MemberDAO dao = MemberDAO.getInstance();
							ArrayList<MemberVO>	memberList = dao.getMemberList();
							
							MemberVO memberVO = new MemberVO();
							
							boolean flag = false;
							String id = request.getParameter("id");
							
							if(memberList !=null && memberList.size()>0){
								for(MemberVO mvo : memberList){
									if(id.equals(mvo.getMem_id())){
										flag = true;
										break;
									}
								}
							}
							
							if(flag){
								request.getRequestDispatcher("ch07_test_signup.jsp?error=1").forward(request, response);
							}else{

							
							String pw = request.getParameter("pw");
							String name = request.getParameter("name");
							String gender = request.getParameter("gender");
							
							
						// 파일 담당 로직
						String path = "C:/upload/images";
						String filename = "";
						File tempFile = new File(path);
						int maxSize = 1*1024*1024;	//1MB(파일 업로드시 최대 사이즈)
						boolean sizeFlag = true;
						
						if(!tempFile.exists()){
							tempFile.mkdirs();							
						}
						Part part = request.getPart("filename");
						long fileSize = part.getSize();
						if(maxSize<fileSize){
							sizeFlag = false;
						}
						if(!sizeFlag){
							request.getRequestDispatcher("ch07_test_signup.jsp?error=2").forward(request,response);
						}else{

						if(part!=null&&part.getSubmittedFileName()!=null&&!part.getSubmittedFileName().equals("")){
							filename = part.getSubmittedFileName();
							
							part.write(path+"/"+filename);	//파일복사
						
							memberVO.setFilename(filename);
						}
						
						memberVO.setMem_id(id);
						memberVO.setMem_pw(pw);
						memberVO.setMem_name(name);

						if(gender.equals("M")){
							memberVO.setMem_sex("남자");
						}else{
							memberVO.setMem_sex("여자");
						}
						
						dao.insertMember(memberVO);
						response.sendRedirect(request.getContextPath()+"ch07_test_signin.jsp");
						}
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