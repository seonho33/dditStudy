<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<script>
    console.group("🔍 NOTICE DEBUG");

    console.log("notice =", "${notice}");
    console.log("noticeNo =", "${notice.noticeNo}");

    console.log("notice is empty? =", ${empty notice});
    console.log("noticeNo is empty? =", ${empty notice.noticeNo});

    console.groupEnd();
</script>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 공지사항 상세</title>
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
        
        <div class="mb-6">
            <button onclick="location.href='${pageContext.request.contextPath}/notice/list.do'" 
                    class="px-6 py-3 bg-gray-100 hover:bg-gray-200 rounded-xl font-bold text-gray-700 transition">
                <i class="fas fa-arrow-left mr-2"></i>목록으로
            </button>
        </div>

        <div class="bg-white p-10 rounded-[35px] border-2 shadow-lg
            <c:choose>
                <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
                <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
                <c:otherwise>theme-border-user</c:otherwise>
            </c:choose>">
            
            <div class="border-b-2 border-gray-100 pb-6 mb-6">
                <c:if test="${notice.topYn == 'Y'}">
                    <span class="inline-block px-4 py-2 bg-gradient-to-r from-purple-500 to-pink-500 text-white rounded-full text-sm font-black mb-4">
                        <i class="fas fa-thumbtack mr-2"></i>상단 고정
                    </span>
                </c:if>
                
                <h2 class="text-4xl font-black text-gray-900 mb-4">${notice.noticeTitle}</h2>
                
                <div class="flex items-center gap-6 text-sm text-gray-500">
                    <span><i class="far fa-user mr-2"></i>${notice.userId}</span>
                    <span><i class="far fa-calendar mr-2"></i><fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    <span><i class="far fa-eye mr-2"></i>조회 ${notice.hitCount}</span>
                    <c:if test="${notice.updateDate != null}">
                        <span class="text-blue-500"><i class="fas fa-edit mr-2"></i>수정됨</span>
                    </c:if>
                </div>
            </div>

            <div class="prose max-w-none mb-8">
                <p class="text-gray-700 leading-relaxed whitespace-pre-wrap text-lg">${notice.noticeContent}</p>
            </div>

            <c:if test="${loginUser.division == '관리자'}">
                <div class="flex justify-end gap-3 pt-6 border-t-2 border-gray-100">
                    <button onclick="location.href='${pageContext.request.contextPath}/notice/update.do?noticeNo=${notice.noticeNo}'" 
                            class="px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white rounded-xl font-bold transition">
                        <i class="fas fa-edit mr-2"></i>수정
                    </button>
                    <button onclick="deleteNotice()" 
                            class="px-6 py-3 bg-red-500 hover:bg-red-600 text-white rounded-xl font-bold transition">
                        <i class="fas fa-trash mr-2"></i>삭제
                    </button>
                </div>
            </c:if>

        </div>

    </main>

    <script>
        function deleteNotice() {
            if(confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/notice/delete.do';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'noticeNo';
                input.value = '${notice.noticeNo}';
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>

</body>
</html>