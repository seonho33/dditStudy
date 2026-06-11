<%@page import="java.util.Map"%>
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
	<%
	List<Map<String,Object>> reqmemberList = (List<Map<String,Object>>) request.getAttribute("reqResultList");
			//redirect1)
			List<Map<String,Object>> sesmemberList = (List<Map<String,Object>>) session.getAttribute("sesResultList");//*****
			
			
			if(reqmemberList != null&&reqmemberList.size()>0){
	%>
		<c:set value="<%=reqmemberList%>" var="rResultList"></c:set>
	<%
	}//end if(forward)
		
			if(sesmemberList !=null&& sesmemberList.size()>0){
	%>
			<!-- JSTL 변수(sResultList)에 담음 : EL활용가능 -->
			<c:set value="<%=sesmemberList%>" var="sResultList"></c:set>
	<%
	//스크립틀릿
			}//end if(redirect)
	%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH04")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						
						<%
							Map<String,Object> resultMap=null;	
							//redirect2)
							if(sesmemberList!=null){
							resultMap = sesmemberList.get(0);
							}
							
							String type;
							String number;
							
							if(request.getParameter("type")!=null||request.getParameter("type")!=""){
								 type = request.getParameter("type");
							}else{
								 type = (String)resultMap.get("type");
							}
							if(request.getParameter("number")!=null&&request.getParameter("number")!=""){
								 number = request.getParameter("number");
							}else{
								 number = (String)resultMap.get("number");
							}
							
							int num = Integer.parseInt(number);
							
							request.setAttribute("num", num);
						%>
						
						<button class="btn btn-sm btn-primary">다시하기</button><br>
						<table class="table table-bordered">
							<tr>
								<c:if test="${type eq 'forward'}">
 								<c:choose>
									<c:when test="${no<num}"> 
										<c:forEach var="k" begin="1" end="${no}">
											<img src="/resources/images/ch04/sin${k}.jpg" width="300px"/><br/>
										</c:forEach>
 									</c:when>				
									<c:otherwise>
										<c:forEach var="k" begin="1" end="${num}">
											<img src="/resources/images/ch04/sin${k}.jpg" width="300px"/><br/>
										</c:forEach>
									</c:otherwise>									
								</c:choose>
								</c:if>
								<c:if test='${type eq "redirect"&& num < 5}'>
										<c:forEach var="k" begin="1" end="${number}" step="1">
											<img src="/resources/images/ch04/sin${k}.jpg" width="300px"/><br/>
										</c:forEach>
								</c:if>
								<c:if test='${type eq "redirect" && num > 4}'>
									<c:forEach  var="k" begin="1" end="4" step="1">
										<img src="/resources/images/ch04/sin${k}.jpg" width="300px"/><br/>
									</c:forEach>
								</c:if>
								<td>
									<p class="ddit_text">
										페이지 이동방식 타입 : ${type}<br/>
										입력 횟수 : ${num}번<br/>
									</p>
									<c:choose>
										<c:when test="${no>num}">
											<p class="ddit_text">
												현재 횟수 : ${no}번<br/>
											</p>	
										</c:when>
										<c:otherwise>
											<p class="ddit_text">
												현재 횟수 : ${no}번<br/>
											</p>	
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${no>=num}">
											<p class="ddit_text">
												현재 상태 : 횟수 사용 완료! 이미지 완성!
											</p>
										</c:when>
										<c:otherwise>
											<p class="ddit_text">
												현재 상태 : 진행중!
											</p>
										</c:otherwise>
									</c:choose>
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