<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M 사장님 대시보드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;900&display=swap');
        body { font-family: 'Pretendard', sans-serif; background-color: #f1f5f9; color: #334155; margin: 0; }
        .sidebar { width: 280px; height: 100vh; background: #0f172a; position: fixed; z-index: 50; }
        .nav-link { 
            display: flex; align-items: center; gap: 15px; padding: 16px 30px; 
            cursor: pointer; transition: 0.3s; color: #94a3b8; font-weight: 600; 
        }
        .nav-link:hover { background: #1e293b; color: #fff; }
        .nav-link.active { background: #1e293b; color: #38bdf8; border-left: 4px solid #38bdf8; font-weight: 900; }
        .main-content { margin-left: 280px; padding: 50px; min-height: 100vh; }
        .owner-card { 
            background: #fff; border: 1px solid #e2e8f0; border-radius: 35px; 
            padding: 45px; box-shadow: 0 10px 40px rgba(0,0,0,0.02); min-height: 500px;
        }
        .stat-card { 
            background: #fff; border-radius: 25px; padding: 25px; 
            border: 1px solid #e2e8f0; display: flex; align-items: center; gap: 20px; 
        }
        .animate-fadeIn { animation: fadeIn 0.4s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <aside class="sidebar py-12">
        <div class="px-10 mb-10">
<a href="${pageContext.request.contextPath}/main.do"
   class="block text-3xl font-black text-sky-400 italic tracking-tighter hover:opacity-80 transition">
    D.D.M
    <span class="text-xs text-white not-italic opacity-40 ml-1">OWNER</span>
</a>

        </div>

        <nav id="main-nav">
            <p class="text-[11px] font-black text-slate-500 px-10 mb-4 uppercase tracking-widest">매장 관리 서비스</p>
			<a href="javascript:void(0);" 
   onclick="loadOwnerPage('storeSearch', '${pageContext.request.contextPath}/store/list.do', this)" 
   class="nav-link active">
    <i class="fa-solid fa-magnifying-glass"></i> 가게 조회
</a>
            <a href="javascript:void(0);" onclick="loadOwnerPage('store', '${pageContext.request.contextPath}/store/detail.do', this)" class="nav-link">
                <i class="fa-solid fa-shop"></i> 가게 관리
            </a>
            <a href="javascript:void(0);" onclick="loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', this)" class="nav-link">
                <i class="fa-solid fa-utensils"></i> 메뉴 관리
            </a>
            <a href="javascript:void(0);" onclick="loadOwnerPage('reservation', '${pageContext.request.contextPath}/reservation/list.do', this)" class="nav-link">
                <i class="fa-solid fa-calendar-check"></i> 예약 관리
            </a>
            <a href="javascript:void(0);" onclick="loadOwnerPage('review', '${pageContext.request.contextPath}/owner/reviewList.do', this)" class="nav-link">
                <i class="fa-solid fa-star-half-stroke"></i> 리뷰 관리
            </a>
            <a href="javascript:void(0);" onclick="loadOwnerPage('coupon', '${pageContext.request.contextPath}/couponList.do', this)" class="nav-link">
                <i class="fa-solid fa-ticket-simple"></i> 쿠폰 관리
            </a>

            <p class="text-[11px] font-black text-slate-500 px-10 mt-10 mb-4 uppercase tracking-widest">계정 설정</p>

            <a href="javascript:void(0);" onclick="loadOwnerPage('profile', '${pageContext.request.contextPath}/TEST/views/store/storeUpdate.jsp', this)" class="nav-link">
                <i class="fa-solid fa-user-tie"></i> 내 정보
            </a>
<a href="javascript:void(0);" 
   onclick="loadOwnerPage('withdraw', '${pageContext.request.contextPath}/deleteOwner.do', this)" 
   class="nav-link">

                <i class="fa-solid fa-user-xmark"></i> 회원탈퇴
            </a>
        </nav>

        <div class="absolute bottom-10 left-10">
            <button onclick="location.href='${pageContext.request.contextPath}/logout.do'" class="text-slate-500 text-sm font-bold hover:text-red-400 transition-colors">
                <i class="fa-solid fa-right-from-bracket mr-2"></i> 로그아웃
            </button>
        </div>
    </aside>

    <main class="main-content">
        <header class="flex justify-between items-center mb-10">
            <div>
                <h2 id="owner-title" class="text-4xl font-black text-slate-800 tracking-tight">가게 조회</h2>
                <p class="text-slate-400 text-sm font-bold mt-2 italic text-sky-500">반갑습니다, ${sessionScope.loginUser.name} 사장님</p>
            </div>

            <div class="flex items-center gap-4 bg-white p-2 pr-6 rounded-full border border-slate-200 shadow-sm">
                <div class="w-12 h-12 bg-sky-500 rounded-full flex items-center justify-center text-white font-black">${sessionScope.loginUser.name.substring(0,1)}</div>
                <div>
                    <span class="block text-[10px] font-black text-slate-400 uppercase tracking-tighter">파트너 계정</span>
                    <span class="text-sm font-bold text-slate-700">${loginUser.name}</span>
                </div>
            </div>
        </header>

        <div class="grid grid-cols-3 gap-6 mb-10">
<div class="stat-card border-l-4 border-l-blue-500">
                <div class="w-14 h-14 bg-blue-50 text-blue-500 rounded-2xl flex items-center justify-center text-2xl"><i class="fa-solid fa-calendar-day"></i></div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">오늘 예약</p>
                    <p class="text-2xl font-black text-slate-800 italic">
                        <span id="stat-today">${not empty stats.todayReservCount ? stats.todayReservCount : 0}</span> 
                        <span class="text-sm font-bold not-italic ml-1 text-slate-400">건</span>
                    </p>
                </div>
            </div>
<div class="stat-card border-l-4 border-l-orange-500">
                <div class="w-14 h-14 bg-orange-50 text-orange-500 rounded-2xl flex items-center justify-center text-2xl"><i class="fa-solid fa-star"></i></div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">전체 리뷰</p>
                    <p class="text-2xl font-black text-slate-800 italic">
                        <span id="stat-review">${not empty stats.reviewCount ? stats.reviewCount : 0}</span> 
                        <span class="text-sm font-bold not-italic ml-1 text-slate-400">개</span>
                    </p>
                </div>
            </div>
            <div class="stat-card border-l-4 border-l-green-500">
                <div class="w-14 h-14 bg-green-50 text-green-500 rounded-2xl flex items-center justify-center text-2xl"><i class="fa-solid fa-door-open"></i></div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">승인 대기</p>
                    <p class="text-2xl font-black text-green-600 italic">
                        <span id="stat-pending">${not empty stats.pendingReservCount ? stats.pendingReservCount : 0}</span> 
                        <span class="text-sm font-bold not-italic ml-1 text-slate-400">건</span>
                    </p>
                </div>
            </div>
        </div>

        <div id="owner-content" class="owner-card animate-fadeIn">
            <c:choose>
                <c:when test="${not empty contentPage}"><jsp:include page="${contentPage}" /></c:when>
                <c:otherwise><jsp:include page="/TEST/views/store/myStoreList.jsp" /></c:otherwise>
            </c:choose>
        </div>
    </main>

<script>
// 페이지 전환 함수
function loadOwnerPage(menu, url, element) {
    const contentArea = document.getElementById('owner-content');
    const titleArea = document.getElementById('owner-title');

    if (url === undefined && typeof menu === 'string' && menu.includes('.do')) {
        url = menu;
        menu = 'menu';
    }

    if (!url || url === 'undefined') {
        Swal.fire('오류', '주소가 유효하지 않습니다.', 'error');
        return;
    }

    document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
    if (element) element.classList.add('active');

    const menuNames = {
    		  storeSearch: '가게 조회',
    		  store: '가게 관리', 
    		  menu: '메뉴 관리', 
    		  reservation: '예약 관리',
    		  review: '리뷰 관리', 
    		  coupon: '쿠폰 관리', 
    		  profile: '내 정보', 
    		  withdraw: '회원 탈퇴'
    		};

    titleArea.innerText = menuNames[menu] || 'D.D.M 사장님';

    contentArea.innerHTML = `<div class="flex justify-center py-20"><div class="animate-spin rounded-full h-12 w-12 border-b-2 border-sky-500"></div></div>`;

    fetch(url, { method: 'GET', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
    .then(res => { if(!res.ok) throw new Error(res.status); return res.text(); })
    .then(html => {
        contentArea.innerHTML = html;
        
        // 스크립트 재실행 로직
        contentArea.querySelectorAll("script").forEach(oldScript => {
            const newScript = document.createElement("script");
            if (oldScript.src) newScript.src = oldScript.src;
            else newScript.textContent = oldScript.textContent;
            document.head.appendChild(newScript).parentNode.removeChild(newScript);
        });
        
        contentArea.classList.remove('animate-fadeIn');
        void contentArea.offsetWidth;
        contentArea.classList.add('animate-fadeIn');
    })
    .catch(e => {
        contentArea.innerHTML = `<div class="py-20 text-center font-bold text-red-400">페이지 로드 실패 (${e.message})</div>`;
    });
}
</script>
</body>
</html>