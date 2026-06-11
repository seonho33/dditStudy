<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="activeTab" value="notice" />


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 공지사항</title>
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

        .hidden { display: none !important; }
        
        /*  공지사항 리스트 스타일 */
        .notice-item {
            transition: all 0.2s;
            cursor: pointer;
        }
        .notice-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
    
    
       /* 상단 고정 공지 - 전체 스타일에 자연스럽게 어울리는 강조 */
		.notice-top {
		    background-color: #fff7ed !important; /* 연한 오렌지 톤 */
		    border: 2px solid rgba(249, 115, 22, 0.35) !important;
		    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.06) !important;
		    position: relative;
		}
		
		/* 왼쪽 포인트 바 (시선 유도용) */
		.notice-top::before {
		    content: "";
		    position: absolute;
		    left: 0;
		    top: 12px;
		    bottom: 12px;
		    width: 6px;
		    border-radius: 6px;
		    background-color: #f97316;
		}
		
		/* 제목 */
		.notice-top h4 {
		    color: #7c2d12 !important;
		    font-weight: 900 !important;
		}
		
		/* 메타 정보 */
		.notice-top span,
		.notice-top i {
		    color: #9a3412 !important;
		}
		
		/* 상단 고정 뱃지 */
		.notice-top .bg-white\/20 {
		    background-color: #f97316 !important;
		    color: white !important;
		    font-weight: 800 !important;
		}
		
		/* 화살표 */
		.notice-top .fa-chevron-right {
		    color: #fb923c !important;
		}

/* ===== 상단 고정 공지 : 역할별 색상 ===== */

/* 관리자 */
.notice-top.admin {
  background-color: #f3f4f6 !important;
  border: 2px solid rgba(17,24,39,.35) !important;
}
.notice-top.admin::before {
  background-color: #111827;
}
.notice-top.admin h4,
.notice-top.admin span,
.notice-top.admin i {
  color: #111827 !important;
}

/* 점주 */
.notice-top.owner {
  background-color: #eff6ff !important;
  border: 2px solid rgba(37,99,235,.35) !important;
}
.notice-top.owner::before {
  background-color: #2563eb;
}
.notice-top.owner h4,
.notice-top.owner span,
.notice-top.owner i {
  color: #1e40af !important;
}

/* 일반회원 */
.notice-top.user {
  background-color: #fff7ed !important;
  border: 2px solid rgba(249,115,22,.35) !important;
}
.notice-top.user::before {
  background-color: #f97316;
}
.notice-top.user h4,
.notice-top.user span,
.notice-top.user i {
  color: #9a3412 !important;
}
/* ===== 상단 고정 배지(원) 역할별 색상 ===== */

/* 관리자 */
.notice-top.admin .bg-white\/20{
  background-color:#111827 !important;
  color:#ffffff !important;
}

/* 점주 */
.notice-top.owner .bg-white\/20{
  background-color:#2563eb !important;
  color:#ffffff !important;
}

/* 일반회원 */
.notice-top.user .bg-white\/20{
  background-color:#f97316 !important;
  color:#ffffff !important;
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
        
        <!-- 탭 버튼 -->
        <div class="flex gap-2 mb-12 p-2 bg-white rounded-[30px] w-fit mx-auto border-2 border-gray-100 shadow-sm">
<button type="button"
        onclick="location.href='${pageContext.request.contextPath}/notice/list.do'"
        id="tab-notice"
        class="tab-btn px-12 py-4 rounded-[22px] font-black
        <c:if test='${activeTab eq "notice"}'>
          <c:choose>
            <c:when test="${loginUser.division == '관리자'}">theme-admin</c:when>
            <c:when test="${loginUser.division == '점주'}">theme-owner</c:when>
            <c:otherwise>theme-user</c:otherwise>
          </c:choose>
        </c:if>">
  공지사항
</button>

<button type="button"
        onclick="location.href='${pageContext.request.contextPath}/qna/list.do'"
        id="tab-qna"
        class="tab-btn px-12 py-4 rounded-[22px] font-black">
  Q&A 커뮤니티
</button>

        </div>

        <!-- 공지사항 섹션 -->
        <div id="notice-section">
            
            <!-- 헤더 -->
            <div class="flex justify-between items-center mb-6">
            <h3 class="text-3xl b-grade-font
<c:choose>
  <c:when test="${loginUser.division == '관리자'}">theme-text-admin</c:when>
  <c:when test="${loginUser.division == '점주'}">theme-text-owner</c:when>
  <c:otherwise>theme-text-user</c:otherwise>
</c:choose>">
 NOTICE
</h3>

                
                <!-- 관리자만 등록 버튼 표시 -->
                <c:if test="${loginUser.division == '관리자'}">
                    <button onclick="location.href='${pageContext.request.contextPath}/notice/insert.do'" 
                            class="theme-admin px-6 py-3 rounded-xl font-black shadow-lg">
                        <i class="fas fa-plus mr-2"></i>공지 등록
                    </button>
                </c:if>
            </div>

            <!-- 검색 폼 -->
            <div class="bg-white p-4 rounded-2xl border-2 border-gray-100 mb-6 shadow-sm">
                <form action="${pageContext.request.contextPath}/notice/list.do" method="get" class="flex gap-3">
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

            <!-- 공지사항 리스트 -->
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty noticeList}">
                        <div class="bg-white p-12 rounded-3xl border-2 border-gray-100 shadow-sm text-center">
                            <i class="fas fa-inbox text-6xl text-gray-300 mb-4"></i>
                            <p class="text-gray-400 font-bold text-lg">등록된 공지사항이 없습니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
