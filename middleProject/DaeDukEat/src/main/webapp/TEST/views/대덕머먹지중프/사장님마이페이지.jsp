<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M OWNER DASHBOARD</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;600;900&display=swap');
        body { font-family: 'Pretendard', sans-serif; background-color: #f1f5f9; color: #334155; margin: 0; }
        
        .sidebar { width: 280px; height: 100vh; background: #0f172a; position: fixed; z-index: 50; }
        .nav-link { 
            display: flex; align-items: center; gap: 15px; padding: 18px 30px; 
            cursor: pointer; transition: 0.3s; color: #94a3b8; font-weight: 600; 
        }
        .nav-link:hover { background: #1e293b; color: #fff; }
        .nav-link.active { background: #1e293b; color: #38bdf8; border-left: 4px solid #38bdf8; font-weight: 900; }

        .main-content { margin-left: 280px; padding: 50px; min-height: 100vh; }
        .owner-card { 
            background: #fff; border: 1px solid #e2e8f0; border-radius: 35px; 
            padding: 45px; box-shadow: 0 10px 40px rgba(0,0,0,0.02); 
            min-height: 500px;
        }

        .stat-card { 
            background: #fff; border-radius: 25px; padding: 25px; 
            border: 1px solid #e2e8f0; display: flex; align-items: center; 
            gap: 20px; transition: 0.3s; 
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.05); }

        .animate-fadeIn { animation: fadeIn 0.4s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <aside class="sidebar py-12">
        <div class="px-10 mb-12">
            <h1 class="text-3xl font-black text-sky-400 italic tracking-tighter">D.D.M <span class="text-xs text-white not-italic opacity-40 ml-1">OWNER</span></h1>
        </div>
        
        <nav id="main-nav">
            <p class="text-[11px] font-black text-slate-500 px-10 mb-4 uppercase tracking-widest">Store Management</p>
            <div onclick="loadOwnerPage('store', '가게관리.jsp', this)" class="nav-link active">
                <i class="fa-solid fa-shop text-lg"></i> 가게 관리
            </div>
            <div onclick="loadOwnerPage('menu', '메뉴관리.jsp', this)" class="nav-link">
                <i class="fa-solid fa-utensils text-lg"></i> 메뉴 관리
            </div>
            <div onclick="loadOwnerPage('reservation', '예약관리.jsp', this)" class="nav-link">
                <i class="fa-solid fa-calendar-check text-lg"></i> 예약 관리
            </div>
            <div onclick="loadOwnerPage('review', '리뷰관리.jsp', this)" class="nav-link">
                <i class="fa-solid fa-star-half-stroke text-lg"></i> 리뷰 관리
            </div>
            <div onclick="loadOwnerPage('coupon', '쿠폰관리.jsp', this)" class="nav-link">
                <i class="fa-solid fa-ticket-simple text-lg"></i> 쿠폰 관리
            </div>
            
            <p class="text-[11px] font-black text-slate-500 px-10 mt-10 mb-4 uppercase tracking-widest">Account</p>
            <div onclick="loadOwnerPage('profile', '내정보사장님.jsp', this)" class="nav-link">
                <i class="fa-solid fa-user-tie text-lg"></i> 내 정보
            </div>
                
            <div onclick="loadOwnerPage('profile', 'StoreDelete.jsp', this)" class="nav-link">
                <i class="fa-solid fa-user-tie text-lg"></i> 회원탈퇴
            </div>
        </nav>

        <div class="absolute bottom-10 left-10">
            <button onclick="location.href='logout.do'" class="text-slate-500 text-sm font-bold hover:text-red-400 transition-colors">
                <i class="fa-solid fa-right-from-bracket mr-2"></i> 로그아웃
            </button>
        </div>
    </aside>

    <main class="main-content">
        <header class="flex justify-between items-center mb-10">
            <div>
                <h2 id="owner-title" class="text-4xl font-black text-slate-800 tracking-tight">가게 관리</h2>
                <p class="text-slate-400 text-sm font-bold mt-2 italic text-sky-500">Welcome to Owner Dashboard</p>
            </div>
            
            <div class="flex items-center gap-4 bg-white p-2 pr-6 rounded-full border border-slate-200 shadow-sm">
                <div class="w-12 h-12 bg-sky-500 rounded-full flex items-center justify-center text-white font-black shadow-inner">P</div>
                <div>
                    <span class="block text-[10px] font-black text-slate-400 uppercase tracking-tighter">Owner Admin</span>
                    <span class="text-sm font-bold text-slate-700">박사장님 (성수점)</span>
                </div>
            </div>
        </header>

        <div class="grid grid-cols-3 gap-6 mb-10">
            <div class="stat-card">
                <div class="w-14 h-14 bg-blue-50 text-blue-500 rounded-2xl flex items-center justify-center text-2xl">
                    <i class="fa-solid fa-calendar-day"></i>
                </div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Today Resv</p>
                    <p class="text-2xl font-black text-slate-800 italic">${todayResCount != null ? todayResCount : 12} <span class="text-sm font-bold not-italic ml-1 text-slate-400">건</span></p>
                </div>
            </div>

            <div class="stat-card">
                <div class="w-14 h-14 bg-orange-50 text-orange-500 rounded-2xl flex items-center justify-center text-2xl">
                    <i class="fa-solid fa-star"></i>
                </div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Total Reviews</p>
                    <p class="text-2xl font-black text-slate-800 italic">${totalReviewCount != null ? totalReviewCount : 48} <span class="text-sm font-bold not-italic ml-1 text-slate-400">개</span></p>
                </div>
            </div>

            <div class="stat-card border-l-4 border-l-green-500">
                <div class="w-14 h-14 bg-green-50 text-green-500 rounded-2xl flex items-center justify-center text-2xl">
                    <i class="fa-solid fa-door-open"></i>
                </div>
                <div>
                    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Store Status</p>
                    <p class="text-2xl font-black text-green-600 italic uppercase">Open</p>
                </div>
            </div>
        </div>

        <div id="owner-content" class="owner-card animate-fadeIn">
            <jsp:include page="가게관리.jsp" />
        </div>
    </main>

    <script>
        /**
         * 사장님 페이지 동적 로드 (Ajax)
         */
        function loadOwnerPage(menu, fileName, element) {
            const contentArea = document.getElementById('owner-content');
            const title = document.getElementById('owner-title');
            
            // 1. 네비게이션 액티브 토글 (전달받은 element 기준)
            document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
            if (element) {
                element.classList.add('active');
            }

            // 2. 타이틀 업데이트
            const menuNames = {
                'store': '가게 관리',
                'menu': '메뉴 관리',
                'reservation': '예약 관리',
                'review': '리뷰 관리',
                'coupon': '쿠폰 관리',
                'profile': '내 정보',
                'withdraw': '회원 탈퇴'

            };
            title.innerText = menuNames[menu];

            // 3. 파일 로드 (한글 파일명 처리를 위해 encodeURI 사용)
            fetch(encodeURI(fileName))
                .then(response => {
                    if (!response.ok) throw new Error();
                    return response.text();
                })
                .then(html => {
                    contentArea.innerHTML = html;
                })
                .catch(error => {
                    console.error('Fetch error:', error);
                    contentArea.innerHTML = `
                        <div class="flex flex-col items-center justify-center h-full py-20 text-center">
                            <i class="fa-solid fa-circle-exclamation text-5xl text-red-100 mb-6"></i>
                            <h3 class="text-xl font-black text-slate-800 mb-2">페이지 로드 실패</h3>
                            <p class="text-slate-400 font-bold">\${fileName} 파일을 찾을 수 없습니다.</p>
                        </div>`;
                });
        }

        // 초기 상태 설정 (jsp:include를 썼으므로 별도 호출 불필요하지만, 
        // nav-link의 active 상태를 확실히 하기 위해 사용 가능)
    </script>
</body>
</html>