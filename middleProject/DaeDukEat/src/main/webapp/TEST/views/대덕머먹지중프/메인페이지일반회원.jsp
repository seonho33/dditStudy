<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>D.D.M MYPAGE SUPREME</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@1,900&family=Pretendard:wght@400;700;900&display=swap');
        
        body { background-color: #fff5eb; margin: 0; overflow: hidden; font-family: 'Pretendard', sans-serif; }
        .ddm-wrapper { display: flex; height: 100vh; padding: 25px; gap: 25px; }
        
        /* [1] 사이드바 디자인 */
        .ddm-sidebar { 
            width: 300px; background: #ffffff; border-radius: 40px;
            box-shadow: 0 20px 50px rgba(255, 126, 0, 0.08);
            padding: 45px 20px; display: flex; flex-direction: column;
        }
        .ddm-brand { 
            font-family: 'Montserrat', sans-serif; font-size: 36px; font-weight: 900; 
            color: #ff6b00; font-style: italic; margin-bottom: 40px; text-align: center; letter-spacing: -2px; cursor: pointer;
        }
        
        .nav-scroll { flex: 1; overflow-y: auto; }
        .nav-scroll::-webkit-scrollbar { width: 0; }

        .nav-label { font-size: 11px; font-weight: 900; color: #ff6b00; opacity: 0.4; letter-spacing: 2px; margin: 25px 0 10px 15px; text-transform: uppercase; display: block; }
        
        .nav-item { 
            display: flex; align-items: center; gap: 14px; padding: 14px 20px; 
            color: #64748b; font-weight: 700; border-radius: 20px; cursor: pointer; 
            transition: 0.3s ease; margin-bottom: 4px; font-size: 15px;
        }
        .nav-item:hover { background: #fff0e0; color: #ff6b00; transform: translateX(5px); }
        .nav-item.active { background: #ff7e00; color: #ffffff; box-shadow: 0 10px 20px rgba(255, 126, 0, 0.2); }

        .btn-logout {
            margin-top: 20px; width: 100%; display: flex; align-items: center; justify-content: center; gap: 10px;
            padding: 16px; border-radius: 22px; background: #fff1f2; color: #f43f5e;
            font-weight: 800; border: none; cursor: pointer; transition: 0.3s;
        }
        .btn-logout:hover { background: #f43f5e; color: #ffffff; transform: translateY(-3px); }

        /* [2] 메인 영역 디자인 */
        .ddm-container { flex: 1; display: flex; flex-direction: column; gap: 20px; }
        
        .ddm-header { 
            background: #ffffff; padding: 30px 45px; border-radius: 35px;
            box-shadow: 0 15px 40px rgba(255, 126, 0, 0.05);
            display: flex; justify-content: space-between; align-items: center;
        }
        .header-title-main { 
            font-size: 30px; font-weight: 900; color: #1e293b; letter-spacing: -1px;
            background: linear-gradient(to right, #1e293b, #64748b);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }

        .ddm-content-area { 
            flex: 1; background: #ffffff; border-radius: 40px; padding: 50px; 
            box-shadow: 0 25px 70px rgba(255, 126, 0, 0.1);
            overflow-y: auto; position: relative;
        }
        
        /* 로딩 애니메이션 */
        .loading-overlay { opacity: 0.4; pointer-events: none; transition: 0.3s; }
    </style>
</head>
<body>

<div class="ddm-wrapper">
    <aside class="ddm-sidebar">
        <div class="ddm-brand" onclick="location.href='main.do'">D.D.M</div>
        
        <nav class="nav-scroll">
            <span class="nav-label">Profile Management</span>
            <div onclick="loadPage('info', 'memberProfile.jsp')" class="nav-item active">
                <i class="fa-solid fa-id-card"></i> 정보 조회
            </div>
            <div onclick="loadPage('edit', '정보수정일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-user-gear"></i> 정보 수정
            </div>
            <div onclick="loadPage('out', '회원탈퇴일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-user-xmark"></i> 회원 탈퇴
            </div>

            <span class="nav-label">Community Area</span>
            <div onclick="loadPage('qna', 'QNA일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-comments"></i> 나의 Q&A
            </div>
            <div onclick="loadPage('review', '리뷰일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-star"></i> 나의 리뷰
            </div>

            <span class="nav-label">Service & Shop</span>
            <div onclick="loadPage('coupon', '쿠폰함일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-ticket"></i> 쿠폰함
            </div>
            <div onclick="loadPage('resv', '예약알림일반회원.jsp')" class="nav-item">
                <i class="fa-solid fa-calendar-check"></i> 예약/알림
            </div>
        </nav>
        
        <button class="btn-logout" onclick="location.href='logout.do'">
            <i class="fa-solid fa-power-off"></i> <span>Log out</span>
        </button>
    </aside>

    <main class="ddm-container">
        <header class="ddm-header">
            <div>
                <span id="page-sub" class="text-orange-500 text-[10px] font-black tracking-[3px] uppercase">My Settings</span>
                <h2 id="page-title" class="header-title-main">회원정보 조회</h2>
            </div>
            
            <div class="flex items-center gap-4 bg-orange-50 p-2 pr-6 rounded-2xl border border-orange-100">
                <div class="w-11 h-11 bg-orange-500 rounded-xl flex items-center justify-center text-white text-xl font-black shadow-lg">K</div>
                <div>
                    <p class="text-[10px] text-orange-400 font-black leading-none uppercase mb-1">Gold Master</p>
                    <p class="text-slate-800 font-black text-sm italic">Hello, User!</p>
                </div>
            </div>
        </header>

        <div id="main-view" class="ddm-content-area">
            <jsp:include page="정보수정일반회원.jsp" /> 
        </div>
    </main>
</div>

<script>
    /**
     * SPA 방식 페이지 전환 함수
     * @param type - 메뉴 카테고리 (텍스트 변경용)
     * @param jspName - 실제 서버에서 불러올 JSP 파일명
     */
    function loadPage(type, jspName) {
        const view = document.getElementById('main-view');
        const titleArea = document.getElementById('page-title');
        const subArea = document.getElementById('page-sub');
        
        // 1. 클릭한 메뉴 활성화 디자인
        document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
        event.currentTarget.classList.add('active');
        
        // 2. 헤더 텍스트 변경 (매핑 데이터)
        const meta = {
            'info': ['MY SETTINGS', '회원정보 조회'],
            'edit': ['MY SETTINGS', '정보 수정'],
            'out': ['MY SETTINGS', '회원 탈퇴'],
            'qna': ['COMMUNITY', '나의 Q&A'],
            'review': ['COMMUNITY', '나의 리뷰'],
            'coupon': ['SHOPPING', '나의 쿠폰함'],
            'resv': ['SERVICE', '예약 및 알림']
        };
        
        if(meta[type]) {
            subArea.innerText = meta[type][0];
            titleArea.innerText = meta[type][1];
        }

        // 3. AJAX (fetch) 호출하여 JSP 내용물만 교체
        view.classList.add('loading-overlay');
        
        // DATA: 프로젝트 경로가 포함되어야 할 수 있음 (예: '/webpro/' + jspName)
        fetch(jspName)
            .then(response => {
                if (!response.ok) throw new Error('해당 페이지를 찾을 수 없습니다.');
                return response.text();
            })
            .then(html => {
                view.innerHTML = html;
                view.classList.remove('loading-overlay');

                // 4. [매우중요] 로드된 JSP 안에 있는 스크립트를 수동으로 재실행
                const scripts = view.querySelectorAll("script");
                scripts.forEach(oldScript => {
                    const newScript = document.createElement("script");
                    Array.from(oldScript.attributes).forEach(attr => newScript.setAttribute(attr.name, attr.value));
                    newScript.appendChild(document.createTextNode(oldScript.innerHTML));
                    oldScript.parentNode.replaceChild(newScript, oldScript);
                });
            })
            .catch(error => {
                view.innerHTML = `
                    <div class="flex flex-col items-center justify-center h-full text-red-400">
                        <i class="fa-solid fa-circle-exclamation text-6xl mb-4"></i>
                        <p class="text-xl font-black italic">ERROR: \${error.message}</p>
                    </div>`;
                view.classList.remove('loading-overlay');
            });
    }
</script>

</body>
</html>