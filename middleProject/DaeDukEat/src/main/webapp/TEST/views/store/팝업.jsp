<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String imgUrl = "팝업.jpg"; 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>맛집 대형 팝업</title>
    <link rel="icon" href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==">
    
    <style>
        #ad-popup {
            position: fixed;
            top: 50%;           
            left: 10%;
            transform: translateY(-50%); 
            width: 300px;
            background: #fff;
            z-index: 1000;
            display: none;      
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            border-radius: 20px; 
            overflow: hidden;
            font-family: 'Malgun Gothic', sans-serif;
        }

        .ad-body img { 
            width: 100%; 
            height: auto; 
            display: block; 
            border: none;
            cursor: pointer;
        }

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

        .test-btn { 
            position: fixed; 
            bottom: 20px; 
            right: 20px; 
            z-index: 2000; 
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

<!--     <button class="test-btn" onclick="resetAdStorage()">
        🔄 테스트용: 팝업 초기화
    </button>  -->

    <div id="ad-popup">
        <div class="ad-body">
            <img src="<%= imgUrl %>" alt="대형 맛집 광고" onclick="goToEvent()">
        </div>
        <div class="ad-footer">
            <label>
                <input type="checkbox" id="no-show-cb"> 7일 동안 보지 않기
            </label>
            <button onclick="closeAd()">닫기</button>
        </div>
    </div>

    <script>
        const popup = document.getElementById('ad-popup');
        const storageKey = 'ad_expiry_date';

        window.onload = function() {
            const expiry = localStorage.getItem(storageKey);
            const now = new Date().getTime();

            if (!expiry || now > parseInt(expiry)) {
                popup.style.display = 'block';
            }
        };

        function goToEvent() {
            event.preventDefault();
           event.stopPropagation(); 
            
            console.log('goToEvent 함수 호출됨');
            alert('팝업이벤트 페이지로 이동합니다!');
            
            // 같은 폴더에 있는 경우
            window.location.href = '팝업이벤트.jsp';
            
            // 또는 절대 경로 사용
            <%--  window.location.href = '<%= request.getContextPath() %>/팝업이벤트.jsp'; --%>
        }

        function closeAd() {
            const isChecked = document.getElementById('no-show-cb').checked;
            if (isChecked) {
                const sevenDays = 7 * 24 * 60 * 60 * 1000;
                const expiryDate = new Date().getTime() + sevenDays;
                localStorage.setItem(storageKey, expiryDate);
            }
            popup.style.display = 'none';
        }

        function resetAdStorage() {
            localStorage.removeItem(storageKey);
            alert('초기화되었습니다!');
            location.reload();
        }
    </script>
</body>
</html>
