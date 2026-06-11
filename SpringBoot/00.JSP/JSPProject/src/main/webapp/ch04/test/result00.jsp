<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH01") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<%
							// 타입(포워딩:1, 리다이렉트:2) 꺼내기
							String type = (String) request.getParameter("type");
							
							if(type.equals("redirect")){	// 리다이렉트 타입
								// 이미지 횟수 목록 꺼내기
								List<Integer> s_imgList = (List<Integer>) session.getAttribute("imgList");
								String s_num = (String) request.getParameter("s_num");	// 횟수 꺼내기
								%>
								<c:set value="<%=s_imgList %>" var="s_imgList"/>
								<c:set value="<%=s_num %>" var="s_num"/>
								<%
							}else{							// 포워드 타입
								String num = (String) request.getAttribute("num");		// 입력 횟수 꺼내기
								int cnt = (int) request.getAttribute("cnt");			// 요청 횟수 꺼내기
								String status = (String) request.getAttribute("status");// 상태 꺼내기
								List<Integer> imgList = (List<Integer>) request.getAttribute("imgList");	// 이미지 횟수 목록 꺼내기
								%>
								<c:set value="<%=cnt %>" var="cnt"/>
								<c:set value="<%=status %>" var="stat"/>
								<c:set value="<%=imgList %>" var="imgList"/>
								<c:set value="<%=num %>" var="num"/>
								<%
							}
						%>
						<c:set value="<%=type %>" var="type"/>
						
						<button class="btn btn-sm btn-primary" onclick="javascript:location.href='/send.do'">다시하기</button>
						<table class="table table-bordered">
							<c:if test="${type ne 'forward' }">
								<tr>
									<td>
										<c:forEach items="${s_imgList }" var="imgNum">
										<img src="${pageContext.request.contextPath }/resources/images/ch04/sin${imgNum}.jpg" width="300px"/><br/>
									</c:forEach>
									</td>
									<td>
										<p class="ddit_text">
											페이지 이동방식 타입 : ${type }<br/>
											입력 횟수 : ${s_num }번<br/>
											현재 횟수 : ${s_num }번<br/>
											현재 상태 : 횟수 사용 완료! 이미지 완성!
										</p>
									</td>
								</tr>
							</c:if>
							<c:if test="${type eq 'forward' }">
								<tr>
									<td width="30%">
										<c:forEach items="${imgList }" var="imgNum">
											<img src="${pageContext.request.contextPath }/resources/images/ch04/sin${imgNum}.jpg" width="300px"/><br/>
										</c:forEach>
									</td>
									<td>
										<p class="ddit_text">
											페이지 이동방식 타입 : ${type }<br/>
											입력 횟수 : ${num }번<br/>
											현재 횟수 : ${cnt }번<br/>
											<c:if test="${stat eq 'ing' }">
												현재 상태 : 진행중!
											</c:if>
											<c:if test="${stat eq 'ok' }">
												현재 상태 : 횟수 사용 완료! 이미지 완성!
											</c:if>
										</p>
									</td>
								</tr>
							</c:if>
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