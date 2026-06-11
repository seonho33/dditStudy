<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로 맛잘러 영달봇 | 대덕인재개발원</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 기존 스타일 유지 + 보완 */
        body { font-family: 'Pretendard', sans-serif; background-color: #fff5eb; margin: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }
        
        .chat-container {
            width: 950px; height: 90vh; background-color: white; border-radius: 30px;
            box-shadow: 0 20px 60px rgba(255, 126, 0, 0.15); display: flex; flex-direction: column;
            overflow: hidden; border: 2px solid #ff7e00; position: relative;
        }

        /* 헤더 디자인 강화 */
        .header { background: linear-gradient(135deg, #ff9d00, #ff5e00); color: white; padding: 35px; text-align: center; }
        
        /* [추가] 관리자용 빠른 복귀 버튼 */
        .admin-back-btn {
            position: absolute; right: 30px; top: 35px;
            background: rgba(0,0,0,0.2); color: white; padding: 10px 15px;
            border-radius: 12px; font-size: 0.9rem; font-weight: 800; text-decoration: none;
            transition: 0.3s;
        }
        .admin-back-btn:hover { background: #000; }

        /* 채팅창 내부 스타일 */
        #chat-window { flex: 1; padding: 40px; overflow-y: auto; background-color: #ffffff; scroll-behavior: smooth; }
        .message { max-width: 80%; padding: 18px 24px; border-radius: 25px; font-size: 1.1rem; line-height: 1.6; margin-bottom: 10px; }
        .bot { background-color: #fff0e0; align-self: flex-start; border-bottom-left-radius: 4px; border: 1px solid #ffe0c0; }
        .user { background-color: #ff7e00; color: white; align-self: flex-end; border-bottom-right-radius: 4px; box-shadow: 0 4px 10px rgba(255, 126, 0, 0.2); }

        /* 결과 카드 디자인 */
        .res-card { 
            background: #fff; border-radius: 18px; border: 1px solid #eee; padding: 20px; 
            margin-top: 15px; box-shadow: 0 10px 20px rgba(0,0,0,0.03);
            border-left: 5px solid #ff7e00;
        }
        .link-btn { display: inline-block; margin-top: 15px; background: #ff7e00; color: white; padding: 8px 16px; border-radius: 10px; text-decoration: none; font-size: 0.9rem; font-weight: bold; }
    </style>
</head>
<body>

<div class="chat-container">
    <c:if test="${sessionScope.userRole == 'ADMIN'}">
        <a href="admin_main.jsp" class="admin-back-btn">
            <i class="fa-solid fa-gear mr-1"></i> 관리자 모드
        </a>
    </c:if>

    <div class="header">
        <a href="index.jsp" class="home-btn" style="position: absolute; left: 30px; color: white; text-decoration: none; font-size: 1.5rem;">🏠</a>
        <h1>영달봇 🤖</h1>
        <p>대덕인재개발원 근처 찐맛집 큐레이션</p>
    </div>

    <div id="chat-window">
        </div>

    <div class="input-area" style="padding: 30px; background: #fff9f5; display: flex; gap: 15px;">
        <input type="text" id="user-input" 
               style="flex: 1; padding: 20px; border: 2px solid #ffdec0; border-radius: 20px; outline: none; font-size: 1.1rem;" 
               placeholder="궁금한 음식 종류를 입력하세요 (예: 닭볶음탕, 일식...)"
               onkeypress="if(event.keyCode==13) sendMessage()">
        <button onclick="sendMessage()" 
                style="padding: 0 35px; background: #ff7e00; color: white; border: none; border-radius: 20px; font-weight: bold; cursor: pointer;">
            전송
        </button>
    </div>
</div>

<script>
    // [DB 대용 데이터] 실제 환경에서는 서버에서 JSON으로 받아오는 것이 좋습니다.
    const restaurantDB = { /* ... 위에서 주신 데이터와 동일 ... */ };
    const keywordMap = { /* ... 위에서 주신 키워드와 동일 ... */ };

    function addMessage(text, sender) {
        const chatWindow = document.getElementById('chat-window');
        const msgDiv = document.createElement('div');
        msgDiv.className = `message \${sender}`;
        msgDiv.innerHTML = text;
        chatWindow.appendChild(msgDiv);
        chatWindow.scrollTo(0, chatWindow.scrollHeight);
    }

    function sendMessage(passedText = null) {
        const inputField = document.getElementById('user-input');
        const userText = passedText || inputField.value.trim();
        if (!userText) return;

        addMessage(userText, 'user');
        if(!passedText) inputField.value = "";

        // 봇 응답 처리 로직 (생략 - 기존과 동일)
    }

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const initialMsg = urlParams.get('message');
        if (initialMsg) {
            sendMessage(decodeURIComponent(initialMsg));
        } else {
            addMessage(`반갑습니다! <b>영달봇</b>입니다. 🍊<br>한식, 중식, 일식 등 원하시는 메뉴를 말씀해주세요!`, 'bot');
        }
    };
</script>

</body>
</html>