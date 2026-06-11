<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 공지사항 등록</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-border-admin { border-color: #1a1a1b !important; }
    </style>
</head>
<body class="pb-20">

    <header class="bg-white border-b-4 theme-border-admin py-6 sticky top-0 z-50 shadow-sm">
        <div class="max-w-[1200px] mx-auto px-6 flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/main.do" class="text-4xl b-grade-font tracking-tighter italic text-gray-900">D.D.M</a>
        </div>
    </header>

    <main class="max-w-[900px] mx-auto px-6 py-12">
        
        <h2 class="text-4xl b-grade-font text-gray-900 mb-8">공지사항 등록</h2>

        <c:if test="${not empty errorMsg}">
            <div class="bg-red-100 border-2 border-red-500 text-red-700 px-6 py-4 rounded-2xl mb-6">
                <i class="fas fa-exclamation-circle mr-2"></i>${errorMsg}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/notice/insert.do" method="post" 
              class="bg-white p-10 rounded-[35px] border-2 theme-border-admin shadow-lg">
            
            <!-- 제목 -->
            <div class="mb-6">
                <label class="block text-sm font-bold text-gray-700 mb-2">
                    제목 <span class="text-red-500">*</span>
                </label>
                <input type="text" name="noticeTitle" required maxlength="200"
                       class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg"
                       placeholder="공지사항 제목을 입력하세요">
            </div>

            <!-- 내용 -->
            <div class="mb-6">
                <label class="block text-sm font-bold text-gray-700 mb-2">
                    내용 <span class="text-red-500">*</span>
                </label>
                <textarea name="noticeContent" required maxlength="1000" rows="15"
                          class="w-full px-5 py-4 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 text-lg resize-none"
                          placeholder="공지사항 내용을 입력하세요"></textarea>
            </div>

            <!-- 상단 고정 여부 -->
            <div class="mb-8">
                <label class="flex items-center gap-3 cursor-pointer">
                    <input type="checkbox" name="topYn" value="Y" 
                           class="w-5 h-5 text-blue-600 border-2 border-gray-300 rounded">
                    <span class="text-sm font-bold text-gray-700">상단에 고정</span>
                </label>
            </div>

            <!-- 버튼 -->
            <div class="flex gap-3">
                <button type="submit" class="flex-1 py-4 theme-admin rounded-xl font-black text-lg shadow-lg">
                    <i class="fas fa-check mr-2"></i>등록하기
                </button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/notice/list.do'" 
                        class="px-8 py-4 bg-gray-200 hover:bg-gray-300 rounded-xl font-bold text-gray-700 transition">
                    취소
                </button>
            </div>

        </form>

    </main>

</body>
</html>