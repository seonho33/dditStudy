<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 아이디 찾기</title>
    <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8fafc; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        .input-group { position: relative; margin-bottom: 1rem; }
        .input-style {
            width: 100%; background-color: #fff; border: 2px solid #e5e7eb; color: #1f2937;
            border-radius: 18px; padding: 1rem 1.2rem 1rem 3rem; font-weight: 700; outline: none; transition: all 0.3s;
        }
        .input-style:focus { border-color: #f97316; box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1); }
        .input-icon { position: absolute; left: 1.2rem; top: 1.15rem; color: #9ca3af; font-size: 1.1rem; }
        .btn-orange { background-color: #f97316; color: #fff; transition: 0.3s; border-radius: 18px; font-weight: 900; }
        .btn-orange:hover { background-color: #ea580c; transform: translateY(-2px); }
        .btn-orange:disabled { background-color: #fed7aa; transform: none; cursor: wait; }
        
        /* 사용자님이 강조하신 인증 섹션 제어 */
        #auth-section { display: none; animation: slideDown 0.4s ease-out; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-6">

    <div class="w-full max-w-[480px]">
        <div class="text-center mb-8">
            <h1 class="text-5xl b-grade-font text-orange-500 italic tracking-tighter mb-2">D.D.M</h1>
            <p class="text-gray-400 font-black text-xs tracking-widest uppercase">ID Recovery System</p>
        </div>

        <div class="bg-white p-10 rounded-[40px] shadow-xl border border-gray-100">
            <div id="find-step-1">
                <h2 class="text-2xl font-black text-gray-800 mb-2">아이디 찾기</h2>
                <p class="text-gray-400 text-sm mb-8 font-bold">등록된 이름과 이메일 주소를 입력해 주세요.</p>

                <div class="input-group">
                    <i class="fa-solid fa-signature input-icon"></i>
                    <input type="text" id="userName" class="input-style" placeholder="이름 입력">
                </div>

                <div class="flex gap-2 mb-4">
                    <div class="input-group flex-1 mb-0">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <input type="email" id="userEmail" class="input-style" placeholder="받으실 이메일 주소">
                    </div>
                    <button onclick="sendAuthCode()" id="sendBtn" class="btn-orange px-6 text-sm shrink-0">
                        인증번호 전송
                    </button>
                </div>

                <div id="auth-section" class="space-y-4">
                    <div class="input-group">
                        <i class="fa-solid fa-shield-halved input-icon"></i>
                        <input type="text" id="authCode" class="input-style" placeholder="메일로 온 번호 6자리" maxlength="6">
                        <span id="timer" class="absolute right-4 top-4 text-orange-500 font-black text-sm">03:00</span>
                    </div>
                    <button onclick="verifyAndFind()" class="w-full py-4 btn-orange text-lg shadow-lg">인증 완료</button>
                </div>
            </div>

            <div id="find-result" class="hidden text-center py-4">
                <div class="bg-orange-50 rounded-[30px] p-8 mb-6 border-2 border-dashed border-orange-200">
                    <h3 id="displayID" class="text-3xl font-black text-gray-900 tracking-tight"></h3>
                    <p class="text-orange-600 font-bold text-sm mt-2">아이디 조회가 완료되었습니다!</p>
                </div>
                <button class="w-full py-4 btn-orange text-lg" onclick="location.reload()">처음으로 돌아가기</button>
            </div>
        </div>
    </div>

    <script>
        emailjs.init("CvLtuOK6FxB63xa2g");

        let generatedCode = "";
        let timerInterval;

        // [수정된 로직] 전송 버튼 클릭 시 즉시 화면 전환 및 이메일 발송
        function sendAuthCode() {
            const name = document.getElementById('userName').value.trim();
            const email = document.getElementById('userEmail').value.trim();
            const btn = document.getElementById('sendBtn');
            const authSection = document.getElementById('auth-section');

            if(!name || !email) {
                alert("이름과 이메일을 모두 입력해주세요.");
                return;
            }

            // 1. 즉시 인증 섹션 노출 (사용자님이 원하신 부분)
            authSection.style.display = 'block';
            btn.innerText = "전송 중...";
            btn.disabled = true;

            // 2. 난수 생성 및 발송
            generatedCode = Math.floor(100000 + Math.random() * 900000).toString();

            emailjs.send("service_19bgm5b", "template_ib1q8nb", {
                to_email: email,
                to_name: name,
                auth_code: generatedCode
            }).then(() => {
                alert("성공! 인증번호가 전송되었습니다.");
                btn.innerText = "재전송";
                btn.disabled = false;
                startTimer();
            }, (error) => {
                alert("발송 실패. 다시 시도해 주세요.");
                btn.disabled = false;
            });
        }

        function startTimer() {
            let timeLeft = 180;
            clearInterval(timerInterval);
            timerInterval = setInterval(() => {
                const min = Math.floor(timeLeft / 60);
                const sec = timeLeft % 60;
                document.getElementById('timer').innerText = `${min}:${sec < 10 ? '0' : ''}${sec}`;
                if(timeLeft <= 0) { clearInterval(timerInterval); alert("시간 초과!"); }
                timeLeft--;
            }, 1000);
        }

        function verifyAndFind() {
            const inputCode = document.getElementById('authCode').value;
            if(inputCode !== generatedCode || generatedCode === "") {
                alert("인증번호가 일치하지 않습니다.");
                return;
            }
            
            clearInterval(timerInterval);
            
            // 3. 인증 성공 시 화면 전환 및 결과 노출
            document.getElementById('find-step-1').classList.add('hidden');
            document.getElementById('find-result').classList.remove('hidden');
            
            // 실제 환경에서는 여기서 Ajax나 Form submit으로 DB의 아이디를 가져와야 합니다.
            // 임시로 하드코딩된 아이디를 보여줍니다.
            document.getElementById('displayID').innerText = "ddm_admin****";
        }
    </script>
</body>
</html>