<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // [테스트] 여기서 ADMIN, OWNER, USER 중 하나로 변경하고 새로고침해보세요.
    if(session.getAttribute("userRole") == null) {
        session.setAttribute("userRole", "OWNER"); 
        session.setAttribute("userId", "관리자");
    }
    String userRole = (String)session.getAttribute("userRole");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 테마 완벽 적용</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        /* 탭 버튼 기본 스타일 */
        .tab-btn { 
            background: #fff; border: 2px solid #e5e7eb; color: #9ca3af; 
            cursor: pointer; transition: all 0.2s ease-in-out;
        }

        /* [핵심] 테마별 강제 클래스 - !important로 Tailwind를 이깁니다. */
        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-owner { background-color: #2563eb !important; color: white !important; border-color: #2563eb !important; }
        .theme-user { background-color: #f97316 !important; color: white !important; border-color: #f97316 !important; }

        .theme-text-admin { color: #1a1a1b !important; }
        .theme-text-owner { color: #2563eb !important; }
        .theme-text-user { color: #f97316 !important; }

        .theme-border-admin { border-color: #1a1a1b !important; }
        .theme-border-owner { border-color: #2563eb !important; }
        .theme-border-user { border-color: #f97316 !important; }

        .hidden { display: none !important; }
    </style>
</head>
<body class="pb-20">

    <header class="bg-white border-b-4 py-6 sticky top-0 z-50 shadow-sm
        ${userRole == 'ADMIN' ? 'theme-border-admin' : (userRole == 'OWNER' ? 'theme-border-owner' : 'theme-border-user')}">
        <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
            <a href="index.jsp" class="text-4xl b-grade-font tracking-tighter italic 
                ${userRole == 'ADMIN' ? 'theme-text-admin' : (userRole == 'OWNER' ? 'theme-text-owner' : 'theme-text-user')}">D.D.M</a>
            <div class="flex items-center gap-4">
                <span class="text-[10px] font-black bg-gray-100 text-gray-500 px-4 py-2 rounded-full uppercase">
                    ROLE: <span class="${userRole == 'ADMIN' ? 'theme-text-admin' : (userRole == 'OWNER' ? 'theme-text-owner' : 'theme-text-user')}">${userRole}</span>
                </span>
            </div>
        </div>
    </header>

    <main class="max-w-[900px] mx-auto px-6 py-12">
        <div class="flex gap-2 mb-12 p-2 bg-white rounded-[30px] w-fit mx-auto border-2 border-gray-100 shadow-sm">
            <button type="button" onclick="switchTab('notice')" id="tab-notice" class="tab-btn px-12 py-4 rounded-[22px] font-black">
                공지사항
            </button>
            <button type="button" onclick="switchTab('qna')" id="tab-qna" class="tab-btn px-12 py-4 rounded-[22px] font-black">
                Q&A 커뮤니티
            </button>
        </div>

        <div id="notice-section">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-3xl b-grade-font text-gray-900">NOTICE</h3>
                <c:if test="${userRole == 'ADMIN'}">
                    <button class="theme-admin px-6 py-3 rounded-xl font-black shadow-lg">공지 등록</button>
                </c:if>
            </div>
            <div class="bg-white p-8 rounded-[35px] border-2 shadow-sm relative overflow-hidden
                ${userRole == 'ADMIN' ? 'theme-border-admin' : (userRole == 'OWNER' ? 'theme-border-owner' : 'theme-border-user')}">
                <h4 class="text-2xl font-black text-gray-800 mb-3">테마 적용 안내</h4>
                <p class="text-gray-500 font-medium tracking-tight">
                    현재 당신의 등급은 <span class="font-black ${userRole == 'ADMIN' ? 'theme-text-admin' : (userRole == 'OWNER' ? 'theme-text-owner' : 'theme-text-user')}">${userRole}</span> 입니다.
                </p>
            </div>
        </div>

        <div id="qna-section" class="hidden">
            <div class="flex justify-between items-end mb-8">
                <h3 class="text-4xl b-grade-font text-gray-900">Q&A</h3>
                <c:if test="${userRole != 'ADMIN'}">
                    <button class="px-8 py-4 rounded-2xl font-black shadow-xl 
                        ${userRole == 'OWNER' ? 'theme-owner' : 'theme-user'}">질문 작성</button>
                </c:if>
            </div>
            <div id="qna-list" class="space-y-4">
                <div class="bg-white p-6 rounded-3xl border border-gray-100 shadow-sm">등록된 질문이 없습니다.</div>
            </div>
        </div>
    </main>

    <script>
        // 1. 서버의 Role을 JS 변수로 가져옴
        const ROLE = "${userRole}"; 

        // 2. 등급에 맞는 CSS 클래스명 결정 함수
        function getThemeClass() {
            if (ROLE === 'ADMIN') return 'theme-admin';
            if (ROLE === 'OWNER') return 'theme-owner';
            return 'theme-user';
        }

        // 3. 탭 전환 및 색상 강제 주입
        function switchTab(tabName) {
            const noticeSec = document.getElementById('notice-section');
            const qnaSec = document.getElementById('qna-section');
            const noticeBtn = document.getElementById('tab-notice');
            const qnaBtn = document.getElementById('tab-qna');
            const themeClass = getThemeClass();

            // 모든 버튼 초기화
            noticeBtn.classList.remove('theme-admin', 'theme-owner', 'theme-user');
            qnaBtn.classList.remove('theme-admin', 'theme-owner', 'theme-user');

            if (tabName === 'notice') {
                noticeSec.classList.remove('hidden');
                qnaSec.classList.add('hidden');
                noticeBtn.classList.add(themeClass); // 현재 등급 색상 입히기
            } else {
                noticeSec.classList.add('hidden');
                qnaSec.classList.remove('hidden');
                qnaBtn.classList.add(themeClass); // 현재 등급 색상 입히기
            }
        }

        // 초기 실행: 공지사항 탭 활성화
        window.onload = () => {
            switchTab('notice');
        };
    </script>
</body>
</html>