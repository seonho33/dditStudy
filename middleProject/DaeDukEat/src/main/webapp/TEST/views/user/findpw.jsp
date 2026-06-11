<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- ✅ type을 head에서 먼저 세팅 (스타일에서 쓰기 위해) -->
    <c:set var="type" value="${empty param.type ? 'user' : param.type}" />

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 비밀번호 재설정</title>

    <!-- EmailJS 라이브러리 불러오기 -->
    <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
    <script>
        // EmailJS 초기화 (사이트에서 복사한 Public Key 입력)
        emailjs.init("2R2lLwmO4nzTytIIa"); // Public Key 입력
    </script>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');

        /* ===== 색상 변수 (기본: user=주황 / seller=파랑) ===== */
        :root {
            --point-color: #f97316;
            --point-dark:  #ea580c;
            --point-soft:  rgba(249, 115, 22, 0.1);
        }
        <c:if test="${type eq 'seller'}">
        :root {
            --point-color: #3b82f6;
            --point-dark:  #1d4ed8;
            --point-soft:  rgba(59, 130, 246, 0.12);
        }
        </c:if>

        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f8fafc; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        .input-group { position: relative; margin-bottom: 1rem; }
        .input-style {
            width: 100%; background-color: #fff; border: 2px solid #e5e7eb; color: #1f2937;
            border-radius: 18px; padding: 1rem 1.2rem 1rem 3rem; font-weight: 700; outline: none; transition: all 0.3s;
        }
        /* ✅ 포커스 주황 → 변수 */
        .input-style:focus { border-color: var(--point-color); box-shadow: 0 0 0 4px var(--point-soft); }

        .input-icon { position: absolute; left: 1.2rem; top: 1.15rem; color: #9ca3af; font-size: 1.1rem; }

        /* ✅ 버튼 주황 → 변수 */
        .btn-orange { background-color: var(--point-color); color: #fff; transition: 0.3s; border-radius: 18px; font-weight: 900; }
        .btn-orange:hover { background-color: var(--point-dark); transform: translateY(-2px); }

        /* ✅ disabled도 seller일 때 톤 맞추기 (색만) */
        .btn-orange:disabled { background-color: var(--point-soft); cursor: wait; }

        /* 섹션 제어 (초기 상태 세팅) */
        #auth-section, #reset-section, #success-section { display: none; }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .animate-down { animation: slideDown 0.4s ease-out; }
    </style>
</head>

<body class="flex items-center justify-center min-h-screen p-6">

    <div class="w-full max-w-[480px]">
        <div class="text-center mb-8">
            <!-- ✅ 로고 색 주황 고정 → 변수 -->
            <h1 class="text-5xl b-grade-font italic tracking-tighter mb-2" style="color: var(--point-color);">D.D.M</h1>
            <p class="text-gray-400 font-black text-xs tracking-widest uppercase">Password Recovery</p>
        </div>

        <div class="bg-white p-10 rounded-[40px] shadow-xl border border-gray-100">
            <div id="find-step-1">
                <h2 class="text-2xl font-black text-gray-800 mb-2">비밀번호 찾기</h2>
                <p class="text-gray-400 text-sm mb-8 font-bold">아이디와 가입 이메일을 입력해 주세요.</p>

                <div class="input-group">
                    <i class="fa-solid fa-user-tag input-icon"></i>
                    <input type="text" id="userID" class="input-style" placeholder="아이디 입력">
                </div>

                <div class="flex gap-2 mb-4">
                    <div class="input-group flex-1 mb-0">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <input type="email" id="userEmail" class="input-style" placeholder="가입 이메일 주소">
                    </div>
                    <button onclick="sendAuthCode()" id="sendBtn" class="btn-orange px-6 text-sm shrink-0">
                        인증번호 전송
                    </button>
                </div>

                <div id="auth-section" class="space-y-4 animate-down">
                    <div class="input-group">
                        <i class="fa-solid fa-shield-halved input-icon"></i>
                        <input type="text" id="authCode" class="input-style" placeholder="인증번호 6자리" maxlength="6">
                        <!-- ✅ timer 주황 고정 → 변수 -->
                        <span id="timer" class="absolute right-4 top-4 font-black text-sm" style="color: var(--point-color);">03:00</span>
                    </div>
                    <button onclick="verifyAuthCode()" class="w-full py-4 btn-orange text-lg shadow-lg">인증 확인</button>
                </div>
            </div>

            <div id="reset-section" class="animate-down">
                <h2 class="text-2xl font-black text-gray-800 mb-2">비밀번호 재설정</h2>
                <p class="text-gray-400 text-sm mb-8 font-bold">새로운 비밀번호를 입력해 주세요.</p>
                <div class="input-group">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <input type="password" id="newPW" class="input-style" placeholder="새 비밀번호">
                </div>
                <div class="input-group">
                    <i class="fa-solid fa-circle-check input-icon"></i>
                    <input type="password" id="confirmPW" class="input-style" placeholder="비밀번호 확인">
                </div>
                <button onclick="updatePassword()" class="w-full py-4 btn-orange text-lg shadow-lg">비밀번호 변경 완료</button>
            </div>

            <div id="success-section" class="text-center py-4 animate-down">
                <!-- ✅ 성공 박스 오렌지 고정 → 변수 -->
                <div class="rounded-[30px] p-8 mb-6 border-2 border-dashed"
                     style="background-color: var(--point-soft); border-color: var(--point-color);">
                    <div class="text-5xl mb-4">🎉</div>
                    <!-- ✅ 텍스트 컬러 오렌지 고정 → 변수 -->
                    <p class="font-black text-xl mb-2" style="color: var(--point-dark);">변경 성공!</p>
                    <p class="text-gray-500 font-bold text-sm">새로운 비밀번호로 로그인하세요.</p>
                </div>
                <button class="w-full py-4 btn-orange text-lg" onclick="goToLogin()">로그인 하러가기</button>
            </div>
        </div>
    </div>

    <script>
        const EMAILJS_PUBLIC_KEY = "CvLtuOK6FxB63xa2g";
        const EMAILJS_SERVICE_ID = "service_19bgm5b";
        const EMAILJS_TEMPLATE_ID = "template_ib1q8nb";

        emailjs.init(EMAILJS_PUBLIC_KEY);
        let generatedCode = "";
        let timerInterval;

        function sendAuthCode() {
            const id = document.getElementById('userID').value.trim();
            const email = document.getElementById('userEmail').value.trim();
            const btn = document.getElementById('sendBtn');

            if(!id || !email) { alert("아이디와 이메일을 입력해주세요."); return; }

            document.getElementById('auth-section').style.display = 'block';

            generatedCode = Math.floor(100000 + Math.random() * 900000).toString();
            btn.innerText = "전송 중...";
            btn.disabled = true;

            emailjs.send(EMAILJS_SERVICE_ID, EMAILJS_TEMPLATE_ID, {
                to_email: email, to_name: id, auth_code: generatedCode
            }).then(() => {
                alert("인증번호가 발송되었습니다.");
                btn.innerText = "재전송";
                btn.disabled = false;
                startTimer();
            }, (err) => {
                alert("발송 실패");
                btn.disabled = false;
            });
        }

        function startTimer() {
            let timeLeft = 180;
            clearInterval(timerInterval);
            timerInterval = setInterval(() => {
                const min = Math.floor(timeLeft / 60);
                const sec = timeLeft % 60;
                document.getElementById('timer').innerText = min + ":" + (sec < 10 ? '0' : '') + sec;
                if(timeLeft <= 0) { clearInterval(timerInterval); alert("시간 초과!"); }
                timeLeft--;
            }, 1000);
        }

        function verifyAuthCode() {
            if(document.getElementById('authCode').value === generatedCode) {
                clearInterval(timerInterval);
                document.getElementById('find-step-1').style.display = 'none';
                document.getElementById('reset-section').style.display = 'block';
            } else {
                alert("인증번호가 일치하지 않습니다.");
            }
        }

        function updatePassword() {
            const pw = document.getElementById('newPW').value;
            const confirm = document.getElementById('confirmPW').value;

            if(pw !== confirm) {
                alert("비밀번호가 일치하지 않습니다.");
                return;
            }

            const id = document.getElementById('userID').value;

            fetch('updatePassword.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'userID=' + encodeURIComponent(id) + '&newPassword=' + encodeURIComponent(pw)
            })
            .then(response => response.text())
            .then(data => {
                if(data.trim() === 'success') {
                    document.getElementById('reset-section').style.display = 'none';
                    document.getElementById('success-section').style.display = 'block';
                } else {
                    alert('비밀번호 변경에 실패했습니다: ' + data);
                }
            })
            .catch(error => {
                console.error('에러:', error);
                alert('오류가 발생했습니다.');
            });
        }

        function goToLogin() {
            location.href = 'login.jsp';
        }
    </script>
</body>
</html>
