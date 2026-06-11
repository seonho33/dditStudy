<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 통합 로그인</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        :root { --point-color: #f97316; --point-dark: #c2410c; }
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fafafa; transition: 0.4s; overflow-x: hidden; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        /* =========================
		   로그인 버튼 전용 폰트
		========================= */
		.login-btn-font { font-family: 'GmarketSans', sans-serif; font-weight: 800; /* Medium~Bold 느낌 */ }
        
        .main-logo { 
            font-size: clamp(4rem, 12vw, 6rem); 
            letter-spacing: -3px; 
            text-shadow: 4px 4px 0px rgba(0,0,0,0.05); 
            line-height: 1; 
            white-space: nowrap;
        }
        
        .login-input {
            width: 100%; 
            background-color: #fff; 
            border: 2px solid #e5e7eb;
            border-radius: 9999px; 
            padding: clamp(0.9rem, 2vw, 1.2rem) 1.5rem;
            font-size: clamp(1rem, 2.5vw, 1.2rem); 
            font-weight: 800; 
            transition: 0.3s; 
            outline: none; 
            color: #1f2937;
        }
        .login-input:focus { border-color: var(--point-color); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }

        .dynamic-text { color: var(--point-color); transition: 0.4s; }
        .dynamic-bg { background-color: var(--point-color); transition: 0.4s; }
        
        .tab-btn { 
            font-size: clamp(1.1rem, 3vw, 1.4rem); 
            font-weight: 900; 
            border-bottom: 5px solid transparent; 
            padding-bottom: 10px;
        }
        .tab-active { color: var(--point-color); border-bottom-color: var(--point-color); }

        .max-container { width: 100%; max-width: 500px; margin: clamp(40px, 8vh, 100px) auto; padding: 0 20px; }
        
        .find-link { font-weight: 800; color: #9ca3af; transition: 0.2s; cursor: pointer; white-space: nowrap; }
        .find-link:hover { color: var(--point-color); }
    </style>
</head>
<body id="bodyBg">
	
	<!-- 탈퇴한 회원 로그인 시 alert -->
	<c:if test="${not empty alertError}">
	    <script>
	        alert("${alertError}");
	    </script>
	</c:if>



    <main class="max-container">
        <div class="text-center mb-10">
            <a href="${pageContext.request.contextPath}/main.do"><h1 id="logoText" class="main-logo b-grade-font dynamic-text">D.D.M</h1></a>
            <p id="subText" class="text-gray-400 font-black uppercase tracking-[0.25em] text-xs md:text-sm mt-3">Delicious Map</p>
        </div>
		
		
		<!-- 로그인 박스 -->
        <div class="bg-white rounded-[45px] shadow-[0_40px_80px_rgba(0,0,0,0.1)] p-8 md:p-14 border-2 border-white">
            <!-- 탭선택 버튼 -->
            <div class="flex mb-10 gap-2 md:gap-4">
                <button id="userTab" onclick="switchMode('user')" class="flex-1 tab-btn tab-active">일반 회원</button>
                <button id="sellerTab" onclick="switchMode('seller')" class="flex-1 tab-btn text-gray-300">판매자</button>
            </div>
            
			<!-- 로그인 폼 
            <form id="loginForm" action="${pageContext.request.contextPath}/TEST/views/user/main.jsp" method="POST" class="space-y-6">-->
            <form id="loginForm" action="${pageContext.request.contextPath}/login.do" method="POST" class="space-y-6">
            <form id="StoreloginForm" action="${pageContext.request.contextPath}/Storelogin.do" method="POST" class="space-y-6">
            	<!-- 서버로 보낼 회원 타입(user/seller) -->
                <input type="hidden" id="loginType" name="type" value="user">
				
				<!-- 아이디 입력 -->
                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 ml-5 uppercase tracking-tighter">Identity</label>
                    <div class="relative">
                        <i class="fa-solid fa-circle-user absolute left-6 top-1/2 -translate-y-1/2 text-gray-300 text-xl"></i>
                        <input type="text" name="id" id="userId" class="login-input pl-16" placeholder="아이디" required>
                    </div>             
                </div>
				
				<!-- 비밀번호 입력 -->
                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 ml-5 uppercase tracking-tighter">Password</label>
                    <div class="relative">
                        <i class="fa-solid fa-lock-open absolute left-6 top-1/2 -translate-y-1/2 text-gray-300 text-xl"></i>
                        <input type="password" name="pw" class="login-input pl-16" placeholder="비밀번호" required>
                    </div>
                </div>
				
				<!-- 서버에서 전달된 오류 메시지 표시 -->
                <c:if test="${not empty error}">
                    <p class="text-center text-red-500 text-sm font-bold animate-pulse">${error}</p>
                </c:if>
                <!-- 에러 한 번 보여준 후 삭제 -->
				<c:remove var="error" scope="session"/>
				
				<!-- 로그인 버튼 -->
                <button type="submit" id="mainBtn" class="w-full py-5 rounded-full text-2xl login-btn-font text-white dynamic-bg shadow-xl hover:scale-[1.01] active:scale-95 transition-all mt-4 border-b-[6px]" style="border-bottom-color: var(--point-dark);">
                    로그인 하기
                </button>
                
   
            </form>
            
			<!-- 아이디/비밀번호 찾기 링크 -->
            <div class="mt-10 pt-8 border-t border-gray-50 flex justify-center items-center gap-4 md:gap-8 text-sm">
				<div onclick="goFind('id')" class="find-link">아이디 찾기</div>
                <span class="text-gray-200">|</span>
				<div onclick="goFind('pw')" class="find-link">비밀번호 찾기</div>
            </div>
        </div>
        
		<!-- 회원가입 링크 -->
        <div class="mt-12 text-center">
          <!--   <a href="join.do?type=user" id="joinform" class="inline-block text-gray-400 font-bold text-sm hover:text-gray-600 transition-all"> -->
<a href="${pageContext.request.contextPath}/TEST/views/user/join.jsp"
   id="joinform"
   class="inline-block text-gray-400 font-bold text-sm hover:text-gray-600 transition-all">
  계정이 없으신가요?
  <span class="dynamic-text border-b-2 dynamic-border ml-1">회원가입 하기</span>
</a>
        </div>
    </main>

	<!-- 로그인 모드 전환 JS -->
    <script>
    
    const ctx = "${pageContext.request.contextPath}";

    
        function switchMode(type) {
            const root = document.documentElement;				// CSS 변수 변경
            const bodyBg = document.getElementById('bodyBg');   // 배경색 변경
            const userTab = document.getElementById('userTab');
            const sellerTab = document.getElementById('sellerTab');
            const subText = document.getElementById('subText');     // 서브텍스트 변경
            const mainBtn = document.getElementById('mainBtn');		// 버튼 텍스트 변경
            const loginType = document.getElementById('loginType'); // 서버 전송용 타입 변경
            const joinform = document.getElementById('joinform');   // 회원가입 링크 변경

            if (type === 'user') { //일반 회원  user
                root.style.setProperty('--point-color', '#f97316');
                root.style.setProperty('--point-dark', '#c2410c');
                bodyBg.style.backgroundColor = '#fafafa';
                userTab.classList.add('tab-active');
                userTab.classList.remove('text-gray-300');
                sellerTab.classList.remove('tab-active');
                sellerTab.classList.add('text-gray-300');
                subText.innerText = "Delicious Map";
                mainBtn.innerHTML = '<i class="fa-solid fa-sign-in-alt"></i> 로그인 하기';  // ✅ 수정
                loginType.value = "user"; // 서버에 보낼 타입 변경
                joinform.href = ctx + "/TEST/views/user/join.jsp";   // ✅ 일반회원 가입 JSP

            } else {  //판매자 seller
                root.style.setProperty('--point-color', '#3b82f6');
                root.style.setProperty('--point-dark', '#1d4ed8');
                bodyBg.style.backgroundColor = '#f0f4f8';
                sellerTab.classList.add('tab-active');
                sellerTab.classList.remove('text-gray-300');
                userTab.classList.remove('tab-active');
                userTab.classList.add('text-gray-300');
                subText.innerText = "Business Partner";
                mainBtn.innerHTML = '<i class="fa-solid fa-store"></i> 파트너 로그인';  // ✅ 수정
                loginType.value = "seller"; // 서버에 보낼 타입 변경
                joinform.href = ctx + "/TEST/views/store/storeRegister.jsp"; // ✅ 판매자 가입 JSP
            }
        }
               
        
        /*
        아이디 입력칸에서 포커스를 벗어나는 순간(blur)
        → 서버(IdCheck.do)로 아이디를 보내서
        → DB에 있는지 확인하고
        → 결과를 화면에 출력한다
      */
      document.getElementById("userId").addEventListener("blur", function () {

          const id = this.value.trim();               // 입력한 아이디
          const msg = document.getElementById("idCheckMsg"); // 결과 출력용

          // 아이디 안 썼으면 아무것도 안 함
          if (id === "") {
              msg.innerText = "";
              return;
          }

          // IdCheck 서블릿으로 아이디 전송 (GET 방식)
          fetch("${pageContext.request.contextPath}/IdCheck.do?id=" + encodeURIComponent(id))

              // 서버에서 JSON 받기
              .then(res => res.json())

              // 결과 처리
              .then(data => {
                  if (data.flag === "사용가능") {
                      msg.innerText = "사용 가능한 아이디입니다.";
                      msg.style.color = "green";
                  } else {
                      msg.innerText = "이미 사용 중인 아이디입니다.";
                      msg.style.color = "red";
                  }
              })

              // 에러 발생 시
              .catch(err => {
                  console.error(err);
                  msg.innerText = "서버 오류";
                  msg.style.color = "red";
              });
      });
     

      function goFind(kind) {
    	  const t = document.getElementById('loginType').value; // user / seller
    	  if (kind === 'id') location.href = ctx + "/TEST/views/user/findid.jsp?type=" + encodeURIComponent(t);
    	  else location.href = ctx + "/TEST/views/user/findpw.jsp?type=" + encodeURIComponent(t);
    	}
        
    </script>
</body>
</html>