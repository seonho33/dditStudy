<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>&#xD68C;&#xC6D0;&#xAC00;&#xC785;</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Malgun Gothic', sans-serif;
            background: linear-gradient(135deg, #fff9e6 0%, #ffe680 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 500px;
        }

        .signup-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .signup-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .signup-header p {
            color: #666;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #ffd700;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.1);
        }

        .input-with-button {
            display: flex;
            gap: 10px;
        }

        .input-with-button input {
            flex: 1;
        }

        .check-btn {
            padding: 12px 20px;
            background: #ffd700;
            border: none;
            border-radius: 8px;
            color: #333;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.3s;
        }

        .check-btn:hover {
            background: #ffed4e;
            transform: translateY(-2px);
        }

        .check-btn:active {
            transform: translateY(0);
        }

        .check-message {
            margin-top: 5px;
            font-size: 13px;
        }

        .check-message.success {
            color: #22c55e;
        }

        .check-message.error {
            color: #ef4444;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: #ffd700;
            border: none;
            border-radius: 8px;
            color: #333;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: #ffed4e;
            transform: translateY(-2px);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }

        .login-link a {
            color: #f59e0b;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .required {
            color: #ef4444;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h1>&#xD68C;&#xC6D0;&#xAC00;&#xC785;</h1>
            <p>&#xC0C8;&#xB85C;&#xC6B4; &#xACC4;&#xC815;&#xC744; &#xB9CC;&#xB4E4;&#xC5B4;&#xBCF4;&#xC138;&#xC694;</p>
        </div>

        <div id="signupForm">
            <div class="form-group">
                <label>&#xC544;&#xC774;&#xB514; <span class="required">*</span></label>
                <div class="input-with-button">
                    <input type="text" id="username" placeholder="&#xC544;&#xC774;&#xB514;&#xB97C; &#xC785;&#xB825;&#xD558;&#xC138;&#xC694;">
                    <button class="check-btn" onclick="checkUsername()">&#xC911;&#xBCF5;&#xD655;&#xC778;</button>
                </div>
                <div id="usernameCheck" class="check-message"></div>
            </div>

            <div class="form-group">
                <label>&#xBE44;&#xBC00;&#xBC88;&#xD638; <span class="required">*</span></label>
                <input type="password" id="password" placeholder="&#xBE44;&#xBC00;&#xBC88;&#xD638;&#xB97C; &#xC785;&#xB825;&#xD558;&#xC138;&#xC694;">
            </div>

            <div class="form-group">
                <label>&#xBE44;&#xBC00;&#xBC88;&#xD638; &#xD655;&#xC778; <span class="required">*</span></label>
                <input type="password" id="confirmPassword" placeholder="&#xBE44;&#xBC00;&#xBC88;&#xD638;&#xB97C; &#xB2E4;&#xC2DC; &#xC785;&#xB825;&#xD558;&#xC138;&#xC694;">
            </div>

            <div class="form-group">
                <label>&#xC774;&#xB984; <span class="required">*</span></label>
                <input type="text" id="name" placeholder="&#xC774;&#xB984;&#xC744; &#xC785;&#xB825;&#xD558;&#xC138;&#xC694;">
            </div>

            <div class="form-group">
                <label>&#xC0DD;&#xB144;&#xC6D4;&#xC77C; <span class="required">*</span></label>
                <input type="date" id="birthDate">
            </div>

            <div class="form-group">
                <label>&#xC774;&#xBA54;&#xC77C; <span class="required">*</span></label>
                <input type="email" id="email" placeholder="example@email.com">
            </div>

            <div class="form-group">
                <label>&#xAE30;&#xC218;&#xBC88;&#xD638; <span class="required">*</span></label>
                <input type="number" id="cohort" placeholder="&#xC608;: 01" min="1" max="99">
            </div>

            <button class="submit-btn" onclick="submitForm()">&#xD68C;&#xC6D0;&#xAC00;&#xC785;</button>
        </div>

        <div class="login-link">
            &#xC774;&#xBBF8; &#xACC4;&#xC815;&#xC774; &#xC788;&#xC73C;&#xC2E0;&#xAC00;&#xC694;? <a href="#">&#xB85C;&#xADF8;&#xC778;</a>
        </div>
    </div>

    <script>
        let isUsernameChecked = false;
        let usernameAvailable = false;

        document.getElementById('username').addEventListener('input', function() {
            isUsernameChecked = false;
            document.getElementById('usernameCheck').textContent = '';
        });

        function checkUsername() {
            const username = document.getElementById('username').value;
            const checkMessage = document.getElementById('usernameCheck');

            if (!username) {
                alert('아이디를 입력해주세요.');
                return;
            }

            // 실제로는 서버에 AJAX 요청을 보내야 합니다
            // 예시: fetch('/checkUsername?username=' + username)
            const isAvailable = Math.random() > 0.5;
            
            isUsernameChecked = true;
            usernameAvailable = isAvailable;

            if (isAvailable) {
                checkMessage.textContent = '✓ 사용 가능한 아이디입니다.';
                checkMessage.className = 'check-message success';
                alert('사용 가능한 아이디입니다.');
            } else {
                checkMessage.textContent = '✗ 이미 사용 중인 아이디입니다.';
                checkMessage.className = 'check-message error';
                alert('이미 사용 중인 아이디입니다.');
            }
        }

        function submitForm() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const name = document.getElementById('name').value;
            const birthDate = document.getElementById('birthDate').value;
            const email = document.getElementById('email').value;
            const cohort = document.getElementById('cohort').value;

            if (!isUsernameChecked || !usernameAvailable) {
                alert('아이디 중복확인을 해주세요.');
                return;
            }

            if (password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }

            if (!username || !password || !name || !birthDate || !email || !cohort) {
                alert('모든 항목을 입력해주세요.');
                return;
            }

            // 실제 서버 전송 코드
            // 예시:
            // const formData = new FormData();
            // formData.append('username', username);
            // formData.append('password', password);
            // formData.append('name', name);
            // formData.append('birthDate', birthDate);
            // formData.append('email', email);
            // formData.append('cohort', cohort);
            // 
            // fetch('/signup', {
            //     method: 'POST',
            //     body: formData
            // }).then(response => response.json())
            //   .then(data => {
            //       if(data.success) {
            //           alert('회원가입이 완료되었습니다!');
            //           window.location.href = '/login';
            //       }
            //   });

            console.log('회원가입 데이터:', {
                username: username,
                password: password,
                name: name,
                birthDate: birthDate,
                email: email,
                cohort: cohort
            });

            alert('회원가입이 완료되었습니다!');
        }
    </script>
</body>
</html>