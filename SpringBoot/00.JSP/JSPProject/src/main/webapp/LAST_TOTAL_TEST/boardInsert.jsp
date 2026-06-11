<%@page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@page import="kr.or.ddit.ch17.vo.BoardFileVO"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
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
							게시글 등록 처리 페이지 입니다.
							게시글 등록 페이지에서 입력된 데이터를 전송하면 이곳으로 전달되어 옵니다.
							이곳에서 게시글 등록 처리를 진행하면 됩니다.
							1. 게시글 등록을 처리해주세요.
								> 게시글 등록 성공 시, 상세보기 페이지(boardView.jsp)로 이동해주세요.
														
							2. 게시글 등록 시, 구현해야할 옵션 기능을 설정해주세요.
								# 파일업로드
								> 게시글 등록 시, 파일 크기는 1MB로 제한해주세요.
								> 파일크기 1MB를 넘는 파일을 업로드 시, '업로드 파일 크기를 초과하였습니다' 메세지를 출력해주세요.
								> 파일을 추가하지 않은 경우에는 일반 게시글이 등록될 수 있도록도 해주세요.(파일 없이도 게시글 등록이 가능하도록)
								
								# 작성자
								> 작성자는 로그인 당시에 설정한 회원 정보의 아이디를 작성자로 넣어주세요.					
						 -->
						 <% 
						 request.setCharacterEncoding("UTF-8");
						 
						 String[] user = (String[])session.getAttribute("SessionInfo");
						 if(user==null||user.length==0){
							response.sendRedirect("login.jsp?error=2");
							return;
						 };
						 String writer = user[0];
						 String title = request.getParameter("title");
						 String content = request.getParameter("content");
						 
						 BoardRepository boardDao = BoardRepository.getInstance();
						 /////////////////해야할것, vosetting + 로그인 안했을 경우 로그인화면으로!
						 
						 BoardVO bvo = new BoardVO();
						 
						 //파일관련 
						 String path = request.getServletContext().getRealPath("/resources/images/upload");
						 BoardFileVO bfvo = new BoardFileVO();

						 int maxSize = 1*1024*1024;	//1MB 맥스사이즈
						 boolean flag = true;
						 String fileName = "";	//저장할 파일이름 UUID로 구할것
						 String originalFileName = "";	//저장할 파일의 원본이름(보여주기용)
						 String contentType = "";	//미디어타입
						 
						 File tempFile = new File(path);
						 if(!tempFile.exists()){
							 tempFile.mkdirs(); // 없을경우 경로까지 싹 만들기
						 }
						 
						 Part atchFile =request.getPart("filename");
						 
						 long fileSize = atchFile.getSize();
						 
						 if(maxSize<fileSize){
							response.sendRedirect("boardForm.jsp?error=1");							 
						 }			//fileSize 검사
						 
						 if(atchFile !=null && atchFile.getSize()>0){
							 originalFileName = atchFile.getSubmittedFileName();
							 contentType = originalFileName.substring(originalFileName.lastIndexOf("."));
							 fileName = UUID.randomUUID().toString() + contentType;
							 
							 atchFile.write(path + File.separator + fileName);
							 
							 bfvo.setContentType(contentType);
							 bfvo.setFileName(fileName);
							 bfvo.setFileSize(fileSize);
							 bfvo.setOriginalFileName(originalFileName);
							 bvo.setFileVO(bfvo);
						 }
						 bvo.setWriter(writer);
						 bvo.setContent(content);
						 bvo.setTitle(title);
						 
						 boardDao.addBoard(bvo);
							
						 response.sendRedirect("boardList.jsp?insRes=1");
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