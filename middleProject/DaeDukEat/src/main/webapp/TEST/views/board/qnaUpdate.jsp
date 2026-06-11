<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%



UserVO uvo = (UserVO) session.getAttribute("loginUser");
String userId = uvo.getUserId();
String loginUser.division = uvo.getDivision();

   /*  String loginUser.division = (String)session.getAttribute("loginUser.division");
    String userId = (String)session.getAttribute("userId");
    if(loginUser.division == null) loginUser.division = "USER";  */
    // 관리자는 질문 작성 불가
    if("ADMIN".equals(loginUser.division)) {
        response.sendRedirect(request.getContextPath() + "/qna/list.do");
        return;
    }
    
    if(loginUser.division == null) loginUser.division = "USER";
%>  --%>

<%-- <%
    // 1. 기존 세션 무시하고 임시로 'USER' 권한 부여
    String loginUser.division = "USER";
    String userId = "user001"; // 임시 아이디
    
    /* // 2. 관리자 리다이렉트 로직은 테스트를 위해 잠시 주석 처리합니다.
    if("ADMIN".equals(loginUser.division)) {
        response.sendRedirect(request.getContextPath() + "/qna/list.do");
        return;
    }
    */
    
    // 만약의 상황을 대비한 기본값 설정
    if(loginUser.division == null) loginUser.division = "USER";
