<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<!-- 

[아래 결과처럼 출력해주세요.]

유저 ID : a001
패스워드 : 1234
이름 : 조현준
E-Mail : wh-guswns123@hanmail.net
생년월일 : 어떤 날짜 규격이든 날짜 데이터면 됨
성별 : 남자 or 여자
개발자 여부 : 개발자 or 비개발자
외국인 여부 : 외국인 or 내국인
국적 : 대한민국 or 캐나다 or 호주
소유차량 : 수유차량 없음 or AUDI, BMW or AUDI, BMW, VOLVOL 
취미 : 취미 없음 or 운동 영화시청 or 운동 영화시청 음악감상 
우편번호 : 123456
주소 : 대전광역시 종구 오류동 112
카드1(번호) : 1451-1234-1234-1234
카드1(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨
카드2(번호) : 1451-1234-1234-1234
카드2(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨
소개 : 반갑습니다!

 -->
<c:set value="${memberVO.carArray}" var="carArray"/>
<c:set value="${memberVO.hobbyList }" var="hobbyList"/>

<h4>유저 ID : ${memberVO.userId}</h4>
<h4>패스워드 : ${memberVO.password }</h4>
<h4>이름 : ${memberVO.userName }</h4>
<h4>E-Mail : ${memberVO.email }</h4>
<h4>생년월일 : <fmt:formatDate value="${memberVO.dateOfBirth}" pattern="yyyy-MM-dd"/></h4>
<h4>성별 : ${memberVO.gender eq 'male' ? "남자" : "여자" }</h4>
<c:if test=""></c:if>

<h4>개발자 여부 : ${memberVO.developer eq 'Y' ? "개발자" : "비개발자" }</h4>
<h4>외국인 여부 : ${memberVO.isForeigner()?"외국인":"내국인"}</h4>
<c:choose>
	<c:when test="${memberVO.nationality eq 'korea'}">
		<h4>국적 : 대한민국</h4>
	</c:when>
	<c:when test="${memberVO.nationality eq 'germany'}">
		<h4>국적 : 독일</h4>
	</c:when>
	<c:when test="${memberVO.nationality eq 'canada'}">
		<h4>국적 : 캐나다</h4>
	</c:when>
	<c:when test="${memberVO.nationality eq 'usa'}">
		<h4>국적 : 미국</h4>
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${not empty carArray}">
			<h4> 소유차량 : 
				<c:forEach items="${carArray }" var="car" varStatus="vs">
					<c:choose>
						<c:when test="${!vs.last && car ne '' }">
							${car }, 
						</c:when>
						<c:when test="${vs.last }">
							${car }
						</c:when>
					</c:choose>
				</c:forEach>
			</h4>
	</c:when>
	<c:otherwise>
		<h4>소유 차량 없음</h4>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty hobbyList }">
		<h4>취미 : 
			<c:forEach items="${hobbyList }" var="hobby" varStatus="vs">
				<c:choose>
					<c:when test="${!vs.last}">
						<c:if test="${hobby eq 'book' }">
							독서, 
						</c:if>
						<c:if test="${hobby eq 'sports' }">
							운동, 
						</c:if>
						<c:if test="${hobby eq 'movie' }">
							영화감상, 
						</c:if>
						<c:if test="${hobby eq 'music' }">
							음악감상, 
						</c:if>
					</c:when>
					<c:when test="${vs.last }">
						<c:if test="${hobby eq 'book' }">
							독서
						</c:if>
						<c:if test="${hobby eq 'sports' }">
							운동
						</c:if>
						<c:if test="${hobby eq 'movie' }">
							영화감상
						</c:if>
						<c:if test="${hobby eq 'music' }">
							음악감상
						</c:if>
					</c:when>
				</c:choose>
			</c:forEach>
		</h4>	
	</c:when>
	<c:otherwise>
		<h4>취미 없음</h4>
	</c:otherwise>
</c:choose>

<h4>우편번호 : ${memberVO.address.postCode }</h4>
<h4>주소 : ${memberVO.address.location }</h4>
<h4>카드1-번호 : ${memberVO.cardList.get(0).no }</h4>
<h4>카드1-유효연월 : <fmt:formatDate value="${memberVO.cardList.get(0).validMonth }" pattern="yyyy년MM월dd일"/></h4>
<h4>카드2-번호 : ${memberVO.cardList.get(1).no }</h4>
<h4>카드2-유효연월 : <fmt:formatDate value="${memberVO.cardList.get(1).validMonth }" pattern="yyyy년MM월dd일"/></h4>
<h4>소개 : ${memberVO.introduction }</h4>

</body>
</html>