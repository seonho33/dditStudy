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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH05")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<table class="tabel table-bordered">
							<tr>
								<td>헤더 KEY</td>
								<td>헤더 VALUE</td>
							</tr>
							<% 
							//모든 헤더 이름을 가져오도록 request 내장객체의
							//retHeaderNames() 메소드를 작성하고 이를 모두 저장하도록
							//Enumberation 객체 타입의 en 변수를 작성
							Enumeration en = request.getHeaderNames();
							
							//Enumberation 객체 타입의 변수 en의 hasMoreLements()메서드를 ㅂㄹ
							//저장된 헤더 이름이 없을 때 까지 반복하도록 while 문을 작성함
							while(en.hasMoreElements()){
								//현재 헤더 이름을 가져오도록 Enumeration 객체 타입의 변수
								//변수 en 의 nextElement() 메소드를 진행함
								String headerName = (String) en.nextElement();
								//설정된 헤더이름의 값을 가져오도록 request 내장객체의
								//getHeader() 메서드를 작성함
								String headerValue = request.getHeader(headerName);
								
								//스타일 지정 : 배경색 (white or snow)
								String style = "white";
								//header /정보들 중, accept 또는 user-agent 인 경우 스타일을 ㅈ정
								if(headerName.equals("accept")||
									headerName.equals("user-agent")){
										style="snow";
								}
							%>
							<tr style="background-color: <%=style%>">
								<th><%=headerName %></th>
								<td><%=headerValue%></td>
							</tr>
							<%
							}
							
							//#user-agent 정보
							//[형태 : Mozilla 정보/버전 + 운영체제 정보 + 브라우저 랜더링 엔진 정보 + 브라우저 버전 정보]
							//User-Agent는 위와 같이 사용자의 운영체제, 브라우저 정보 등을 가지고 있으므로 파일 다운로드, 수집 정보 등을
							//핸들링 할 때 활용도가 높은 정보입니다.
							//#Accept
							//클라이언트가 서버로부터 어떤 ContentType(Mime Type)의 데이터를 받을 수 있는지를 서버에게 알려주는 역할을 합니다.
							//즉, 클라이언트가 처리할 수 있는 데이터 형식을 서버에게 명시적으로 전달합니다.
							//[ex) Accept : text/html, application/xhtml_xml, application/xml;q=0.9,image...]
							//HTML 문서를 가장 선호하고 XHTML 문서를 다음 순서로 선호하고... XML은 우선순위가 조금 하위, 이미지는 ~~~~
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