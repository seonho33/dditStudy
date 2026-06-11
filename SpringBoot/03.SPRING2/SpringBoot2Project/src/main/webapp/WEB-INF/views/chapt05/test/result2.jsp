<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
    <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>start</h1>

<c:set value="${memberVO.carArray }" var="carArray"/>
<c:set value="${memberVO.hobbyList }" var="hobbyList"/>

<h4>아이디 : ${memberVO.userId }</h4>
<h4>비밀번호 : ${memberVO.password }</h4>
<h4>이름 : ${memberVO.userName }</h4>
<h4>이메일 : ${memberVO.email }</h4>
<h4>생년월일 : <fmt:formatDate value="${memberVO.dateOfBirth }" pattern="yyyy년MM월dd일"/></h4> 
<h4>성별 : ${memberVO.gender eq 'male'? '남성' : '여성' }</h4>
<h4>개발자 여부 : ${not empty memberVO.developer ? '개발자' : '비개발자' }</h4>	
<h4>외국인 여부 : ${memberVO.foreigner? '외국인':'내국인' }</h4>
<h4>국적
<c:choose>
	<c:when test="${memberVO.nationality eq 'korea' }">
		 : 대한민국</h4>
	</c:when> 
	<c:when test="${memberVO.nationality eq 'germany' }">
		 : 독일</h4>
	</c:when> 
	<c:when test="${memberVO.nationality eq 'usa' }">
		 : 미국</h4>
	</c:when> 
	<c:otherwise>
		없음</h4>
	</c:otherwise>
</c:choose>


<h4>소유차량
	<c:choose>
		<c:when test="${not empty carArray and fn:length(carArray)>0 }">
			<c:forEach items="${carArray }" var="car" varStatus="vs">
				<c:if test="${!vs.last and car ne '' }">
					${car } ,
				</c:if>
				<c:if test="${vs.last }">
					${car } </h4>
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			없음 </h4>
		</c:otherwise>
	</c:choose>	
</h4>


<h4>취미
	
</h4>


<h4>우편번호 : ${memberVO.address.postCode }</h4>
<h4>주소 : ${memberVO.address.location }</h4>
<h4>카드1-번호 : ${memberVO.cardList.get(0).no} </h4>



<h4>카드1-유효년월 : <fmt:formatDate value="${memberVO.cardList.get(0).validMonth }" pattern="yyyy년MM월dd일"/> </h4>
<h4>카드2-번호 ${memberVO.cardList.get(1).no}</h4>
<h4>카드2-유효년월 <fmt:formatDate value="${memberVO.cardList.get(1).validMonth}" pattern="yyyy년MM월dd일"/>  </h4>
<h4>소개</h4>

</body>
</html>