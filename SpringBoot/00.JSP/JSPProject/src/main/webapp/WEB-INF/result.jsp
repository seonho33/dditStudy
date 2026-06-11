<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	<%
		List<Map<String, Object>> r_memberList = (List<Map<String,Object>>) request.getAttribute("reqMemberList");
		List<Map<String, Object>> s_memberList = (List<Map<String,Object>>) session.getAttribute("sesMemberList");
		
		if(r_memberList != null&&r_memberList.size()>0){
	%>
		<c:set value="<%=r_memberList %>" var="rMemberList"></c:set>
	<%
		}
		if(s_memberList !=null&& s_memberList.size()>0){
	%>
		<c:set value="<%=s_memberList%>" var="sMemberList"></c:set>
	<%
	}
	%>

	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH04") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<%
							//입력받은 data는 페이지 이동방식에 따라서 결과 페이지만 result.jsp
							//로 전달되거나 전달되지 못한다. 아ㅓ떤 방식이냐에 따라서 scope에 담긴
							//데이터를 꺼낼 수 있다
							String type = request.getParameter("type"); 
							String id = request.getParameter("id");
							
						%>
					
						<h4 class="ddit_chapter text-center">입력받은 Data</h4>
						<p class="ddit_text pb-4"></p>
						<p>입력받은 타입 :	<%=type %></p>
						<p>입렫받은 아이디 :<%=id %> </p>
						
						<h4 class="ddit_chapter text-center">등록 완료 후</h4>
						<p class="ddit_text pb-4">페이지 이동방식 포워딩</p>
						
						<p>request_memberList : ${rMemberList }</p>
						<p>session_memberList : ${sMemberList }</p>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>번호</th>
									<th>아이디</th>
									<th>비밀번호</th>
									<th>이름</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty rMemberList }">
										<tr>
											<td colspan="4"> 조회하신 정보가 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${rMemberList}" var="member">
											<tr>
												<td>${member.no}</td>
												<td>${member.id }</td>
												<td>${member.pw }</td>
												<td>${member.name }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						
						<p class="ddit_text pb-4">페이지 이동방식 리다이렉트</p>
						<p>request_memberList : ${rMemberList }</p>
						<p>session_memberList : ${sMemberList }</p>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>번호</th>
									<th>아이디</th>
									<th>비밀번호</th>
									<th>이름</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty sMemberList }">
										<tr>
											<td colspan="4"> 조회하신 정보가 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${sMemberList}" var="member">
											<tr>
												<td>${member.no}</td>
												<td>${member.id }</td>
												<td>${member.pw }</td>
												<td>${member.name }</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
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