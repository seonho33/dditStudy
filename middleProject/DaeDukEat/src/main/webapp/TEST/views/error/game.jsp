<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>맛집통행증검문소 | The Gourmet Inspector</title>
    <style>
        /* =============================================
           Papers, Please 완벽 재현
        ============================================= */
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            image-rendering: pixelated;
            image-rendering: -moz-crisp-edges;
            image-rendering: crisp-edges;
        }
        
        body {
            font-family: 'Courier New', monospace;
            background: #1a1a1a;
            color: #d4d4d4;
            overflow-x: hidden;
        }
        
        /* 배경 이미지 */
        .custom-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-image: url('${pageContext.request.contextPath}/resources/images/동무먹으라우.png'); 
            background-color: #2a2a2a;
            opacity: 0.5;
        }
        
        /* CRT 스캔라인 */
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
            background-size: 100% 3px;
            pointer-events: none;
            z-index: 1000;
            animation: scanline 10s linear infinite;
        }
        
        @keyframes scanline {
            0% { background-position: 0 0; }
            100% { background-position: 0 100%; }
        }
        
        /* 노이즈 */
        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.03'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 999;
            opacity: 0.25;
            animation: noiseAnim 0.2s infinite;
        }
        
        @keyframes noiseAnim {
            0%, 100% { opacity: 0.25; }
            50% { opacity: 0.28; }
        }
        
        .game-container {
            max-width: 980px;
            margin: 15px auto;
            padding: 6px;
            background: rgba(64, 58, 48, 0.92);
            border: 10px solid #1a1a1a;
            box-shadow: 
                inset 0 0 30px rgba(0,0,0,0.6),
                0 0 50px rgba(0, 0, 0, 0.9);
        }
        
        /* 헤더 */
        .header {
            text-align: center;
            background: linear-gradient(180deg, #4a3030 0%, #3a2020 100%);
            padding: 18px;
            border: 6px solid #1a1a1a;
            margin-bottom: 12px;
            box-shadow: inset 0 0 20px rgba(0,0,0,0.6);
            position: relative;
        }
        
        .header::before, .header::after {
            content: "★";
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            font-size: 28px;
            color: #c4a040;
            text-shadow: 2px 2px 4px #000;
        }
        
        .header::before { left: 15px; }
        .header::after { right: 15px; }
        
        .title {
            font-size: 22px;
            color: #c4a040;
            text-shadow: 
                2px 2px 0 #000,
                3px 3px 0 rgba(0,0,0,0.6),
                0 0 10px rgba(196, 160, 64, 0.3);
            letter-spacing: 4px;
            font-weight: bold;
        }
        
        .subtitle {
            font-size: 10px;
            color: #999;
            margin-top: 6px;
            letter-spacing: 2px;
        }
        
        /* 책상 영역 */
        .desk-area {
            background: 
                linear-gradient(90deg, 
                    rgba(70, 60, 50, 0.85) 0%,
                    rgba(60, 50, 40, 0.85) 50%,
                    rgba(70, 60, 50, 0.85) 100%);
            padding: 25px;
            border: 8px solid #2a2a1a;
            min-height: 560px;
            position: relative;
            box-shadow: 
                inset 0 0 40px rgba(0,0,0,0.8),
                inset 0 10px 20px rgba(0,0,0,0.4);
            overflow: hidden;
        }
        
        /* 책상 나무 결 */
        .desk-area::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                repeating-linear-gradient(
                    90deg,
                    transparent 0px,
                    rgba(40, 30, 20, 0.1) 40px,
                    transparent 80px
                );
            pointer-events: none;
        }
        
        /* 말풍선 */
        .speech-bubble {
            position: absolute;
            top: 15px;
            left: 50%;
            transform: translateX(-50%);
            background: #f4e8d8;
            border: 5px solid #2a2a2a;
            padding: 12px 22px;
            font-size: 15px;
            font-weight: bold;
            color: #1a1a1a;
            box-shadow: 5px 5px 0 rgba(0,0,0,0.6);
            z-index: 200;
            opacity: 0;
            animation: bubbleAppear 0.25s forwards;
            white-space: nowrap;
        }
        
        .speech-bubble::after {
            content: "";
            position: absolute;
            bottom: -18px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 14px solid transparent;
            border-right: 14px solid transparent;
            border-top: 18px solid #2a2a2a;
        }
        
        .speech-bubble::before {
            content: "";
            position: absolute;
            bottom: -11px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-top: 13px solid #f4e8d8;
            z-index: 1;
        }
        
        @keyframes bubbleAppear {
            0% {
                opacity: 0;
                transform: translateX(-50%) scale(0.7);
            }
            100% {
                opacity: 1;
                transform: translateX(-50%) scale(1);
            }
        }
        
        /* 서류 컨테이너 */
        .document-container {
            position: relative;
            width: 580px;
            height: 450px;
            margin: 50px auto 20px;
            perspective: 1000px;
        }
        
        /* 서류 스택 (뒤에 보이는 서류들) */
        .document-stack-bg {
            position: absolute;
            width: 100%;
            height: 100%;
        }
        
        .stack-paper {
            position: absolute;
            width: 580px;
            height: 450px;
            background: linear-gradient(135deg, #d8ccc0 0%, #c8bcb0 100%);
            border: 4px solid #2a2a2a;
            opacity: 0.4;
        }
        
        .stack-paper:nth-child(1) {
            transform: translate(10px, 10px) rotate(2deg);
        }
        
        .stack-paper:nth-child(2) {
            transform: translate(5px, 5px) rotate(-1deg);
        }
        
        /* 메인 서류 */
        .document {
            position: absolute;
            width: 580px;
  			background: linear-gradient(135deg, #f6f0e6 0%, #eadfce 100%);
            border: 6px solid #2a2a2a;
            padding: 28px;
			box-shadow:
			    12px 12px 0 rgba(0, 0, 0, 0.65),
			    inset 0 0 40px rgba(139, 90, 43, 0.08);
            font-size: 13px;
            color: #1a1a1a;
            z-index: 50;
            transform-origin: center center;
              filter: brightness(1.07) contrast(1.10);
        }
        
        /* 서류 입장 애니메이션 (오른쪽에서) */
        .document.slide-in {
            animation: slideInFromRight 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        }
        
        @keyframes slideInFromRight {
            0% {
                transform: translateX(800px) rotate(5deg);
                opacity: 0;
            }
            100% {
                transform: translateX(0) rotate(-1deg);
                opacity: 1;
            }
        }
        
        /* 서류 퇴장 애니메이션 (왼쪽으로) */
        .document.slide-out {
            animation: slideOutToLeft 0.6s cubic-bezier(0.55, 0.085, 0.68, 0.53) forwards;
            pointer-events: none;
        }
        
        @keyframes slideOutToLeft {
            0% {
                transform: translateX(0) rotate(-1deg);
                opacity: 1;
            }
            100% {
                transform: translateX(-900px) rotate(-12deg);
                opacity: 0;
            }
        }
        
        /* 종이 구김/얼룩 효과 */
        .document::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 18% 28%, rgba(100, 60, 30, 0.18) 0%, transparent 35%),
                radial-gradient(circle at 82% 72%, rgba(100, 60, 30, 0.15) 0%, transparent 38%),
                radial-gradient(circle at 45% 55%, rgba(100, 60, 30, 0.08) 0%, transparent 45%),
                radial-gradient(circle at 65% 25%, rgba(100, 60, 30, 0.12) 0%, transparent 30%);
            pointer-events: none;
        }
        
        /* 종이 접힌 자국 */
        .document::after {
            content: "";
            position: absolute;
            top: 48%;
            left: -6px;
            right: -6px;
            height: 3px;
            background: rgba(80, 50, 30, 0.15);
            box-shadow: 0 1px 0 rgba(255, 255, 255, 0.1);
        }
        
        .document-header {
            background: linear-gradient(180deg, #3a2a2a 0%, #2a1a1a 100%);
            color: #d4c8b0;
            padding: 14px;
            text-align: center;
            font-size: 17px;
            font-weight: bold;
            border: 5px solid #1a1a1a;
            margin: -28px -28px 22px -28px;
            letter-spacing: 5px;
            box-shadow: 0 6px 0 rgba(0,0,0,0.6);
            position: relative;
        }
        
        .document-header::before {
            content: "◆";
            position: absolute;
            left: 12px;
            color: #c4a040;
            font-size: 14px;
        }
        
        .document-header::after {
            content: "◆";
            position: absolute;
            right: 12px;
            color: #c4a040;
            font-size: 14px;
        }
        
        .doc-number {
            text-align: right;
            font-size: 10px;
            color: #5a5a5a;
            margin-bottom: 14px;
            border-bottom: 3px solid #9a8a7a;
            padding-bottom: 7px;
            font-weight: bold;
        }
        
        .doc-layout {
            display: flex;
            gap: 18px;
        }
        
        .doc-photo {
            flex-shrink: 0;
            width: 130px;
            height: 150px;
            border: 5px solid #2a2a2a;
            background: 
                linear-gradient(135deg, #8a7a6a 0%, #7a6a5a 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            color: #5a5a5a;
            position: relative;
            box-shadow: inset 0 0 30px rgba(0,0,0,0.4);
            overflow: hidden;
        }
        
        .doc-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .doc-photo::before {
            content: "🍴";
            font-size: 52px;
            opacity: 0.25;
            position: absolute;
        }
        
        .doc-photo-text {
            position: relative;
            z-index: 1;
            text-align: center;
            font-weight: bold;
        }
        
        .doc-info {
            flex: 1;
        }
        
        .info-row {
            padding: 10px 6px;
            border-bottom: 2px dotted #8a7a6a;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: bold;
            color: #2a2a2a;
            min-width: 100px;
            font-size: 12px;
        }
        
        .info-value {
            font-weight: bold;
            color: #1a1a1a;
            text-align: right;
            flex: 1;
        }
        
        .grade-badge {
            display: inline-block;
            padding: 5px 18px;
            background: #4a4a4a;
            color: #fff;
            border: 4px solid #2a2a2a;
            font-weight: bold;
            font-size: 13px;
            box-shadow: 3px 3px 0 rgba(0,0,0,0.5);
        }
        
        .grade-A { background: #4a8a4a; }
        .grade-B { background: #4a6a8a; }
        .grade-C { background: #8a8a4a; color: #1a1a1a; }
        .grade-D { background: #8a4a4a; }
        
        .doc-signature {
            margin-top: 18px;
            padding-top: 14px;
            border-top: 3px double #8a7a6a;
            text-align: right;
            font-style: italic;
            font-size: 12px;
            color: #3a3a3a;
        }
        
        /* 도장 영역 */
        .stamp-area {
            display: flex;
            justify-content: center;
            gap: 50px;
            margin-top: 25px;
            position: relative;
            z-index: 60;
        }
        
        /* 도장 - Papers, Please 스타일 긴 직사각형 */
        .stamp {
            width: 200px;
            height: 75px;
            border: 7px solid;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            box-shadow: 
                0 8px 0 rgba(0,0,0,0.6),
                inset 0 0 20px rgba(0,0,0,0.4);
            transition: all 0.08s;
            line-height: 1.35;
            font-size: 12px;
            position: relative;
        }
        
        .stamp::before {
            content: "";
            position: absolute;
            inset: 4px;
            border: 2px solid;
            opacity: 0.3;
        }
        
        .stamp:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 13px 0 rgba(0,0,0,0.6),
                inset 0 0 20px rgba(0,0,0,0.4);
        }
        
        .stamp:active {
            transform: translateY(3px);
            box-shadow: 
                0 3px 0 rgba(0,0,0,0.6),
                inset 0 0 20px rgba(0,0,0,0.4);
        }
        
        .stamp-approved { 
            background: linear-gradient(180deg, #5a9a5a 0%, #4a8a4a 100%);
            border-color: #2a5a2a; 
            color: #1a3a1a; 
        }
        
        .stamp-approved::before {
            border-color: #1a3a1a;
        }
        
        .stamp-denied { 
            background: linear-gradient(180deg, #9a5a5a 0%, #8a4a4a 100%);
            border-color: #5a2a2a; 
            color: #3a1a1a; 
        }
        
        .stamp-denied::before {
            border-color: #3a1a1a;
        }
        
        /* 도장 찍힌 마크 - 긴 직사각형 */
        .stamp-mark {
            position: absolute;
            width: 220px;
            height: 85px;
            border: 8px solid;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            pointer-events: none;
            z-index: 120;
            opacity: 0.82;
            animation: stampSlam 0.25s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            padding: 8px;
            text-align: center;
            line-height: 1.3;
            box-shadow: 
                0 0 40px rgba(0,0,0,0.6),
                inset 0 0 30px rgba(0,0,0,0.3);
        }
        
        .stamp-mark::before {
            content: "";
            position: absolute;
            inset: 3px;
            border: 3px solid;
            opacity: 0.25;
        }
        
        .stamp-mark-approved {
            background: 
                radial-gradient(ellipse at center, 
                    rgba(74, 138, 74, 0.95) 0%, 
                    rgba(74, 138, 74, 0.75) 70%);
            border-color: #2a5a2a;
            color: #1a3a1a;
        }
        
        .stamp-mark-approved::before {
            border-color: #1a3a1a;
        }
        
        .stamp-mark-denied {
            background: 
                radial-gradient(ellipse at center, 
                    rgba(138, 74, 74, 0.95) 0%, 
                    rgba(138, 74, 74, 0.75) 70%);
            border-color: #5a2a2a;
            color: #3a1a1a;
        }
        
        .stamp-mark-denied::before {
            border-color: #3a1a1a;
        }
        
        /* 도장 찍는 애니메이션 */
        @keyframes stampSlam {
            0% {
                transform: translate(-50%, -50%) rotate(-30deg) scale(0.4);
                opacity: 0;
            }
            60% {
                transform: translate(-50%, -50%) rotate(-8deg) scale(1.12);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -50%) rotate(-12deg) scale(1);
                opacity: 0.82;
            }
        }
        
        .stamp-mark-title {
            font-size: 22px;
            margin-bottom: 3px;
            border-bottom: 3px solid;
            padding-bottom: 3px;
            width: 100%;
            letter-spacing: 2px;
        }
        
        .stamp-mark-message {
            font-size: 11px;
            line-height: 1.25;
            margin-top: 3px;
            font-weight: bold;
        }
        
        /* 잉크 번짐 효과 강화 */
        .ink-splatter {
            position: absolute;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 18%, rgba(0,0,0,0.22) 0%, transparent 28%),
                radial-gradient(circle at 85% 25%, rgba(0,0,0,0.18) 0%, transparent 24%),
                radial-gradient(circle at 25% 82%, rgba(0,0,0,0.2) 0%, transparent 26%),
                radial-gradient(circle at 75% 78%, rgba(0,0,0,0.16) 0%, transparent 22%);
            pointer-events: none;
        }
        
        /* 버튼 */
        .button-area {
            text-align: center;
            margin-top: 18px;
        }
        
        .pixel-button {
            background: linear-gradient(180deg, #5a4a4a 0%, #4a3a3a 100%);
            color: #d4c8b0;
            border: 5px solid #2a2a2a;
            font-size: 14px;
            font-family: 'Courier New', monospace;
            cursor: pointer;
            transition: all 0.08s;
            box-shadow: 
                7px 7px 0 #1a1a1a,
                inset 0 0 15px rgba(0,0,0,0.4);
            font-weight: bold;
            letter-spacing: 2px;
        }
        
        .pixel-button:hover {
            background: linear-gradient(180deg, #6a5a5a 0%, #5a4a4a 100%);
            transform: translate(-2px, -2px);
            box-shadow: 
                9px 9px 0 #1a1a1a,
                inset 0 0 15px rgba(0,0,0,0.4);
        }
        
        .pixel-button:active {
            transform: translate(3px, 3px);
            box-shadow: 
                4px 4px 0 #1a1a1a,
                inset 0 0 15px rgba(0,0,0,0.4);
        }
        
        /* 통계 */
        .stats {
            background: linear-gradient(180deg, #3a2a2a 0%, #2a1a1a 100%);
            padding: 14px;
            margin-top: 18px;
            border: 5px solid #1a1a1a;
            text-align: center;
            color: #c4b8a0;
            font-size: 13px;
            box-shadow: inset 0 0 20px rgba(0,0,0,0.6);
        }
        
        .stat-item {
            display: inline-block;
            margin: 0 25px;
        }
        
        .stat-value {
            color: #c4a040;
            font-weight: bold;
            font-size: 19px;
            text-shadow: 0 0 8px rgba(196, 160, 64, 0.4);
        }
        
        /* 숨김 */
        .hidden {
            display: none;
        }
        
/* ✅ 강제 숨김/표시 */
.force-hidden { display:none !important; }
.force-show { display:flex !important; } /* button-row에서 flex로 맞춤 */
        
        /* 메시지 박스 */
        .message-box {
            background: linear-gradient(180deg, #3a2a2a 0%, #2a1a1a 100%);
            color: #c4a040;
            padding: 16px;
            margin: 12px 0;
            border: 5px solid #1a1a1a;
            text-align: center;
            font-size: 13px;
            min-height: 55px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 20px rgba(0,0,0,0.6);
            font-weight: bold;
            letter-spacing: 1px;
        }
        
        /* ✅ 합격 후 '가게로 이동' 버튼 (통행증/승인 느낌) */
.passport-button {
  background: linear-gradient(180deg, #c4a040 0%, #a8842f 100%);
  color: #1a1a1a;
  border: 5px solid #2a2a2a;
  padding: 14px 34px;
  font-size: 13px;
  font-family: 'Courier New', monospace;
  cursor: pointer;
  transition: all 0.08s;
  box-shadow:
    7px 7px 0 #1a1a1a,
    inset 0 0 18px rgba(0,0,0,0.35);
  font-weight: 900;
  letter-spacing: 1px;
  text-transform: uppercase;
  position: relative;
}

/* 안쪽 테두리(서류/도장 감성) */
.passport-button::before {
  content: "";
  position: absolute;
  inset: 5px;
  border: 2px solid rgba(26,26,26,0.35);
  pointer-events: none;
}

/* 작은 도장 느낌 */
.passport-button::after {
  content: "APPROVED";
  position: absolute;
  top: -10px;
  right: 10px;
  transform: rotate(-8deg);
  font-size: 10px;
  padding: 4px 8px;
  background: rgba(74,138,74,0.92);
  border: 3px solid #1a3a1a;
  color: #102410;
  box-shadow: 3px 3px 0 rgba(0,0,0,0.55);
  letter-spacing: 1px;
}

/* 호버/클릭 */
.passport-button:hover {
  transform: translate(-2px, -2px);
  box-shadow:
    9px 9px 0 #1a1a1a,
    inset 0 0 18px rgba(0,0,0,0.35);
}

.passport-button:active {
  transform: translate(3px, 3px);
  box-shadow:
    4px 4px 0 #1a1a1a,
    inset 0 0 18px rgba(0,0,0,0.35);
}

/* ✅ 합격 시 버튼 깜빡임(살짝) */
.passport-button.flash {
  animation: passportFlash 0.9s ease-in-out 2;
}

@keyframes passportFlash {
  0%, 100% { filter: brightness(1); }
  50% { filter: brightness(1.18); }
}
        
        /* 버튼 정렬용 행 */
.button-row{
  display:flex;
  justify-content:center;
  align-items:stretch;
  gap:14px;
}
/* ✅ 두 버튼 공통 베이스 */
.button-row .btn{
  height:58px;
  min-width: 260px;          /* 원하면 제거 가능 */
  display:flex;
  align-items:center;
  justify-content:center;
  white-space:nowrap;
  line-height:1;             /* ← 텍스트 때문에 높이 튀는거 방지 */
  padding:0 26px;            /* 세로 padding 제거 */
  box-sizing:border-box;
}

/* passport 버튼이 pixel 버튼보다 커 보이지 않게 조정 */
.passport-button {
  padding: 0 26px;           /* 세로 padding 제거 */
  font-size: 13px;
}
        
    </style>
    
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="custom-background" id="customBg"></div>
    
    <div class="game-container">
        <!-- 헤더 -->
        <div class="header">
            <div class="title">맛 집 통 행 증 검 문 소</div>
            <div class="subtitle">THE GOURMET INSPECTOR | 주체113년 5월 15일</div>
        </div>
        
        <!-- 메시지 영역 -->
        <div class="message-box" id="messageBox">
            동무! 아래 버튼을 눌러 첫 지원자를 맞이하시오!
        </div>
        
        <!-- 책상 영역 -->
        <div class="desk-area">
            <!-- 말풍선 -->
            <div class="speech-bubble hidden" id="speechBubble"></div>
            
            <!-- 서류 컨테이너 -->
            <div class="document-container" id="documentContainer">
                <!-- 배경 스택 -->
                <div class="document-stack-bg">
                    <div class="stack-paper"></div>
                    <div class="stack-paper"></div>
                </div>
                
                <!-- 메인 서류 영역 -->
                <div id="mainDocument"></div>
            </div>
            
            <!-- 도장 영역 -->
            <div class="stamp-area hidden" id="stampArea">
                <div class="stamp stamp-approved" onclick="applyStamp('approved')">
                    <div>
                        훌륭하오!<br/>
                        ─────<br/>
                        合 格
                    </div>
                </div>
                <div class="stamp stamp-denied" onclick="applyStamp('denied')">
                    <div>
                        불량하오!<br/>
                        ─────<br/>
                        不合格
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 버튼 영역 -->
<div class="button-area">
  <div class="button-row">
<button class="pixel-button btn" id="nextButton" onclick="nextApplicant()">
  ▶ 다음 동무 부르기 ◀
</button>

<button class="passport-button btn force-hidden" id="goStoreButton" onclick="goToStore()">
  ▶ 미각통행증 승인! 가게로 이동 ◀
</button>


  </div>
</div>


        
        <!-- 통계 -->
        <div class="stats">
            <span class="stat-item">처리: <span class="stat-value" id="totalCount">0</span></span>
            <span class="stat-item">합격: <span class="stat-value" id="approvedCount">0</span></span>
            <span class="stat-item">불합격: <span class="stat-value" id="deniedCount">0</span></span>
        </div>
    </div>

    <script>
    let audioCtx = null;

 // [1. BGM 설정 - 볼륨 대폭 축소]
    function initBGM() {
        if (!bgm) {
            bgm = new Audio(bgmPath);
            bgm.loop = true;
            bgm.volume = 0.15; // BGM을 아주 잔잔하게 설정 (0.1~0.2 권장)
        }
        if (bgm.paused) {
            bgm.play().catch(e => console.log("BGM 재생 대기 중..."));
        }
    }

    // [2. 도장 소리 - 출력 극대화 및 묵직한 튜닝]
    function playStampSound(type) {
        try {
            if (!audioCtx) {
                audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            }
            if (audioCtx.state === 'suspended') audioCtx.resume();

            const now = audioCtx.currentTime;
            const isApproved = (type === 'approved');

            // --- A. 도장 찍는 찰나 BGM 음소거에 가깝게 줄이기 (사이드체인) ---

            // --- B. 고음역 타격음 (찰칵 하는 날카로운 소리) ---
            const noise = audioCtx.createBufferSource();
            const buffer = audioCtx.createBuffer(1, audioCtx.sampleRate * 0.1, audioCtx.sampleRate);
            const data = buffer.getChannelData(0);
            for (let i = 0; i < data.length; i++) { data[i] = Math.random() * 2 - 1; }
            noise.buffer = buffer;

            const noiseFilter = audioCtx.createBiquadFilter();
            noiseFilter.type = 'lowpass';
            noiseFilter.frequency.setValueAtTime(isApproved ? 1200 : 800, now);

            const noiseGain = audioCtx.createGain();
            noiseGain.gain.setValueAtTime(4.0, now); // 노이즈 볼륨 강화
            noiseGain.gain.exponentialRampToValueAtTime(0.01, now + 0.1);

            noise.connect(noiseFilter);
            noiseFilter.connect(noiseGain);
            noiseGain.connect(audioCtx.destination);

            // --- C. 중저음역 "쾅" (핵심 본체 소리) ---
            const body = audioCtx.createOscillator();
            const bodyGain = audioCtx.createGain();
            body.type = 'square'; // 더 거칠고 꽉 찬 소리를 위해 square 파형 사용
            
            body.frequency.setValueAtTime(isApproved ? 150 : 120, now);
            body.frequency.exponentialRampToValueAtTime(40, now + 0.15);

            bodyGain.gain.setValueAtTime(5.0, now); // 핵심 타격음 볼륨 최대화
            bodyGain.gain.exponentialRampToValueAtTime(0.01, now + 0.2);

            body.connect(bodyGain);
            bodyGain.connect(audioCtx.destination);

            // --- D. 초저음 진동 (바닥이 울리는 소리) ---
            const sub = audioCtx.createOscillator();
            const subGain = audioCtx.createGain();
            sub.type = 'sine';
            sub.frequency.setValueAtTime(55, now); // 베이스 드럼 같은 초저역
            
            subGain.gain.setValueAtTime(3.0, now);
            subGain.gain.exponentialRampToValueAtTime(0.01, now + 0.3);

            sub.connect(subGain);
            subGain.connect(audioCtx.destination);

            // 모든 소리 시작
            noise.start(now);
            body.start(now);
            sub.start(now);
            
            noise.stop(now + 0.4);
            body.stop(now + 0.4);
            sub.stop(now + 0.4);

        } catch (e) {
            console.error("오디오 출력 오류:", e);
        }
    }
    
    
    function fetchUniqueRestaurant(maxRetry = 20) {
    	  return new Promise((resolve, reject) => {
    	    const tryFetch = (remain) => {
    	      $.ajax({
    	        url: contextPath + '/inspector/random',
    	        type: 'GET',
    	        dataType: 'json',
    	        success: function (response) {
    	          if (!response.success) {
    	            reject(response.message || '식당 데이터를 불러올 수 없습니다.');
    	            return;
    	          }

    	          const data = response.data;
    	          const id = data && data.storeId;

    	          if (!id) {
    	            reject('storeId가 없습니다.');
    	            return;
    	          }

    	          // ✅ 이미 본 가게면 다시 뽑기
    	          if (seenStoreIds.has(id)) {
    	            if (remain <= 0) {
    	              reject('더 이상 새로운 가게가 없습니다. (중복 제거로 소진)');
    	              return;
    	            }
    	            tryFetch(remain - 1);
    	            return;
    	          }

    	          // ✅ 처음 나온 가게면 기록하고 반환
    	          seenStoreIds.add(id);
    	          sessionStorage.setItem("seenStoreIds", JSON.stringify(Array.from(seenStoreIds)));
    	          resolve(data);
    	        },
    	        error: function () {
    	          reject('서버 연결에 실패했습니다.');
    	        }
    	      });
    	    };

    	    tryFetch(maxRetry);
    	  });
    	}

    
        // =============================================
        // 게임 데이터
        // =============================================
        
        const greetings = [
            "대령이요, 동무!",
            "보고하겠습니다!",
            "충성! 검토 준비 완료!",
            "명령만 내리시오!",
            "인민을 위해 복무!",
        ];
        
        const approvedMessages = [
            "훌륭한\\n식당이오!",
            "혁명의\\n맛이오!",
            "모범적\\n식당!",
            "인민을 위한\\n봉사정신!",
            "수령님도\\n기뻐하실 맛!",
            "당의 방침에\\n부합하오!",
        ];
        
        const deniedMessages = [
            "형편없는\\n음식이오!",
            "위생불량!\\n재교육!",
            "인민을\\n속이려 하오?",
            "반동분자의\\n음식!",
            "즉각 문을\\n닫으시오!",
            "수치스러운\\n맛이오!",
        ];
        
        // =============================================
        // 게임 상태
        // =============================================
        
        let currentRestaurant = null;
     // ✅ 이미 나온 가게 ID 저장(새로고침하면 초기화)
        let seenStoreIds = new Set();

        // ✅ 새로고침해도 유지하고 싶으면(시연 안정성↑) 아래 3줄로 복원
        try {
          const saved = JSON.parse(sessionStorage.getItem("seenStoreIds") || "[]");
          seenStoreIds = new Set(saved);
        } catch(e) {}

        
        let approvedStoreId = null;

        let totalCount = 0;
        let approvedCount = 0;
        let deniedCount = 0;
        let isStamped = false;
        let docCounter = 1000;
        
        const contextPath = '${pageContext.request.contextPath}';
        
        // =============================================
        // 게임 로직
        // =============================================
        
        function showSpeechBubble(text) {
            const bubble = document.getElementById('speechBubble');
            bubble.textContent = text;
            bubble.classList.remove('hidden');
            setTimeout(() => bubble.classList.add('hidden'), 1800);
        }
        
        function createDocument(restaurant) {
            docCounter++;
            const doc = document.createElement('div');
            doc.className = 'document slide-in';

            // 사진 처리 (contextPath 추가)
            let photoHtml;
            if (restaurant.picture) {
                const imgPath = contextPath + restaurant.picture;
                photoHtml = `
                    <img src="${'$'}{imgPath}" alt="식당사진"
                         onerror="this.style.display='none'; this.nextElementSibling.style.display='block';" />
                    <div class="doc-photo-text" style="display:none;">
                        식당<br>대표<br>사진
                    </div>
                `;
            } else {
                photoHtml = '<div class="doc-photo-text">식당<br>대표<br>사진</div>';
            }

            doc.innerHTML = `
                <div class="document-header">[ 미 각 통 행 증 ]</div>
                <div class="doc-number">문서번호: DPRK-${'$'}{docCounter}-GT | 발급: 주체113년</div>

                <div class="doc-layout">
                    <div class="doc-photo">
                        ${'$'}{photoHtml}
                    </div>
                    <div class="doc-info">
                        <div class="info-row">
                            <span class="info-label">□ 식당명칭:</span>
                            <span class="info-value">${'$'}{restaurant.name}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">□ 대표메뉴:</span>
                            <span class="info-value">${'$'}{restaurant.menu}</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">□ 맛집등급:</span>
                            <span class="info-value">
                                <span class="grade-badge grade-${'$'}{restaurant.grade}">${'$'}{restaurant.grade}급</span>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">□ 인민평가:</span>
                            <span class="info-value">${'$'}{restaurant.rating} / 5.0</span>
                        </div>
                    </div>
                </div>

                <div class="doc-signature">신청인: ${'$'}{restaurant.owner} (印)</div>
            `;

            return doc;
        }

     // 1. 전역 변수 영역에 BGM 객체 추가
        let bgm = new Audio(contextPath + '/audio/동무.mp3'); // 경로 확인 필요
        bgm.loop = true; // 무한 반복
        bgm.volume = 0.5; // 배경음이므로 약간 낮게 설정

        function playBGM() {
            if (bgm.paused) {
                bgm.play().catch(e => console.log("BGM 재생 차단됨 (클릭 필요):", e));
            }
        }
        
        function nextApplicant() {
        	playBGM();
        	
            const mainDoc = document.getElementById('mainDocument');
            const currentDoc = mainDoc.querySelector('.document');
            
            // 도장 찍힌 서류가 있으면 치우기
            if (isStamped && currentDoc) {
                currentDoc.classList.add('slide-out');
                setTimeout(() => {
                    currentDoc.remove();
                    loadNewDocument();
                }, 600);
            } else if (!currentRestaurant) {
                // 첫 서류 로드
                loadNewDocument();
            }
        }
        
        function loadNewDocument() {
        	  const greeting = greetings[Math.floor(Math.random() * greetings.length)];
        	  showSpeechBubble(greeting);

        	  const goBtn2 = document.getElementById('goStoreButton');
        	  goBtn2.classList.add('force-hidden');
        	  goBtn2.classList.remove('force-show');
        	  approvedStoreId = null;

        	  fetchUniqueRestaurant(30)
        	    .then((data) => {
        	      currentRestaurant = data;

        	      const mainDoc = document.getElementById('mainDocument');
        	      const newDoc = createDocument(currentRestaurant);
        	      mainDoc.appendChild(newDoc);

        	      document.getElementById('stampArea').classList.remove('hidden');
        	      document.getElementById('stampArea').style.opacity = '1';
        	      document.getElementById('stampArea').style.pointerEvents = 'auto';
        	      document.getElementById('messageBox').textContent = '동무! 서류를 면밀히 검토하고 도장을 찍으시오!';
        	      document.getElementById('messageBox').style.color = '#c4a040';
        	      document.getElementById('nextButton').style.display = 'none';

        	      isStamped = false;
        	    })
        	    .catch((msg) => {
        	      alert(msg);
        	    });
        	}

        
        function applyStamp(type) {
            if (isStamped) return;
            
            isStamped = true;
            
            playStampSound(type); // 🔊 여기서 소리 재생!
            
            totalCount++;
            
            const mainDoc = document.getElementById('mainDocument');
            const currentDoc = mainDoc.querySelector('.document');
            
            if (!currentDoc || !currentRestaurant) return;
            
            // 도장 마크 생성
            const stampMark = document.createElement('div');
            
            // 위치 (중앙 근처 랜덤)
            const randomX = 48 + Math.random() * 4;
            const randomY = 45 + Math.random() * 10;
            const randomRotation = -18 + Math.random() * 36;
            
            stampMark.style.position = 'absolute';
            stampMark.style.left = randomX + '%';
            stampMark.style.top = randomY + '%';
            stampMark.style.transform = 'translate(-50%, -50%) rotate(' + randomRotation + 'deg)';
            
            let message = '';
            let isCorrect = false;
            
            if (type === 'approved') {
                approvedCount++;
                stampMark.className = 'stamp-mark stamp-mark-approved';
                message = approvedMessages[Math.floor(Math.random() * approvedMessages.length)];
                stampMark.innerHTML = `
                    <div class="ink-splatter"></div>
                    <div class="stamp-mark-title">合 格</div>
                    <div class="stamp-mark-message">${'$'}{message}</div>
                `;

                isCorrect = currentRestaurant.isGood;
            } else {
                deniedCount++;
                stampMark.className = 'stamp-mark stamp-mark-denied';
                message = deniedMessages[Math.floor(Math.random() * deniedMessages.length)];
                stampMark.innerHTML = `
                    <div class="ink-splatter"></div>
                    <div class="stamp-mark-title">不合格</div>
                    <div class="stamp-mark-message">${'$'}{message}</div>
                `;
                isCorrect = !currentRestaurant.isGood;
            }
            
            // 도장 찍기
            currentDoc.appendChild(stampMark);
            
            // 결과 메시지
            const messageBox = document.getElementById('messageBox');
            if (isCorrect) {
                messageBox.innerHTML = '<span style="font-size: 18px;">✓</span> 훌륭한 판단이오, 동무!';
                messageBox.style.color = '#5a9a5a';
            } else {
                const correctAction = currentRestaurant.isGood ? '합격' : '불합격';
                messageBox.innerHTML = '<span style="font-size: 18px;">✗</span> 잘못된 판단! 이 식당은 ' + correctAction + '이었소!';
                messageBox.style.color = '#9a5a5a';
            }
            
            // 통계 업데이트
            document.getElementById('totalCount').textContent = totalCount;
            document.getElementById('approvedCount').textContent = approvedCount;
            document.getElementById('deniedCount').textContent = deniedCount;
            
            // 도장 영역 비활성화
            document.getElementById('stampArea').style.opacity = '0.4';
            document.getElementById('stampArea').style.pointerEvents = 'none';
            
            // 서버에 판정 결과 전송 (선택사항)
            $.ajax({
                url: contextPath + '/inspector/judge',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    storeId: currentRestaurant.storeId,
                    decision: type,
                    isCorrect: isCorrect
                }),
                success: function(response) {
                    console.log('판정 기록 완료:', response);
                },
                error: function(xhr, status, error) {
                    console.error('판정 기록 실패:', error);
                }
            });
            
            // 불량하오(denied)일 때만 자동으로 다음 서류
document.getElementById('goStoreButton').classList.add('force-hidden');
document.getElementById('goStoreButton').classList.remove('force-show');
			approvedStoreId = null;

            
            if (type === 'denied') {
                setTimeout(() => {
                    currentDoc.classList.add('slide-out');
                    setTimeout(() => {
                        currentDoc.remove();
                        loadNewDocument();
                    }, 400);
                }, 400);
            }
            
            // 훌륭하오(approved)일 때는 버튼 표시
            if (type === 'approved') {
            	  // 기존 로직 유지
            	  document.getElementById('nextButton').style.display = 'block';
            	  document.getElementById('nextButton').textContent = '▶ 다음 동무 부르기 ◀';

            	  // ✅ '가게로 이동' 버튼 표시
            	  approvedStoreId = currentRestaurant.storeId;
            	  const goBtn = document.getElementById('goStoreButton');
            	  goBtn.classList.remove('force-hidden');
            	  goBtn.classList.add('force-show');
            	  goBtn.classList.add('flash');
            	  setTimeout(() => goBtn.classList.remove('flash'), 1800);
            	}

        }
        
        // 초기화
window.onload = function() {
  const goBtn = document.getElementById('goStoreButton');
  goBtn.classList.add('force-hidden');
  goBtn.classList.remove('force-show');
};

        
        function goToStore() {
        	  if (!approvedStoreId) return;

        	  // ✅ 너희 가게 상세페이지 URL로 바꿔
        	  // 예) /store/detail.do?storeId=STORE017
        	  const url = contextPath + '/storeDetail.do?id=' + encodeURIComponent(approvedStoreId);
        	  window.location.href = url;
        	}
    </script>
</body>
</html>
