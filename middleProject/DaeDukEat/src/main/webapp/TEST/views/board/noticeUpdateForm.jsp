<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
	UserVO uvo = (UserVO)session.getAttribute("loginUser");

	String userRole = uvo.getDivision();
    if(userRole == null || !"관리자".equals(userRole)) {
        response.sendRedirect(request.getContextPath() + "/notice/list.do");
        return;
    }

    // 수정 모드인지 등록 모드인지 판단
   boolean isUpdateMode = request.getAttribute("notice") != null;
%>
<c:set var="isUpdate" value="${not empty notice}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 공지사항 ${isUpdate ? '수정' : '등록'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-text-admin { color: #1a1a1b !important; }
        .theme-border-admin { border-color: #1a1a1b !important; }
    </style>
</head>
<body class="pb-20">

    <header class="bg-white border-b-4 theme-border-admin py-6 sticky top-0 z-50 shadow-sm">
        <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/main.do" 
               class="text-4xl b-grade-font tracking-tighter italic theme-text-admin">D.D.M</a>
            <div class="flex items-center gap-4">
                <span class="text-[10px] font-black bg-gray-100 text-gray-500 px-4 py-2 rounded-full uppercase">
                    ROLE: <span class="theme-text-admin">관리자</span>
                </span>
            </div>
        </div>
    </header>

    <main class="max-w-[900px] mx-auto px-6 py-12">
        
        <!-- 페이지 제목 -->
        <h2 class="text-4xl b-grade-font text-gray-900 mb-8">
            <i class="fas ${isUpdate ? 'fa-edit' : 'fa-plus-circle'} mr-3"></i>
            공지사항 ${isUpdate ? '수정' : '등록'}
        </h2>

        <!-- 에러 메시지 -->
        <c:if test="${not empty errorMsg}">
            <div class="bg-red-100 border-2 border-red-500 text-red-700 px-6 py-4 rounded-2xl mb-6 font-bold">
                <i class="fas fa-exclamation-circle mr-2"></i>${errorMsg}
            </div>
        </c:if>

        <!-- 폼 -->
        <form action="${pageContext.request.contextPath}/notice/${isUpdate ? 'update' : 'insert'}.do" 
              method="post" 
              onsubmit="return validateForm()"
              class="bg-white p-10 rounded-[35px] border-2 theme-border-admin shadow-lg">
            
            <!-- 수정 모드일 때만 noticeNo 전송 -->
            <c:if test="${isUpdate}">
                <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
            </c:if>
            
            <!-- 제목 입력 -->
            <div class="mb-6">
                <label class="block text-sm font-bold text-gray-700 mb-2">
                    제목 <span class="text-red-500">*</span>
                </label>
                <input type="text" 
                       name="noticeTitle" 
                       id="noticeTitle"
                       required 
                       maxlength="200"
                       value="${isUpdate ? notice.noticeTitle : ''}"
                       class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg"
                       placeholder="공지사항 제목을 입력하세요 (최대 200자)">
                <p class="text-xs text-gray-400 mt-2">
                    <span id="titleCount">0</span> / 200자
                </p>
            </div>

            <!-- 내용 입력 -->
            <div class="mb-6">
                <label class="block text-sm font-bold text-gray-700 mb-2">
                    내용 <span class="text-red-500">*</span>
                </label>
                <textarea name="noticeContent" 
                          id="noticeContent"
                          required 
                          maxlength="1000" 
                          rows="15"
                          class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none"
                          placeholder="공지사항 내용을 입력하세요 (최대 1000자)">${isUpdate ? notice.noticeContent : ''}</textarea>
                <p class="text-xs text-gray-400 mt-2">
                    <span id="contentCount">0</span> / 1000자
                </p>
            </div>

            <!-- 상단 고정 여부 -->
            <div class="mb-8 p-5 bg-purple-50 rounded-2xl border-2 border-purple-200">
                <label class="flex items-center gap-3 cursor-pointer">
                    <input type="checkbox" 
                           name="topYn" 
                           value="Y" 
                           ${isUpdate && notice.topYn == 'Y' ? 'checked' : ''}
                           class="w-6 h-6 text-purple-600 border-2 border-purple-300 rounded focus:ring-2 focus:ring-purple-500">
                    <div>
                        <span class="text-sm font-black text-purple-900 block">
                            <i class="fas fa-thumbtack mr-2"></i>상단에 고정
                        </span>
                        <span class="text-xs text-purple-600">
                            체크하면 게시판 최상단에 항상 표시됩니다
                        </span>
                    </div>
                </label>
            </div>

            <!-- 버튼 영역 -->
            <div class="flex gap-3 pt-6 border-t-2 border-gray-100">
                <button type="submit" 
                        class="flex-1 py-4 theme-admin rounded-xl font-black text-lg shadow-lg hover:opacity-90 transition">
                    <i class="fas ${isUpdate ? 'fa-save' : 'fa-check'} mr-2"></i>
                    ${isUpdate ? '수정 완료' : '등록하기'}
                </button>
                <button type="button" 
                        onclick="goBack()" 
                        class="px-10 py-4 bg-gray-200 hover:bg-gray-300 rounded-xl font-bold text-gray-700 transition">
                    <i class="fas fa-times mr-2"></i>취소
                </button>
            </div>

        </form>

    </main>

    <script>
        // 글자 수 카운트 함수
        function updateCharCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(countId);
            
            input.addEventListener('input', function() {
                const currentLength = this.value.length;
                counter.textContent = currentLength;
                
                // 90% 이상이면 경고 색상
                if(currentLength >= maxLength * 0.9) {
                    counter.classList.add('text-red-500', 'font-bold');
                } else {
                    counter.classList.remove('text-red-500', 'font-bold');
                }
            });
            
            // 초기 카운트 설정
            const currentLength = input.value.length;
            counter.textContent = currentLength;
        }

        // 유효성 검사
        function validateForm() {
            const title = document.getElementById('noticeTitle').value.trim();
            const content = document.getElementById('noticeContent').value.trim();
            
            if(title === '') {
                alert('제목을 입력해주세요.');
                document.getElementById('noticeTitle').focus();
                return false;
            }
            
            if(content === '') {
                alert('내용을 입력해주세요.');
                document.getElementById('noticeContent').focus();
                return false;
            }
            
            if(title.length > 200) {
                alert('제목은 200자를 초과할 수 없습니다.');
                return false;
            }
            
            if(content.length > 1000) {
                alert('내용은 1000자를 초과할 수 없습니다.');
                return false;
            }
            
            return true;
        }

        // 뒤로가기 처리
        function goBack() {
            const isUpdate = ${isUpdate};
            const noticeNo = '${isUpdate ? notice.noticeNo : ""}';
            
            if(confirm('작성 중인 내용이 저장되지 않습니다. 정말 취소하시겠습니까?')) {
                if(isUpdate && noticeNo) {
                    // 수정 모드일 때는 상세 페이지로
                    location.href = '${pageContext.request.contextPath}/notice/detail.do?noticeNo=' + noticeNo;
                } else {
                    // 등록 모드일 때는 목록으로
                    location.href = '${pageContext.request.contextPath}/notice/list.do';
                }
            }
        }

        // 페이지 로드 시 실행
        window.onload = function() {
            updateCharCount('noticeTitle', 'titleCount', 200);
            updateCharCount('noticeContent', 'contentCount', 1000);
        };

        // 페이지 벗어날 때 경고 (작성 중일 때만)
        let formChanged = false;
        
        document.getElementById('noticeTitle').addEventListener('input', () => formChanged = true);
        document.getElementById('noticeContent').addEventListener('input', () => formChanged = true);
        
        window.addEventListener('beforeunload', function(e) {
            if(formChanged) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        // 폼 제출 시에는 경고 해제
        document.querySelector('form').addEventListener('submit', () => formChanged = false);
    </script>

</body>
</html>