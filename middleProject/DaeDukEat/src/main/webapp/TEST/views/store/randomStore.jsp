<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오늘 뭐먹지? - 대덕머먹지 랜덤 가게 선택</title>
    <link rel="icon" href="data:,">
    
    <style>
        :root { --accent: #ffdd00; }
        body, html { 
            margin: 0; padding: 0; width: 100%; height: 100%; 
            overflow: hidden; background: #000; 
            font-family: 'Pretendard', -apple-system, sans-serif; 
        }
        
        #game-viewport { 
            position: relative; width: 100vw; height: 100vh; 
            display: flex; flex-direction: column; justify-content: center;
            background: linear-gradient(135deg, #000 0%, #1a1a2e 100%);
            overflow: hidden;
        }

        .rail-wrapper { 
            width: 100%; overflow: hidden; padding: 10px 0; 
        }
        
        .rail { 
            display: flex; gap: 15px; will-change: transform; 
            white-space: nowrap;
            /* ✅ transition 제거로 재설정 시 부드럽게 */
        }

        .menu-item { 
            flex: 0 0 260px; height: 16vh; 
            background: linear-gradient(135deg, #1e1e1e 0%, #2a2a2a 100%);
            border: 1px solid #333; border-radius: 12px;
            display: flex; flex-direction: column;
            justify-content: center; align-items: center;
            font-size: 1.8rem; color: #fff; font-weight: 800;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            transition: all 0.3s;
            overflow: hidden;
            position: relative;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .menu-item::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(
                135deg, 
                rgba(0, 0, 0, 0.7) 0%, 
                rgba(0, 0, 0, 0.5) 100%
            );
            z-index: 1;
        }
        
        .menu-item .store-name {
            position: relative;
            z-index: 2;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.9);
            font-size: 1.6rem;
        }
        
        .menu-item .store-category {
            font-size: 0.85rem;
            color: #ffdd00;
            margin-top: 5px;
            position: relative;
            z-index: 2;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.9);
            font-weight: 600;
        }

        .menu-item.no-image {
            background: linear-gradient(135deg, #1e1e1e 0%, #2a2a2a 100%);
        }

        .menu-item.no-image::before {
            background: linear-gradient(135deg, transparent 0%, rgba(255,255,255,0.05) 100%);
        }

        #overlay-canvas { 
            position: fixed; top: 0; left: 0; 
            width: 100%; height: 100%; 
            z-index: 20; pointer-events: none; 
        }

        .ui-controls { 
            position: fixed; bottom: 40px; left: 50%; 
            transform: translateX(-50%); z-index: 100; 
        }
        
        .btn { 
            padding: 20px 80px; font-size: 1.6rem; 
            color: white; border: none; border-radius: 50px;
            cursor: pointer; font-weight: 900; 
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            box-shadow: 0 8px 25px rgba(255, 65, 108, 0.4);
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(255, 65, 108, 0.6);
        }
        
        .btn:active { 
            transform: scale(0.95); 
        }
        
        .btn.retry { 
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.4);
        }

        .winner { 
            color: #000 !important; 
            transform: scale(1.2) !important; 
            z-index: 50; 
            border: 5px solid var(--accent) !important;
            box-shadow: 0 0 100px var(--accent), 0 0 50px rgba(255,221,0,0.5) !important;
            transition: all 0.5s ease-out;
        }

        .winner::before {
            background: linear-gradient(
                135deg, 
                rgba(255, 221, 0, 0.5) 0%, 
                rgba(255, 221, 0, 0.3) 100%
            ) !important;
        }
        
        .winner .store-name {
            color: #000 !important;
            font-size: 2rem !important;
            text-shadow: 3px 3px 6px rgba(255,255,255,0.8) !important;
        }
        
        .winner .store-category {
            color: #ff416c !important;
            text-shadow: 2px 2px 4px rgba(255,255,255,0.8) !important;
        }
        
        .winner-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            z-index: 200;
            display: none;
            max-width: 500px;
            width: 90%;
        }
        
        .winner-modal.show {
            display: block;
            animation: modalFadeIn 0.5s ease-out;
        }
        
        @keyframes modalFadeIn {
            from { opacity: 0; transform: translate(-50%, -60%); }
            to { opacity: 1; transform: translate(-50%, -50%); }
        }
        
        .winner-modal h2 {
            margin: 0 0 20px 0;
            color: #ff416c;
            font-size: 2rem;
        }
        
        .winner-modal .store-info {
            margin: 15px 0;
            line-height: 1.6;
            color: #333;
        }
        
        .winner-modal .store-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin: 15px 0;
            background: #f5f5f5;
        }
        
        .winner-modal .close-btn {
            background: #ff416c;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 700;
            margin-top: 20px;
        }
        
        .winner-modal .detail-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 700;
            margin: 20px 10px 0 0;
        }
        
        .error-overlay {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 0, 0, 0.9);
            color: white;
            padding: 30px;
            border-radius: 15px;
            z-index: 300;
            text-align: center;
            max-width: 80%;
        }
    </style>
