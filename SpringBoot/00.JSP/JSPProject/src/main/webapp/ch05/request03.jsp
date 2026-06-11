<%@page import="java.net.InetAddress"%>
<%@page import="java.net.UnknownHostException"%>
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
						<table class="table table-bordered">
							<tr>
								<td></td>
								<td>값</td>
								<td>설명</td>
							</tr>
							<!--
								클라이언트 IP
								-0:0:0:0:0:0:0:1
								-IPv6(Internet Protocol version 6) 의 루프백 주소로
								IPv4 의 루프백 주소인 127.0.0.1 과 같은 역할을 합니다
								-즉, 자기 자신을 가리키는 주소
							 
							 -->
							<tr>
								<td width="20%">클라이언트 IP</td>
								<td width="20%"><%=request.getRemoteAddr() %></td>
								<td width="60%">웹 브라우저의 IP주소를 가져옵니다.</td>
							</tr>
							<tr>
								<td>서버 IP(서버의 로컬 IP)</td>
								<td>
								<%
									try{
										InetAddress inetAddr = InetAddress.getLocalHost();
										String servId = inetAddr.getHostAddress();
										out.print(servId);
									}catch(UnknownHostException e){
										out.println("서버 주소를 가져오는데 실패했습니다.");
									}
								%>
								</td>
								<td>인터넷 서비르슷 제공하는 서버 컴퓨터에 할당된 고유한 주소</td>
							</tr>
							<!-- 
								#요청 정보 길이
								- 요청 본문(Body) 영역에 포함되어 있는 데이터릐 길이를 바이트 단위로 변환
								-클라이언트가 서버로 전송한 데이터 본문 크기를 나타낸다.
							 -->
							
							<tr>
								<td>요청 정보 길이</td>
								<td><%= request.getContentLength() %></td>
								<td>웹 브라우저의 요청 본문의 길이를 가져옵니다.</td>
							</tr>
							<tr>
								<td>요청 정보 콘텐츠 유형</td>
								<td><%= request.getContentType() %></td>
								<td>웹 브라우저의 콘텐츠 유형을 가져옵니다.</td>
							</tr>
							<tr>
								<td>요청 정보 인코딩</td>
								<td><%= request.getCharacterEncoding() %></td>
								<td>웹 브라우저의 문자 인코딩을 가져옵니다.</td>
							</tr>
							<tr>
								<td>요청 정보 프로토콜</td>
								<td><%= request.getProtocol() %></td>
								<td>웹 브라우저의 요청 프로토콜을 가져옵니다.</td>
							</tr>
							<tr>
								<td>요청 정보 전송방식</td>
								<td><%= request.getMethod() %></td>
								<td>웹 브라우저의 HTTP 요청 메서드(GET,POST)를 가져옵니다.</td>
							</tr>
							<tr>
								<td>요청 URL</td>
								<td><%= request.getRequestURL() %></td>
								<td>웹 브라우저가 오청한 URL 경로를 가져옵니다.</td>
							</tr>
							
							<!-- #요청 URI : 프로토콜과 도메인(ROOT)를 제외한 나머지 경로를 말한다. -->
							<tr>
								<td>요청 URI</td>
								<td><%=request.getRequestURI()  %></td>
								<td>웹 브라우저가 요청한 URI 경로를 가져옵니다.</td>
							</tr>
							<!-- #컨텍스트 경로 : 웹 애플리케이션의 ROOT경로를 말한다. -->
							<tr>
								<td>컨텍스트 경로</td>
								<td><%= request.getContextPath() %></td>
								<td>현재 JSP 페이지의 웹 어플리케이션 컨텍스트 경로를 가져옵니다.</td>
							</tr>
							<tr>
								<td>서버 이름</td>
								<td><%= request.getServerName() %></td>
								<td>서버 이름을 가져옵니다.</td>
							</tr>
							<tr>
								<td>서버 포트</td>
								<td><%= request.getServerPort() %></td>
								<td>실행중인 서버 포트번호를 가져옵니다.</td>
							</tr>
							<tr>
								<td>쿼리문(Query String)</td>
								<td><%= request.getQueryString() %></td>
								<td>웹 브라우저의 전체 요청 파라미터 문자열
									[물음표(?) 다음 URL에 할당된 문자열을 가져옵니다.]
								</td>
							</tr>
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