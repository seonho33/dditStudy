<%--  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영달봇 채팅</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
    body {
        font-family: 'Pretendard', sans-serif;
        background-color: #fff5eb;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .chat-container {
        width: 500px;
        height: 80vh;
        background-color: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255,126,0,0.2);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        border: 2px solid #ff7e00;
    }
    .header {
        background: linear-gradient(135deg,#ff9d00,#ff5e00);
        color: white;
        padding: 20px;
        text-align: center;
        font-size: 1.2rem;
    }
    #chat-window {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        background-color: #fff;
        display: flex;
        flex-direction: column;
        gap: 10px;
        scroll-behavior: smooth;
    }
    #loading {
    display: none; /* 기본 숨김 */
    text-align: center;
    padding: 10px;
    font-size: 0.9rem;
    color: #ff7e00;
	}
    
    
    .message {
        max-width: 75%;
        padding: 10px 15px;
        border-radius: 20px;
        font-size: 1rem;
        line-height: 1.4;
        word-wrap: break-word;
    }
    .user {
        background-color: #ff7e00;
        color: white;
        align-self: flex-end;
        border-bottom-right-radius: 4px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }
    .bot {
        background-color: #fff0e0;
        align-self: flex-start;
        border-bottom-left-radius: 4px;
        border: 1px solid #ffe0c0;
    }
    .input-area {
        display: flex;
        gap: 10px;
        padding: 15px;
        background-color: #fff9f5;
        border-top: 1px solid #ffdec0;
    }
    .input-area input {
        flex: 1;
        padding: 10px 15px;
        border-radius: 20px;
        border: 2px solid #ffdec0;
        outline: none;
        font-size: 1rem;
    }
    .input-area button {
        padding: 10px 20px;
        background-color: #ff7e00;
        color: white;
        border: none;
        border-radius: 20px;
        font-weight: bold;
        cursor: pointer;
    }
    .input-area button:hover {
        background-color: #ff9d00;
    }
</style>
</head>
<body>

<div class="chat-container">
    <div class="header">영달봇 🤖 - 찐맛집 추천</div>
    
    <!-- 채팅 메시지 창 -->
    <div id="chat-window"></div>
    
    <!-- ✅ 로딩 애니메이션 -->
    <div id="loading" style="display:none; text-align:center; padding:10px; font-size:0.9rem; color:#ff7e00;">
        <i class="fas fa-spinner fa-spin"></i> 답변을 불러오는 중...
    </div>

    <!-- 입력창 -->
    <div class="input-area">
        <input type="text" id="user-input" placeholder="궁금한 음식 종류를 입력하세요" onkeypress="if(event.keyCode==13) sendMessage()">
        <button onclick="sendMessage()">전송</button>
    </div>
</div>


<script>
const chatWindow = document.getElementById("chat-window");

function addMessage(text, sender) {
    const msgDiv = document.createElement("div");
    msgDiv.className = "message " + sender;
    msgDiv.innerHTML = text.replace(/\n/g,"<br>"); // 줄바꿈 처리
    chatWindow.appendChild(msgDiv);
    chatWindow.scrollTop = chatWindow.scrollHeight; // 항상 아래로 스크롤
}

 
 function sendMessage() {
	    const inputField = document.getElementById("user-input");
	    const userText = inputField.value.trim();
	    if(!userText) return;

	    // 사용자 메시지 추가
	    addMessage(userText, "user");

	    // 입력 초기화
	    inputField.value = "";

	    // ✅ 로딩 표시
	    const loading = document.getElementById("loading");
	    loading.style.display = "block";

	    // 서버 호출
	    fetch("<%=request.getContextPath()%>/BotAnswer.do?keyword=" + encodeURIComponent(userText))
	        .then(resp => resp.text())
	        .then(answer => {
	            // ✅ 서버 응답 후 로딩 숨김
	            loading.style.display = "none";

	            addMessage(answer, "bot");
	        })
	        .catch(err => {
	            loading.style.display = "none"; // 오류 시에도 숨김
	            console.error(err);
	            addMessage("서버 오류가 발생했습니다.", "bot");
	        });
	}
 
 function openChatModal() {
	    document.getElementById("chatModal").style.display = "flex";
	    setTimeout(() => {
	        document.getElementById("user-input").focus();
	    }, 100);
	}
 
 
 function closeChatModal() {
	    document.getElementById("chatModal").style.display = "none";
	    document.getElementById("loading").style.display = "none";
	}
	
 //💬 봇 답변 타이핑 효과
 function addBotTyping(text) {
     let i = 0;
     const msgDiv = document.createElement("div");
     msgDiv.className = "message bot";
     chatWindow.appendChild(msgDiv);

     const typing = setInterval(() => {
         msgDiv.innerHTML += text.charAt(i++);
         chatWindow.scrollTop = chatWindow.scrollHeight;
         if (i >= text.length) clearInterval(typing);
     }, 20);
 }

// 초기 안내 메시지
window.onload = function() {
    addMessage("반갑습니다! <b>영달봇</b>입니다. 🍊<br>한식, 중식, 일식 등 원하시는 메뉴를 말씀해주세요!", "bot");
};
</script>

