<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="kr.or.ddit.ch17.vo.BoardFileVO"%>
<%@page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
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
							게시글 수정 처리를 진행할 페이지입니다.
							1. 게시글 수정을 처리해주세요.
								> 수정 성공 후, 상세보기 페이지(boardView.jsp)로 이동해주세요.
								
							2. 게시글 수정 시, 등록과 같은 옵션 정보를 처리해주세요.
								> 등록과  옵션 정보 동일
						-->
						<% 
						String sno = request.getParameter("no");
						if(sno == null){
							response.sendRedirect("boardList.jsp?error=1");
						}
						
						String[] user = (String[])session.getAttribute("SessionInfo");
						String title = (String)request.getParameter("title");
						String content = (String)request.getParameter("title");
						
						if(user == null){
							response.sendRedirect("login.jsp?error=3");
						}

						BoardVO bvo = new BoardVO(); 
						
						BoardRepository boardDao = BoardRepository.getInstance();
						
						int no = Integer.parseInt(sno);
						bvo = boardDao.getOnlyBoardById(no);
						
						
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
						 
						 System.out.println("atchFile size = " + atchFile.getSize());
						 
						 long fileSize = atchFile.getSize();
						 
						 if(maxSize<fileSize){
							response.sendRedirect("boardForm.jsp?error=1");							 
						 }			//fileSize 검사
						 
						 if(atchFile !=null && atchFile.getSize() > 0){
							 originalFileName = atchFile.getSubmittedFileName();
							 contentType = originalFileName.substring(originalFileName.lastIndexOf("."));
							 fileName = UUID.randomUUID().toString() + contentType;
							 
							 atchFile.write(path + File.separator + fileName);
							 
							 bfvo.setContentType(contentType);
							 bfvo.setFileName(fileName);
							 bfvo.setFileSize(fileSize);
							 bfvo.setOriginalFileName(originalFileName);
						 }
						bvo.setFileVO(bfvo);
						 
						bvo.setTitle(title);
						bvo.setContent(content);
						
						boardDao.updateBoard(bvo);
						
						response.sendRedirect("boardList.jsp");
						
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