</head>
<body>

<c:if test="${not empty errorMsg}">
    <div class="error-overlay">
        <h2>⚠️ 오류 발생</h2>
        <p>${errorMsg}</p>
        <button onclick="location.reload()" class="close-btn">새로고침</button>
    </div>
</c:if>

<div id="game-viewport">
    <div class="rail-wrapper"><div id="rail-0" class="rail"></div></div>
    <div class="rail-wrapper"><div id="rail-1" class="rail"></div></div>
    <div class="rail-wrapper"><div id="rail-2" class="rail"></div></div>
    <div class="rail-wrapper"><div id="rail-3" class="rail"></div></div>
    <div class="rail-wrapper"><div id="rail-4" class="rail"></div></div>
</div>

<canvas id="overlay-canvas"></canvas>

<div class="ui-controls">
    <button id="main-btn" class="btn">STOP</button>
</div>

<div id="winner-modal" class="winner-modal">
    <h2>🎉 오늘의 선택!</h2>
    <div id="modal-content"></div>
    <button class="detail-btn" onclick="goToStoreDetail()">가게 상세보기</button>
    <button class="close-btn" onclick="location.reload()">다시 뽑기</button>
</div>

<script>
    const CONTEXT_PATH = '<%= request.getContextPath() %>';
    const IMAGE_BASE_PATH = CONTEXT_PATH + '/images/upload/store/';
    const storesData = <c:out value="${storesJson}" default="[]" escapeXml="false" />;
    
    console.log('=== Random Store Game ===');
    console.log('Stores Count:', Array.isArray(storesData) ? storesData.length : 0);
    
    const rails = [];
    const ITEM_WIDTH = 275; 
    let gameState = 'SPIN'; 
    let lights = [];
    let winnerFound = false;
    let selectedStore = null;

    const canvas = document.getElementById('overlay-canvas');
    const ctx = canvas.getContext('2d');
    const mainBtn = document.getElementById('main-btn');
    const winnerModal = document.getElementById('winner-modal');

    function shuffleArray(array) {
        const shuffled = [...array];
        for (let i = shuffled.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
        }
        return shuffled;
    }

    /**
     * ✅ 핵심 개선: 매우 긴 레일 (15배) + 넓은 재설정 여유 구간
     */
    function init() {
        if (!Array.isArray(storesData) || storesData.length === 0) {
            alert('표시할 가게가 없습니다.');
            mainBtn.disabled = true;
            return;
        }
        
        for (let i = 0; i < 5; i++) {
            const el = document.getElementById('rail-' + i);
            
            // ✅ 15번 섞어서 매우 긴 레일 생성
            const segments = [];
            for (let j = 0; j < 15; j++) {
                segments.push(...shuffleArray(storesData));
            }
            
            segments.forEach(store => {
                const div = document.createElement('div');
                div.className = 'menu-item';
                
                if (store.storePicture && store.storePicture.trim() !== '') {
                    const imageUrl = IMAGE_BASE_PATH + store.storePicture;
                    div.style.backgroundImage = 'url("' + imageUrl + '")';
                } else {
                    div.classList.add('no-image');
                }
                
                div.dataset.storeId = store.storeId || '';
                div.dataset.storeName = store.storeName || '이름없음';
                div.dataset.category = store.category || '기타';
                div.dataset.addr = store.storeAddr || '주소 미등록';
                div.dataset.rating = store.rating || 0;
                div.dataset.pictureFilename = store.storePicture || '';
                
                div.innerHTML = 
                    '<div class="store-name">' + (store.storeName || '이름없음') + '</div>' +
                    '<div class="store-category">' + (store.category || '기타') + '</div>';
                
                el.appendChild(div);
            });
            
            const segmentLength = storesData.length * ITEM_WIDTH;
            
            rails.push({
                el: el,
                // ✅ 중앙에서 시작 (앞뒤로 충분한 여유)
                scrollX: -(segmentLength * 7),
                speed: 5 + Math.random() * 8,
                direction: (i % 2 === 0) ? 1 : -1,
                friction: 0.965,
                segmentLength: segmentLength,
                // ✅ 재설정 안전 구간 (양쪽 3구간씩 여유)
                minSafeX: -(segmentLength * 12),  // 왼쪽 끝 안전선
                maxSafeX: -(segmentLength * 2),   // 오른쪽 끝 안전선
                resetUnit: segmentLength          // 1구간 단위로 재설정
            });
        }
    }

    function getSafePos(r) {
        return {
            x: r + Math.random() * (window.innerWidth - r * 2),
            y: r + Math.random() * (window.innerHeight - r * 2)
        };
    }

    function createLights() {
        const colors = ['#00d4ff', '#ffcc00', '#ff00ff', '#00ffcc'];
        lights = [];
        for(let i=0; i<4; i++) {
            const r = 180 + Math.random() * 50;
            const pos = getSafePos(r);
            lights.push({
                sx: (innerWidth / 5) * (i + 1), sy: -100,
                x: pos.x, y: pos.y,
                tx: getSafePos(r).x, ty: getSafePos(r).y,
                vx: 0, vy: 0, r: r, color: colors[i],
                ease: 0.0006 + Math.random() * 0.0007,
                inertia: 0.98
            });
        }
    }

    /**
     * ✅ 핵심: 안전 구간 내에서만 재설정 (화면 밖에서 처리)
     */
    function animate() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        let allStopped = true;
        rails.forEach(rail => {
            if (gameState === 'STOPPING') {
                rail.speed *= rail.friction;
                if (rail.speed < 0.1) rail.speed = 0;
                else allStopped = false;
            } else if (gameState === 'SPIN') {
                allStopped = false;
            }

            rail.scrollX += (rail.speed * rail.direction);
            
            // ✅ 개선: 안전 구간을 벗어나면 재설정
            if (rail.direction === 1) {
                // 오른쪽으로 이동 중
                if (rail.scrollX > rail.maxSafeX) {
                    // 화면 오른쪽 밖으로 나갔을 때만 재설정
                    rail.scrollX -= rail.resetUnit;
                }
            } else {
                // 왼쪽으로 이동 중
                if (rail.scrollX < rail.minSafeX) {
                    // 화면 왼쪽 밖으로 나갔을 때만 재설정
                    rail.scrollX += rail.resetUnit;
                }
            }
            
            rail.el.style.transform = 'translateX(' + rail.scrollX + 'px)';
        });

        if (gameState === 'STOPPING' && allStopped) {
            gameState = 'BLACKOUT';
            createLights();
        }

        if (gameState === 'BLACKOUT' || gameState === 'FINISHED') {
            renderSpotlightEffect();
        }

        requestAnimationFrame(animate);
    }

    function renderSpotlightEffect() {
        ctx.save();
        ctx.fillStyle = "rgba(0, 0, 0, 0.98)";
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        ctx.globalCompositeOperation = 'destination-out';
        lights.forEach(l => {
            if (gameState === 'BLACKOUT') {
                l.vx += (l.tx - l.x) * l.ease;
                l.vy += (l.ty - l.y) * l.ease;
                l.vx *= l.inertia; 
                l.vy *= l.inertia;
                l.x += l.vx; 
                l.y += l.vy;

                if (l.x < l.r || l.x > canvas.width - l.r) l.vx *= -1;
                if (l.y < l.r || l.y > canvas.height - l.r) l.vy *= -1;

                if (Math.hypot(l.tx - l.x, l.ty - l.y) < 100) {
                    const next = getSafePos(l.r);
                    l.tx = next.x; 
                    l.ty = next.y;
                }
            } else if (gameState === 'FINISHED') {
                l.x += (l.winX - l.x) * 0.1;
                l.y += (l.winY - l.y) * 0.1;
            }

            const grd = ctx.createRadialGradient(l.x, l.y, 0, l.x, l.y, l.r);
            grd.addColorStop(0, "rgba(255, 255, 255, 1)");
            grd.addColorStop(0.8, "rgba(255, 255, 255, 0.2)");
            grd.addColorStop(1, "transparent");
            ctx.fillStyle = grd;
            ctx.beginPath(); 
            ctx.arc(l.x, l.y, l.r, 0, Math.PI*2); 
            ctx.fill();
        });
        ctx.restore();

        ctx.save();
        ctx.globalCompositeOperation = 'lighter';
        lights.forEach(l => {
            const beam = ctx.createLinearGradient(l.sx, l.sy, l.x, l.y);
            beam.addColorStop(0, l.color + "55");
            beam.addColorStop(1, "transparent");
            ctx.fillStyle = beam;
            ctx.beginPath();
            ctx.moveTo(l.sx-40, l.sy); 
            ctx.lineTo(l.sx+40, l.sy);
            ctx.lineTo(l.x + l.r/3, l.y); 
            ctx.lineTo(l.x - l.r/3, l.y);
            ctx.fill();
        });
        ctx.restore();

        if (gameState === 'BLACKOUT') pickTrulyRandomWinner();
    }

    function pickTrulyRandomWinner() {
        if (winnerFound) return;
        winnerFound = true;

        setTimeout(() => {
            const allItems = Array.from(document.querySelectorAll('.menu-item'));
            const visibleItems = allItems.filter(item => {
                const rect = item.getBoundingClientRect();
                return (
                    rect.left >= 0 &&
                    rect.right <= window.innerWidth &&
                    rect.top >= 0 &&
                    rect.bottom <= window.innerHeight
                );
            });

            const winner = visibleItems[Math.floor(Math.random() * visibleItems.length)];
            
            selectedStore = {
                storeId: winner.dataset.storeId,
                storeName: winner.dataset.storeName,
                category: winner.dataset.category,
                addr: winner.dataset.addr,
                rating: winner.dataset.rating,
                pictureFilename: winner.dataset.pictureFilename
            };

            setTimeout(() => {
                gameState = 'FINISHED';
                const rect = winner.getBoundingClientRect();
                lights.forEach(l => {
                    l.winX = rect.left + rect.width / 2;
                    l.winY = rect.top + rect.height / 2;
                });
                
                setTimeout(() => {
                    winner.classList.add('winner');
                    showWinnerModal();
                    mainBtn.innerText = 'RESTART';
                    mainBtn.className = 'btn retry';
                    mainBtn.style.display = 'block';
                }, 1000);
            }, 4500); 
        }, 100);
    }

    function showWinnerModal() {
        const modalContent = document.getElementById('modal-content');
        
        let imageHtml = '';
        if (selectedStore.pictureFilename && selectedStore.pictureFilename.trim() !== '') {
            const fullImagePath = IMAGE_BASE_PATH + selectedStore.pictureFilename;
            
            imageHtml = '<img src="' + fullImagePath + '" ' +
                       'class="store-image" ' +
                       'alt="' + selectedStore.storeName + '" ' +
                       'onerror="this.src=\'' + CONTEXT_PATH + '/images/default-store.png\'; this.onerror=null;">';
        } else {
            imageHtml = '<img src="' + CONTEXT_PATH + '/images/default-store.png" ' +
                       'class="store-image" alt="기본 이미지">';
        }
        
        modalContent.innerHTML = 
            imageHtml +
            '<div class="store-info">' +
            '<p><strong>가게명:</strong> ' + selectedStore.storeName + '</p>' +
            '<p><strong>카테고리:</strong> ' + selectedStore.category + '</p>' +
            '<p><strong>주소:</strong> ' + selectedStore.addr + '</p>' +
            '<p><strong>평점:</strong> ⭐ ' + selectedStore.rating + ' / 5</p>' +
            '</div>';
        
        winnerModal.classList.add('show');
    }

    function goToStoreDetail() {
        if (selectedStore && selectedStore.storeId) {
            location.href = CONTEXT_PATH + '/storeDetail.do?id=' + encodeURIComponent(selectedStore.storeId);
        }
    }

    mainBtn.onclick = () => {
        if (gameState === 'SPIN') {
            gameState = 'STOPPING';
            mainBtn.style.display = 'none';
        } else if (gameState === 'FINISHED') {
            location.reload();
        }
    };

    try {
        init(); 
        animate();
    } catch (error) {
        console.error('초기화 오류:', error);
        alert('페이지 로딩 중 오류가 발생했습니다: ' + error.message);
    }
</script>

</body>
</html>