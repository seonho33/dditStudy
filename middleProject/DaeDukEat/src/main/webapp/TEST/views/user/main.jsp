<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- ✅ JSP에서 직접 슬라이드 데이터 조회 --%>
<%@ page import="kr.or.ddit.admin.service.ISlideStoreService" %>
<%@ page import="kr.or.ddit.admin.service.SlideStoreServiceImpl" %>
<%@ page import="kr.or.ddit.store.vo.StoreVO" %>
<%@ page import="java.util.List" %>

<%
    if(request.getAttribute("slideList") == null) {
        ISlideStoreService slideService = SlideStoreServiceImpl.getInstance();
        List<StoreVO> slideList = slideService.StoreSlide();
        request.setAttribute("slideList", slideList);
    }
    
    /* ===== 팝업 광고 데이터 설정 ===== */
    // TODO: DB에서 동적으로 가져오는 로직으로 교체 가능
    String adImgUrl = request.getContextPath() + "/images/팝업.jpg"; 
    String adLinkUrl = request.getContextPath() + "/TEST/views/store/팝업이벤트.jsp";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 대덕 맛집 가이드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSans.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&family=Oswald:wght@500&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fff; overflow-x: hidden; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }

        /* ===== 슬라이드 트랙 섹션 ===== */
        .story-container { 
            overflow: hidden; width: 100vw; background: #fafafa; 
            padding: 20px 0; perspective: 1200px; 
        }
        .story-track {
            display: flex;
            width: max-content; 
            animation: scroll 60s linear infinite;
            will-change: transform;
        }
        .story-container:hover .story-track { animation-play-state: paused; }
        
        @keyframes scroll {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* ===== 카드 컨테이너 스타일 (테두리 및 입체감 강화) ===== */
        .card-container {
            width: 310px; height: 420px;
            margin: 0 18px;
            perspective: 1000px;
            cursor: pointer;
        }

        .card-inner {
            position: relative;
            width: 100%; height: 100%;
            transition: transform 0.7s cubic-bezier(0.165, 0.84, 0.44, 1);
            transform-style: preserve-3d;
        }

        /* 클릭 시 뒤집힘 */
        .card-container.active .card-inner {
            transform: rotateY(180deg);
        }

        /* 호버 시 테두리 강조 효과 */
        .card-container:hover .side {
            border-color: #ff9800;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .side {
            position: absolute;
            width: 100%; height: 100%;
            backface-visibility: hidden;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            background: #fff;
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* 카드 앞면 */
        .front {
            z-index: 2;
        }
        .front img {
            width: 100%; height: 260px;
            object-fit: cover;
            border-bottom: 1px solid #f3f4f6;
        }
        .front .info {
            padding: 24px 20px;
        }
        .front .store-name {
            font-size: 1.6rem; font-weight: 900; color: #1f2937;
            margin-bottom: 8px; display: block;
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }
        .front .ranking {
            color: #ff9800; font-family: 'Oswald'; font-size: 1.1rem;
            letter-spacing: 1px; font-weight: 500;
        }

        /* 카드 뒷면 (테두리 포인트 강화) */
        .back {
            transform: rotateY(180deg);
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border: 3px solid #ff9800;
        }
        .back h2 { font-family: 'Oswald'; font-size: 24px; color: #111; margin-bottom: 10px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .back .stat-item { display: flex; align-items: center; margin-bottom: 8px; font-weight: 700; font-size: 15px; }
        .back .desc { font-size: 14px; color: #4b5563; line-height: 1.7; margin-top: 15px; }
        
        /* 버튼 스타일 */
        .back .btn-detail {
            width: 100%; height: 54px;
            background: linear-gradient(-90deg, #FFB714, #FFE579);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 900; color: #111; text-transform: uppercase;
            font-size: 14px; transition: 0.3s;
        }
        .back .btn-detail:hover { 
            filter: brightness(1.05);
            transform: translateY(-2px);
        }

        /* ===== 공통 레이아웃 ===== */
        .max-container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        
        /* 드롭다운 메뉴 */
        .all-menu-container {
            position: relative;
        }
        .wide-dropdown {
            display: none !important;
            flex-direction: column;
            position: absolute;
            top: 100%;
            left: 0;
            background: white;
            border: 3px solid #fb923c;
            border-radius: 20px;
            padding: 15px 25px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            z-index: 150;
            width: 750px;
            justify-content: flex-start;
            align-items: flex-start;
            margin-top: 10px;
        }
        
        .wide-dropdown.show {
            display: flex !important;
            animation: fadeIn 0.2s ease-out;
        }
        
        @keyframes fadeIn { 
            from { opacity: 0; transform: translateY(-10px); } 
            to { opacity: 1; transform: translateY(0); } 
        }
   
        /* 드롭다운 그리드 레이아웃 */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 10px;
        }
        
        .category-menu-item {
            font-size: 1.45rem;  
            padding: 10px 12px; 
            gap: 8px;  
            white-space: nowrap;
        }

        .float-bot { animation: float 3s ease-in-out infinite; }
        @keyframes float { 
            0%, 100% { transform: translateY(0); } 
            50% { transform: translateY(-10px); } 
        }
             
        /* ===== 챗봇 모달 스타일 ===== */
        #chatModal { 
            display: none; 
            position: fixed; 
            inset: 0; 
            background: rgba(0,0,0,0.5); 
            justify-content: center; 
            align-items: center; 
            z-index: 9999; 
        }
        
        .chat-container { 
            width: 500px; 
            height: 80vh; 
            background: white; 
            border-radius: 20px; 
            border: 2px solid #ff7e00; 
            box-shadow: 0 10px 30px rgba(255,126,0,0.2); 
            display: flex; 
            flex-direction: column; 
            overflow: hidden; 
        }
        
        .chat-container .header { 
            background: linear-gradient(135deg,#ff9d00,#ff5e00); 
            color: white; 
            padding: 20px; 
            text-align: center; 
            font-size: 1.2rem; 
        }
        
        #chat-window { 
            flex: 1; 
            padding: 20px; 
            display: flex; 
            flex-direction: column; 
            gap: 10px; 
            overflow-y: auto; 
        }
        
        .message { 
            max-width: 75%; 
            padding: 10px 15px; 
            border-radius: 20px; 
            font-size: 1rem; 
            line-height: 1.4; 
        }
        
        .user { 
            background: #ff7e00; 
            color: white; 
            align-self: flex-end; 
            border-bottom-right-radius: 4px; 
        }
        
        .bot { 
            background: #fff0e0; 
            align-self: flex-start; 
            border-bottom-left-radius: 4px; 
            border: 1px solid #ffe0c0; 
        }
        
        .input-area { 
            display: flex; 
            gap: 10px; 
            padding: 15px; 
            background: #fff9f5; 
            border-top: 1px solid #ffdec0; 
        }
        .input-area input { 
            flex: 1; 
            padding: 10px 15px; 
            border-radius: 20px; 
            border: 2px solid #ffdec0; 
            outline: none; 
        }
        .input-area button { 
            padding: 10px 20px; 
            background: #ff7e00; 
            color: white; 
            border: none; 
            border-radius: 20px; 
            font-weight: bold; 
            cursor: pointer; 
        }
        
        #loading { 
            display: none; 
            text-align: center; 
            padding: 10px; 
            font-size: 0.9rem; 
            color: #ff7e00; 
        }

        /* ===== GS 카드 제목 전용 폰트 ===== */
        .gs-title { 
            font-family: 'GmarketSans', 'Noto Sans KR', sans-serif; 
            font-weight: 800; 
            letter-spacing: -0.3px; 
        }
        
        .nav-tag { 
            font-family: 'Black Han Sans', sans-serif; 
            font-weight: 400; 
            letter-spacing: -0.5px; 
        }

        /* ===== 룰렛 버튼 스타일 ===== */
        .roulette-button {
            width: 100%;
            max-width: 800px;
            padding: 1.3rem 0;
            font-family: 'Black Han Sans', sans-serif; 
            font-size: 2.5rem;
            letter-spacing: 1.5px;
            color: #fff;
            background-color: #000;
            border: none;
            border-radius: 5rem;
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease 0s;
            cursor: pointer;
            outline: none;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .roulette-button:hover {
            background-color: #e67300;
            box-shadow: 0px 12px 20px rgba(255, 126, 0, 0.4);
            color: #fff;
            transform: translateY(-5px);
        }

        /* ===================================================================
         * ✅ 팝업 광고 스타일 (기존 main.jsp 스타일과 통합)
         * =================================================================== */
        #ad-popup {
            position: fixed;
            top: 40%;           
            left: 10%;          /* 화면 좌측에서 15% 떨어진 위치 */
            transform: translateY(-50%)scale(0.8); 
            width: 500px;       /* 팝업 크기 */
            background: #fff;
            z-index: 10000;     /* 챗봇(9999)보다 높게 설정하여 최상위 표시 */
            display: none;      /* 초기 숨김 상태 */
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            border-radius: 20px; 
            overflow: hidden;
            font-family: 'Malgun Gothic', sans-serif;
        }

        /* 팝업 본문 이미지 */
        .ad-body img { 
            width: 100%; 
            height: auto; 
            display: block; 
            border: none;
        }

        /* 팝업 하단 푸터 (체크박스 + 닫기버튼) */
        .ad-footer {
            padding: 15px 20px;
            display: flex;
            justify-content: space-between; 
            align-items: center;
            background: #fff;
            border-top: 1px solid #eee;
        }

        .ad-footer label {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            color: #444;
            font-size: 15px;
            font-weight: 500;
        }

        .ad-footer input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .ad-footer button { 
            cursor: pointer; 
            border: none; 
            background: #333;
            color: #fff; 
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
            transition: 0.2s;
        }

        .ad-footer button:hover {
            background: #000;
        }

        /* ✅ 테스트용 초기화 버튼 (개발 완료 후 제거 권장) */
        .test-btn { 
            position: fixed; 
            bottom: 20px; 
            right: 20px; 
            z-index: 10001;     /* 팝업보다도 위 */
            padding: 10px 15px; 
            background: #ff9800; 
            color: white;
            font-size: 13px; 
            border-radius: 8px;
            cursor: pointer;
            border: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

    <!-- ===================================================================
     * HEADER: 로고 + 검색바 + 로그인/마이페이지
     * =================================================================== -->
    <header class="bg-white border-b sticky top-0 z-[110] py-4 shadow-sm">
        <div class="max-container flex items-center justify-between">
            
            <a href="${pageContext.request.contextPath}/main.do" class="flex items-center gap-3">
                <img src="${pageContext.request.contextPath}/images/로고.png" 
                     alt="D.D.M 로고" 
                     class="h-14 w-auto"
                     onerror="this.style.display='none';">
                <span class="text-4xl b-grade-font text-orange-500 tracking-tighter">D.D.M</span>
            </a>

            <div class="flex-grow max-w-xl px-10">
                <form action="${pageContext.request.contextPath}/storeSearch.do" method="get" class="relative">
                    <input type="text" name="keyword" placeholder="어떤 맛집을 찾으시나요?" 
                           class="w-full bg-gray-50 border-2 border-gray-100 rounded-full py-3 px-12 text-lg focus:outline-none focus:border-orange-500 font-bold shadow-inner">
                    <i class="fa-solid fa-magnifying-glass absolute left-4 top-4 text-orange-500 text-xl"></i>
                </form>
            </div>

            <!-- 로그인/로그아웃 분기 -->
            <div class="flex gap-2 items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}">
                        <a href="${pageContext.request.contextPath}/login.do"
                           class="bg-orange-500 hover:bg-orange-600 text-white px-5 py-2 rounded-full text-sm font-black shadow-md hover:shadow-lg transition-all duration-200 flex items-center gap-1.5">
                            <i class="fa-solid fa-sign-in-alt text-xs"></i>
                            <span>로그인</span>
                        </a>
                    </c:when>
    
                    <c:otherwise>
                        <div class="flex items-center gap-2 bg-orange-50 px-3 py-1.5 rounded-full border border-orange-200">
                            <i class="fa-solid fa-user-circle text-orange-500 text-base"></i>
                            <span class="font-bold text-gray-700 text-xs">
                                <span class="text-orange-600 font-black">${sessionScope.loginUser.name}</span>님 환영합니다!
                            </span>
                        </div>
    
                        <a href="${pageContext.request.contextPath}/mypage.do"
                           class="bg-white hover:bg-orange-50 text-orange-600 px-4 py-1.5 rounded-full text-xs font-black hover:shadow-md transition-all duration-200 flex items-center gap-1.5">
                            <i class="fa-solid fa-user text-xs"></i>
                            <span>마이페이지</span>
                        </a>
    
                        <a href="${pageContext.request.contextPath}/logout.do"
                           class="text-gray-400 hover:text-orange-600 font-bold text-xs transition-all duration-200 flex items-center gap-1 px-2 py-1.5 hover:bg-orange-50 rounded-full">
                            <i class="fa-solid fa-sign-out-alt text-xs"></i>
                            <span>로그아웃</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- ===================================================================
     * NAV: 카테고리 메뉴 (전체 드롭다운 + 태그 메뉴)
     * =================================================================== -->
    <nav class="bg-[#fffbf5]" style="height: 60px;">
        <div class="max-container flex justify-around b-grade-font text-2xl text-gray-700" style="align-items: center; height: 100%; text-align: center;">
            <div class="all-menu-container flex items-center h-full relative">
                <a href="#" class="text-orange-600 cursor-pointer">전체<i class="fa-solid fa-chevron-down text-sm"></i></a>
                <div class="wide-dropdown">
                    <c:forEach var="cat" items="${catList}">
                        <a href="category.do?id=${cat.id}">${cat.icon} ${cat.name}</a>
                    </c:forEach>

                    <c:if test="${empty catList}">
                        <div class="category-grid">
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=한식" class="category-menu-item">
                                <span>🍚</span>
                                <span>한식</span> 
                            </a>
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=중식" class="category-menu-item">
                                <span>🥢</span>
                                <span>중식</span> 
                            </a>
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=일식" class="category-menu-item">
                                <span>🍣</span>
                                <span>일식</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=양식" class="category-menu-item">
                                <span>🍝</span>
                                <span>양식</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=카페" class="category-menu-item">
                                <span>☕</span>
                                <span>카페</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/storeSearch.do?category=기타" class="category-menu-item">
                                <span>🍩</span>
                                <span>기타</span>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=파스타" class="nav-tag hover:text-orange-600 transition-all">나야..밀가루🍜</a>
            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=떡볶이" class="nav-tag hover:text-orange-600 transition-all">떡볶이는 살안쪄🍢</a>
            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=밥" class="nav-tag hover:text-orange-600 transition-all">밥은 먹고 다니냐🍚</a>
            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=탕" class="nav-tag hover:text-orange-600 transition-all">해장이 시급하다🍺</a>
        </div>
    </nav>

    <!-- ===================================================================
     * MAIN CONTENT
     * =================================================================== -->
    <main>
        <!-- 섹션 1: 타이틀 -->
        <section class="py-14 text-center">
            <h2 class="text-6xl b-grade-font text-gray-900 tracking-tighter">
                대덕 최고의 맛집 <span class="text-orange-500 italic">TOP 10</span>
            </h2>
        </section>

        <!-- 섹션 2: 슬라이드 카드 -->
        <section class="story-container">
            <div class="story-track">
                <c:forEach var="i" begin="1" end="2">
                    <c:forEach var="shop" items="${slideList}" varStatus="status">
                        <div class="card-container" onclick="this.classList.toggle('active')">
                            <div class="card-inner">
                                <div class="side front">
                                    <img src="${pageContext.request.contextPath}/images/upload/store/${shop.storePicture}" 
                                         onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'">
                                    <div class="info">
                                        <span class="ranking">RANK <fmt:formatNumber value="${status.count}" pattern="00"/></span>
                                        <span class="store-name">${shop.storeName}</span>
                                        <div class="flex items-center text-orange-500 gap-1.5 mt-3">
                                            <i class="fa-solid fa-star text-sm"></i>
                                            <span class="font-black text-lg">${shop.rating}</span>
                                            <span class="text-gray-400 text-sm ml-2 font-normal">(${shop.likesCount} likes)</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="side back">
                                    <div>
                                        <h2>${shop.storeName}</h2>
                                        <div class="stat-item text-orange-500">
                                            <i class="fa-solid fa-star mr-2"></i> 맛집 평점: ${shop.rating} / 5.0
                                        </div>
                                        <div class="stat-item text-red-500">
                                            <i class="fa-solid fa-heart mr-2"></i> 찜한 횟수: ${shop.likesCount}회
                                        </div>
                                        <p class="desc">
                                            대덕 근처 엄선 맛집 "${shop.storeName}" 입니다. <br>
                                            실제 이용자들의 데이터로 검증된 최고의 맛을 경험해보세요.
                                        </p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/storeDetail.do?id=${shop.storeId}" class="btn-detail" onclick="event.stopPropagation();">
                                        상세보기 <i class="fa-solid fa-chevron-right ml-2 text-xs"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:forEach>
            </div>
        </section>

        <!-- 섹션 3: 룰렛 버튼 -->
        <section class="max-container py-6 flex justify-center">
            <a href="${pageContext.request.contextPath}/TEST/views/user/gamezone.jsp" class="roulette-button">
               결정장애 끝판왕 격파 👊 CLICK!
            </a>
        </section>
    </main>

    <!-- ===================================================================
     * FOOTER: GS25 프로모션 카드 섹션
     * =================================================================== -->
<!--     <footer class="bg-blue-50 py-16 border-t-4 border-blue-100"> -->
        <div class="max-w-[1400px] mx-auto px-8 text-center">
            <h3 class="text-6xl b-grade-font text-blue-900 italic mb-10">
                GS25 대덕로또점 전용 특가
            </h3>

            <!-- GS25 카드 3개 -->
            <div class="grid grid-cols-3 gap-6">

                <!-- 1) 갓세일 -->
                <div class="bg-white rounded-[34px] shadow-xl overflow-hidden border-[8px] border-white">
                    <div class="px-8 py-5 border-b bg-sky-50 flex items-center justify-center min-h-[92px]">
                        <p class="text-3xl gs-title text-sky-600">갓세일</p>
                    </div>

                    <div class="p-8">
                        <c:choose>
                            <c:when test="${empty godSale}">
                                <div class="py-20 text-slate-400 font-black text-xl text-center">현재 갓세일 품목이 없습니다</div>
                            </c:when>
                            <c:otherwise>
                                <img
                                    class="w-full h-[260px] object-cover rounded-[26px] shadow-md mb-6"
                                    src="${pageContext.request.contextPath}/images/upload/GS/${godSale.productImageUrl}"
                                    onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'"
                                />
                                <p class="text-2xl font-black text-slate-800 mb-3">${godSale.productName}</p>
                                <p class="text-5xl font-black text-orange-600 mb-3">
                                    <fmt:formatNumber value="${godSale.discountPrice}" pattern="#,###" />원
                                </p>
                                <p class="text-lg font-black text-slate-500">
                                    할인율 <span class="text-orange-500">${godSale.discountRate}%</span>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 2) 마감할인 -->
                <div class="bg-white rounded-[34px] shadow-xl overflow-hidden border-[8px] border-white">
                    <div class="px-8 py-5 border-b bg-orange-50 flex flex-col items-center justify-center gap-3 min-h-[92px]">
                        <p class="text-3xl gs-title text-orange-500 leading-none">마감할인</p>
                    </div>

                    <div class="p-8">
                        <c:choose>
                            <c:when test="${empty endSale}">
                                <div class="py-20 text-slate-400 font-black text-xl text-center">현재 마감할인 품목이 없습니다</div>
                            </c:when>
                            <c:otherwise>
                                <img
                                    class="w-full h-[260px] object-cover rounded-[26px] shadow-md mb-6"
                                    src="${pageContext.request.contextPath}/images/upload/GS/${endSale.productImageUrl}"
                                    onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'"
                                />
                                <p class="text-2xl font-black text-slate-800 mb-3">${endSale.productName}</p>
                                <p class="text-lg font-black text-slate-500">
                                    할인율 <span class="text-orange-500">${endSale.discountRate}%</span>
                                </p>
                                <div class="px-8 pt-4 flex justify-center">
                           <div id="endSaleTimer"
                                data-endtime="${endSale.endTime}"
                                class="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-full bg-white
                                       border-2 border-orange-400 text-orange-600 font-black text-base shadow-sm">
                             ⏰ 마감까지 00:00:00
                           </div>

                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- 3) 핫아이템 -->
                <div class="bg-white rounded-[34px] shadow-xl overflow-hidden border-[8px] border-white">
                    <div class="px-8 py-5 border-b bg-red-50 flex items-center justify-center min-h-[92px]">
                        <p class="text-3xl gs-title text-red-500">핫아이템</p>
                    </div>

                    <div class="p-8">
                        <c:choose>
                            <c:when test="${empty hotItem}">
                                <div class="py-20 text-slate-400 font-black text-xl text-center">현재 핫아이템 품목이 없습니다</div>
                            </c:when>
                            <c:otherwise>
                                <img
                                    class="w-full h-[260px] object-cover rounded-[26px] shadow-md mb-6"
                                    src="${pageContext.request.contextPath}/images/upload/GS/${hotItem.productImageUrl}"
                                    onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'"
                                />
                                <p class="text-2xl font-black text-slate-800 mb-3">${hotItem.productName}</p>
                                <p class="text-5xl font-black text-orange-600 mb-3">
                                    <fmt:formatNumber value="${hotItem.discountPrice}" pattern="#,###" />원
                                </p>
                                <p class="text-lg font-black text-slate-500">
                                    할인율 <span class="text-orange-500">${hotItem.discountRate}%</span>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>
        </div>
    </footer>

    <!-- ===================================================================
     * FOOTER: 회사 정보 (하단 풋터)
     * =================================================================== -->
    <footer style="background-color: #e5e7eb; padding: 40px 20px; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;">
        <div style="max-width: 1200px; margin: 0 auto;">
            <div style="color: #6b7280; font-size: 14px; line-height: 1.8;">
                <p style="margin: 0 0 8px 0; font-weight: 600;">(주)D.D.M</p>
                <p style="margin: 0 0 8px 0;">
                    대표: 노태호 | 사업자 등록번호: 123-00-12345 | 통신판매번호: 2026-대덕인재-304호 | 사업자정보조회
                </p>
                <p style="margin: 0 0 8px 0;">
                    이메일: nono99@ddit.com | 고객센터: 1800-1818 | 대전 인재개발원 13기 팀: 대덕 뭐먹지? 
                </p>
                <p style="margin: 0 0 20px 0;">© 2026 D.D.M All DaeDukEat.</p>
            </div>
            
            <div style="display: flex; gap: 20px;">
                <a href="#" style="color: #9ca3af; text-decoration: none; transition: color 0.2s;" 
                   onmouseover="this.style.color='#6b7280'" onmouseout="this.style.color='#9ca3af'">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                    </svg>
                </a>
                <a href="#" style="color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                   onmouseover="this.style.color='#6b7280'" onmouseout="this.style.color='#9ca3af'">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                    </svg>
                </a>
                <a href="#" style="color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                   onmouseover="this.style.color='#6b7280'" onmouseout="this.style.color='#9ca3af'">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M21 6h-4.9l.4-2c.1-.3 0-.6-.2-.8-.2-.3-.5-.4-.8-.4h-3c-.4 0-.7.2-.9.5L8.5 9 7 6.6c-.2-.3-.5-.5-.9-.5H3c-.6 0-1 .4-1 1v11c0 .6.4 1 1 1h3.3c.3 0 .6-.1.8-.4l6.7-8.2.6 3.8c0 .3.3.6.6.7l8 1.5h.2c.5 0 .8-.3.9-.7l2-10c.1-.6-.3-1.1-.9-1.2 0-.1-.1-.1-.2-.1zm-18 11V7.4l1.3 2.3c.2.3.5.4.8.4.4 0 .7-.2.9-.5l2.4-3.9h1.6l2.1 12.2H3zm17.5-.8-6.4-1.2-.8-4.1 2.4-2.9c.3-.4.3-.9 0-1.3-.2-.2-.5-.3-.8-.3h-2.4l1.1-3.2h1.6l-.5 2.4c-.1.3 0 .6.2.8.2.2.4.3.7.3H20l-1.5 9.5z"/>
                    </svg>
                </a>
                <a href="#" style="color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                   onmouseover="this.style.color='#6b7280'" onmouseout="this.style.color='#9ca3af'">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 0c-6.627 0-12 5.372-12 12 0 5.084 3.163 9.426 7.627 11.174-.105-.949-.2-2.405.042-3.441.218-.937 1.407-5.965 1.407-5.965s-.359-.719-.359-1.782c0-1.668.967-2.914 2.171-2.914 1.023 0 1.518.769 1.518 1.69 0 1.029-.655 2.568-.994 3.995-.283 1.194.599 2.169 1.777 2.169 2.133 0 3.772-2.249 3.772-5.495 0-2.873-2.064-4.882-5.012-4.882-3.414 0-5.418 2.561-5.418 5.207 0 1.031.397 2.138.893 2.738.098.119.112.224.083.345l-.333 1.36c-.053.22-.174.267-.402.161-1.499-.698-2.436-2.889-2.436-4.649 0-3.785 2.75-7.262 7.929-7.262 4.163 0 7.398 2.967 7.398 6.931 0 4.136-2.607 7.464-6.227 7.464-1.216 0-2.359-.631-2.75-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146 1.124.347 2.317.535 3.554.535 6.627 0 12-5.373 12-12 0-6.628-5.373-12-12-12z"/>
                    </svg>
                </a>
                <a href="#" style="color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                   onmouseover="this.style.color='#6b7280'" onmouseout="this.style.color='#9ca3af'">
                    <svg width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                    </svg>
                </a>
            </div>
        </div>
    </footer>

    <!-- ===================================================================
     * ✅ 팝업 광고 HTML (기존 팝업.jsp 통합)
     * =================================================================== -->
    <div id="ad-popup">
        <div class="ad-body">
            <!-- 
                ✅ 팝업 이미지 클릭 시 새 창으로 링크 이동
                @param adLinkUrl: JSP 상단에서 정의한 링크 URL
                @param adImgUrl: JSP 상단에서 정의한 이미지 경로
            -->
            <a href="<%= adLinkUrl %>" target="_self">
                <img src="<%= adImgUrl %>" alt="대형 맛집 광고">
            </a>
        </div>
        <div class="ad-footer">
            <label>
                <!-- ✅ 7일간 보지 않기 체크박스 -->
                <input type="checkbox" id="no-show-cb"> 7일 동안 보지 않기
            </label>
            <!-- ✅ 팝업 닫기 버튼 (JavaScript closeAd() 호출) -->
            <button onclick="closeAd()">닫기</button>
        </div>
    </div>

    <!-- ✅ 테스트용 초기화 버튼 (개발 완료 후 삭제 권장) -->
