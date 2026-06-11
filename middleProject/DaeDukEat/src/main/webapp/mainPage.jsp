<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 대덕 맛집 가이드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fff; overflow-x: hidden; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }

        /* 무한 루프 슬라이드 */
        .story-container { overflow: hidden; width: 100vw; background: #fafafa; cursor: pointer; }
        .story-track {
            display: flex;
            /* 슬라이드 개수에 따라 폭 조절 필요 */
            width: calc(332px * 20); 
            animation: scroll 35s linear infinite;
            will-change: transform;
        }
        .story-container:hover .story-track { animation-play-state: paused; }
        @keyframes scroll { 0% { transform: translateX(0); } 100% { transform: translateX(calc(-332px * 10)); } }

        .story-card {
            width: 320px; height: 50vh; flex-shrink: 0; position: relative; 
            overflow: hidden; margin-right: 12px; border-radius: 15px; background: #eee;
        }
        .story-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
        .story-card:hover img { transform: scale(1.08); }

        /* "전체" 프리미엄 드롭다운 */
        .all-menu-container { position: relative; }
        .wide-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: -20px;
            background: white;
            border: 4px solid #fb923c;
            border-radius: 30px;
            padding: 25px;
            box-shadow: 0 30px 60px rgba(251, 146, 60, 0.2);
            z-index: 150;
            width: 500px;
            margin-top: 15px;
        }
        
        .wide-dropdown::before {
            content: '';
            position: absolute;
            top: -14px;
            left: 40px;
            border-left: 12px solid transparent;
            border-right: 12px solid transparent;
            border-bottom: 12px solid #fb923c;
        }

        .all-menu-container:hover .wide-dropdown {
            display: block;
            animation: menuFadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes menuFadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .category-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; }

        .cat-card {
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            padding: 15px; background: #fffbf7; border: 2px solid #ffedd5; border-radius: 20px;
            transition: all 0.2s ease; text-decoration: none;
        }

        .cat-card:hover { background: #fb923c; border-color: #fb923c; transform: translateY(-5px); }
        .cat-card .emoji { font-size: 32px; margin-bottom: 8px; }
        .cat-card .cat-name { font-family: 'Black Han Sans', sans-serif; font-size: 16px; color: #4b5563; }
        .cat-card:hover .cat-name { color: white; }

        .float-bot { animation: float 3s ease-in-out infinite; }
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
        .max-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }

        /* 인라인 스타일 분리 */
        .story-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            color: white;
        }

        .story-title {
            font-size: 1.875rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
            letter-spacing: -0.05em;
        }

        .story-rating {
            color: #fbbf24;
            font-size: 1.5rem;
            font-weight: 900;
        }

        .empty-message {
            padding: 5rem;
            text-align: center;
            width: 100%;
            font-weight: 700;
            color: #9ca3af;
        }

        .footer-title {
            font-size: 3.75rem;
            font-family: 'Black Han Sans', sans-serif;
            color: #1e3a8a;
            font-style: italic;
            margin-bottom: 3rem;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0;
            border: 10px solid white;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            border-radius: 50px;
            overflow: hidden;
        }

        .footer-item {
            background: white;
            padding: 2.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .footer-item:nth-child(1),
        .footer-item:nth-child(2) {
            border-right: 2px solid #f3f4f6;
        }

        .footer-item:nth-child(2) {
            background: #fef2f2;
        }

        .footer-item img {
            height: 16rem;
            object-fit: cover;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .footer-price-1 {
            font-size: 3rem;
            font-weight: 900;
            color: #ea580c;
        }

        .footer-price-2 {
            font-size: 3rem;
            font-weight: 900;
            color: #dc2626;
        }

        .footer-price-3 {
            font-size: 3rem;
            font-weight: 900;
            color: #9333ea;
        }

        .countdown-badge {
            background: #dc2626;
            color: white;
            font-weight: 900;
            padding: 0.75rem 2rem;
            margin-bottom: 2rem;
            border-radius: 0.75rem;
        }

        .chatbot-bubble {
            background: white;
            border: 2px solid #f97316;
            color: #ea580c;
            padding: 0.5rem 1.25rem;
            border-radius: 1rem;
            font-weight: 900;
            font-size: 0.875rem;
            margin-bottom: 0.75rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            position: relative;
        }

        .chatbot-bubble::after {
            content: '';
            position: absolute;
            bottom: -0.5rem;
            right: 1.5rem;
            width: 1rem;
            height: 1rem;
            background: white;
            border-right: 2px solid #f97316;
            border-bottom: 2px solid #f97316;
            transform: rotate(45deg);
        }

        .chatbot-button {
            width: 4rem;
            height: 4rem;
            background: #f97316;
            border-radius: 9999px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.875rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            border: 4px solid white;
        }

        .chatbot-container {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 200;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
    </style>
</head>
<body>

    <header class="bg-white border-b sticky top-0 z-[110] py-4 shadow-sm">
        <div class="max-container flex items-center justify-between">
            <a href="index.jsp" class="text-4xl b-grade-font text-orange-500">D.D.M</a>
            <div class="flex-grow max-w-xl px-10">
                <div class="relative">
                    <input type="text" placeholder="어떤 맛집을 찾으시나요?" class="w-full bg-gray-50 border-2 border-gray-100 rounded-full py-3 px-12 text-lg focus:outline-none focus:border-orange-500 font-bold shadow-inner">
                    <i class="fa-solid fa-magnifying-glass absolute left-4 top-4 text-orange-500 text-xl"></i>
                </div>
            </div>
            <div class="flex gap-4">
                <a href="login.jsp" class="bg-orange-500 text-white px-8 py-2 rounded-full text-lg font-bold shadow-md">로그인</a>
            </div>
        </div>
    </header>

    <nav class="bg-orange-50 border-b py-4">
        <div class="max-container flex justify-around b-grade-font text-2xl text-gray-700">
            <div class="all-menu-container">
                <a href="#" class="text-orange-600 cursor-pointer">전체 <i class="fa-solid fa-chevron-down text-sm"></i></a>
                <div class="wide-dropdown">
                    <div class="category-grid">
                        <a href="storeList.do?cat=한식" class="cat-card"><span class="emoji">🍚</span><p class="cat-name">한식</p></a>
                        <a href="storeList.do?cat=중식" class="cat-card"><span class="emoji">🥢</span><p class="cat-name">중식</p></a>
                        <a href="storeList.do?cat=일식" class="cat-card"><span class="emoji">🍣</span><p class="cat-name">일식</p></a>
                        <a href="storeList.do?cat=양식" class="cat-card"><span class="emoji">🍕</span><p class="cat-name">양식</p></a>
                        <a href="storeList.do?cat=카페" class="cat-card"><span class="emoji">☕</span><p class="cat-name">카페</p></a>
                    </div>
                </div>
            </div>
            <a href="list.do?tag=flour" class="hover:text-orange-600 transition-all">나야..밀가루🍜</a>
            <a href="list.do?tag=snack" class="hover:text-orange-600 transition-all">떡볶이는 살안쪄🍢</a>
            <a href="list.do?tag=meal" class="hover:text-orange-600 transition-all">밥은 먹고 다니냐🍚</a>
            <a href="list.do?tag=hangover" class="hover:text-orange-600 transition-all">해장이 시급하다🍺</a>
        </div>
    </nav>

    <main>
        <section class="py-10 text-center">
            <h2 class="text-6xl b-grade-font text-gray-900 tracking-tighter">
                대덕 최고의 맛집 <span class="text-orange-500 italic">TOP 10</span>
            </h2>
        </section>

        <section class="story-container">
           <div class="story-track">
                <c:forEach var="store" items="${storeList}" varStatus="status">
                    <a href="detail.do?id=${store.id}" class="story-card shadow-lg">
                        <img src="${store.imgPath}">
                        <div class="story-overlay">
                            <p class="story-title">${status.count < 10 ? '0' : ''}${status.count}. ${store.name}</p>
                            <span class="story-rating"><i class="fa-solid fa-star"></i> ${store.score}</span>
                        </div>
                    </a>
                </c:forEach>
                
                <c:if test="${empty storeList}">
                    <div class="empty-message">등록된 맛집 데이터가 없습니다.</div>
                </c:if>
            </div>
        </section>

        <section class="max-container py-10">
            <a href="roulette.jsp" class="w-full py-8 rounded-3xl text-4xl b-grade-font text-white bg-orange-500 shadow-xl flex justify-center items-center hover:scale-[1.02] transition-all">
                🎰 룰렛으로 메뉴 정하기 CLICK!
            </a>
        </section>

        <footer class="bg-blue-50 py-20 border-t-4 border-blue-100">
            <div class="max-container text-center">
                <h3 class="footer-title">GS25 대덕로또점 전용 특가</h3>
                <div class="footer-grid">
                    
                    <div class="footer-item">
                        <img src="${gsItem1.img}">
                        <p class="footer-price-1">${gsItem1.price}원</p>
                    </div>

                    <div class="footer-item">
                        <div class="countdown-badge" id="countdown">마감 00:00:00</div>
                        <img src="${gsItem2.img}">
                        <p class="footer-price-2">최대 ${gsItem2.discount}%</p>
                    </div>

                    <div class="footer-item">
                        <img src="${gsItem3.img}">
                        <p class="footer-price-3">${gsItem3.price}원</p>
                    </div>

                </div>
            </div>
        </footer>
    </main>

    <div class="chatbot-container float-bot">
        <div class="chatbot-bubble">영달봇에게 물어보세요! 🤖</div>
        <a href="chatbot.do" class="chatbot-button"><i class="fa-solid fa-robot"></i></a>
    </div>

    <script>
        function updateTimer() {
            const now = new Date(); const target = new Date(); target.setHours(16, 0, 0, 0); 
            let diff = target - now; if (diff < 0) { document.getElementById('countdown').innerText = "판매 종료"; return; }
            const h = Math.floor(diff / 3600000).toString().padStart(2, '0');
            const m = Math.floor((diff % 3600000) / 60000).toString().padStart(2, '0');
            const s = Math.floor((diff % 60000) / 1000).toString().padStart(2, '0');
            document.getElementById('countdown').innerText = `마감까지 ${h}:${m}:${s}`;
        }
        setInterval(updateTimer, 1000); updateTimer();
    </script>
</body>
</html>