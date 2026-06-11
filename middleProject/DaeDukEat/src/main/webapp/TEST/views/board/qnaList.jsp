<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--  <%

 
 UserVO uvo = (UserVO) session.getAttribute("loginUser");
 String userId = uvo.getUserId();
 String loginUser.division = uvo.getDivision(); 
 
/*  String loginUser.division = (String)session.getAttribute("loginUser.division");
    String userId = (String)session.getAttribute("userId"); */
  //  if(loginUser.division == null) loginUser.division = "USER";  

%>  --%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - Q&A 커뮤니티</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #f0f2f5; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .tab-btn { 
            background: #fff; border: 2px solid #e5e7eb; color: #9ca3af; 
            cursor: pointer; transition: all 0.2s ease-in-out;
        }

        .theme-admin { background-color: #1a1a1b !important; color: white !important; border-color: #1a1a1b !important; }
        .theme-owner { background-color: #2563eb !important; color: white !important; border-color: #2563eb !important; }
        .theme-user { background-color: #f97316 !important; color: white !important; border-color: #f97316 !important; }

        .theme-text-admin { color: #1a1a1b !important; }
        .theme-text-owner { color: #2563eb !important; }
        .theme-text-user { color: #f97316 !important; }

        .theme-border-admin { border-color: #1a1a1b !important; }
        .theme-border-owner { border-color: #2563eb !important; }
        .theme-border-user { border-color: #f97316 !important; }

        .qna-item { transition: all 0.2s; cursor: pointer; }
        .qna-item:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        
        .status-badge-pending { background: linear-gradient(135deg, #f97316 0%, #fb923c 100%); }
        .status-badge-complete { background: linear-gradient(135deg, #10b981 0%, #34d399 100%); }
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
        
        <!-- 탭 버튼 (NOTICE 연결) -->
        <div class="flex gap-2 mb-12 p-2 bg-white rounded-[30px] w-fit mx-auto border-2 border-gray-100 shadow-sm">
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/notice/list.do'" 
                    id="tab-notice" class="tab-btn px-12 py-4 rounded-[22px] font-black">
                공지사항
            </button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/qna/list.do'" 
                    id="tab-qna" class="tab-btn px-12 py-4 rounded-[22px] font-black
                    <c:choose>
                        <c:when test="${loginUser.division == '관리자'}">theme-admin</c:when>
                        <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
                        <c:otherwise>theme-user</c:otherwise>
                    </c:choose>">
                Q&A 커뮤니티
            </button>
        </div>

        <!-- Q&A 섹션 -->
        <div id="qna-section">
            
            <!-- 헤더 -->
            <div class="flex justify-between items-center mb-6">
<h3 class="text-3xl b-grade-font
<c:choose>
  <c:when test="${loginUser.division == '관리자'}">theme-text-admin</c:when>
  <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
  <c:otherwise>theme-text-user</c:otherwise>
</c:choose>">
  Q&A
</h3>

                
                <!-- 일반 회원만 질문 작성 버튼 표시 -->
                <c:if test="${loginUser.division != '관리자'}">
                    <button onclick="location.href='${pageContext.request.contextPath}/qna/insert.do'" 
                            class="px-6 py-3 rounded-xl font-black shadow-lg
                            <c:choose>
                                <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
                                <c:otherwise>theme-user</c:otherwise>
                            </c:choose>">
                        <i class="fas fa-plus mr-2"></i>질문 작성
                    </button>
                </c:if>
            </div>

            <!-- 검색 및 필터 -->
            <div class="bg-white p-4 rounded-2xl border-2 border-gray-100 mb-6 shadow-sm">
                <form action="${pageContext.request.contextPath}/qna/list.do" method="get" class="flex gap-3">
                    <select name="status" class="px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500 font-bold">
                        <option value="">전체 상태</option>
                        <option value="접수" ${status == '접수' ? 'selected' : ''}>접수</option>
                        <option value="완료" ${status == '완료' ? 'selected' : ''}>완료</option>
                    </select>
                    <input type="text" name="keyword" value="${keyword}" 
                           placeholder="제목으로 검색하세요..." 
                           class="flex-1 px-5 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:border-blue-500">
                    <button type="submit" class="px-8 py-3 rounded-xl font-black shadow-md
                        <c:choose>
                            <c:when test="${loginUser.division == '관리자'}">theme-admin</c:when>
                            <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
                            <c:otherwise>theme-user</c:otherwise>
                        </c:choose>">
                        <i class="fas fa-search mr-2"></i>검색
                    </button>
                </form>
            </div>

            <!-- Q&A 리스트 -->
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty qnaList}">
                        <div class="bg-white p-12 rounded-3xl border-2 border-gray-100 shadow-sm text-center">
                            <i class="fas fa-inbox text-6xl text-gray-300 mb-4"></i>
                            <p class="text-gray-400 font-bold text-lg">등록된 질문이 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="qna" items="${qnaList}">
                            <div class="qna-item bg-white p-6 rounded-3xl border-2 shadow-sm
                                <c:choose>
                                    <c:when test="${loginUser.division == '관리자'}">theme-border-admin</c:when>
                                    <c:when test="${loginUser.division == '점주'}">theme-border-owner</c:when>
                                    <c:otherwise>theme-border-user</c:otherwise>
                                </c:choose>"
                                onclick="location.href='${pageContext.request.contextPath}/qna/detail.do?qnaId=${qna.qnaId}'">
                                
                                <div class="flex items-start justify-between">
                                    <div class="flex-1">
                                        <!-- 상태 뱃지 -->
                                        <div class="flex items-center gap-2 mb-2">
                                            <c:choose>
                                                <c:when test="${qna.statusYn == '완료'}">
                                                    <span class="status-badge-complete px-3 py-1 text-white rounded-full text-xs font-black">
                                                        <i class="fas fa-check-circle mr-1"></i>답변 완료
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge-pending px-3 py-1 text-white rounded-full text-xs font-black">
                                                        <i class="fas fa-clock mr-1"></i>답변 대기
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- 비밀글 아이콘 -->
                                            <c:if test="${qna.secretYn == 'Y'}">
                                                <span class="px-3 py-1 bg-gray-800 text-white rounded-full text-xs font-black">
                                                    <i class="fas fa-lock mr-1"></i>비밀글
                                                </span>
                                            </c:if>
                                        </div>
                                        
<h4 class="text-xl font-black text-gray-800 mb-2">
  <c:choose>
    <c:when test="${qna.secretYn == 'Y' && loginUser.division != '관리자' && qna.userId != loginUser.userId}">
      비밀글입니다
    </c:when>
    <c:otherwise>
      ${qna.qnaTitle}
    </c:otherwise>
  </c:choose>
</h4>


                                        
                                        <!-- 메타 정보 -->
                                        <div class="flex items-center gap-4 text-sm text-gray-500">
                                            <span><i class="far fa-user mr-1"></i>${qna.userId}</span>
                                            <span><i class="far fa-calendar mr-1"></i><fmt:formatDate value="${qna.createDate}" pattern="yyyy-MM-dd"/></span>
                                        </div>
                                    </div>
                                    
                                    <!-- 화살표 아이콘 -->
                                    <div class="ml-4">
                                        <i class="fas fa-chevron-right text-2xl text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 -->
            <c:if test="${not empty qnaList && totalPages > 1}">
                <div class="flex justify-center items-center gap-2 mt-12">
                    
                    <!-- 이전 페이지 -->
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/qna/list.do?page=${currentPage - 1}&keyword=${keyword}&status=${status}" 
                           class="px-4 py-2 rounded-lg border-2 border-gray-200 hover:border-gray-400 transition">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>
                    
                    <!-- 페이지 번호 -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/qna/list.do?page=${i}&keyword=${keyword}&status=${status}" 
                           class="px-4 py-2 rounded-lg font-bold transition
                           ${i == currentPage ? 
                             (loginUser.division == '관리자' ? 'theme-admin' : (loginUser.division == '점주' ? 'theme-owner' : 'theme-user'))
                             : 'border-2 border-gray-200 hover:border-gray-400 text-gray-600'}">
                            ${i}
                        </a>
                    </c:forEach>
                    
                    <!-- 다음 페이지 -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/qna/list.do?page=${currentPage + 1}&keyword=${keyword}&status=${status}" 
                           class="px-4 py-2 rounded-lg border-2 border-gray-200 hover:border-gray-400 transition">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>

        </div>
    </main>

    <!-- ✅ 비밀글 권한 경고 flashMsg 출력 위치 (여기!) -->
    <c:if test="${not empty sessionScope.flashMsg}">
        <script>
            alert("${sessionScope.flashMsg}");
        </script>
        <c:remove var="flashMsg" scope="session"/>
    </c:if>
</body>
</html>