</body>
</html>

 
 
 
  --%>
  
  
  
  
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영달봇 채팅</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
body {
    font-family: 'Pretendard', sans-serif;
    background-color: #fff5eb;
    margin: 0;
}

/* ===== 모달 ===== */
#chatModal {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.5);
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

/* ===== 채팅 컨테이너 ===== */
.chat-container {
    width: 500px;
    height: 80vh;
    background: white;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(255,126,0,0.2);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    border: 2px solid #ff7e00;
}

.header {
    background: linear-gradient(135deg,#ff9d00,#ff5e00);
    color: white;
    padding: 20px;
    text-align: center;
    font-size: 1.2rem;
}

#chat-window {
    flex: 1;
    padding: 20px;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

/* ===== 메시지 ===== */
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

/* ===== 입력 ===== */
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

/* ===== 로딩 ===== */
#loading {
    display: none;
    text-align: center;
    padding: 10px;
    font-size: 0.9rem;
    color: #ff7e00;
}

/* ===== 모바일 ===== */
@media (max-width: 600px) {
    .chat-container {
        width: 100vw;
        height: 100vh;
        border-radius: 0;
    }
}
</style>
</head>

<body>

<!-- 🔘 챗봇 열기 버튼 -->
<button onclick="openChatModal()"
        style="position:fixed; right:30px; bottom:30px;
               width:60px; height:60px; border-radius:50%;
               background:#ff7e00; color:white; font-size:1.5rem;
               border:none; box-shadow:0 10px 25px rgba(0,0,0,0.2);">
🤖
</button>

<!-- ===== 모달 ===== -->
<div id="chatModal" onclick="closeChatModal()">

    <div style="position:relative;" onclick="event.stopPropagation()">

        <!-- 닫기 버튼 -->
        <button onclick="closeChatModal()"
                style="position:absolute; top:-15px; right:-15px;
                       width:40px; height:40px; border-radius:50%;
                       border:none; background:#ff7e00; color:white;
                       font-size:1.2rem; cursor:pointer;">✕</button>

        <div class="chat-container">
            <div class="header">영달봇 🤖 - 찐맛집 추천</div>

            <div id="chat-window"></div>

            <div id="loading">
                <i class="fas fa-spinner fa-spin"></i> 답변을 불러오는 중...
            </div>

            <div class="input-area">
                <input type="text" id="user-input"
                       placeholder="궁금한 음식 종류를 입력하세요"
                       onkeypress="if(event.keyCode==13) sendMessage()">
                <button onclick="sendMessage()">전송</button>
            </div>
        </div>
    </div>
</div>

<script>
const chatWindow = document.getElementById("chat-window");
let initialized = false;
let isSending = false;

/* 메시지 출력 */
function addMessage(text, sender) {
    const div = document.createElement("div");
    div.className = "message " + sender;
    div.innerHTML = text.replace(/\n/g,"<br>");
    chatWindow.appendChild(div);
    chatWindow.scrollTop = chatWindow.scrollHeight;
}

/* 봇 타이핑 효과 */
function addBotTyping(text) {
    let i = 0;
    const div = document.createElement("div");
    div.className = "message bot";
    chatWindow.appendChild(div);

    const typing = setInterval(() => {
        div.innerHTML += text.charAt(i++);
        chatWindow.scrollTop = chatWindow.scrollHeight;
        if (i >= text.length) clearInterval(typing);
    }, 20);
}

/* 메시지 전송 */
function sendMessage() {
    if (isSending) return;

    const input = document.getElementById("user-input");
    const text = input.value.trim();
    if (!text) return;

    isSending = true;
    addMessage(text, "user");
    input.value = "";

    document.getElementById("loading").style.display = "block";

    fetch("<%=request.getContextPath()%>/BotAnswer.do?keyword=" + encodeURIComponent(text))
        .then(resp => resp.text())
        .then(answer => addBotTyping(answer))
        .catch(() => addMessage("서버 오류가 발생했습니다.", "bot"))
        .finally(() => {
            document.getElementById("loading").style.display = "none";
            isSending = false;
        });
}

/* 모달 열기 */
function openChatModal() {
    document.getElementById("chatModal").style.display = "flex";

    if (!initialized) {
        addMessage("반갑습니다! <b>영달봇</b>입니다 🍊<br>원하시는 메뉴를 입력해주세요!", "bot");
        initialized = true;
    }

    setTimeout(() => document.getElementById("user-input").focus(), 100);
}

/* 모달 닫기 */
function closeChatModal() {
    document.getElementById("chatModal").style.display = "none";
    document.getElementById("loading").style.display = "none";
    
    // 채팅 내용 초기화
    chatWindow.innerHTML = "";
    initialized = false; // 초기 안내 메시지 다시 표시 가능
}

/* ESC 닫기 */
document.addEventListener("keydown", e => {
    if (e.key === "Escape") closeChatModal();
});
</script>

</body>
</html>
   --%>