<!--     <button class="test-btn" onclick="resetAdStorage()">
        🔄 테스트용: 팝업 초기화
    </button> -->

    <!-- ===================================================================
     * 챗봇 모달 HTML
     * =================================================================== -->
    <div id="chatModal">
        <div class="chat-container">
            <div class="header relative">
                <span>영달봇 🤖</span>
                <button id="closeChatBtn"
                        class="absolute right-4 top-4 text-white text-xl font-black hover:scale-110 transition">
                    &times;
                </button>
            </div>
            <div id="chat-window">
                <!-- ✅ JS로 메시지가 들어올 영역 -->
            </div>
            <div id="loading">답변 생성 중...</div>
            <div class="input-area">
                <input type="text" id="chatInput" placeholder="메시지를 입력하세요...">
                <button id="sendBtn">전송</button>
            </div>
        </div>
    </div>

    <!-- 챗봇 플로팅 버튼 -->
    <div class="fixed bottom-8 right-8 z-[200] flex flex-col items-end float-bot">
        <div class="bg-white border-2 border-orange-500 text-orange-600 px-5 py-2 rounded-2xl font-black text-sm mb-3 shadow-2xl relative">
            영달봇에게 물어보세요! 🤖
            <div class="absolute -bottom-2 right-6 w-4 h-4 bg-white border-r-2 border-b-2 border-orange-500 rotate-45"></div>
        </div>
        <button id="chatBtn"
                style="right:30px; bottom:30px;
                       width:60px; height:60px; border-radius:50%;
                       background:#ff7e00; color:white; font-size:1.5rem;
                       border:none; box-shadow:0 10px 25px rgba(0,0,0,0.2);">
            🤖 
        </button>
    </div>

    <!-- ===================================================================
     * JAVASCRIPT: jQuery + 스크립트 모음
     * =================================================================== -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        /**
         * ===================================================================
         * [1] 카테고리 드롭다운 토글 스크립트
         * ===================================================================
         */
        $(function () {
            $('.all-menu-container > a').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $(this).siblings('.wide-dropdown').toggleClass('show');
            });

            $(document).on('click', function () {
                $('.wide-dropdown').removeClass('show');
            });

            $('.wide-dropdown').on('click', function(e){
                e.stopPropagation(); // 드롭다운 내부 클릭해도 안 닫히게
            });
        });

        /**
         * ===================================================================
         * [2] GS25 마감할인 타이머 스크립트
         * ===================================================================
         * @description 마감시간(data-endtime)까지 남은 시간을 실시간 카운트다운
         * @example <div id="endSaleTimer" data-endtime="23:59:59"></div>
         */
         (function(){
             const el = document.getElementById('endSaleTimer');
             if (!el) return;

             const endTimeStr = (el.getAttribute('data-endtime') || '').trim(); // "HH:mm" or "HH:mm:ss"
             if (!endTimeStr) return;

             function pad2(n){ return String(n).padStart(2, '0'); }

             function parseTime(t){
               const parts = t.split(':'); // ["19","00"] or ["19","00","00"]
               const hh = parseInt(parts[0] || '0', 10);
               const mm = parseInt(parts[1] || '0', 10);
               const ss = parseInt(parts[2] || '0', 10); // ✅ 없으면 0 처리
               return { hh, mm, ss };
             }

             const { hh, mm, ss } = parseTime(endTimeStr);

             function computeTarget(){
               const now = new Date();
               let target = new Date(now.getFullYear(), now.getMonth(), now.getDate(), hh, mm, ss, 0);

               // ✅ 이미 오늘 마감시간이 지났으면 "내일 마감"으로 넘길지/종료할지 선택
               // 여기서는 "판매 종료"로 처리 (원하면 내일로 넘기는 버전도 줄게)
               if (target.getTime() <= now.getTime()) return null;
               return target;
             }

             const target = computeTarget();

             function tick(){
               if (!target){
                 el.textContent = '⏰ 판매 종료';
                 return;
               }

               const now = new Date();
               let diff = target.getTime() - now.getTime();

               if (diff <= 0){
                 el.textContent = '⏰ 판매 종료';
                 return;
               }

               const h = Math.floor(diff / 3600000);
               diff %= 3600000;
               const m = Math.floor(diff / 60000);
               diff %= 60000;
               const s = Math.floor(diff / 1000);

               el.textContent = '⏰ 마감까지 ' + pad2(h) + ':' + pad2(m) + ':' + pad2(s);
               setTimeout(tick, 1000);
             }

             tick();
           })();


        /**
         * ===================================================================
         * [3] ✅ 팝업 광고 제어 스크립트 (통합됨)
         * ===================================================================
         * @description 
         * - 페이지 로드 시 localStorage 확인하여 팝업 표시 여부 결정
         * - "7일간 보지 않기" 체크 시 7일 후 timestamp를 localStorage에 저장
         * - 닫기 버튼 클릭 시 팝업 숨김
         * 
         * @localStorage ad_expiry_date: 팝업 재표시 금지 만료 시간(timestamp)
         */
        (function(){
            const popup = document.getElementById('ad-popup');
            const storageKey = 'ad_expiry_date';

            /**
             * ✅ 페이지 로드 시 팝업 표시 여부 결정
             * - localStorage에 저장된 만료시간이 현재보다 미래면 팝업 안 보임
             * - 만료되었거나 없으면 팝업 표시
             */
            window.addEventListener('load', function() {
                const expiry = localStorage.getItem(storageKey);
                const now = new Date().getTime();

                if (!expiry || now > parseInt(expiry)) {
                    popup.style.display = 'block';
                }
            });

            /**
             * ✅ 팝업 닫기 함수
             * - "7일간 보지 않기" 체크 시 localStorage에 만료시간 저장
             * - 팝업 숨김 처리
             */
            window.closeAd = function() {
                const isChecked = document.getElementById('no-show-cb').checked;
                if (isChecked) {
                    const sevenDays = 7 * 24 * 60 * 60 * 1000; // 7일을 밀리초로 변환
                    const expiryDate = new Date().getTime() + sevenDays;
                    localStorage.setItem(storageKey, expiryDate);
                }
                popup.style.display = 'none';
            };

            /**
             * ✅ 테스트용: localStorage 초기화 함수
             * - 개발/테스트 시에만 사용, 운영 배포 시 제거 권장
             */
            window.resetAdStorage = function() {
                localStorage.removeItem(storageKey);
                alert('팝업 설정이 초기화되었습니다!');
                location.reload();
            };
        })();

        /**
         * ===================================================================
         * [4] 챗봇 외부 스크립트 로드
         * ===================================================================
         * @description chatbot.js 파일에 챗봇 로직이 구현되어 있음
         */
        window.APP = { contextPath: '<%=request.getContextPath()%>' };
    </script>
    
    <!-- ✅ 챗봇 외부 스크립트 -->
    <script src="<%=request.getContextPath()%>/TEST/js/main/chatbot.js"></script>

</body>
</html>
