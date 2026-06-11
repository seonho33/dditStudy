<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
s<!DOCTYPE html>
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

        /* 무한 루프 슬라이드 애니메이션 */
        .story-container { overflow: hidden; width: 100vw; background: #fafafa; cursor: pointer; }
        .story-track {
            display: flex;
            /* [데이터 대응] 맛집 개수에 따라 가변적으로 너비 계산 가능 */
            width: max-content; 
            animation: scroll 40s linear infinite;
            will-change: transform;
        }
        .story-container:hover .story-track { animation-play-state: paused; }
        @keyframes scroll {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); } /* 데이터 복제로 무한 루프 구현 */
        }

        .story-card {
            width: 320px; height: 50vh; flex-shrink: 0; position: relative; 
            overflow: hidden; margin-right: 12px; border-radius: 15px; background: #eee;
        }
        .story-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
        .story-card:hover img { transform: scale(1.08); }

        /* 드롭다운 스타일 */
        .all-menu-container { position: relative; }
        .wide-dropdown {
            display: none; position: absolute; top: 100%; left: 0;
            background: white; border: 3px solid #fb923c; border-radius: 20px;
            padding: 15px 25px; box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            z-index: 150; width: 450px; justify-content: space-between; align-items: center; margin-top: 10px;
        }
        .all-menu-container:hover .wide-dropdown { display: flex; animation: fadeIn 0.2s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        .float-bot { animation: float 3s ease-in-out infinite; }
        @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
        .max-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
    </style>
</head>
<body>

    <%-- 
        [규율 2: 백엔드 로직 추론 주역]
        1. SQL (Mapper.xml):
           - <select id="getTopShops" resultType="ShopVO"> : 별점 높은 상위 10개 조회
           - <select id="getCategories" resultType="CategoryVO"> : 카테고리 목록 조회
           - <select id="getSpecialOffers" resultType="OfferVO"> : GS25 특가 상품 조회
        2. Controller (Java):
           List<ShopVO> topList = service.getTopShops();
           List<CategoryVO> catList = service.getCategories();
           request.setAttribute("topList", topList);
           request.setAttribute("catList", catList);
    --%>

    <header class="bg-white border-b sticky top-0 z-[110] py-4 shadow-sm">
        <div class="max-container flex items-center justify-between">
            <a href="index.do" class="text-4xl b-grade-font text-orange-500">D.D.M</a>
            <div class="flex-grow max-w-xl px-10">
                <form action="search.do" method="get" class="relative">
                    <input type="text" name="keyword" placeholder="어떤 맛집을 찾으시나요?" class="w-full bg-gray-50 border-2 border-gray-100 rounded-full py-3 px-12 text-lg focus:outline-none focus:border-orange-500 font-bold shadow-inner">
                    <i class="fa-solid fa-magnifying-glass absolute left-4 top-4 text-orange-500 text-xl"></i>
                </form>
            </div>
            <div class="flex gap-4">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}">
                        <a href="login.do" class="bg-orange-500 text-white px-8 py-2 rounded-full text-lg font-bold shadow-md">로그인</a>
                    </c:when>
                    <c:otherwise>
                        <span class="font-bold text-gray-600">${sessionScope.loginUser.name}님 환영합니다!</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <nav class="bg-orange-50 border-b py-4">
        <div class="max-container flex justify-around b-grade-font text-2xl text-gray-700">
            <div class="all-menu-container">
                <a href="#" class="text-orange-600 cursor-pointer">전체 <i class="fa-solid fa-chevron-down text-sm"></i></a>
                <div class="wide-dropdown">
                    <%-- [데이터 주입] DB 카테고리 동적 생성 --%>
                    <c:forEach var="cat" items="${catList}">
                        <a href="category.do?id=${cat.id}">${cat.icon} ${cat.name}</a>
                    </c:forEach>
                    <c:if test="${empty catList}">
                        <a href="#">🍚 한식</a><a href="#">🥢 중식</a><a href="#">☕ 카페</a>
                    </c:if>
                </div>
            </div>
            <a href="mdRecommend.do?tag=noodle" class="hover:text-orange-600 transition-all">나야..밀가루🍜</a>
            <a href="mdRecommend.do?tag=snack" class="hover:text-orange-600 transition-all">떡볶이는 살안쪄🍢</a>
            <a href="mdRecommend.do?tag=rice" class="hover:text-orange-600 transition-all">밥은 먹고 다니냐🍚</a>
            <a href="mdRecommend.do?tag=hangover" class="hover:text-orange-600 transition-all">해장이 시급하다🍺</a>
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
                <%-- [데이터 주입] TOP 10 리스트 (MyBatis 데이터) --%>
                <c:forEach var="shop" items="${topList}" varStatus="status">
                    <a href="shopDetail.do?id=${shop.id}" class="story-card shadow-lg">
                        <img src="${shop.imgUrl}">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/80 p-6 flex flex-col justify-end text-white">
                            <p class="text-3xl font-black mb-2 tracking-tighter">
                                <fmt:formatNumber value="${status.count}" pattern="00"/>. ${shop.name}
                            </p>
                            <span class="text-yellow-400 text-2xl font-black"><i class="fa-solid fa-star"></i> ${shop.rating}</span>
                        </div>
                    </a>
                </c:forEach>
                
                <%-- 무한 루프를 위한 데이터 복제 (서버 데이터 없을 시 더미 출력) --%>
                <c:if test="${empty topList}">
                    <div class="p-20 text-gray-400 font-bold">맛집 데이터를 불러오는 중입니다...</div>
                </c:if>
           </div>
        </section>

        <section class="max-container py-10">
            <a href="roulette.do" class="w-full py-8 rounded-3xl text-4xl b-grade-font text-white bg-orange-500 shadow-xl flex justify-center items-center hover:scale-[1.02] transition-all">
                🎰 룰렛으로 메뉴 정하기 CLICK!
            </a>
        </section>

        <footer class="bg-blue-50 py-20 border-t-4 border-blue-100">
            <div class="max-container text-center">
                <h3 class="text-6xl b-grade-font text-blue-900 italic mb-12">GS25 대덕로또점 전용 특가</h3>
                <div class="grid grid-cols-3 gap-0 border-[10px] border-white shadow-2xl rounded-[50px] overflow-hidden">
                    <%-- [데이터 주입] 특가 상품 리스트 --%>
                    <c:forEach var="item" items="${offerList}">
                        <div class="bg-white p-10 flex flex-col items-center border-r-2 border-gray-100">
                            <img src="${item.img}" class="h-64 object-cover rounded-2xl mb-6 shadow-md">
                            <p class="text-5xl font-black text-orange-600"><fmt:formatNumber value="${item.price}" type="currency"/>원</p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </footer>
    </main>

    <div class="fixed bottom-8 right-8 z-[200] flex flex-col items-end float-bot">
        <div class="bg-white border-2 border-orange-500 text-orange-600 px-5 py-2 rounded-2xl font-black text-sm mb-3 shadow-2xl relative">
            영달봇에게 물어보세요! 🤖
            <div class="absolute -bottom-2 right-6 w-4 h-4 bg-white border-r-2 border-b-2 border-orange-500 rotate-45"></div>
        </div>
        <a href="chatbot.do" class="w-16 h-16 bg-orange-500 rounded-full flex items-center justify-center text-white text-3xl shadow-2xl border-4 border-white"><i class="fa-solid fa-robot"></i></a>
    </div>

    <script>
        // 타임세일 카운트다운 (데이터에서 마감시간 전달받음)
        const targetTime = "${empty offerLimit ? '16:00:00' : offerLimit}";
        
        function updateTimer() {
            const now = new Date();
            const [targetH, targetM, targetS] = targetTime.split(':');
            const target = new Date();
            target.setHours(targetH, targetM, targetS, 0); 

            let diff = target - now;
            const timerEl = document.getElementById('countdown');
            if (!timerEl) return;

            if (diff < 0) { timerEl.innerText = "판매 종료"; return; }
            
            const h = Math.floor(diff / 3600000).toString().padStart(2, '0');
            const m = Math.floor((diff % 3600000) / 60000).toString().padStart(2, '0');
            const s = Math.floor((diff % 60000) / 1000).toString().padStart(2, '0');
            timerEl.innerText = `마감까지 ${h}:${m}:${s}`;
        }
        setInterval(updateTimer, 1000); updateTimer();
    </script>
</body>
</html>