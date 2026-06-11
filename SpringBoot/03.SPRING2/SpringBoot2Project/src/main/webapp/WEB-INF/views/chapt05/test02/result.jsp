<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<c:set value="${memberVO.attachFile}" var="attachFile"></c:set>

<body>

<h1>결과</h1>
<c:choose>
	<c:when test="${not empty attachFile and attachFile.size > 0}">
		<h3>파일명 : ${attachFile.originalFilename }</h3>
		<h3>파일크기 : ${attachFile.size }</h3>
		<h3>파일 타입 : ${attachFile.contentType}</h3>
		<img id="preview" src="${imageSrc }" width="300px">
	</c:when>
	<c:otherwise>
		<h3>프로필 사진이 없습니다.</h3>
	</c:otherwise>
</c:choose>
<hr>
<h3>아이디 : ${memberVO.userId }</h3>
<h3>비밀번호 : ${memberVO.password }</h3>
<h3>이름 : ${memberVO.userName }</h3>
<h3>성별 : ${memberVO.gender eq 'M'?'남자':'여자' }</h3>
<h3>핸드폰 : ${memberVO.phone}-${memberVO.phone2 }-${memberVO.phone3 }</h3>
<h3>이메일 : ${memberVO.email }</h3>
<h3>우편번호 : ${memberVO.addressPostCode }</h3>
<h3>기본주소 : ${memberVO.addressLocation }</h3>
<h3>상세주소 : ${memberVO.addressDetail }</h3>
<h3>자기소개 : ${memberVO.introduction }</h3>
<h3>첨부파일 : </h3>
<div>
	<c:if test="${not empty memberVO.attachFileList and memberVO.attachFileList.size > 0}">
		<c:forEach items="${memberVO.attachFileList }" var="attachFile">
			<c:choose>
				<c:when test="${not empty attachFile}">
					<div>
						${attachFile.getOriginalFilename() } <br>
						${attachFile.getSize() }		
					</div>
				</c:when>
				<c:otherwise>
					<h3>첨부파일이 없습니다.</h3>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
</div>
<h3></h3>


</body>

</html>