%>

 --%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - Q&A <c:if test="${not empty qna}">수정</c:if><c:if test="${empty qna}">등록</c:if></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .theme-owner { background-color: #2563eb !important; color: white !important; border-color: #2563eb !important; }
        .theme-user { background-color: #f97316 !important; color: white !important; border-color: #f97316 !important; }
        
        .theme-text-owner { color: #2563eb !important; }
        .theme-text-user { color: #f97316 !important; }
        
        .theme-border-owner { border-color: #2563eb !important; }
        .theme-border-user { border-color: #f97316 !important; }
    </style>
</head>
<body class="pb-20">

    <header class="bg-white border-b-4 py-6 sticky top-0 z-50 shadow-sm
        <c:choose>
            <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
            <c:otherwise>theme-border-user</c:otherwise>
        </c:choose>">
        <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/main.do" 
               class="text-4xl b-grade-font tracking-tighter italic
               <c:choose>
                   <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
                   <c:otherwise>theme-text-user</c:otherwise>
               </c:choose>">D.D.M</a>
            <div class="flex items-center gap-4">
                <span class="text-[10px] font-black bg-gray-100 text-gray-500 px-4 py-2 rounded-full uppercase">
                    ROLE: <span class="<c:choose>
                        <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
                        <c:otherwise>theme-text-user</c:otherwise>
                    </c:choose>">${loginUser.division}</span>
                </span>
            </div>
        </div>
    </header>

    <main class="max-w-[900px] mx-auto px-6 py-12">
        
        <!-- 페이지 제목 -->
        <h2 class="text-4xl b-grade-font text-gray-900 mb-8">
            <c:choose>
                <c:when test="${not empty qna}">
                    <i class="fas fa-edit mr-3"></i>질문 수정
                </c:when>
                <c:otherwise>
                    <i class="fas fa-plus-circle mr-3"></i>질문 등록
                </c:otherwise>
            </c:choose>
        </h2>

        <!-- 에러 메시지 -->
        <c:if test="${not empty errorMsg}">
            <div class="bg-red-100 border-2 border-red-500 text-red-700 px-6 py-4 rounded-2xl mb-6 font-bold">
                <i class="fas fa-exclamation-circle mr-2"></i>${errorMsg}
            </div>
        </c:if>

        <!-- 폼 -->
        <c:choose>
            <c:when test="${not empty qna}">
                <!-- 수정 모드 -->
                <form action="${pageContext.request.contextPath}/qna/update.do" 
                      method="post" 
                      onsubmit="return validateForm()"
                      class="bg-white p-10 rounded-[35px] border-2 shadow-lg
                      <c:choose>
                          <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
                          <c:otherwise>theme-border-user</c:otherwise>
                      </c:choose>">
                    
                    <input type="hidden" name="qnaId" value="${qna.qnaId}">
                    
                    <!-- 제목 입력 -->
                    <div class="mb-6">
                        <label class="block text-sm font-bold text-gray-700 mb-2">
                            제목 <span class="text-red-500">*</span>
                        </label>
                        <input type="text" 
                               name="qnaTitle" 
                               id="qnaTitle"
                               required 
                               maxlength="300"
                               value="${qna.qnaTitle}"
                               class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg"
                               placeholder="질문 제목을 입력하세요 (최대 300자)">
                        <p class="text-xs text-gray-400 mt-2">
                            <span id="titleCount">0</span> / 300자
                        </p>
                    </div>

                    <!-- 내용 입력 -->
                    <div class="mb-6">
                        <label class="block text-sm font-bold text-gray-700 mb-2">
                            내용 <span class="text-red-500">*</span>
                        </label>
                        <textarea name="qnaContent" 
                                  id="qnaContent"
                                  required 
                                  maxlength="500" 
                                  rows="12"
                                  class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none"
                                  placeholder="질문 내용을 입력하세요 (최대 500자)">${qna.qnaContent}</textarea>
                        <p class="text-xs text-gray-400 mt-2">
                            <span id="contentCount">0</span> / 500자
                        </p>
                    </div>

                    <!-- 비밀글 설정 -->
                    <div class="mb-8 p-5 bg-purple-50 rounded-2xl border-2 border-purple-200">
                        <label class="flex items-center gap-3 cursor-pointer">
                            <input type="checkbox" 
                                   name="secretYn" 
                                   value="Y" 
                                   ${qna.secretYn == 'Y' ? 'checked' : ''}
                                   class="w-6 h-6 text-purple-600 border-2 border-purple-300 rounded focus:ring-2 focus:ring-purple-500">
                            <div>
                                <span class="text-sm font-black text-purple-900 block">
                                    <i class="fas fa-lock mr-2"></i>비밀글로 설정
                                </span>
                                <span class="text-xs text-purple-600">
                                    체크하면 본인과 관리자만 볼 수 있습니다
                                </span>
                            </div>
                        </label>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="flex gap-3 pt-6 border-t-2 border-gray-100">
                        <button type="submit" 
                                class="flex-1 py-4 rounded-xl font-black text-lg shadow-lg hover:opacity-90 transition
                                <c:choose>
                                    <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
                                    <c:otherwise>theme-user</c:otherwise>
                                </c:choose>">
                            <i class="fas fa-save mr-2"></i>수정 완료
                        </button>
                        <button type="button" 
                                onclick="goBack()" 
                                class="px-10 py-4 bg-gray-200 hover:bg-gray-300 rounded-xl font-bold text-gray-700 transition">
                            <i class="fas fa-times mr-2"></i>취소
                        </button>
                    </div>

                </form>
            </c:when>
            <c:otherwise>
                <!-- 등록 모드 -->
                <form action="${pageContext.request.contextPath}/qna/insert.do" 
                      method="post" 
                      onsubmit="return validateForm()"
                      class="bg-white p-10 rounded-[35px] border-2 shadow-lg
                      <c:choose>
                          <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
                          <c:otherwise>theme-border-user</c:otherwise>
                      </c:choose>">
                    
                    <!-- 제목 입력 -->
                    <div class="mb-6">
                        <label class="block text-sm font-bold text-gray-700 mb-2">
                            제목 <span class="text-red-500">*</span>
                        </label>
                        <input type="text" 
                               name="qnaTitle" 
                               id="qnaTitle"
                               required 
                               maxlength="300"
                               class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg"
                               placeholder="질문 제목을 입력하세요 (최대 300자)">
                        <p class="text-xs text-gray-400 mt-2">
                            <span id="titleCount">0</span> / 300자
                        </p>
                    </div>

                    <!-- 내용 입력 -->
                    <div class="mb-6">
                        <label class="block text-sm font-bold text-gray-700 mb-2">
                            내용 <span class="text-red-500">*</span>
                        </label>
                        <textarea name="qnaContent" 
                                  id="qnaContent"
                                  required 
                                  maxlength="500" 
                                  rows="12"
                                  class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none"
                                  placeholder="질문 내용을 입력하세요 (최대 500자)"></textarea>
                        <p class="text-xs text-gray-400 mt-2">
                            <span id="contentCount">0</span> / 500자
                        </p>
                    </div>

                    <!-- 비밀글 설정 -->
                    <div class="mb-8 p-5 bg-purple-50 rounded-2xl border-2 border-purple-200">
                        <label class="flex items-center gap-3 cursor-pointer">
                            <input type="checkbox" 
                                   name="secretYn" 
                                   value="Y"
                                   class="w-6 h-6 text-purple-600 border-2 border-purple-300 rounded focus:ring-2 focus:ring-purple-500">
                            <div>
                                <span class="text-sm font-black text-purple-900 block">
                                    <i class="fas fa-lock mr-2"></i>비밀글로 설정
                                </span>
                                <span class="text-xs text-purple-600">
                                    체크하면 본인과 관리자만 볼 수 있습니다
                                </span>
                            </div>
                        </label>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="flex gap-3 pt-6 border-t-2 border-gray-100">
                        <button type="submit" 
                                class="flex-1 py-4 rounded-xl font-black text-lg shadow-lg hover:opacity-90 transition
                                <c:choose>
                                    <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
                                    <c:otherwise>theme-user</c:otherwise>
                                </c:choose>">
                            <i class="fas fa-check mr-2"></i>등록하기
                        </button>
                        <button type="button" 
                                onclick="goBack()" 
                                class="px-10 py-4 bg-gray-200 hover:bg-gray-300 rounded-xl font-bold text-gray-700 transition">
                            <i class="fas fa-times mr-2"></i>취소
                        </button>
                    </div>

                </form>
            </c:otherwise>
        </c:choose>

    </main>

    <script>
        // 글자 수 카운트 함수
        function updateCharCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(countId);
            
            input.addEventListener('input', function() {
                const currentLength = this.value.length;
                counter.textContent = currentLength;
                
                if(currentLength >= maxLength * 0.9) {
                    counter.classList.add('text-red-500', 'font-bold');
                } else {
                    counter.classList.remove('text-red-500', 'font-bold');
                }
            });
            
            const currentLength = input.value.length;
            counter.textContent = currentLength;
        }

        // 유효성 검사
        function validateForm() {
            const title = document.getElementById('qnaTitle').value.trim();
            const content = document.getElementById('qnaContent').value.trim();
            
            if(title === '') {
                alert('제목을 입력해주세요.');
                document.getElementById('qnaTitle').focus();
                return false;
            }
            
            if(content === '') {
                alert('내용을 입력해주세요.');
                document.getElementById('qnaContent').focus();
                return false;
            }
            
            if(title.length > 300) {
                alert('제목은 300자를 초과할 수 없습니다.');
                return false;
            }
            
            if(content.length > 500) {
                alert('내용은 500자를 초과할 수 없습니다.');
                return false;
            }
            
            return true;
        }

        // 뒤로가기 처리
        function goBack() {
            const isUpdate = ${not empty qna};
            const qnaId = '${not empty qna ? qna.qnaId : ""}';
            
            if(confirm('작성 중인 내용이 저장되지 않습니다. 정말 취소하시겠습니까?')) {
                if(isUpdate && qnaId) {
                    location.href = '${pageContext.request.contextPath}/qna/detail.do?qnaId=' + qnaId;
                } else {
                    location.href = '${pageContext.request.contextPath}/qna/list.do';
                }
            }
        }

        // 페이지 로드 시 실행
        window.onload = function() {
            updateCharCount('qnaTitle', 'titleCount', 300);
            updateCharCount('qnaContent', 'contentCount', 500);
        };

        // 페이지 벗어날 때 경고
        let formChanged = false;
        
        document.getElementById('qnaTitle').addEventListener('input', () => formChanged = true);
        document.getElementById('qnaContent').addEventListener('input', () => formChanged = true);
        
        window.addEventListener('beforeunload', function(e) {
            if(formChanged) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        document.querySelector('form').addEventListener('submit', () => formChanged = false);
    </script>

</body>
</html>