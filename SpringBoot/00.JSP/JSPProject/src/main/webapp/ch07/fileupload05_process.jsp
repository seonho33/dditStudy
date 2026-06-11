<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH07")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<%
							// 파일을 업로드 하기 위한 방법
							// 2. 서버 업로드 환경에 업로드
							// 이클립스에 설정한 tomcat의 환경이 존재한다. 그렇기 때문에 우리가 개발중인
							// 프로젝트가 서버를 통해 run 이 되면, .war로 변환된 프로젝트 파일이 tomcat
							// 서버 환경에 배포되어 실행되는데, 이때 해당 경로가
							// workspace_jsp/.metadata/plugins/xxx.server.core/tmp0/wtpwebapp/JSPProject에 해당하는 ROOT
							// 로부터 내가 설정한 /resources/upload 라는 폴더를 찾아 해당 위치에 파일을
							// 업로드 하기 시작합니다.
							
							// 그렇기 때문에 배포된 내 프로젝트 파일이 ROOT로서 시작하는 위치 경로를
							// 자바 메서드를 통해서 가져올 필요가 있습니다. 이때 사용할 수 있는 메서드가
							// getServletContext().getRealPath() 메소드를 활용할 수 있습니다.
							
							String path = request.getServletContext().getRealPath("/resources/upload");
							// 해당 위치에 upload 폴더가 존재하지 않을 때
							File tempFile = new File(path);
							if(!tempFile.exists()){
								tempFile.mkdirs();	//만들어지지 않은 폴더 모두 만들엉!!!
							}
							
							//일반 데이터를 꺼낸다. (getParameter())
							String id = request.getParameter("id");
							String pw = request.getParameter("pw");
							String name = request.getParameter("name");

							String filename = "";	// 파일 명
							int maxSize = 1*1024*1024;	//1MB(파일 업로드시 최대 사이즈)
							boolean flag = true;	//업로드 성공이 기본값!
							
							Collection<Part> collect = request.getParts();
							//Iterator를 이용해 Part 데이터를 꺼내기 위한 준비를 한다.
							Iterator<Part> ite = collect.iterator();
							while (ite.hasNext()){
								Part part = ite.next();
								String key = part.getName();
								
								// 파라미터중 첨부파일인 profileImg 는 분기로 걸러서 따로 받는다.
								if(key.equals("profileImg")){
									filename = part.getSubmittedFileName();
									long fileSize = part.getSize();	// 파일 크기
									
									if(maxSize < fileSize){
										flag = false;	// 업로드 실패
									}else{
										part.write(path+"/"+filename);	//파일 복사
									}
								}
							}
							
							if(flag){
								out.println("<h5 class='customer_text'>가입을 완료합니다!</h5>");
								out.println("<p class='ddit_text'>");
								out.println("  아이디 : " + id + "<br/>");
								out.println("  비밀번호 : " + pw + "<br/>");
								out.println("  이름 : " + name + "<br/>");
								out.println("  프로필 : " + filename + "<br/>");
								out.println("</p>");
							}else{
								out.println("등록에 실패했습니다!<br/>");
								out.println("파일 크기를 초과하였습니다!<br/>");
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