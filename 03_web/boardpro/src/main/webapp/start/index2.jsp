<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 포털</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html, body {
            height: 100%;
            overflow: hidden;
        }
        
        .container-fluid {
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        header {
            background-color: #343a40;
            color: white;
            padding: 15px 20px;
            flex-shrink: 0;
        }
        
        .main-content {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        
        aside {
            width: 250px;
            background-color: #f8f9fa;
            border-right: 1px solid #dee2e6;
            flex-shrink: 0;
            overflow-y: auto;
        }
        
        section {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: white;
        }
        
        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 10px;
            flex-shrink: 0;
        }
        
        .nav-link {
            color: #495057;
            padding: 12px 20px;
            cursor: pointer;
            border-bottom: 1px solid #dee2e6;
        }
        
        .nav-link:hover {
            background-color: #e9ecef;
            color: #212529;
        }
        
        .nav-link.active {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Header 영역 -->
        <header class="d-flex justify-content-between align-items-center">
            <h3>회원 포털</h3>
            <div id="headerButtons">
                <!-- 동적으로 생성될 버튼 영역 -->
            </div>
        </header>
        
        <!-- Main Content 영역 -->
        <div class="main-content">
            <!-- Aside 영역 -->
            <aside>
                <nav class="nav flex-column">
                    <a class="nav-link active" onclick="loadMenu('notice')">공지사항</a>
                    <a class="nav-link" onclick="loadMenu('qna')">QNA</a>
                    <a class="nav-link" onclick="loadMenu('board')">자유게시판</a>
                    <a class="nav-link" onclick="loadMenu('bookstore')">북스토어</a>
                </nav>
            </aside>
            
            <!-- Section 영역 -->
            <section id="contentSection">
                <h2>공지사항</h2>
                <p>공지사항 내용이 여기에 표시됩니다.</p>
                <div class="mt-3">
                    <div class="card mb-2">
                        <div class="card-body">
                            <h5 class="card-title">공지사항 1</h5>
                            <p class="card-text">첫 번째 공지사항 내용입니다.</p>
                        </div>
                    </div>
                    <div class="card mb-2">
                        <div class="card-body">
                            <h5 class="card-title">공지사항 2</h5>
                            <p class="card-text">두 번째 공지사항 내용입니다.</p>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        
        <!-- Footer 영역 -->
        <footer>
            <p>&copy; 2026 회원 포털. All rights reserved.</p>
        </footer>
    </div>

    <!-- 로그인 모달 -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm">
                        <div class="mb-3">
                            <label for="memberId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="memberId" name="memberId" required>
                        </div>
                        <div class="mb-3">
                            <label for="memberPw" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="memberPw" name="memberPw" required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-input" for="rememberMe">
                                아이디 저장
                            </label>
                        </div>
                        <div id="loginError" class="alert alert-danger d-none" role="alert"></div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="submitLogin()">로그인</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // 서버에서 전달받은 세션 정보
        <%
            Object loginok = session.getAttribute("loginok");
            String memberId = null;
            if (loginok != null) {
                // MemberVO 객체에서 memberId를 가져옵니다
                // 실제 MemberVO 클래스의 getter 메서드명에 맞게 수정하세요
                try {
                    memberId = (String) loginok.getClass().getMethod("getMemberId").invoke(loginok);
                } catch (Exception e) {
                    memberId = null;
                }
            }
        %>
        
        let sessionData = {
            loginok: <%= (memberId != null) ? "{ memberId: '" + memberId + "' }" : "null" %>
        };

        // 헤더 버튼 생성
        function createHeaderButtons() {
            const headerButtons = document.getElementById('headerButtons');
            
            if (sessionData.loginok === null || sessionData.loginok === undefined) {
                // 로그인 안 된 상태
                headerButtons.innerHTML = '<div>' +
                    '<button class="btn btn-outline-light me-2" onclick="login()">로그인</button>' +
                    '<button class="btn btn-light" onclick="signup()">회원가입</button>' +
                    '</div>';
            } else {
                // 로그인 된 상태
                headerButtons.innerHTML = '<div class="dropdown">' +
                    '<button class="btn btn-light dropdown-toggle" type="button" id="userMenuDropdown" data-bs-toggle="dropdown" aria-expanded="false">' +
                    sessionData.loginok.memberId + '님 환영합니다' +
                    '</button>' +
                    '<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenuDropdown">' +
                    '<li><a class="dropdown-item" href="#" onclick="myPage()">마이페이지</a></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="myPosts()">내가 쓴 글</a></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="myComments()">내 댓글</a></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="orderHistory()">주문내역</a></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="wishlist()">찜 목록</a></li>' +
                    '<li><hr class="dropdown-divider"></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="settings()">설정</a></li>' +
                    '<li><a class="dropdown-item" href="#" onclick="logout()">로그아웃</a></li>' +
                    '</ul>' +
                    '</div>';
            }
        }

        // 메뉴 로드 함수
        function loadMenu(menu) {
            const section = document.getElementById('contentSection');
            const navLinks = document.querySelectorAll('.nav-link');
            
            // 모든 메뉴의 active 클래스 제거
            navLinks.forEach(link => link.classList.remove('active'));
            
            // 클릭한 메뉴에 active 클래스 추가
            event.target.classList.add('active');
            
            switch(menu) {
                case 'notice':
                    section.innerHTML = '<h2>공지사항</h2>' +
                        '<p>중요한 공지사항을 확인하세요.</p>' +
                        '<div class="mt-3">' +
                        generateSampleCards('공지사항', 5) +
                        '</div>';
                    break;
                case 'qna':
                    section.innerHTML = '<h2>QNA</h2>' +
                        '<p>질문과 답변을 확인하고 작성할 수 있습니다.</p>' +
                        '<button class="btn btn-primary mb-3">질문하기</button>' +
                        '<div class="mt-3">' +
                        generateSampleCards('질문', 8) +
                        '</div>';
                    break;
                case 'board':
                    section.innerHTML = '<h2>자유게시판</h2>' +
                        '<p>자유롭게 의견을 나누는 공간입니다.</p>' +
                        '<button class="btn btn-primary mb-3">글쓰기</button>' +
                        '<div class="mt-3">' +
                        generateSampleCards('게시글', 10) +
                        '</div>';
                    break;
                case 'bookstore':
                    section.innerHTML = '<h2>북스토어</h2>' +
                        '<p>다양한 도서를 만나보세요.</p>' +
                        '<div class="row mt-3">' +
                        generateBookCards(12) +
                        '</div>';
                    break;
            }
        }

        // 샘플 카드 생성 함수
        function generateSampleCards(title, count) {
            let cards = '';
            for (let i = 1; i <= count; i++) {
                cards += '<div class="card mb-2">' +
                    '<div class="card-body">' +
                    '<h5 class="card-title">' + title + ' ' + i + '</h5>' +
                    '<p class="card-text">' + title + ' ' + i + '의 내용입니다. 여기에 상세한 설명이 들어갑니다.</p>' +
                    '<small class="text-muted">작성일: 2026-01-' + String(i).padStart(2, '0') + '</small>' +
                    '</div>' +
                    '</div>';
            }
            return cards;
        }

        // 북스토어 카드 생성 함수
        function generateBookCards(count) {
            let cards = '';
            for (let i = 1; i <= count; i++) {
                cards += '<div class="col-md-3 mb-3">' +
                    '<div class="card">' +
                    '<div class="card-body">' +
                    '<h5 class="card-title">도서 ' + i + '</h5>' +
                    '<p class="card-text">저자: 작가 ' + i + '</p>' +
                    '<p class="card-text"><strong>' + (15000 + i * 1000).toLocaleString() + '원</strong></p>' +
                    '<button class="btn btn-sm btn-primary">장바구니</button>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            }
            return cards;
        }

        // 버튼 액션 함수들
        function login() {
            // 로그인 모달 열기
            const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
            loginModal.show();
        }

        function submitLogin() {
            const memberId = document.getElementById('memberId').value;
            const memberPw = document.getElementById('memberPw').value;
            const loginError = document.getElementById('loginError');
            
            // 입력 검증
            if (!memberId || !memberPw) {
                loginError.textContent = '아이디와 비밀번호를 입력해주세요.';
                loginError.classList.remove('d-none');
                return;
            }
            
            // 서버로 로그인 요청
            fetch('loginProcess.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'memberId=' + encodeURIComponent(memberId) + '&memberPw=' + encodeURIComponent(memberPw)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 로그인 성공
                    alert('로그인에 성공했습니다.');
                    location.reload(); // 페이지 새로고침하여 세션 정보 반영
                } else {
                    // 로그인 실패
                    loginError.textContent = data.message || '아이디 또는 비밀번호가 일치하지 않습니다.';
                    loginError.classList.remove('d-none');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                loginError.textContent = '로그인 처리 중 오류가 발생했습니다.';
                loginError.classList.remove('d-none');
            });
        }

        function signup() {
            alert('회원가입 페이지로 이동합니다.');
            location.href = 'signup.jsp';
        }

        function logout() {
            if (confirm('로그아웃 하시겠습니까?')) {
                // 서버의 로그아웃 처리 페이지로 이동
                location.href = 'logout.jsp'; // 실제 로그아웃 처리 URL로 변경하세요
            }
        }

        function myPage() {
            alert('마이페이지로 이동합니다.');
        }

        function myPosts() {
            alert('내가 쓴 글 페이지로 이동합니다.');
        }

        function myComments() {
            alert('내 댓글 페이지로 이동합니다.');
        }

        function orderHistory() {
            alert('주문내역 페이지로 이동합니다.');
        }

        function wishlist() {
            alert('찜 목록 페이지로 이동합니다.');
        }

        function settings() {
            alert('설정 페이지로 이동합니다.');
        }

        // 페이지 로드 시 헤더 버튼 생성
        createHeaderButtons();
    </script>
</body>
</html>