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

    <main class="max-container">
        <div class="text-center mb-10">
            <a href="list.do"><h1 id="logoText" class="main-logo b-grade-font dynamic-text">D.D.M</h1></a>
            <p id="subText" class="text-gray-400 font-black uppercase tracking-[0.25em] text-xs md:text-sm mt-3">Delicious Map</p>
        </div>

        <div class="bg-white rounded-[45px] shadow-[0_40px_80px_rgba(0,0,0,0.1)] p-8 md:p-14 border-2 border-white">
            
            <div class="flex mb-10 gap-2 md:gap-4">
                <button id="userTab" onclick="switchMode('user')" class="flex-1 tab-btn tab-active">일반 회원</button>
                <button id="sellerTab" onclick="switchMode('seller')" class="flex-1 tab-btn text-gray-300">판매자</button>
            </div>

            <form id="loginForm" action="login.do" method="POST" class="space-y-6">
                <input type="hidden" id="loginType" name="type" value="user">

                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 ml-5 uppercase tracking-tighter">Identity</label>
                    <div class="relative">
                        <i class="fa-solid fa-circle-user absolute left-6 top-1/2 -translate-y-1/2 text-gray-300 text-xl"></i>
                        <input type="text" name="id" class="login-input pl-16" placeholder="아이디" required>
                    </div>
                </div>

                <div class="space-y-2">
                    <label class="block text-xs font-black text-gray-400 ml-5 uppercase tracking-tighter">Password</label>
                    <div class="relative">
                        <i class="fa-solid fa-lock-open absolute left-6 top-1/2 -translate-y-1/2 text-gray-300 text-xl"></i>
                        <input type="password" name="pw" class="login-input pl-16" placeholder="비밀번호" required>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <p class="text-center text-red-500 text-sm font-bold animate-pulse">${error}</p>
                </c:if>

                <button type="submit" id="mainBtn" class="w-full py-5 rounded-full text-2xl b-grade-font text-white dynamic-bg shadow-xl hover:scale-[1.01] active:scale-95 transition-all mt-4 border-b-[6px]" style="border-bottom-color: var(--point-dark);">
                    로그인 하기
                </button>
            </form>

            <div class="mt-10 pt-8 border-t border-gray-50 flex justify-center items-center gap-4 md:gap-8 text-sm">
                <div onclick="location.href='findId.do'" class="find-link">아이디 찾기</div>
                <span class="text-gray-200">|</span>
                <div onclick="location.href='findPw.do'" class="find-link">비밀번호 찾기</div>
            </div>
        </div>

        <div class="mt-12 text-center">
            <a href="join.do?type=user" id="joinform" class="inline-block text-gray-400 font-bold text-sm hover:text-gray-600 transition-all">
                계정이 없으신가요? <span class="dynamic-text border-b-2 dynamic-border ml-1">회원가입 하기</span>
            </a>
        </div>
    </main>

    <script>
        function switchMode(type) {
            const root = document.documentElement;
            const bodyBg = document.getElementById('bodyBg');
            const userTab = document.getElementById('userTab');
            const sellerTab = document.getElementById('sellerTab');
            const subText = document.getElementById('subText');
            const mainBtn = document.getElementById('mainBtn');
            const loginType = document.getElementById('loginType');
            const joinform = document.getElementById('joinform');

            if (type === 'user') {
                root.style.setProperty('--point-color', '#f97316');
                root.style.setProperty('--point-dark', '#c2410c');
                bodyBg.style.backgroundColor = '#fafafa';
                userTab.classList.add('tab-active');
                userTab.classList.remove('text-gray-300');
                sellerTab.classList.remove('tab-active');
                sellerTab.classList.add('text-gray-300');
                subText.innerText = "Delicious Map";
                mainBtn.innerText = "로그인 하기";
                loginType.value = "user"; // 서버에 보낼 타입 변경
                joinform.href = "join.do?type=user";

            } else {
                root.style.setProperty('--point-color', '#3b82f6');
                root.style.setProperty('--point-dark', '#1d4ed8');
                bodyBg.style.backgroundColor = '#f0f4f8';
                sellerTab.classList.add('tab-active');
                sellerTab.classList.remove('text-gray-300');
                userTab.classList.remove('tab-active');
                userTab.classList.add('text-gray-300');
                subText.innerText = "Business Partner";
                mainBtn.innerText = "파트너 로그인";
                loginType.value = "seller"; // 서버에 보낼 타입 변경
                joinform.href = "join.do?type=seller";
            }
        }
    </script>
</body>
</html>