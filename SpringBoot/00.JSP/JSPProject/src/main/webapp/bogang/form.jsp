<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
<div class="container">
    <div class="row justify-content-center align-items-center" style="min-height: 100vh;">
        
        <div class="col-12 col-md-5">
            <div class="card shadow">
                <div class="card-body">
                    <h4 class="text-center mb-4">회원가입</h4>
                    <form action="process.jsp" method="post" id="insertForm">

                        <div class="mb-3">
                            <label class="form-label">아이디</label>
                            <input type="text" name="id" id="id" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">비밀번호</label>
                            <input type="password" name="pw" id="pw" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">비밀번호 확인</label>
                            <input type="password" name="pw2" id="pw2" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">이름</label>
                            <input type="text" name="name" id="name" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">생년월일</label>
                            <input type="date" name="bir" id="bir" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">이메일</label>
                            <div class="input-group">
                                <input type="text" name="email" id="email" class="form-control">
                                <span>@</span>
                                <select name="email2" id="email2" class="form-control">
                                    <option value="naver.com">naver.com</option>
                                    <option value="naver2.com">naver2.com</option>
                                    <option value="naver3.com">naver3.com</option>
                                    <option value="naver4.com">naver4.com</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-grid">
                            <button class="btn btn-primary">가입하기</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>

    </div>
</div>



<script type="text/javascript">

</script>
</body>
</html>