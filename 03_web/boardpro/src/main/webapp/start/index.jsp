<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Bootstrap 기반 웹페이지</title>

<!-- Font Awesome CDN (head 영역에 삽입) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 <!-- Bootstrap CSS -->
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
 
 
  <style>
    html, body {
      height: 100%;
      margin: 0;
    }
  
    .main-layout {
      height: calc(100vh - 100px); 
      overflow: hidden;
    }
    aside {
      background-color: #f8f9fa;
      height: 100%;
      overflow-y: auto;
    }
    section {
      width : 100%;
      height: 100%;
      overflow-y: auto;
      padding: 20px;
    }
    footer {
      height: 50px;
      line-height: 50px;
    }
    
  
   .dropdown {
    position: relative;
    display: inline-block;
  }
 .custom-aside{
    width : 250px;
 }
/* 드롭다운 버튼 내부 정렬 및 높이 통일 */
.dropdown .btn {
  height: 35px;
  padding: 4px 10px;
  display: flex;
  align-items: center;
  margin-right: 8px; /* 선택 사항 */
}

/* 회원가입 버튼도 동일한 높이 적용 */
header .btn-outline-light.btn-sm {
  height: 35px;
  padding: 4px 10px;
}
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 140px;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    color: black;
    padding: 8px 12px;
    text-decoration: none;
    display: block;
  }

  .dropdown-content a:hover {
    background-color: #f1f1f1;
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }
    .profile-img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 8px;
  }
  </style>
</head>
<body class="d-flex flex-column">

<!-- Header -->
<!-- py-4 :세로길이.   원래는 py-2 이었는데  py-4로 바꿈-->
 <header class="bg-dark text-white px-4 py-4 d-flex justify-content-end align-items-center">

   <c:choose> 
    <c:when test="${empty sessionScope.loginok}">
      <button class="btn btn-outline-light btn-sm me-2" onclick="location.href='logpro.jsp'">🔐 로그인</button>
      <button class="btn btn-outline-light btn-sm" onclick="loadContent('join')">📝 회원가입</button>
    </c:when>
    <c:otherwise>
	 <div class="dropdown">
        <button class="btn btn-outline-light btn-sm dmemberPwropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown" aria-expanded="false">
           <span><strong>${sessionScope.loginok.mem_name}님</strong></span>
        </button>

        <ul class="dropdown-menu dropdown-menu-end">
          <li><a class="dropdown-item" href="mypage.jsp">👤 마이페이지</a></li>
          <li><a class="dropdown-item" href="mail.jsp">📧 메일</a></li>
          <li><a class="dropdown-item" href="message.jsp">💬 쪽지</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item text-danger" onclick="doLogout()">🚪 로그아웃</a></li>
        </ul>
      </div>
	</c:otherwise>
  </c:choose>  
  
</header>


  <!-- Main Layout -->
  <div class="container-fluid flex-grow-1">
    <div class="row main-layout">
      <!-- Aside -->
     <aside class="col-3 col-md-2 p-3 border-end">
     <!--  <aside class="custom-aside  p-3 border-end"> -->
        <ul class="nav flex-column">
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('홈')">🏠 홈</a></li>
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('게시판')">📋 게시판</a></li>
          <li class="nav-item mb-2"><a class="nav-link" href="#" onclick="loadContent('QNA')" >💬❓ QNA</a></li>
          <li class="nav-item"><a class="nav-link" href="#" onclick="loadContent('북스토어')">⚙️ 북스토어</a></li>
        </ul>
        
      </aside>

      <!-- Section -->
      <section class="col-9 col-md-10" id="content">
        <h2>홈</h2>
        <p>환영합니다! 왼쪽 메뉴를 클릭하여 내용을 확인하세요.</p>
      </section>
    </div>
  </div>

  <!-- Footer -->
  <footer class="bg-dark text-white text-center">
    ⓒ 2026 My Bootstrap Page. All rights reserved.
  </footer>