<c:forEach var="notice" items="${noticeList}">

    <%-- 역할별 기본 테두리 클래스 --%>
    <c:set var="roleBorderClass" value="${
        loginUser.division == '관리자' ? 'theme-border-admin' :
        loginUser.division == '점주' ? 'theme-border-owner' :
        'theme-border-user'
    }"/>

    <%-- 상단고정 + 역할별 강조 클래스 --%>
    <c:set var="topClass" value="${
        notice.topYn == 'Y' ?
            (loginUser.division == '관리자' ? 'notice-top admin' :
             loginUser.division == '점주' ? 'notice-top owner' :
             'notice-top user')
        : ''
    }"/>

    <div class="notice-item bg-white p-6 rounded-3xl border-2 shadow-sm ${roleBorderClass} ${topClass}"
         onclick="location.href='${pageContext.request.contextPath}/notice/detail.do?noticeNo=${notice.noticeNo}'">

        <div class="flex items-start justify-between">
            <div class="flex-1">

                <%-- 상단 고정 뱃지 --%>
                <c:if test="${notice.topYn == 'Y'}">
                    <span class="inline-block px-3 py-1 bg-white/20 rounded-full text-xs font-black mb-2">
                        <i class="fas fa-thumbtack mr-1"></i>상단 고정
                    </span>
                </c:if>

                <%-- 제목 --%>
                <h4 class="text-xl font-black mb-2 text-gray-800">
                    ${notice.noticeTitle}
                </h4>

                <%-- 메타 정보 (원래대로) --%>
                <div class="flex items-center gap-4 text-sm text-gray-500">
                    <span><i class="far fa-user mr-1"></i>${notice.userId}</span>
                    <span><i class="far fa-calendar mr-1"></i><fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd"/></span>
                    <span><i class="far fa-eye mr-1"></i>${notice.hitCount}</span>
                </div>

            </div>

            <%-- ✅ 화살표 제거 완료 --%>

        </div>
    </div>
</c:forEach>

                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 -->
            <c:if test="${not empty noticeList && totalPages > 1}">
                <div class="flex justify-center items-center gap-2 mt-12">
                    
                    <!-- 이전 페이지 -->
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/notice/list.do?page=${currentPage - 1}&keyword=${keyword}" 
                           class="px-4 py-2 rounded-lg border-2 border-gray-200 hover:border-gray-400 transition">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>
                    
                    <!-- 페이지 번호 -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/notice/list.do?page=${i}&keyword=${keyword}" 
                           class="px-4 py-2 rounded-lg font-bold transition
                           ${i == currentPage ? 
                             (loginUser.division == '관리자' ? 'theme-admin' : (loginUser.division == '점주' ? 'theme-owner' : 'theme-user'))
                             : 'border-2 border-gray-200 hover:border-gray-400 text-gray-600'}">
                            ${i}
                        </a>
                    </c:forEach>
                    
                    <!-- 다음 페이지 -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/notice/list.do?page=${currentPage + 1}&keyword=${keyword}" 
                           class="px-4 py-2 rounded-lg border-2 border-gray-200 hover:border-gray-400 transition">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>

        </div>
    </main>
<script>
  // ✅ 1) 화면 어디든 클릭이 잡히는지 (캡처 단계)
  document.addEventListener('click', function(e){
    const item = e.target.closest('.notice-item');
    console.log('[CLICK]', 'target=', e.target, 'noticeItem=', !!item);
    if (item) console.log('data-href=', item.getAttribute('data-href'), 'onclick=', item.getAttribute('onclick'));
  }, true); // ← 캡처 true
</script>

</body>
</html>