<%@page import="java.util.Enumeration"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH06")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<table class="table table-bordered">
							<tr>
								<th>요청 파라미터 이름</th>							
								<th>요청 파라미터 값</th>							
							</tr>

						
					<%!public String getHobby(String hobby){
						String hob=null;
						
						if(hobby.equals("book"))hob="독서";
						if(hobby.equals("sports"))hob="운동";
						if(hobby.equals("movie"))hob="영화감상";
						
						return hob;
					}%>
					<%
						request.setCharacterEncoding("utf-8");
					
						Enumeration paramNames = request.getParameterNames();
						while(paramNames.hasMoreElements()){
							String name = (String)paramNames.nextElement();
							out.println("<tr><td>" + name +"</td>");
							
							//폼 페이지에서 전송된 요청 파라미터의 값을 얻어온다.
							String paramValue = request.getParameter(name);
							
							// 넘겨받은 값들 중, 성별과 취미는 형태 변화가 필요함.
							if(name.equals("gender")){
								paramValue = "남자";
								String gender = request.getParameter(name);
								if(gender.equals("G")) paramValue= "여자";
							}
							if(name.equals("hobby")){
								paramValue ="";
								String[] hob = request.getParameterValues(name);
								for(int i =0; i<hob.length; i++){
									paramValue += getHobby(hob[i]) + " ";
								}
							}
							
							out.println("<td>" +paramValue+"</td></tr>");
						}
					%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>