<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- ============================================================ -->
<!-- [VIEW LAYER] 공통 에러 페이지                               -->
<!-- ============================================================ -->
<!-- AUTHOR  : Senior Architect                                   -->
<!-- DATE    : 2025-01-23                                         -->
<!-- PURPOSE : 예외 발생 시 사용자 친화적 에러 메시지 표시       -->
<!-- DATA    : errorMessage (Controller에서 제공)                 -->
<!-- ============================================================ -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생 - D.D.M</title>
    
    <%-- Tailwind CSS CDN --%>
    <script src="https://cdn.tailwindcss.com"></script>
    
    <%-- Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
            20%, 40%, 60%, 80% { transform: translateX(10px); }
        }
        .animate-shake {
            animation: shake 0.5s ease-in-out;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100 min-h-screen flex items-center justify-center p-4">

    <div class="max-w-2xl w-full">
        
        <%-- ==================== 에러 카드 ==================== --%>
        <div class="bg-white rounded-[40px] shadow-2xl p-12 text-center">
            
            <%-- 에러 아이콘 --%>
            <div class="mb-8 animate-shake">
                <i class="fa-solid fa-circle-exclamation text-8xl text-red-500"></i>
            </div>

            <%-- 에러 메시지 --%>
            <h1 class="text-3xl font-black text-slate-800 mb-4">오류가 발생했습니다</h1>
            
            <c:choose>
                <%-- Controller에서 제공한 에러 메시지 --%>
                <c:when test="${not empty errorMessage}">
                    <div class="bg-red-50 border border-red-200 rounded-2xl p-6 mb-8">
                        <p class="text-red-700 font-medium text-sm leading-relaxed">
                            <i class="fa-solid fa-triangle-exclamation mr-2"></i>
                            <c:out value="${errorMessage}"/>
                        </p>
                    </div>
                </c:when>
                
                <%-- JSP 예외 정보 (개발 환경용) --%>
                <c:when test="${not empty pageContext.exception}">
                    <div class="bg-red-50 border border-red-200 rounded-2xl p-6 mb-8">
                        <p class="text-red-700 font-medium text-sm">
                            <i class="fa-solid fa-bug mr-2"></i>
                            <c:out value="${pageContext.exception.message}"/>
                        </p>
                        
                        <%-- 개발 환경에서만 스택 트레이스 표시 --%>
                        <c:if test="${pageContext.request.serverName eq 'localhost'}">
                            <details class="mt-4 text-left">
                                <summary class="cursor-pointer text-xs text-red-600 font-bold">스택 트레이스 보기</summary>
                                <pre class="mt-2 text-[10px] bg-white p-4 rounded-lg overflow-auto max-h-60 border border-red-100">
                                    <c:out value="${pageContext.exception}"/>
                                </pre>
                            </details>
                        </c:if>
                    </div>
                </c:when>
                
                <%-- 기본 에러 메시지 --%>
                <c:otherwise>
                    <p class="text-slate-500 mb-8">
                        일시적인 오류가 발생했습니다.<br>
                        잠시 후 다시 시도해주세요.
                    </p>
                </c:otherwise>
            </c:choose>

            <%-- 액션 버튼 --%>
            <div class="flex gap-4 justify-center">
                <button 
                    onclick="history.back()" 
                    class="bg-slate-200 text-slate-700 px-8 py-4 rounded-2xl font-bold hover:bg-slate-300 transition-all">
                    <i class="fa-solid fa-arrow-left mr-2"></i>이전 페이지
                </button>
                <a 
                    href="${pageContext.request.contextPath}/" 
                    class="bg-orange-500 text-white px-8 py-4 rounded-2xl font-black hover:bg-orange-600 transition-all">
                    <i class="fa-solid fa-home mr-2"></i>홈으로 이동
                </a>
            </div>

            <%-- 지원 안내 --%>
            <div class="mt-8 pt-8 border-t border-slate-100">
                <p class="text-xs text-slate-400">
                    문제가 계속되면 고객센터로 문의해주세요
                    <br>
                    <a href="mailto:support@ddm.com" class="text-orange-500 hover:underline">support@ddm.com</a>
                </p>
            </div>

        </div>

    </div>

</body>
</html>