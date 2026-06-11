<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대덕머먹지 게임존 | DaeDukEat Game Arcade</title>
    
    <style>
        /* =============================================
           CRITICAL: 레트로 아케이드 베이스 스타일
        ============================================= */
        
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            image-rendering: pixelated;
            image-rendering: -moz-crisp-edges;
            image-rendering: crisp-edges;
        }
        
        body {
            font-family: 'Press Start 2P', 'Courier New', monospace;
            background: #0a0a0a;
            color: #00ff00;
            overflow-x: hidden;
            min-height: 100vh;
            position: relative;
        }
        
        /* CRT 스캔라인 효과 */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                rgba(18, 16, 16, 0) 50%, 
                rgba(0, 0, 0, 0.25) 50%
            );
            background-size: 100% 4px;
            pointer-events: none;
            z-index: 9999;
            animation: scanline 8s linear infinite;
        }
        
        @keyframes scanline {
            0% { background-position: 0 0; }
            100% { background-position: 0 100%; }
        }
        
        /* CRT 곡면 왜곡 효과 */
        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(ellipse at center, transparent 0%, rgba(0,0,0,0.3) 100%);
            pointer-events: none;
            z-index: 9998;
        }
        
        /* 배경 그리드 애니메이션 */
        .grid-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                linear-gradient(0deg, transparent 24%, rgba(0, 255, 255, 0.05) 25%, rgba(0, 255, 255, 0.05) 26%, transparent 27%, transparent 74%, rgba(0, 255, 255, 0.05) 75%, rgba(0, 255, 255, 0.05) 76%, transparent 77%, transparent),
                linear-gradient(90deg, transparent 24%, rgba(0, 255, 255, 0.05) 25%, rgba(0, 255, 255, 0.05) 26%, transparent 27%, transparent 74%, rgba(0, 255, 255, 0.05) 75%, rgba(0, 255, 255, 0.05) 76%, transparent 77%, transparent);
            background-size: 50px 50px;
            z-index: -1;
            animation: gridMove 20s linear infinite;
        }
        
        @keyframes gridMove {
            0% { background-position: 0 0; }
            100% { background-position: 50px 50px; }
        }
        
        /* =============================================
           헤더 영역 - 네온사인 효과
        ============================================= */
        
        .arcade-header {
            text-align: center;
            padding: 60px 20px 40px;
            position: relative;
            z-index: 10;
        }
        
        .neon-title {
            font-size: clamp(24px, 5vw, 48px);
            color: #fff;
            text-shadow: 
                0 0 10px #00ffff,
                0 0 20px #00ffff,
                0 0 30px #00ffff,
                0 0 40px #ff00ff,
                0 0 70px #ff00ff,
                0 0 80px #ff00ff,
                0 0 100px #ff00ff,
                0 0 150px #ff00ff;
            animation: neonFlicker 3s infinite alternate;
            letter-spacing: 4px;
            margin-bottom: 20px;
        }
        
        @keyframes neonFlicker {
            0%, 19%, 21%, 23%, 25%, 54%, 56%, 100% {
                text-shadow: 
                    0 0 10px #00ffff,
                    0 0 20px #00ffff,
                    0 0 30px #00ffff,
                    0 0 40px #ff00ff,
                    0 0 70px #ff00ff,
                    0 0 80px #ff00ff,
                    0 0 100px #ff00ff,
                    0 0 150px #ff00ff;
            }
            20%, 24%, 55% {
                text-shadow: none;
            }
        }
        
        .subtitle {
            font-size: clamp(10px, 2vw, 14px);
            color: #00ff00;
            letter-spacing: 2px;
            text-shadow: 0 0 5px #00ff00;
        }
        
        /* 동전 투입구 애니메이션 */
        .coin-slot {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            border: 3px solid #ffff00;
            color: #ffff00;
            font-size: 12px;
            text-shadow: 0 0 10px #ffff00;
            animation: coinBlink 1s infinite;
        }
        
        @keyframes coinBlink {
            0%, 50%, 100% { opacity: 1; }
            25%, 75% { opacity: 0.5; }
        }
        
        /* =============================================
           게임 카드 그리드
        ============================================= */
        
        .games-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 50px;
            position: relative;
            z-index: 10;
        }
        
        /* 게임 캐비닛 카드 */
        .game-cabinet {
            background: linear-gradient(180deg, #1a1a2e 0%, #0f0f1e 100%);
            border: 8px solid #2a2a4e;
            border-radius: 20px;
            padding: 0;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 
                0 10px 30px rgba(0, 0, 0, 0.8),
                inset 0 0 20px rgba(0, 255, 255, 0.1);
            cursor: pointer;
        }
        
        .game-cabinet:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: #00ffff;
            box-shadow: 
                0 20px 50px rgba(0, 255, 255, 0.4),
                inset 0 0 30px rgba(0, 255, 255, 0.2);
        }
        
        /* 게임 화면 영역 */
        .game-screen {
            height: 300px;
            background: #000;
            border: 6px solid #1a1a1a;
            margin: 20px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .game-screen::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                rgba(0, 255, 0, 0.03) 50%, 
                transparent 50%
            );
            background-size: 100% 4px;
            pointer-events: none;
            z-index: 1;
        }
        
        /* =============================================
           게임 아이콘 - GIF 크기 대폭 증가
        ============================================= */
        
        .game-icon {
            width: 95%;           /* 200px → 화면의 95% */
            height: 95%;          /* 게임 스크린을 거의 다 채움 */
            max-width: 320px;     /* 최대 크기 제한 */
            max-height: 280px;
            object-fit: contain;  /* 비율 유지하며 꽉 채움 */
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
        }
        
        /* 호버 시 확대 및 글로우 효과 */
        .game-cabinet:hover .game-icon {
            transform: scale(1.05);  /* 1.15 → 1.05로 줄임 (이미 크므로) */
            filter: brightness(1.3);
        }
        
        /* 각 게임별 글로우 효과 */
        .icon-inspector {
            filter: drop-shadow(0 0 25px #c4a040) drop-shadow(0 0 50px #c4a040);
        }
        
        .game-cabinet:hover .icon-inspector {
            filter: drop-shadow(0 0 40px #c4a040) drop-shadow(0 0 80px #c4a040) brightness(1.3);
        }
        
        .icon-random {
            filter: drop-shadow(0 0 25px #ff416c) drop-shadow(0 0 50px #ff416c);
        }
        
        .game-cabinet:hover .icon-random {
            filter: drop-shadow(0 0 40px #ff416c) drop-shadow(0 0 80px #ff416c) brightness(1.3);
        }
        
        .icon-roulette {
            filter: drop-shadow(0 0 25px #ffd700) drop-shadow(0 0 50px #ffd700);
        }
        
        .game-cabinet:hover .icon-roulette {
            filter: drop-shadow(0 0 40px #ffd700) drop-shadow(0 0 80px #ffd700) brightness(1.3);
        }
        
        /* 이미지 로딩 실패 시 대체 이모지 스타일 */
        .game-icon-fallback {
            font-size: 180px;     /* 120px → 180px */
            animation: iconFloat 3s ease-in-out infinite;
            position: relative;
            z-index: 2;
        }
        
        @keyframes iconFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        
        .game-icon-fallback.icon-inspector { 
            color: #c4a040; 
            text-shadow: 0 0 20px #c4a040; 
        }
        
        .game-icon-fallback.icon-random { 
            color: #ff416c; 
            text-shadow: 0 0 20px #ff416c; 
        }
        
        .game-icon-fallback.icon-roulette { 
            color: #ffd700; 
            text-shadow: 0 0 20px #ffd700; 
        }
        
        /* =============================================
           게임 정보 패널
        ============================================= */
        
        .game-info {
            padding: 30px;
            text-align: center;
        }
        
        .game-title {
            font-size: clamp(16px, 3vw, 24px);
            color: #00ffff;
            margin-bottom: 15px;
            text-shadow: 0 0 10px #00ffff;
            letter-spacing: 2px;
        }
        
        .game-description {
            font-size: 10px;
            color: #00ff00;
            line-height: 1.8;
            margin-bottom: 20px;
            text-shadow: 0 0 5px #00ff00;
        }
        
        /* 게임 태그 */
        .game-tags {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .tag {
            padding: 5px 12px;
            background: rgba(255, 255, 0, 0.1);
            border: 2px solid #ffff00;
            color: #ffff00;
            font-size: 8px;
            text-shadow: 0 0 5px #ffff00;
        }
        
        /* START 버튼 */
        .start-button {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(180deg, #ff0080 0%, #ff0040 100%);
            color: #fff;
            font-size: 14px;
            border: 4px solid #ff00ff;
            text-decoration: none;
            transition: all 0.2s;
            box-shadow: 
                0 0 10px #ff00ff,
                0 0 20px #ff00ff,
                inset 0 0 10px rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .start-button::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .start-button:hover::before {
            width: 300px;
            height: 300px;
        }
        
        .start-button:hover {
            transform: scale(1.1);
            box-shadow: 
                0 0 20px #ff00ff,
                0 0 40px #ff00ff,
                inset 0 0 20px rgba(255, 255, 255, 0.3);
        }
        
        .start-button:active {
            transform: scale(0.95);
        }
        
        /* 장식용 LED */
        .led-strip {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: linear-gradient(
                90deg,
                #ff0000 0%, #ff0000 12.5%,
                #ff7f00 12.5%, #ff7f00 25%,
                #ffff00 25%, #ffff00 37.5%,
                #00ff00 37.5%, #00ff00 50%,
                #0000ff 50%, #0000ff 62.5%,
                #4b0082 62.5%, #4b0082 75%,
                #9400d3 75%, #9400d3 87.5%,
                #ff0000 87.5%, #ff0000 100%
            );
            animation: ledScroll 2s linear infinite;
        }
        
        @keyframes ledScroll {
            0% { background-position: 0 0; }
            100% { background-position: 80px 0; }
        }
        
        /* =============================================
           하단 푸터
        ============================================= */
        
        .arcade-footer {
            text-align: center;
            padding: 40px 20px;
            margin-top: 60px;
            border-top: 2px solid #00ff00;
            position: relative;
            z-index: 10;
        }
        
        .credit-text {
            font-size: 10px;
            color: #00ff00;
            text-shadow: 0 0 5px #00ff00;
            margin-bottom: 10px;
        }
        
        .back-button {
            display: inline-block;
            padding: 12px 30px;
            background: rgba(0, 255, 0, 0.1);
            border: 3px solid #00ff00;
            color: #00ff00;
            text-decoration: none;
            font-size: 12px;
            transition: all 0.3s;
            text-shadow: 0 0 5px #00ff00;
            margin-top: 20px;
        }
        
        .back-button:hover {
            background: rgba(0, 255, 0, 0.2);
            box-shadow: 0 0 20px #00ff00;
            transform: scale(1.05);
        }
        
        /* =============================================
           반응형 미디어 쿼리
        ============================================= */
        
        @media (max-width: 768px) {
            .games-container {
                grid-template-columns: 1fr;
                gap: 30px;
                padding: 20px 10px;
            }
            
            .game-screen {
                height: 200px;
                margin: 15px;
            }
            
            .game-icon {
                max-width: 240px;
                max-height: 180px;
            }
            
            .game-info {
                padding: 20px;
            }
            
            .game-icon-fallback {
                font-size: 120px;
            }
        }
        
        /* =============================================
           로딩 애니메이션
        ============================================= */
        
        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #000;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            opacity: 1;
            transition: opacity 0.5s;
        }
        
        .loading-screen.hidden {
            opacity: 0;
            pointer-events: none;
        }
        
        .loading-text {
            font-size: 24px;
            color: #00ff00;
            text-shadow: 0 0 10px #00ff00;
            animation: loadingBlink 1s infinite;
        }
        
        @keyframes loadingBlink {
            0%, 50%, 100% { opacity: 1; }
            25%, 75% { opacity: 0.3; }
        }
        
        .audio-control {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 10001;
        background: rgba(0, 0, 0, 0.7);
        border: 2px solid #00ff00;
        color: #00ff00;
        padding: 5px 10px;
        cursor: pointer;
        font-size: 10px;
    }
</style>

<button class="audio-control" onclick="toggleBgm()">🔊 BGM ON</button>

</head>
<body>
<audio id="bgm" loop>
    <source src="${pageContext.request.contextPath}/audio/bgm.mp3" type="audio/mpeg">
    브라우저가 오디오 태그를 지원하지 않습니다.
</audio>

    <div class="grid-background"></div>
    
    <div class="loading-screen" id="loadingScreen">
        <div class="loading-text">LOADING...</div>
    </div>
    
    <header class="arcade-header">
        <h1 class="neon-title">대덕머먹지 게임존</h1>
        <p class="subtitle">DAEDUKEAT GAME ARCADE</p>
        <div class="coin-slot">▼ INSERT COIN ▼</div>
    </header>
    
    <main class="games-container">
        
		<!-- 게임 #1: 맛집통행증검문소 -->
		<article class="game-cabinet" onclick="location.href='${pageContext.request.contextPath}/inspector/game'">
		    <div class="game-screen">
		        <img src="${pageContext.request.contextPath}/images/upload/game/동무.gif" 
		             alt="Inspector Game Icon" 
		             class="game-icon icon-inspector"
		             onerror="this.outerHTML='<div class=\'game-icon-fallback icon-inspector\'>🛂</div>'">
		    </div>
		    <div class="game-info">
		        <h2 class="game-title">맛집통행증검문소</h2>
		        <p class="game-description">
		            동무! 서류를 면밀히 검토하고<br>
		            도장을 찍으시오!<br>
		            인민을 위한 봉사정신!
		        </p>
		        <div class="game-tags">
		            <span class="tag">INSPECTION</span>
		            <span class="tag">RETRO</span>
		            <span class="tag">SINGLE</span>
		        </div>
		        <a href="${pageContext.request.contextPath}/inspector/game" class="start-button">
		            <span style="position: relative; z-index: 1;">▶ START GAME</span>
		        </a>
		    </div>
		    <div class="led-strip"></div>
		</article>

        
		<!-- 게임 #2: 오늘 뭐먹지? -->
		<article class="game-cabinet" onclick="location.href='${pageContext.request.contextPath}/randomStore.do'">
		    <div class="game-screen">
		        <img src="${pageContext.request.contextPath}/images/upload/game/스포트라이트.gif" 
		             alt="Random Game Icon" 
		             class="game-icon icon-random"
		             onerror="this.outerHTML='<div class=\'game-icon-fallback icon-random\'>🎰</div>'">
		    </div>
		    <div class="game-info">
		        <h2 class="game-title">오늘 뭐먹지?</h2>
		        <p class="game-description">
		            고민 끝! 운명에 맡겨라!<br>
		            STOP 버튼으로 결정하는<br>
		            오늘의 맛집 추천!
		        </p>
		        <div class="game-tags">
		            <span class="tag">RANDOM</span>
		            <span class="tag">SLOT</span>
		            <span class="tag">FAST</span>
		        </div>
		        <a href="${pageContext.request.contextPath}/randomStore.do" class="start-button">
		            <span style="position: relative; z-index: 1;">▶ START GAME</span>
		        </a>
		    </div>
		    <div class="led-strip"></div>
		</article>
		        
		 <!-- 게임 #3: 영달 잭팟 룰렛 -->
		<article class="game-cabinet" onclick="location.href='${pageContext.request.contextPath}/StoreRoulette.do'">
		    <div class="game-screen">
		        <img src="${pageContext.request.contextPath}/images/upload/game/룰렛.gif" 
		             alt="Roulette Game Icon" 
		             class="game-icon icon-roulette"
		             onerror="this.outerHTML='<div class=\'game-icon-fallback icon-roulette\'>💎</div>'">
		    </div>
		    <div class="game-info">
		        <h2 class="game-title">영달 잭팟 룰렛</h2>
		        <p class="game-description">
		            별점 필터링 기능!<br>
		            다중 슬롯으로 동시에<br>
		            여러 맛집 잭팟 도전!
		        </p>
		        <div class="game-tags">
		            <span class="tag">JACKPOT</span>
		            <span class="tag">MULTI</span>
		            <span class="tag">VIP</span>
		        </div>
		        <a href="${pageContext.request.contextPath}/StoreRoulette.do" class="start-button">
		            <span style="position: relative; z-index: 1;">▶ START GAME</span>
		        </a>
		    </div>
		    <div class="led-strip"></div>
		</article>

        
    </main>
    
    <footer class="arcade-footer">
        <p class="credit-text">
            ⓒ 2025 DAEDUKEAT GAME ARCADE<br>
            ALL RIGHTS RESERVED
        </p>
        <a href="${pageContext.request.contextPath}/main.do" class="back-button">
            ◀ 메인으로 돌아가기
        </a>
    </footer>
    
    <script>
    
    function toggleBgm() {
        const bgm = document.getElementById('bgm');
        const btn = document.querySelector('.audio-control');
        if (bgm.paused) {
            bgm.play();
            btn.innerText = "🔊 BGM ON";
        } else {
            bgm.pause();
            btn.innerText = "🔇 BGM OFF";
        }
    }
    
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                document.getElementById('loadingScreen').classList.add('hidden');
            }, 500);
            
            console.log(`
    ╔══════════════════════════════════════╗
    ║   DAEDUKEAT GAME ARCADE LOADED      ║
    ║   버전: 1.0.0                        ║
    ║   개발: Legacy Full-Stack Architect  ║
    ╚══════════════════════════════════════╝
            `);
        });
        
        document.querySelectorAll('.game-cabinet').forEach(function(cabinet) {
            cabinet.addEventListener('mouseenter', function() {
                try {
                    var audioContext = new (window.AudioContext || window.webkitAudioContext)();
                    var oscillator = audioContext.createOscillator();
                    var gainNode = audioContext.createGain();
                    
                    oscillator.connect(gainNode);
                    gainNode.connect(audioContext.destination);
                    
                    oscillator.frequency.value = 800;
                    oscillator.type = 'square';
                    
                    gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
                    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.1);
                    
                    oscillator.start(audioContext.currentTime);
                    oscillator.stop(audioContext.currentTime + 0.1);
                } catch (e) {
                    console.log('Audio context requires user interaction');
                }
            });
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            const bgm = document.getElementById('bgm');
            bgm.volume = 0.3; // 너무 크지 않게 볼륨 조절 (0.0 ~ 1.0)

            // 사용자가 페이지를 처음 클릭하면 음악 재생 시작 (브라우저 정책 대응)
            const playBgm = () => {
                bgm.play().then(() => {
                    // 재생 성공 시 이벤트 리스너 제거
                    document.removeEventListener('click', playBgm);
                }).catch(error => {
                    console.log("자동 재생이 차단되었습니다. 클릭이 필요합니다.");
                });
            };

            document.addEventListener('click', playBgm);
            
            // 로딩 화면이 사라질 때 재생 시도 (일부 브라우저 허용)
            setTimeout(function() {
                document.getElementById('loadingScreen').classList.add('hidden');
            }, 500);
        });
    </script>
</body>
</html>