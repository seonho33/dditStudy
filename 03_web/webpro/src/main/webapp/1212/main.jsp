<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.main-container{
	min-height: 750px;
	max-width: 1200px;
	margin: 0 auto;
	padding : 20px;
	font-family: sans-serif;
}
.book-section{
	margin: 20px auto;
	padding: 20px;
}

.book-section h2{
	font-size: 1.5rem;
	margin-bottom: 5px;
	padding: 10px;
}

.book-grid{			/* book-card를 배치하기 위함 - 가로 배치  */
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
	align-items: center;
	padding: 10px;
}
.book-card{			/*   */
	background: #f9f9f9;
	border: 1px solid #ccc;
	padding: 10px;
	margin: 5px;
	text-align: center;
	height: 300px;
	flex: 20%;
	display: flex; /* card안의 이미지, title, 가격에 flex  */
	flex-direction: column;
	justify-content: space-between;
	transition : transform 0.2s;
}
.book-card:hover {
	transform : scale(1.03);
	box-shadow: 0 0 5px 3px rgba(250,156,200,0.2);
}
.book-card img{
	width: 100%;
	height: 80%; 
}
#book-section-title{
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.price{
	color: red;
}
.btn-more{
	font-size: 14px;
	padding: 6px 12px;
	background: #f85a44;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	transition : background-color 0.5s
}
.btn-more:hover {
	background-color : #DC143C;
}
.book-section h2{
	border-left: 3px solid red;
}
.header{
	position : fixed;
	width : 100%;
	border-bottom: 1px solid #e9ecdf;
}
.header-content{	/*  mypage-header top-header  */
     /*  max-width: 1200px; */
       width: 100%;
       margin: 0 auto;
       display: flex;  
       align-items: center;
       flex-direction: column; /* 세로 방향으로 변경 */
}
.mypage-header a{
	color: rgb(114,114,114);
    font-family: sans-serif;
    font-size: 12px;
    text-decoration: none;
	margin-left: 10px; /* 링크들 사이 간격 */
}
.top-header{
	display: flex;
	align-items: center;
	justify-content: space-between;
	background-color: white;
	width: 100%;
	box-sizing: border-box;
}
 /*  search-container을 포함 */			
 .search-section { 
    flex: 1;
    display: flex;
    justify-content: center; 
    align-items: center;
   
}
  	/* 검색 컨테이너 - 로고 아이콘 과 검색폼(search-form)을 나란히 배치 */
.search-container { 
    display: flex;
    align-items: center;
    gap: 20px;
   /*  max-width: 1500px; */
    width: 100%; /* 가능한 너비 차지 */
    justify-content: center; /* 내부 요소들도 중앙 정렬 */
	/* overflow: hidden; */ /* 내부 요소가 넘치지 않도록 */
}
/* select text button  */
.search-form { 
    display: flex;
   /*  gap: 0; */
    align-items: center;
    justify-content: flex-start;  
    background: white;
    border-radius: 25px;
    overflow: hidden; /*  돋보기부분 넘치는 부분*/
    border: 1.2px solid #bbb;
    transition: all 0.3s ease;
    width: 100%; /* 전체 너비 차지 */
    max-width: 600px;  
    min-width: 300px;  
    height: 50px;
    font-family: sans-serif;
}
  /* select  */
.search-category {  
	padding: 0px 20px; /* 좌우만 패딩 설정 */
	border: none;
	border-right: 1px solid #ddd;
	border-radius: 28px 0 0 28px; /* 왼쪽만 둥글게 */
	font-size: 15px;
	min-width: 120px;
	background: white;
	margin-left: 0;
	cursor: pointer;
	height: 100%;
}
.search-input {
   flex: 1; /* 영역채우기 */
   padding: 0px 20px;
   border: none;
    font-size: 16px;
   background: transparent;
    height: 100%; /* 부모 높이에 맞춤 */
 }
   
   /* 돋보기버튼 */  
 .search-btn {
   padding: 0px 25px;
   background-color: white;
   border: none;
   cursor: pointer;
    font-size: 16px;
	font-weight: bold;
   height: 100%; /* 부모 높이에 맞춤 */
 }
 .search-btn:hover {
         background-color: #2980b9;
  }
</style>

</head>
<body>

 <header class="header">
     <div class="header-content">
        <div class="mypage-header">
        		
                <a href="#">로그인</a>&nbsp;
          		<a href="#">회원가입</a>
        </div>
        <div class="top-header">

	            <!-- 검색 영역 -->
		       <section class="search-section">
		        	<div class="search-container">
		        	
			        	  <a href="" class="logo">
						    <img src="../images/아.png" alt="BookDam 로고">
						  </a>
				            <form class="search-form">
				                <select class="search-category" id="stype">
				                    <option value="all">전체</option>
				                    <option value="title">도서명</option>
				                    <option value="author">저자</option>
				                    <option value="publisher">출판사</option>
				                </select>
				                <input type="text" class="search-input" id="sword"
				                       placeholder="검색할 도서명 또는 저자 또는 출판사를 입력하세요" required>
				                <button id="search-btn" type="button" class="search-btn">🔍</button>
				             </form>
			         </div>
		        </section> 
        	</div>
        	
       </div>
  </header>
    
<!-- 메인 컨테이너 -->
   <div class="main-container"> 
  
		<!-- 🔥 베스트셀러 -->
		<section class="book-section">
		  <div id="book-section-title" >
		    <h2 class="section-title">🔥 베스트셀러</h2>
		    <a href="#" class="btn-more">더보기</a>
		  </div>
		  
		  <div class="book-grid">
		     <c:forEach var="i" begin="0" end="4">
	          <div class="book-card">
	              <img src="../images/JSP2_1.jpg" alt="JSP2_1.jpg" />
		            <div class="title">JSP마스터</div>
		            <div class="price">33,000</div>
	          </div>
	         </c:forEach>
		  </div>
		</section>
		
		<!-- 📚 20대 인기도서 -->
		<section class="book-section">
		  <h2>📚 20대 인기도서</h2>
		  <div class="book-grid" >
		    <c:forEach var="i" begin="0" end="4">
		      
		          <div class="book-card">
		              <img src="../images/ajaxin.jpg" alt="ajaxin.jpg" />
		             <div class="title">ajax에 대하여</div>
		             <div class="price">23,000</div>
		          </div>
		     </c:forEach>
		  </div>
		</section>
		
		<!-- 📖 카테고리별 인기 도서 -->
		<section class="book-section">
		  <h2>📖카테고리별  인기 도서</h2>
		  <div class="book-grid">
		    <c:forEach var="i" begin="0" end="4">
		          <div class="book-card" >
		              <img src="../images/jQuery.jpg" alt="jQuery.jpg" />
		              <div class="title">편리한 라이브러리</div>
		              <div class="price">15,000</div>
		          </div>
		    </c:forEach>
		  </div>
		</section> 
	</div>
</body>
</html>