<%@page import="java.util.Enumeration"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	<%!public String getHobby(String hobby){
		String hob=null;
		
		if(hobby.equals("book"))hob="독서";
		else if(hobby.equals("sports"))hob="운동";
		else if(hobby.equals("movie"))hob="영화감상";
		else if(hobby.equals("music"))hob="음악";
		else if(hobby.equals("etc")){
			hob="";
		}else{
			hob = hobby;
		}
		
		return hob;
	}%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH06")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<select class="form-control" id="selectOption" name="option" onchange="selectOption(this.value)">
							<option value="type">---선택해주세요---</option>
							<option value="script">스크립틀릿</option>
							<option value="jstl">JSTL</option>
						</select><br/><br/>
						
					<div id="none"  style="display: none;">
						<h1>선택해주세요</h1>
					</div>
						
					<div id="scriptDiv" style="display: none;">
						<table class="table table-bordered">
							<tr>
								<th>요청 파라미터 이름</th>
								<th>요청 파라미터 값</th>
							</tr>
							
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
					<div id="jstlDiv" style="display: none;">
						타입 : ${param.type}<br/>
						아이디 : ${param.id}<br/>
						비밀번호 : ${param.pw }<br/>
						이름 : ${param.name }<br/>
						핸드폰 번호 : ${param.phone1} - ${param.phone2 } - ${param.phone3 }<br/>
						성별 :<c:if test="${param.gender eq 'M' }">남자</c:if>
							 <c:if test="${param.gender eq 'G'}">여자</c:if><br/>
						
						취미 :
						<c:forEach var="k" items="${paramValues.hobby}" >
							<c:choose>
									<c:when test="${k eq 'sports' }">운동</c:when>
									<c:when test="${k eq 'book' }">독서</c:when>
									<c:when test="${k eq 'movie' }">영화감상</c:when>
									<c:when test="${k eq 'music' }">음악</c:when>
									<c:when test="${k eq 'etc' }"></c:when>
									<c:otherwise>${k}</c:otherwise>
							</c:choose>
						</c:forEach>
						<br/>
							
						가입인사 : ${param.comment}
					</div>			
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
<script type="text/javascript">


const selectOption = (ev) => {
		
	  document.querySelector("#none").style.display = "none";
	  document.querySelector("#scriptDiv").style.display = "none";
	  document.querySelector("#jstlDiv").style.display = "none";
		
	if(ev === "type"){
	    document.querySelector("#none").style.display = "block";
	  } else if(ev === "script"){
	    document.querySelector("#scriptDiv").style.display = "block";
	  } else if(ev === "jstl"){
	    document.querySelector("#jstlDiv").style.display = "block";
	  }
}
	
</script>
	
</body>
</html>