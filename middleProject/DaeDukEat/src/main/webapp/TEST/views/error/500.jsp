<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 - Internal Server Error</title>
    <style>
        /* 제공해주신 스타일 적용 */
        @import url("https://fonts.googleapis.com/css?family=Fira+Code&display=swap");

        * {
            margin: 0;
            padding: 0;
            font-family: "Fira Code", monospace;
        }
        
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            /* 배경을 부드러운 주황빛/아이보리 톤으로 설정 */
            background-color: white; 
        }

        .container {
            text-align: center;
            margin: auto;
            padding: 4em;
        }

        .container img {
            /* 제작된 대덕 레저 이미지 느낌의 일러스트 또는 아이콘 */
            width: 300px;
            height: auto;
            margin-bottom: 1rem;
        }

        .container h1 {
            margin-top: 1rem;
            font-size: 35px;
            text-align: center;
            /* 강조색을 주황색으로 설정 */
            color: #e67e22; 
        }

        .container h1 span {
            font-size: 80px;
            display: block;
            line-height: 1;
        }

        .container p {
            margin-top: 1.5rem;
            color: #555;
            font-size: 18px;
        }

        .info {
            margin-top: 3em !important;
            font-size: 14px !important;
        }

        .info a {
            text-decoration: none;
            color: #d35400;
            font-weight: bold;
            padding: 10px 20px;
            border: 2px solid #d35400;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .info a:hover {
            background-color: #d35400;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://i.imgur.com/qIufhof.png" alt="Error Illustration" />

        <h1>
            <span>500</span>
            Internal Server Error
        </h1>
        
        <p>서버 오류가 발생했습니다. 문제를 해결하기 위해 노력 중입니다.</p>
        
        <p class="info">
            <a href="<%= request.getContextPath() %>/main.do">
                홈으로 돌아가기
            </a>
        </p>
    </div>
</body>
</html>