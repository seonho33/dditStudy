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

        <form action="signup" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">&#xC544;&#xC774;&#xB514; <span class="required">*</span></label>
                <div class="input-with-button">
                    <input type="text" id="username" name="username" required>
                    <button type="button" class="check-btn" onclick="checkUsername()">&#xC911;&#xBCF5;&#xD655;&#xC778;</button>
                </div>
                <div id="usernameCheck" class="check-message"></div>
            </div>

            <div class="form-group">
                <label for="password">&#xBE44;&#xBC00;&#xBC88;&#xD638; <span class="required">*</span></label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">&#xBE44;&#xBC00;&#xBC88;&#xD638; &#xD655;&#xC778; <span class="required">*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>

            <div class="form-group">
                <label for="name">&#xC774;&#xB984; <span class="required">*</span></label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="birthDate">&#xC0DD;&#xB144;&#xC6D4;&#xC77C; <span class="required">*</span></label>
                <input type="date" id="birthDate" name="birthDate" required>
            </div>

            <div class="form-group">
                <label for="email">&#xC774;&#xBA54;&#xC77C; <span class="required">*</span></label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="cohort">&#xAE30;&#xC218;&#xBC88;&#xD638; <span class="required">*</span></label>
                <input type="number" id="cohort" name="cohort" min="1" max="99" required>
            </div>

            <button type="submit" class="submit-btn">&#xD68C;&#xC6D0;&#xAC00;&#xC785;</button>
        </form>

        <div class="login-link">
            &#xC774;&#xBBF8; &#xACC4;&#xC815;&#xC774; &#xC788;&#xC73C;&#xC2E0;&#xAC00;&#xC694;? <a href="login.jsp">&#xB85C;&#xADF8;&#xC778;</a>
        </div>
    </div>

    <script>
        var isUsernameChecked = false;
        var usernameAvailable = false;

        document.getElementById('username').addEventListener('input', function() {
            isUsernameChecked = false;
            usernameAvailable = false;
            document.getElementById('usernameCheck').textContent = '';
        });

        function checkUsername() {
            var username = document.getElementById('username').value;
            var checkMessage = document.getElementById('usernameCheck');

            if (!username) {
                alert('\uC544\uC774\uB514\uB97C \uC785\uB825\uD574\uC8FC\uC138\uC694.');
                return;
            }

            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'checkUsername?username=' + encodeURIComponent(username), true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    isUsernameChecked = true;
                    usernameAvailable = response.available;

                    if (response.available) {
                        checkMessage.textContent = '\uC0AC\uC6A9 \uAC00\uB2A5\uD55C \uC544\uC774\uB514\uC785\uB2C8\uB2E4';
                        checkMessage.className = 'check-message success';
                    } else {
                        checkMessage.textContent = '\uC774\uBBF8 \uC0AC\uC6A9 \uC911\uC778 \uC544\uC774\uB514\uC785\uB2C8\uB2E4';
                        checkMessage.className = 'check-message error';
                    }
                }
            };
            xhr.send();
        }

        function validateForm() {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (!isUsernameChecked || !usernameAvailable) {
                alert('\uC544\uC774\uB514 \uC911\uBCF5\uD655\uC778\uC744 \uD574\uC8FC\uC138\uC694.');
                return false;
            }

            if (password !== confirmPassword) {
                alert('\uBE44\uBC00\uBC88\uD638\uAC00 \uC77C\uCE58\uD558\uC9C0 \uC54A\uC2B5\uB2C8\uB2E4.');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>