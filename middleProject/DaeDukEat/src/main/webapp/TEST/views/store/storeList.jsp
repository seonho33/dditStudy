<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 다이내믹 큐레이션</title> 
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fafafa; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        /* 🎨 [핵심] 활성화 테마 컬러 통일 */
        .category-item.active { 
            background-color: #f97316 !important; 
            color: white !important; 
            box-shadow: 0 10px 20px rgba(249, 115, 22, 0.25); 
        }
        .category-item.active i { color: white !important; }

        .sort-tab.active { 
            color: #f97316 !important; 
            border-bottom: 3px solid #f97316 !important; 
        }
        
        /* 공통 스타일 */
        .shop-card { 
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
            min-height: 100px;
        }
        .shop-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 20px 40px rgba(0,0,0,0.08); 
        }
        .max-container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 0 20px; 
        }
        
        .review-full-panel { 
            display: none; 
            width: 100%; 
            margin-top: 2rem; 
            border-top: 2px dashed #eee; 
            padding-top: 1.5rem; 
        }
        .review-full-panel.show { 
            display: block; 
            animation: fadeIn 0.3s ease-in; 
        }
        @keyframes fadeIn { 
            from { opacity: 0; } 
            to { opacity: 1; } 
        }

        /* 인터랙션 */
        .btn-interact { 
            transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
        }
        .btn-interact:active { 
            transform: scale(1.3); 
        }
        .is-active-heart { color: #ef4444 !important; } 
        .is-active-bookmark { color: #f59e0b !important; }

        /* ========================================
           [🔥 수정] 좌우 배너
        ======================================== */
        .side-banner {
            position: fixed;
            top: 120px;
            width: 200px;
            z-index: 40;
            transition: transform 0.3s ease;
        }
        
        .side-banner.left {
            left: 50px;
        }
        
        .side-banner.right {
            right: 50px;
        }
        
        .side-banner.hidden {
            transform: translateX(-300px);
        }
        
        .side-banner.right.hidden {
            transform: translateX(300px);
        }
        
        .side-banner img {
            width: 100%;
            height: auto;
            border-radius: 0;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
            border: 2px solid #333;
            display: block;
        }
        
        /* 🔥 X 버튼 */
        .banner-close-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            width: 5px;
            height: 5px;
         /*   background: #ef4444; */
            color: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 12px;
            font-weight: bold;
            box-shadow: 0 6px 16px rgba(0,0,0,0.4);
            transition: all 0.2s;
            z-index: 50;
        }
        
        .banner-close-btn:hover {
            background: #dc2626;
            transform: scale(1.15);
        }
        
        .banner-close-btn:active {
            transform: scale(0.95);
        }

        /* 반응형: 1400px 이하에서 배너 숨김 */
        @media (max-width: 1400px) {
            .side-banner {
                display: none;
            }
        }
        
        .side-banner a { display:block; cursor:pointer; }
        
    </style>
</head>
<body>

<%-- 태그 받기 --%>
<%
   String tag = request.getParameter("tag") != null ? request.getParameter("tag") : "";
%>

    <header class="bg-white border-b sticky top-0 z-50 py-4 shadow-sm">
        <div class="max-container flex items-center justify-between gap-10">
            <a href="${pageContext.request.contextPath}/main.do" class="flex items-center gap-3">
                <img src="${pageContext.request.contextPath}/images/로고.png" 
                    alt="D.D.M 로고" 
                    class="h-14 w-auto"
                    onerror="this.style.display='none';">
                <span class="text-4xl b-grade-font text-orange-500 tracking-tighter">D.D.M</span>
            </a>
            
            <div class="flex-grow max-w-xl px-10">
                <form action="${pageContext.request.contextPath}/storeSearch.do" method="get" class="relative">
                    <input type="text" name="keyword" value="${param.keyword}"
                           placeholder="맛집이나 메뉴를 검색해보세요!"
                           class="w-full bg-gray-50 border-2 border-gray-100 rounded-full py-3 px-12 text-lg focus:outline-none focus:border-orange-500 font-bold shadow-inner">
                    <i class="fa-solid fa-magnifying-glass absolute left-4 top-4 text-orange-500 text-xl"></i>
                </form>
            </div>
            
            <div class="hidden lg:flex gap-4 font-black text-gray-400">
                <c:choose>
                    <c:when test="${empty sessionScope.loginUser}">
                        <a href="${pageContext.request.contextPath}/login.do"
                           class="bg-orange-500 hover:bg-orange-600 text-white px-5 py-2 rounded-full text-sm font-black shadow-md hover:shadow-lg transition-all duration-200 flex items-center gap-1.5">
                            <i class="fa-solid fa-sign-in-alt text-xs"></i>
                            <span>로그인</span>
                        </a>
                    </c:when>
                    <c:otherwise>   
                        <a href="${pageContext.request.contextPath}/mypage.do"
                           class="bg-white hover:bg-orange-50 text-orange-600 px-4 py-1.5 rounded-full text-xs font-black hover:shadow-md transition-all duration-200 flex items-center gap-1.5">
                            <i class="fa-solid fa-user text-xs"></i>
                            <span>마이페이지</span>
                        </a> 
                        <a href="${pageContext.request.contextPath}/notice/list.do"
                           class="bg-white hover:bg-orange-50 text-orange-600 px-4 py-1.5 rounded-full text-xs font-black hover:shadow-md transition-all duration-200 flex items-center gap-1.5">
                            <i class="fa-solid fa-question-circle text-xs"></i>
                            <span>Q & A</span>
                        </a>                  
                        <a href="${pageContext.request.contextPath}/logout.do"
                           class="text-gray-400 hover:text-orange-600 font-bold text-xs transition-all duration-200 flex items-center gap-1 px-2 py-1.5 hover:bg-orange-50 rounded-full">
                            <i class="fa-solid fa-sign-out-alt text-xl"></i>
                            <span>로그아웃</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- ========================================
         [🔥 좌측 배너] - 디버깅 코드 추가
    ======================================== -->
<aside id="leftBanner" class="side-banner left">
<div class="banner-close-btn" onclick="event.preventDefault(); event.stopPropagation(); closeBanner('left')">

        <i class="fa-solid fa-xmark"></i>
    </div>

    <!-- ✅ 배너 클릭 시 main.do 이동 -->
    <a href="${pageContext.request.contextPath}/main.do">
        <img id="leftBannerImg"
             src="${pageContext.request.contextPath}/images/upload/banner/left.gif" 
             alt="대덕 맛집을 DDM"
             onerror="console.error('❌ 좌측 배너 로드 실패:', this.src); this.style.display='none';"
             onload="console.log('✅ 좌측 배너 로드 성공:', this.src);">
    </a>
</aside>

    <!-- ========================================
         [🔥 우측 배너] - 디버깅 코드 추가
    ======================================== -->
<aside id="rightBanner" class="side-banner right">
<div class="banner-close-btn" onclick="event.preventDefault(); event.stopPropagation(); closeBanner('right')">

        <i class="fa-solid fa-xmark"></i>
    </div>

    <!-- ✅ 우측 배너 클릭 시 팝업이벤트.jsp 이동 -->
    <a href="${pageContext.request.contextPath}/TEST/views/store/팝업이벤트.jsp">
        <img id="rightBannerImg"
             src="${pageContext.request.contextPath}/images/upload/banner/right.png"
             alt="데이트 맛집 추천"
             onerror="console.error('❌ 우측 배너 로드 실패:', this.src); this.style.display='none';"
             onload="console.log('✅ 우측 배너 로드 성공:', this.src);">
    </a>
</aside>


    <main class="max-container py-12">
        <div class="flex flex-col md:flex-row gap-10">
            
            <aside class="w-full md:w-72 flex-shrink-0">
                <div class="space-y-6 sticky top-28">
                    <div class="bg-white rounded-[40px] p-8 shadow-sm border border-gray-100">
                        <h3 class="text-2xl b-grade-font text-gray-900 mb-6 px-2">카테고리</h3>
                        <nav class="space-y-3">
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=전체보기"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '전체보기' || param.category == null ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                전체보기
                                <i class="fa-solid fa-layer-group"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=한식"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '한식' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                한식
                                <i class="fa fa-archive"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=중식"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '중식' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                중식
                                <i class="fa fa-fire"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=일식"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '일식' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                일식
                                <i class="fa-solid fa-water"></i>                         
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=양식"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '양식' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                양식
                                <i class="fa-solid fa-utensils"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=카페"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '카페' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                카페
                                <i class="fa-solid fa-coffee"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}/storeSearch.do?category=기타"
                               class="category-item w-full text-left px-7 py-4 rounded-2xl font-black flex justify-between items-center transition-all
                                      ${param.category == '기타' ? 'active text-orange-400' : 'text-gray-400 hover:bg-orange-50'}">
                                기타
                                <i class="fa-solid fa-ellipsis"></i>
                            </a>              
                        </nav>
                    </div>

                    <div class="bg-orange-50 rounded-[40px] p-8 border border-orange-100 shadow-sm">
                        <h3 class="text-2xl b-grade-font text-orange-600 mb-6 px-2">
                            <i class="fa-solid fa-wand-magic-sparkles mr-1"></i> MD 추천
                        </h3>
                        <nav class="space-y-2">
                            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=파스타"
                               class="md-btn category-item w-full text-left px-5 py-3 rounded-xl
                                      font-black text-orange-400 hover:bg-white flex justify-between
                                      items-center text-sm transition-all
                                      ${param.tag == '파스타' ? 'active' : ''}">
                                나야..밀가루 🍜
                                <i class="fa-solid fa-chevron-right text-[10px]"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=떡볶이"
                               class="md-btn category-item w-full text-left px-5 py-3 rounded-xl
                                      font-black text-orange-400 hover:bg-white flex justify-between
                                      items-center text-sm transition-all
                                      ${param.tag == '떡볶이' ? 'active' : ''}">
                                떡볶이는 살안쪄 🍢
                                <i class="fa-solid fa-chevron-right text-[10px]"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=밥"
                               class="md-btn category-item w-full text-left px-5 py-3 rounded-xl
                                      font-black text-orange-400 hover:bg-white flex justify-between
                                      items-center text-sm transition-all
                                      ${param.tag == '밥' ? 'active' : ''}">
                                밥은 먹고 다니냐 🍚
                                <i class="fa-solid fa-chevron-right text-[10px]"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/storeSearch.do?tag=탕"
                               class="md-btn category-item w-full text-left px-5 py-3 rounded-xl
                                      font-black text-orange-400 hover:bg-white flex justify-between
                                      items-center text-sm transition-all
                                      ${param.tag == '탕' ? 'active' : ''}">
                                해장이 시급하다 🍺
                                <i class="fa-solid fa-chevron-right text-[10px]"></i>
                            </a>
                        </nav>
                    </div>
                </div>
            </aside>

            <section class="flex-grow">
                <div class="mb-6 px-4 flex flex-col gap-6">
                    <h2 class="text-4xl b-grade-font text-gray-900" id="listTitle">
                        대덕의 <span class="text-orange-500">
                            <%= (tag != null && !tag.isEmpty()) ? tag
                                : (request.getParameter("category") != null 
                                   && !request.getParameter("category").isEmpty())
                                    ? request.getParameter("category")
                                : (request.getParameter("keyword") != null 
                                   && !request.getParameter("keyword").isEmpty())
                                    ? request.getParameter("keyword")
                                : "전체 맛집" %>
                        </span>
                    </h2>
                    
                    <div class="flex gap-6 border-b border-gray-100 pb-2">
                        <a href="javascript:void(0)"
                           class="sort-tab pb-2 text-sm font-black transition-all active"
                           onclick="sortShops('likes', this)">
                            좋아요순
                        </a>
                        
                        <a href="javascript:void(0)"
                           class="sort-tab pb-2 text-sm font-black transition-all"
                           onclick="sortShops('bookmarks', this)">
                            찜많은순
                        </a>
                    </div>
                </div>
               
                <div id="shopListContainer" class="space-y-8"></div>
            </section>
            
        </div>
    </main>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        
        // 🔥 디버깅: contextPath 및 배너 경로 출력
        console.log("🔍 ContextPath:", contextPath);
        console.log("🔍 좌측 배너 경로:", contextPath + "/images/upload/banner/left.gif");
        console.log("🔍 우측 배너 경로:", contextPath + "/images/upload/banner/right.png");
        
        const initialShops = [
        <c:forEach var="store" items="${storeList}" varStatus="s">
        {
            storeId: "${store.storeId}",
            storeName: "${store.storeName}",
            category: "${store.category}",
            star: Number("${store.rating}"),
            likes: Number("${store.likesCount}"),
            bookmarks: Number("${store.dibsCount}"),
            storeContent: "${store.storeContent}",
            img: "${store.storePicture}",
            review: "${store.review}"
        }${!s.last ? ',' : ''}
        </c:forEach>
        ];
        
        let currentData = [...initialShops];
        
        function closeBanner(side) {
            const bannerId = side === 'left' ? 'leftBanner' : 'rightBanner';
            const banner = document.getElementById(bannerId);
            banner.classList.add('hidden');
            localStorage.setItem(`banner_${side}_closed`, 'true');
            console.log(`🚫 ${side} 배너 닫힘`);
        }
        
        function restoreBannerState() {
            if (localStorage.getItem('banner_left_closed') === 'true') {
                document.getElementById('leftBanner').classList.add('hidden');
                console.log('📦 좌측 배너 상태 복원: 닫힘');
            }
            if (localStorage.getItem('banner_right_closed') === 'true') {
                document.getElementById('rightBanner').classList.add('hidden');
                console.log('📦 우측 배너 상태 복원: 닫힘');
            }
        }
        
        function renderShops(data) {
            const container = document.getElementById("shopListContainer");
            container.innerHTML = "";

            if (!data || data.length === 0) {
                container.innerHTML = `<p class="text-gray-400 font-bold">검색 결과가 없습니다.</p>`;
                return;
            }

            data.forEach(shop => {
                const imgSrc = (!shop.img || shop.img === 'null')
                    ? contextPath + '/images/upload/store/default-store.png'
                    : contextPath + '/images/upload/store/' + shop.img;

                const link = document.createElement("a");
                link.href = contextPath + "/storeDetail.do?id=" + shop.storeId;
                link.className = "block w-full shop-card bg-white rounded-xl shadow hover:shadow-lg transition-all";

                link.innerHTML = '<div class="group relative flex items-stretch p-6 rounded-2xl border-2 border-gray-200 ' +
                            'hover:border-orange-400 hover:bg-orange-50/30 hover:-translate-y-1 ' +
                            'transition-all duration-300 shadow-md hover:shadow-lg w-full">' +
                        
                            '<div class="w-60 h-48 rounded-xl overflow-hidden flex-shrink-0 bg-gray-100">' +
                                '<img src="' + contextPath + '/images/upload/store/' + shop.img + '" ' +
                                'alt="가게 이미지" ' +
                                'class="w-full h-full object-cover">' +
                            '</div>' +
                        
                            '<div class="flex flex-col flex-grow justify-between ml-6">' +
                                '<div>' +
                                    '<h3 class="text-2xl font-bold text-gray-900 mb-1">' + shop.storeName + '</h3>' +
                                    '<p class="text-lg text-orange-500 font-semibold mb-1">' + shop.category + '</p>' +
                                    '<p class="text-base text-gray-600 line-clamp-3">' + shop.storeContent + '</p>' +
                                '</div>' +

                                '<div class="mt-4 w-full bg-white/90 backdrop-blur ' +
                                     'border border-gray-200 rounded-xl p-4 shadow-sm">' +
                                    '<div class="flex items-center gap-2 mb-2">' +
                                        '<i class="fa-solid fa-comment-dots text-orange-500"></i>' +
                                        '<span class="text-sm font-bold text-gray-800">최근 리뷰</span>' +
                                    '</div>' +
                                    '<p class="text-sm text-gray-600 leading-relaxed line-clamp-3">' +
                                        (shop.review ? shop.review : '아직 등록된 리뷰가 없습니다.') +
                                    '</p>' +
                                '</div>' +
                            '</div>' +
                        
                            '<div class="absolute top-4 right-4 flex items-center gap-3 text-sm font-bold">' +
                                '<span class="flex items-center gap-1 px-3 py-1 rounded-full bg-yellow-100 text-yellow-600">' +
                                    '<img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" class="w-4 h-4">' +
                                    shop.star +
                                '</span>' +
                                '<span class="flex items-center gap-1 px-3 py-1 rounded-full bg-red-100 text-red-500">' +
                                    '<img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" class="w-4 h-4">' +
                                    shop.likes +
                                '</span>' +
                                '<span class="flex items-center gap-1 px-3 py-1 rounded-full bg-blue-100 text-blue-500">' +
                                    '<img src="https://img.icons8.com/ios-filled/50/0000FF/bookmark-ribbon--v1.png" class="w-4 h-4">' +
                                    shop.bookmarks +
                                '</span>' +
                            '</div>' +
                        '</div>';

                container.appendChild(link);
            });
        }

        function handleLike(storeId, btn) {
            fetch(`${contextPath}/userLikeDids.do`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `type=like&storeId=${storeId}`
            })
            .then(res => res.json())
            .then(data => {
                if (data.result > 0) {
                    btn.querySelector('i').classList.toggle('fa-solid');
                    btn.querySelector('i').classList.toggle('fa-regular');
                }
            });
        }

        function handleBookmark(storeId, btn) {
            fetch(`${contextPath}/userLikeDids.do`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `type=dibs&storeId=${storeId}`
            })
            .then(res => res.json())
            .then(data => {
                if (data.result > 0) {
                    btn.querySelector('i').classList.toggle('fa-solid');
                    btn.querySelector('i').classList.toggle('fa-regular');
                }
            });
        }

        function sortShops(type, btn) {
            setActive(btn, '.sort-tab');
            if(type==='likes') currentData.sort((a,b)=>b.likes-a.likes);
            if(type==='bookmarks') currentData.sort((a,b)=>b.bookmarks-a.bookmarks);
            renderShops(currentData);
        }

        function setActive(btn, selector) {
            document.querySelectorAll(selector).forEach(el => el.classList.remove('active'));
            btn.classList.add('active');
        }

        window.onload = function() {
            console.log("🚀 페이지 로드 완료");
            restoreBannerState();
            
            currentData.sort(function(a, b) {
                return b.likes - a.likes;
            });
            renderShops(currentData);
        };
    </script>
</body>
</html>
