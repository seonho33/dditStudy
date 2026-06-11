<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발렌타인데이 다이닝 - 로맨틱한 순간을 위한</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif;
            background-color: #fff;
            color: #333;
        }

        /* 헤더 배너 */
        .hero-banner {
            background: linear-gradient(135deg, #8B0000 0%, #DC143C 100%);
            color: white;
            text-align: center;
            padding: 60px 20px;
            position: relative;
            overflow: hidden;
        }

        .hero-banner::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 50%;
            height: 100%;
            background: linear-gradient(135deg, transparent 0%, #DC143C 100%);
            clip-path: polygon(30% 0, 100% 0, 100% 100%, 0% 100%);
        }

        .banner-content {
            position: relative;
            z-index: 2;
            max-width: 1200px;
            margin: 0 auto;
        }

        .banner-subtitle {
            font-size: 18px;
            margin-bottom: 15px;
            opacity: 0.95;
            letter-spacing: 2px;
        }

        .banner-title {
            font-size: 52px;
            font-weight: bold;
            margin-bottom: 10px;
            letter-spacing: -1px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .banner-period {
            font-size: 20px;
            margin-top: 20px;
            opacity: 0.9;
        }

        /* 컨테이너 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px;
        }

        /* TOP 3 섹션 */
        .top3-section {
            text-align: center;
            margin-bottom: 80px;
        }

        .section-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #8B0000;
        }

        .section-subtitle {
            font-size: 16px;
            color: #666;
            margin-bottom: 50px;
            line-height: 1.6;
        }

        .top3-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }

        .top3-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .top3-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 30px rgba(139,0,0,0.2);
        }

        .top3-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
            background: linear-gradient(135deg, #ffeef8, #ffe0e9);
        }

        .top3-content {
            padding: 30px 20px;
        }

        .top3-name {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #333;
        }

        .top3-description {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }

        /* 탭 네비게이션 */
        .tab-navigation {
            display: flex;
            justify-content: center;
            gap: 0;
            margin-bottom: 60px;
            border-bottom: 2px solid #e0e0e0;
        }

        .tab-button {
            flex: 1;
            max-width: 200px;
            padding: 18px 30px;
            background: white;
            border: none;
            font-size: 16px;
            font-weight: 600;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .tab-button:hover {
            color: #DC143C;
        }

        .tab-button.active {
            color: #DC143C;
        }

        .tab-button.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 3px;
            background: #DC143C;
        }

        /* 상품 그리드 */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 50px;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .product-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            background: linear-gradient(135deg, #ffeef8, #ffe0e9);
        }

        .product-content {
            padding: 20px;
        }

        .product-badge {
            display: inline-block;
            padding: 5px 12px;
            background: #DC143C;
            color: white;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-name {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-price {
            display: flex;
            align-items: baseline;
            gap: 8px;
            margin-top: 12px;
        }

        .discount-rate {
            color: #DC143C;
            font-size: 18px;
            font-weight: bold;
        }

        .price {
            color: #333;
            font-size: 16px;
            font-weight: 600;
        }

        .original-price {
            color: #999;
            font-size: 13px;
            text-decoration: line-through;
        }

        /* 특별 이벤트 배너 */
        .event-banner {
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            margin: 60px 0;
            color: white;
        }

        .event-banner h3 {
            font-size: 28px;
            margin-bottom: 15px;
        }

        .event-banner p {
            font-size: 16px;
            margin-bottom: 25px;
            opacity: 0.95;
        }

        .event-button {
            display: inline-block;
            padding: 15px 40px;
            background: white;
            color: #DC143C;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .event-button:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .products-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .banner-title {
                font-size: 36px;
            }

            .top3-grid {
                grid-template-columns: 1fr;
            }

            .products-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .tab-button {
                padding: 15px 20px;
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {
            .products-grid {
                grid-template-columns: 1fr;
            }
        }

        .product-link {
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .product-link:visited {
            color: inherit;
        }

        .product-link:hover,
        .product-link:active,
        .product-link:focus {
            text-decoration: none;
            color: inherit;
            outline: none;
        }
    </style>
</head>
<body>
    <!-- 히어로 배너 -->
    <div class="hero-banner">
        <div class="banner-content">
            <p class="banner-subtitle">로맨틱한 순간을 위한</p>
            <h1 class="banner-title">발렌타인데이<br>다이닝</h1>
            <p class="banner-period">2.04(수) ~ 2.27(금)</p>
        </div>
    </div>

    <div class="container">
        <!-- TOP 3 섹션 -->
        <div class="top3-section">
            <h2 class="section-title">발렌타인데이<br>추천 키워드 TOP 3</h2>
            <p class="section-subtitle">발렌타인데이에 맞이 찾는<br>로맨틱한 맛집을 소개할게요</p>

            <div class="top3-grid">
                <div class="top3-card">
                    <img class="top3-image" src="${pageContext.request.contextPath}/images/upload/store/와인.jpg" alt="와인">
                    <div class="top3-content">
                        <h3 class="top3-name">BAR</h3>
                        <p class="top3-description">사랑하는 사람에게<br>마음을 전하는<br>특별한 선물</p>
                    </div>
                </div>

                <div class="top3-card">
                    <img class="top3-image" src="${pageContext.request.contextPath}/images/upload/store/케이크.jpg" alt="케이크">
                    <div class="top3-content">
                        <h3 class="top3-name">케이크</h3>
                        <p class="top3-description">달콤한 순간을<br>더 특별하게<br>만드는 디저트</p>
                    </div>
                </div>

                <div class="top3-card">
                    <img class="top3-image" src="${pageContext.request.contextPath}/images/upload/store/다이닝.jpg" alt="분위기 맛집">
                    <div class="top3-content">
                        <h3 class="top3-name">분위기 맛집</h3>
                        <p class="top3-description">로맨틱한<br>분위기 속에서<br>즐기는 데이트</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- 탭 네비게이션 -->
        <div class="tab-navigation">
            <button class="tab-button active" data-category="all">전체</button>
            <button class="tab-button" data-category="bar">BAR</button>
            <button class="tab-button" data-category="cake">케이크</button>
            <button class="tab-button" data-category="restaurant">분위기 맛집</button>
        </div>

        <!-- 상품 그리드 - BAR -->
        <div class="products-grid" data-category="bar">
            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE110" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/파라다이스.jpg" alt="파라다이스.jpg">
                    <div class="product-content">
                        <span class="product-badge">베스트</span>
                        <h3 class="product-name">로스트파라다이스</h3>
                        <div class="product-price">
                            <span class="price">15,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE111" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/머스탱.jpg" alt="튤립 꽃다발">
                    <div class="product-content">
                        <span class="product-badge">추천</span>
                        <h3 class="product-name">머스탱</h3>
                        <div class="product-price">
                            <span class="price">13,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE112" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/덩치.jpg" alt="덩치.jpg">
                    <div class="product-content">
                        <h3 class="product-name">덩치레코오드 LP바</h3>
                        <div class="product-price">
                            <span class="price">17,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE113" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/아도니스.jpg" alt="핑크 튤립">
                    <div class="product-content">
                        <h3 class="product-name">아도니스</h3>
                        <div class="product-price">
                            <span class="price">10,000원</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- 상품 그리드 - 케이크 -->
        <div class="products-grid" data-category="cake">
            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE078" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/맘스케익.jpg" alt="하트 레드벨벳 케이크">
                    <div class="product-content">
                        <span class="product-badge">베스트</span>
                        <h3 class="product-name">맘스케익 대전중구점</h3>
                        <div class="product-price">
                            <span class="price">30,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE115" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/투썸.jpg" alt="투썸.jpg">
                    <div class="product-content">
                        <span class="product-badge">추천</span>
                        <h3 class="product-name">투썸플레이스 대전오룡역점</h3>
                        <div class="product-price">
                            <span class="price">9,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE116" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/로심.jpg" alt="로심.jpg">
                    <div class="product-content">
                        <h3 class="product-name">로심</h3>
                        <div class="product-price">
                            <span class="price">9,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE117" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/우아.jpg" alt="우아.jpg">
                    <div class="product-content">
                        <h3 class="product-name">카페우아</h3>
                        <div class="product-price">
                            <span class="price">33,000원</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- 상품 그리드 - 분위기 맛집 -->
        <div class="products-grid" data-category="restaurant">
            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE077" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/트루.jpg" alt="트루.jpg">
                    <div class="product-content">
                        <span class="product-badge">베스트</span>
                        <h3 class="product-name">트루</h3>
                        <div class="product-price">
                            <span class="price">17,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE076" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/티마.jpg" alt="티마.jpg">
                    <div class="product-content">
                        <span class="product-badge">추천</span>
                        <h3 class="product-name">티마</h3>
                        <div class="product-price">
                            <span class="price">15,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE103" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/키호시.jpg" alt="키호시.jpg">
                    <div class="product-content">
                        <h3 class="product-name">키호시</h3>
                        <div class="product-price">
                            <span class="price">59,000원</span>
                        </div>
                    </div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/storeDetail.do?id=STORE075" class="product-link">
                <div class="product-card">
                    <img class="product-image" src="${pageContext.request.contextPath}/images/upload/store/카페범스.jpg" alt="카페범스.jpg">
                    <div class="product-content">
                        <h3 class="product-name">범스</h3>
                        <div class="product-price">
                            <span class="price">15,500원</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- 특별 이벤트 배너  ★ href="game.jsp"로 변경 ★ -->
        <div class="event-banner">
            <h3>발렌타인데이 특별 커플 이벤트</h3>
            <p>BAR + 케이크 + 레스토랑 패키지 구매 시 최대 50% 할인!</p>
            <a href="game.jsp" class="event-button">패키지 상품 보러가기 →</a>
        </div>
    </div>

    <script>
        document.querySelectorAll('.tab-button').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.tab-button').forEach(btn => {
                    btn.classList.remove('active');
                });
                this.classList.add('active');

                const selectedCategory = this.getAttribute('data-category');
                const productGrids = document.querySelectorAll('.products-grid');

                productGrids.forEach(grid => {
                    const gridCategory = grid.getAttribute('data-category');
                    if (selectedCategory === 'all') {
                        grid.style.display = 'grid';
                    } else {
                        grid.style.display = (gridCategory === selectedCategory) ? 'grid' : 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>