<%-- <%
 // sessionScope에 저장된 값을 꺼내서 변수설정
  MemberVO   mvo =   (MemberVO)session.getAttribute("loginok");
   String user = null;
   Gson  gson = new Gson();
   //mvo 자바 객체를 직렬화
   if(mvo != null)  user= gson.toJson(mvo);    // {"mem_id" : "a001" , "mem_name" : "김은대". "mem_hp" : "010-1234-5678"}
   //user자바변수를 script에서 사용하기 위해 uvo스크립트변수로 설정 
 %>
  <script>
 //user자바 변수를 uvo스크립트변수로 설정  -  null 또는 json데이타
  //board.js에서 로그인 사용자와 글쓴이 비교해서 수정 삭제시 사용
    uvo = <%= user != null ? user : "null" %>;  --%>
  
  
  <!-- Custom JS -->
<!-- 변수 선언 -->
<c:set var="mvo" value ="${sessionScope.loginok}"/>
<script>

//------------------------------------------------------

  //board.js에서 로그인 사용자와 글쓴이 비교해서 수정 삭제시 사용
let uvo = null;

<c:if test="${not empty mvo}">{
	uvo = {
			mem_id : "${mvo.mem_id}",
			mem_name : "${mvo.mem_name}",
			mem_mail : "${mvo.mem_mail}"
	}
}

</c:if>

console.log(uvo);

 //script에서 사용하는 변수- fetch 전송시 url에서
  mypath = '<%= request.getContextPath()%>';
  console.log("mypath(request.getContextpath()) : "+ mypath);

  mypath = '${pageContext.request.contextPath}';
  console.log("'${pageContext.request.contextPath}' : "+mypath);
  
  const loadUtil = async(url, element, fn)=>{
	  //fn은 함수 - 비동기처리 후 fn() 호출 해야한다
	  
	  const resp = await fetch(url)
	  
	  //결과를 board.jsp뷰 페이지의 내용을 출력한다
	  //board.jsp 는 결과를 json이 아니고 html코드이다.
	  const vcont = await resp.text();
	  
	  element.innerHTML = vcont;
	  
	  if(typeof fn !="undefined"){
		  //이후 실행될 이벤트 핸들러
		  fn();
	  }
   }
  
  
  function loadContent(menu) {
      //출력부분 - section 영역
		const menuContent = document.getElementById('content');
		
	      let html = '';

	      switch (menu) {
	        case '홈':
	             html = `<h2>홈</h2><p>홈 페이지에 오신 것을 환영합니다!</p>`;
	             break;
	        case '게시판':
	        	
				loadUtil(`\${mypath}/BoardList.do`,menuContent,boardPro)
	        	break;
	        case 'QNA':
	              html = `<h2>홈</h2><p>QnA 입니다!</p>`;
	              break;
	        case '북스토어':
	              html = `<h2>홈</h2><p>북스토어입니다!</p>`;
	              break;
	        case 'join' :
	        	  html = `<h2>홈</h2><p>join 회원가입 입니다 ! </p>`;
	        	  break;
	        default:
	             html = `<h2>404</h2><p>해당 메뉴는 존재하지 않습니다.</p>`;
	      }

	      menuContent.innerHTML = html;
  }
	   
  const doLogout = async() =>{
	  
	  const res = await fetch(`\${mypath}/Logout.do`);
	  
	  const datas = await res.json();
	  if(datas['flag']=="no"){
		  //로그아웃 성공 - 새로고침 - index.jsp로 이동
		  
		  location.href = `\${mypath}/start/index.jsp`
	  }
	  
  }
		
  </script>
  
  <%-- 게시판 실행을 위한 외부스크립트 --%>
    <%-- board게시판의 이벤트 등록 --%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/boardevent.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/board.js"></script>
  	<%-- board게시판의 이벤트 발생시 서버로 전송하는 비동기 fetch 코드를 작성한다 --%>
  
  
  
</body>
</html>
