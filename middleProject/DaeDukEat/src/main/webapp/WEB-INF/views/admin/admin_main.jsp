<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>D.D.M MASTER - SINGLE PAGE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;800&family=Black+Han+Sans&display=swap');
        body { font-family: 'Pretendard', sans-serif; background-color: #020617; color: #e2e8f0; margin: 0; overflow: hidden; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        .sidebar { background: #0f172a; border-right: 1px solid #1e293b; }
        .nav-item { transition: 0.3s; cursor: pointer; border-radius: 12px; margin: 5px 15px; padding: 12px 20px; color: #94a3b8; font-weight: 600; display: flex; align-items: center; gap: 12px; }
        .nav-item:hover { background: #1e293b; color: #fff; }
        .nav-item.active { background: #38bdf8; color: #020617; font-weight: 800; }
        .section-label { font-size: 11px; font-weight: 800; color: #475569; letter-spacing: 0.1em; padding: 20px 30px 10px; text-transform: uppercase; }
        /* 로딩 애니메이션 */
        .loading { opacity: 0.5; pointer-events: none; }
    </style>
</head>
<body class="flex h-screen">

    <aside class="sidebar w-72 flex flex-col h-full">
        <div class="p-8 text-center">
            <h1 class="text-3xl b-grade-font text-white italic tracking-tighter">D.D.M <span class="text-sky-500 text-sm not-italic ml-1 font-bold">PRO</span></h1>
        </div>
        
        <nav class="flex-1 overflow-y-auto" id="sidebar-nav">
            <div class="section-label">Membership</div>
            <div onclick="loadContent('/admin/member.do', this)" class="nav-item active">
                <i class="fa-solid fa-users"></i> 회원관리
            </div>
           

            <div class="section-label">Community</div>
            <div onclick="loadContent('/admin/community.do', this)" class="nav-item">
                <i class="fa-solid fa-bullhorn"></i> 공지사항 관리
            </div>

            <div class="section-label">GS25 System</div>
            <div onclick="loadContent('/admin/gs25.do', this)" class="nav-item">
                <i class="fa-solid fa-box"></i> 할인상품 관리
            </div>

            <div class="section-label">Automation</div>
            <div onclick="loadContent('/admin/bot.do', this)" class="nav-item">
                <i class="fa-solid fa-robot"></i> 영달봇 설정
            </div>
        </nav>
    </aside>

    <main class="flex-1 flex flex-col h-full overflow-hidden">
        <header class="h-20 px-10 border-b border-slate-800 flex items-center">
            <h2 id="page-title" class="text-2xl font-extrabold text-white uppercase tracking-tight">User Management</h2>
        </header>

        <div id="main-content" class="flex-1 p-10 overflow-y-auto"></div>

    </main>

    <script>
        /**
         * 핵심 함수: 페이지 새로고침 없이 JSP 알맹이만 가져와서 박아버림
         */
         /**
          * 핵심 함수 수정: 컨텐츠 로드 후 스크립트 재실행 보장
          */
          function loadContent(url, element) {
        	    const contentArea = document.getElementById('main-content');
        	    const titleArea = document.getElementById('page-title');

        	    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
        	    element.classList.add('active');
        	    titleArea.innerText = element.innerText.trim();
        	    contentArea.classList.add('loading');

        	    fetch("<%=request.getContextPath()%>" + url)
        	      .then(response => {
        	        if (!response.ok) throw new Error('요청 실패: ' + response.status);
        	        return response.text();
        	      })
        	      .then(html => {
        	        contentArea.innerHTML = html;
        	        contentArea.classList.remove('loading');

        	        // 주입된 script 강제 실행(네 로직 유지)
        	        const scripts = contentArea.querySelectorAll("script");
        	        scripts.forEach(oldScript => {
        	          const newScript = document.createElement("script");
        	          Array.from(oldScript.attributes).forEach(attr => newScript.setAttribute(attr.name, attr.value));
        	          newScript.appendChild(document.createTextNode(oldScript.innerHTML));
        	          oldScript.parentNode.replaceChild(newScript, oldScript);
        	        });

        	        if (typeof initInvEvents === 'function') initInvEvents();
        	      })
        	      .catch(error => {
        	        contentArea.innerHTML =
        	          '<div class="text-red-500 p-10 font-bold">에러 발생: ' + error.message + '</div>';
        	        contentArea.classList.remove('loading');
        	      });
        	  }
    </script>
    <script>
window.addEventListener("DOMContentLoaded", () => {
    const firstNav = document.querySelector(".nav-item.active");
    loadContent("/admin/member.do", firstNav);
 });
</script>
    
</body>
</html>