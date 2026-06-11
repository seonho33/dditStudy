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
						/* 	
							파일을 받는 방법엔 여러가지 방식이 존재한다.
							Commons 종류의 라이브러리를 이용한 방법, HttpServletRequest 객체를 활용한 방법
							등등이 존재하는데 Commons 종류를 활용한 방법에는 DiskFileUpload 객체를 활용해
							전달받은 request를 parseRequest()메소드를 이용해 reqeust에 담겨져 들어오는
							일반데이터와 파일 데이터를 isFormField() 메소드로 분리해 일반데이터와 파일데이터를
							각각 처리할 수 있도록 제공합니다. 하지만, 해당 DiskFileUpload 객체를 활용한 방법은
							Servlet 5.0 이상에서는 지원되지 않습니다.
							parseRequest()의 parameter는 request 객체인데 해당 객체의 타입이
							HttpServletRequest 객체만 가능합니다. 우리가 현재 사용중인 Servlet5.0 이상이면서
							Tomcat 10이상입니다. 그렇기 때문에 request 객체 타입이 javax의 형태가 아닌 jakarta의 형태이므로
							전달되어지는 파라미터가 달라집니다.
							즉, DiskFileUpload 객체를 활용한 파일 업로드가 불가능하다는 이야기입니다.
							그래서, request 객체 안에 들어있는 여럭데이터들 중, 파일 데이터를 받을 때 사용합니다.
							Part 타입의 데이터는 request에 담겨져 들어오는 데이터들 중, 파일 데이터를 받을 때 사용합니다.
							Part는 Method 방식이 Post 요청 내에서 'multipart/form-data'수신된 부분 또는
							양식 항목을 나타냅니다
						
						 */
							Part part = request.getPart("fileNameeee");
							if(part!=null&&part.getSize()>0){
								out.println("<p clas='customer_text'>Result</p>");
								out.println("<p class='ddit_text'>");
								//getName() 메소드로 파일데이터의 key 값을 꺼낸다
								out.println("  name : " + part.getName()+"<br/>");
								//getSubmittedFileName() 메소드로 파일명을 꺼낸다
								out.println("  fileName : " + part.getSubmittedFileName()+"<br/>");
								//getSize() 메소드로 파일 크기를 꺼낸다.
								out.println("  size : " + part.getSize()+"<br/>");
								//getContentType() 메소드로 파일 MimeType 을 꺼낸다
								out.println("  contentType : " + part.getContentType()+"<br/>");
								out.println("</p>");
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