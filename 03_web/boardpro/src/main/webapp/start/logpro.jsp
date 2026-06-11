<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: #0f0f0f;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            position: relative;
            overflow: hidden;
        }
        
        /* 배경 애니메이션 */
        body::before {
            content: '';
            position: absolute;
            width: 150%;
            height: 150%;
            background: radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3), transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(74, 144, 226, 0.3), transparent 50%),
                        radial-gradient(circle at 40% 20%, rgba(138, 43, 226, 0.2), transparent 50%);
            animation: bgRotate 20s linear infinite;
            z-index: 0;
        }
        
        @keyframes bgRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .login-container {
            position: relative;
            z-index: 1;
            background: rgba(26, 26, 26, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 50px 45px;
            max-width: 440px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5),
                        0 0 80px rgba(120, 119, 198, 0.1);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-header h1 {
            color: #fff;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }
        
        .login-header p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 24px;
            position: relative;
        }
        
        .password-wrapper {
            position: relative;
        }
        
        .form-label {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            font-size: 0.9rem;
            margin-bottom: 10px;
            display: block;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1.5px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #ffffff;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(120, 119, 198, 0.6);
            box-shadow: 0 0 0 4px rgba(120, 119, 198, 0.1);
            color: #ffffff;
        }
        
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        
        /* 자동완성 배경색 처리 */
        .form-control:-webkit-autofill,
        .form-control:-webkit-autofill:hover,
        .form-control:-webkit-autofill:focus {
            -webkit-text-fill-color: #ffffff;
            -webkit-box-shadow: 0 0 0px 1000px rgba(255, 255, 255, 0.05) inset;
            transition: background-color 5000s ease-in-out 0s;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            padding: 0;
            transition: color 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
        }
        
        .password-toggle:hover {
            color: rgba(255, 255, 255, 0.9);
        }
        
        .password-toggle svg {
            width: 22px;
            height: 22px;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-check-input {
            width: 18px;
            height: 18px;
            border: 1.5px solid rgba(255, 255, 255, 0.3);
            background: transparent;
            cursor: pointer;
            margin: 0;
        }
        
        .form-check-input:checked {
            background-color: #7877C6;
            border-color: #7877C6;
        }
        
        .form-check-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            cursor: pointer;
            user-select: none;
        }
        
        .forgot-link {
            color: rgba(120, 119, 198, 1);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }
        
        .forgot-link:hover {
            color: rgba(138, 137, 206, 1);
        }
        
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #7877C6 0%, #4A90E2 100%);
            border: none;
            border-radius: 12px;
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn-login:hover::before {
            left: 100%;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(120, 119, 198, 0.4);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }
        
        .divider {
            text-align: center;
            margin: 30px 0;
            position: relative;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 40%;
            height: 1px;
            background: rgba(255, 255, 255, 0.1);
        }
        
        .divider::before {
            left: 0;
        }
        
        .divider::after {
            right: 0;
        }
        
        .divider span {
            color: rgba(255, 255, 255, 0.4);
            font-size: 0.85rem;
            background: rgba(26, 26, 26, 0.7);
            padding: 0 15px;
        }
        
        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            justify-content: center;
        }
        
        .social-btn {
            width: 56px;
            height: 56px;
            padding: 0;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: rgba(255, 255, 255, 0.8);
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .social-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
        }
        
        .social-btn svg {
            width: 28px;
            height: 28px;
        }
        
        .social-btn.kakao:hover {
            background: rgba(254, 229, 0, 0.15);
            border-color: rgba(254, 229, 0, 0.3);
        }
        
        .social-btn.naver:hover {
            background: rgba(3, 199, 90, 0.15);
            border-color: rgba(3, 199, 90, 0.3);
        }
        
        .social-btn.google:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .signup-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .signup-link p {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
        }
        
        .signup-link a {
            color: #7877C6;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .signup-link a:hover {
            color: #8A87CE;
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-left: 4px solid #ef4444;
            color: #fca5a5;
            padding: 14px 16px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 0.9rem;
            display: none;
            animation: shake 0.5s;
        }
        
        .error-message.show {
            display: block;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        /* 로딩 애니메이션 */
        .btn-login.loading {
            pointer-events: none;
            opacity: 0.7;
        }
        
        .btn-login.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        @media (max-width: 480px) {
            .login-container {
                padding: 40px 30px;
                margin: 20px;
            }
            
            .login-header h1 {
                font-size: 1.75rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Welcome Back</h1>
            <p>계정에 로그인하여 계속하세요</p>
        </div>
        
        <div id="errorMessage" class="error-message"></div>
        
        <form action="loginForm" method="post">
            <div class="form-group">
                <label class="form-label">아이디</label>
                <input type="text" class="form-control" id="memberId" name="mem_id" 
                       placeholder="아이디를 입력하세요" required autofocus>
            </div>
            
            <div id="resultLogin"></div>
            
            <div class="form-group">
                <label class="form-label">비밀번호</label>
                <div class="password-wrapper">
                    <input type="password" class="form-control" id="memberPw" name="mem_pass" 
                           placeholder="비밀번호를 입력하세요" required style="padding-right: 50px;">
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                        </svg>
                    </button>
                </div>
            </div>
            
            <div class="remember-forgot">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">
                        로그인 상태 유지
                    </label>
                </div>
                <a href="#" class="forgot-link" onclick="findPassword(); return false;">비밀번호 찾기</a>
            </div>
            
            <button type="button" class="btn-login" id="loginBtn" onclick="doLogin()">로그인</button>
        </form>
        
        <div class="divider">
            <span>또는</span>
        </div>
        
        <div class="social-login">
            <button class="social-btn kakao" onclick="socialLogin('kakao')" title="카카오 로그인">
                <svg viewBox="0 0 24 24" fill="currentColor" style="color: #FEE500;">
                    <path d="M12 3C6.5 3 2 6.6 2 11c0 2.8 1.9 5.3 4.7 6.7-.2.8-.6 2.8-.7 3.2 0 .2-.1.5.2.6.2.2.5.1.6.1.5-.1 3.6-2.4 4.2-2.8.3 0 .7.1 1 .1 5.5 0 10-3.6 10-8S17.5 3 12 3z"/>
                </svg>
            </button>
            <button class="social-btn naver" onclick="socialLogin('naver')" title="네이버 로그인">
                <svg viewBox="0 0 24 24" fill="currentColor" style="color: #03C75A;">
                    <path d="M16.273 12.845L7.376 0H0v24h7.726V11.156L16.624 24H24V0h-7.727v12.845z"/>
                </svg>
            </button>
            <button class="social-btn google" onclick="socialLogin('google')" title="Google 로그인">
                <svg viewBox="0 0 24 24" fill="currentColor" style="color: #fff;">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
            </button>
        </div>
        
        <div class="signup-link">
            <p>아직 계정이 없으신가요? <a href="signup.jsp">회원가입</a></p>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
    //현재 contextRoot(프로젝트) 이름을 얻는 방법
    mypath = '<%= request.getContextPath()%>';
    
    const doLogin = async () =>{
    	//입력한 id와 비밀번호 가져오기 - 수동으로 하나씩 가져오려면 id를 이용
    	idValue=document.querySelector("#memberId").value.trim();
    	passValue = document.querySelector("#memberPw").value.trim();
    	data = JSON.stringify({ mem_id : idValue , mem_pass : passValue })
    	
    	//fetch를 이용해 Login.do를 실행
    	//성공시 다시 index로 실행
		const res = await fetch("/boardpro/Login.do", { // <-- 여기 수정
		  method : "post",
		  headers: {"content-type" : "application/json;charset=utf-8"},
		  body : data
		})
	    	
    	if(res.ok){
    		//
    		datas = await res.json();
    		console.log(datas);
    		if(datas['flag']=="ok"){
    			//로그인 성공 - 새로고침 - index.jsp로 화면이동
    		location.href="http://localhost/boardpro/start/index.jsp";
    		//`\${mypath}/start/index.jsp
    	}else{
    		document.querySelector("#resultLogin").innerHTML = "아이디 또는 비밀번호 오류";
    		document.querySelector("#resultLogin").style.color = "red";
    	}
    	
    	}
    }
    </script>
</body>
</html>