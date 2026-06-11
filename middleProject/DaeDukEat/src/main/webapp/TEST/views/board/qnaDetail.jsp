

<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - Q&A 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');

        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }

        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-owner { background-color: #2563eb !important; color: white !important; border-color: #2563eb !important; }
        .theme-user { background-color: #f97316 !important; color: white !important; border-color: #f97316 !important; }

        .theme-text-admin { color: #1a1a1b !important; }
        .theme-text-owner { color: #2563eb !important; }
        .theme-text-user { color: #f97316 !important; }

        .theme-border-admin { border-color: #1a1a1b !important; }
        .theme-border-owner { border-color: #2563eb !important; }
        .theme-border-user { border-color: #f97316 !important; }

        .answer-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }

        /* ===== 모달 스타일 (Premium 모달) ===== */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes slideUp {
            from { transform: translate(-50%, -45%); opacity: 0; }
            to { transform: translate(-50%, -50%); opacity: 1; }
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 90%;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: slideUp 0.4s ease;
            text-align: center;
        }

        .modal-header {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f8f9fa;
            font-size: 24px;
            font-weight: 700;
        }

        .modal-header::before {
            content: '⚠️';
            font-size: 32px;
        }

        .confirm-message {
            font-size: 16px;
            color: #495057;
            margin: 24px 0;
            line-height: 1.6;
        }

        .confirm-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220,53,69,0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>
</head>
<body class="pb-20">

<header class="bg-white border-b-4 py-6 sticky top-0 z-50 shadow-sm
        <c:choose>
            <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
            <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
            <c:otherwise>theme-border-user</c:otherwise>
        </c:choose>">
    <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
        <a href="${pageContext.request.contextPath}/main.do" class="text-4xl b-grade-font tracking-tighter italic
            <c:choose>
                <c:when test="${loginUser.division == '관리자'}">theme-text-admin</c:when>
                <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
                <c:otherwise>theme-text-user</c:otherwise>
            </c:choose>">D.D.M</a>
    </div>
</header>

<main class="max-w-[900px] mx-auto px-6 py-12">

    <!-- 뒤로가기 버튼 -->
    <div class="mb-6">
        <button onclick="location.href='${pageContext.request.contextPath}/qna/list.do'"
                class="px-6 py-3 bg-gray-100 hover:bg-gray-200 rounded-xl font-bold text-gray-700 transition">
            <i class="fas fa-arrow-left mr-2"></i>목록으로
        </button>
    </div>

    <!-- 질문 영역 -->
    <div class="bg-white p-10 rounded-[35px] border-2 shadow-lg mb-6
        <c:choose>
            <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
            <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
            <c:otherwise>theme-border-user</c:otherwise>
        </c:choose>">

        <!-- 제목 영역 -->
        <div class="border-b-2 border-gray-100 pb-6 mb-6">
            <div class="flex items-center gap-2 mb-4">
                <c:choose>
                    <c:when test="${qna.statusYn == '완료'}">
                        <span class="px-4 py-2 bg-gradient-to-r from-green-500 to-emerald-500 text-white rounded-full text-sm font-black">
                            <i class="fas fa-check-circle mr-2"></i>답변 완료
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="px-4 py-2 bg-gradient-to-r from-orange-500 to-red-500 text-white rounded-full text-sm font-black">
                            <i class="fas fa-clock mr-2"></i>답변 대기
                        </span>
                    </c:otherwise>
                </c:choose>

                <c:if test="${qna.secretYn == 'Y'}">
                    <span class="px-4 py-2 bg-gray-800 text-white rounded-full text-sm font-black">
                        <i class="fas fa-lock mr-2"></i>비밀글
                    </span>
                </c:if>
            </div>

            <h2 class="text-4xl font-black text-gray-900 mb-4">${qna.qnaTitle}</h2>

            <div class="flex items-center gap-6 text-sm text-gray-500">
                <span><i class="far fa-user mr-2"></i>${qna.userId}</span>
                <span><i class="far fa-calendar mr-2"></i><fmt:formatDate value="${qna.createDate}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
        </div>

        <!-- 질문 내용 -->
        <div class="prose max-w-none mb-8">
            <p class="text-gray-700 leading-relaxed whitespace-pre-wrap text-lg">${qna.qnaContent}</p>
        </div>

        <!-- 작성자 본인만 수정/삭제 버튼 표시 -->
        <c:if test="${qna.userId == loginUser.userId}">
            <div class="flex justify-end gap-3 pt-6 border-t-2 border-gray-100">
                <button onclick="location.href='${pageContext.request.contextPath}/qna/update.do?qnaId=${qna.qnaId}'"
                        class="px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold transition">
                    <i class="fas fa-edit mr-2"></i>수정
                </button>
                <button onclick="deleteQna()"
                        class="px-6 py-3 bg-red-500 hover:bg-red-600 text-white rounded-xl font-bold transition">
                    <i class="fas fa-trash mr-2"></i>삭제
                </button>
            </div>
        </c:if>
    </div>

    <!-- 답변 영역 -->
    <c:choose>
        <c:when test="${not empty qna.answerContent}">
            <div class="answer-section p-10 rounded-[35px] shadow-lg text-white">
                <div class="flex items-center gap-3 mb-6">
                    <i class="fas fa-user-shield text-3xl"></i>
                    <div>
                        <h3 class="text-2xl font-black">관리자 답변</h3>
                        <p class="text-sm text-white/80">
                            <fmt:formatDate value="${qna.answerDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                    </div>
                </div>
                <div class="bg-white/20 p-6 rounded-2xl">
                    <p class="text-white leading-relaxed whitespace-pre-wrap text-lg">${qna.answerContent}</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:if test="${loginUser.division == '관리자'}">
                <div class="bg-white p-10 rounded-[35px] border-2 theme-border-admin shadow-lg">
                    <h3 class="text-2xl font-black text-gray-900 mb-6">
                        <i class="fas fa-comment-dots mr-2"></i>답변 작성
                    </h3>
                    <form action="${pageContext.request.contextPath}/qna/answer.do" method="post">
                        <input type="hidden" name="qnaId" value="${qna.qnaId}">
                        <textarea name="answerContent" 
                                  required 
                                  maxlength="1000" 
                                  rows="10"
                                  class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none mb-4"
                                  placeholder="답변을 입력하세요 (최대 1000자)"></textarea>
                        <button type="submit" 
                                class="w-full py-4 theme-admin rounded-xl font-black text-lg shadow-lg">
                            <i class="fas fa-paper-plane mr-2"></i>답변 등록
                        </button>
                    </form>
                </div>
            </c:if>
            <c:if test="${loginUser.division != '관리자'}">
                <div class="bg-gray-100 p-10 rounded-[35px] text-center">
                    <i class="fas fa-hourglass-half text-6xl text-gray-400 mb-4"></i>
                    <p class="text-gray-600 font-bold text-lg">관리자의 답변을 기다리고 있습니다.</p>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>
</main>

<!-- ================== QnA 삭제 모달 ================== -->
<div id="qnaDeleteModal" class="modal confirm-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>질문 삭제</h3>
        </div>
        <div class="confirm-message">
            정말로 이 질문을 삭제하시겠습니까?<br>
            <strong>삭제된 질문은 복구할 수 없습니다.</strong>
        </div>
        <div class="confirm-actions">
            <button class="btn btn-danger" id="qnaDeleteConfirmBtn">삭제</button>
            <button class="btn btn-secondary" onclick="closeQnaDeleteModal()">취소</button>
        </div>
    </div>
</div>

<script>
    // QnA 삭제용 네임스페이스
    window.QnaApp = window.QnaApp || { qnaIdToDelete: null };

    // 삭제 모달 열기
    function deleteQna() {
        window.QnaApp.qnaIdToDelete = '${qna.qnaId}';
        document.getElementById('qnaDeleteModal').style.display = 'block';
    }

    // 삭제 모달 닫기
    function closeQnaDeleteModal() {
        document.getElementById('qnaDeleteModal').style.display = 'none';
        window.QnaApp.qnaIdToDelete = null;
    }

    // 실제 삭제 처리
    document.getElementById('qnaDeleteConfirmBtn').addEventListener('click', function() {
        const qnaId = window.QnaApp.qnaIdToDelete;
        if (!qnaId) return;

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/qna/delete.do';
        
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'qnaId';
        input.value = qnaId;
        
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('qnaDeleteModal');
        if (event.target === modal) closeQnaDeleteModal();
    });
</script>

</body>
</html>


<%-- <%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%

UserVO uvo = (UserVO) session.getAttribute("loginUser");

out.print("<h1>uvo : " + uvo + "</h1>");

String userId = "";
String loginUser.division  = "";

if(uvo!=null){
	userId = uvo.getUserId();
	loginUser.division = uvo.getDivision();
}
/* String loginUser.division = (String)session.getAttribute("loginUser.division");
String userId = (String)session.getAttribute("userId");

    if(loginUser.division == null) loginUser.division = "USER";  */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - Q&A 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-owner { background-color: #2563eb !important; color: white !important; border-color: #2563eb !important; }
        .theme-user { background-color: #f97316 !important; color: white !important; border-color: #f97316 !important; }

        .theme-text-admin { color: #1a1a1b !important; }
        .theme-text-owner { color: #2563eb !important; }
        .theme-text-user { color: #f97316 !important; }

        .theme-border-admin { border-color: #1a1a1b !important; }
        .theme-border-owner { border-color: #2563eb !important; }
        .theme-border-user { border-color: #f97316 !important; }

        .answer-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    </style>
</head>
<body class="pb-20">
	<!--     JSTL변수           JAVA변수 -->
	<!-- 
	page 영역 -> 객체 : pageContext
	request 영역 -> 객체 : request
	session 영역 -> 객체 : session
	application 영역 -> 객체 : application
	 -->
	<c:set var="userId" value="<%=userId%>" scope="page" />
	<c:set var="loginUser.division" value="<%=loginUser.division%>" />
    <header class="bg-white border-b-4 py-6 sticky top-0 z-50 shadow-sm
        <c:choose>
            <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
            <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
            <c:otherwise>theme-border-user</c:otherwise>
        </c:choose>">
        <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/main.do" class="text-4xl b-grade-font tracking-tighter italic 
                <c:choose>
                    <c:when test="${loginUser.division == '관리자'}">theme-text-admin</c:when>
                    <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
                    <c:otherwise>theme-text-user</c:otherwise>
                </c:choose>">D.D.M</a>
            <div class="flex items-center gap-4">
                <span class="text-[10px] font-black bg-gray-100 text-gray-500 px-4 py-2 rounded-full uppercase">
                    ROLE: <span class="<c:choose>
                        <c:when test="${loginUser.division == '관리자'}">theme-text-admin</c:when>
                        <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
                        <c:otherwise>theme-text-user</c:otherwise>
                    </c:choose>">${loginUser.division}</span>
                </span>
            </div>
        </div>
    </header>

    <main class="max-w-[900px] mx-auto px-6 py-12">
        
        <!-- 뒤로가기 버튼 -->
        <div class="mb-6">
            <button onclick="location.href='${pageContext.request.contextPath}/qna/list.do'" 
                    class="px-6 py-3 bg-gray-100 hover:bg-gray-200 rounded-xl font-bold text-gray-700 transition">
                <i class="fas fa-arrow-left mr-2"></i>목록으로
            </button>
        </div>

        <!-- 질문 영역 -->
        <div class="bg-white p-10 rounded-[35px] border-2 shadow-lg mb-6
            <c:choose>
                <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
                <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
                <c:otherwise>theme-border-user</c:otherwise>
            </c:choose>">
            
            <!-- 제목 영역 -->
            <div class="border-b-2 border-gray-100 pb-6 mb-6">
                <!-- 상태 뱃지 -->
                <div class="flex items-center gap-2 mb-4">
                    <c:choose>
                        <c:when test="${qna.statusYn == '완료'}">
                            <span class="px-4 py-2 bg-gradient-to-r from-green-500 to-emerald-500 text-white rounded-full text-sm font-black">
                                <i class="fas fa-check-circle mr-2"></i>답변 완료
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="px-4 py-2 bg-gradient-to-r from-orange-500 to-red-500 text-white rounded-full text-sm font-black">
                                <i class="fas fa-clock mr-2"></i>답변 대기
                            </span>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${qna.secretYn == 'Y'}">
                        <span class="px-4 py-2 bg-gray-800 text-white rounded-full text-sm font-black">
                            <i class="fas fa-lock mr-2"></i>비밀글
                        </span>
                    </c:if>
                </div>
                
                <h2 class="text-4xl font-black text-gray-900 mb-4">${qna.qnaTitle}</h2>
                
                <div class="flex items-center gap-6 text-sm text-gray-500">
                    <span><i class="far fa-user mr-2"></i>${qna.userId}</span>
                    <span><i class="far fa-calendar mr-2"></i><fmt:formatDate value="${qna.createDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
            </div>

            <!-- 질문 내용 -->
            <div class="prose max-w-none mb-8">
            	<p>qna : ${qna}</p>
            	<h2>loginUser : ${sessionScope.loginUser}</h2>
            	<p>userId : ${userId}</p>
                <p class="text-gray-700 leading-relaxed whitespace-pre-wrap text-lg">${qna.qnaContent}</p>
            </div>
			
			
			
            <!-- 작성자 본인만 수정/삭제 버튼 표시 -->
            <c:if test="${qna.userId == loginUser.userId}">
                <div class="flex justify-end gap-3 pt-6 border-t-2 border-gray-100">
                    <button onclick="location.href='${pageContext.request.contextPath}/qna/update.do?qnaId=${qna.qnaId}'" 
                            class="px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold transition">
                        <i class="fas fa-edit mr-2"></i>수정
                    </button>
                    <button onclick="deleteQna()" 
                            class="px-6 py-3 bg-red-500 hover:bg-red-600 text-white rounded-xl font-bold transition">
                        <i class="fas fa-trash mr-2"></i>삭제
                    </button>
                </div>
            </c:if>

        </div>

        <!-- 답변 영역 -->
        <c:choose>
            <c:when test="${not empty qna.answerContent}">
                <!-- 답변 완료 -->
                <div class="answer-section p-10 rounded-[35px] shadow-lg text-white">
                    <div class="flex items-center gap-3 mb-6">
                        <i class="fas fa-user-shield text-3xl"></i>
                        <div>
                            <h3 class="text-2xl font-black">관리자 답변</h3>
                            <p class="text-sm text-white/80">
                                <fmt:formatDate value="${qna.answerDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </p>
                        </div>
                    </div>
                    <div class="bg-white/20 p-6 rounded-2xl">
                        <p class="text-white leading-relaxed whitespace-pre-wrap text-lg">${qna.answerContent}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 답변 대기 중 -->
                <c:if test="${loginUser.division == '관리자'}">
                    <!-- 관리자 답변 작성 폼 -->
                    <div class="bg-white p-10 rounded-[35px] border-2 theme-border-admin shadow-lg">
                        <h3 class="text-2xl font-black text-gray-900 mb-6">
                            <i class="fas fa-comment-dots mr-2"></i>답변 작성
                        </h3>
                        <form action="${pageContext.request.contextPath}/qna/answer.do" method="post">
                            <input type="hidden" name="qnaId" value="${qna.qnaId}">
                            
                            <textarea name="answerContent" 
                                      required 
                                      maxlength="1000" 
                                      rows="10"
                                      class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none mb-4"
                                      placeholder="답변을 입력하세요 (최대 1000자)"></textarea>
                            
                            <button type="submit" 
                                    class="w-full py-4 theme-admin rounded-xl font-black text-lg shadow-lg">
                                <i class="fas fa-paper-plane mr-2"></i>답변 등록
                            </button>
                        </form>
                    </div>
                </c:if>
                
                <c:if test="${loginUser.division != '관리자'}">
                    <!-- 일반 사용자: 답변 대기 메시지 -->
                    <div class="bg-gray-100 p-10 rounded-[35px] text-center">
                        <i class="fas fa-hourglass-half text-6xl text-gray-400 mb-4"></i>
                        <p class="text-gray-600 font-bold text-lg">관리자의 답변을 기다리고 있습니다.</p>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

    </main>

     <script>
         function deleteQna() {
            if(confirm('정말로 이 질문을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/qna/delete.do';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'qnaId';
                input.value = '${qna.qnaId}';
                
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        } 
    </script>

</body>

</html> --%>