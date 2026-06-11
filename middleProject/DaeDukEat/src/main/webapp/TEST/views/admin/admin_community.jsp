<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
  window.COMMUNITY_URL = window.CTX + "/admin/community.do";
</script>


<style>
/* 스르륵 열림/닫힘 */
.comm-detail{
  overflow: hidden;
  max-height: 0;
  opacity: 0;
  transform: translateY(-6px);
  transition:
    max-height 0.45s ease,
    opacity 0.45s ease,
    transform 0.45s ease;
}

/* 열린 상태 */
.comm-card.is-open .comm-detail{
  opacity: 1;
  transform: translateY(0);
}

/* 카드 전체 클릭 UX */
.comm-card { cursor: pointer; }

/* 안내 전용 박스: 토글/호버/커서 없음 */
.comm-card.is-empty{
  cursor: default;
}
.comm-card.is-empty:hover{
  border-color: #1e293b; /* 기본 테두리 유지 */
}


/* 화살표 회전 */
.comm-toggle-icon { display:inline-block; transition: transform 0.25s ease; }
.comm-card.is-open .comm-toggle-icon { transform: rotate(180deg); }

/* ... 기존 스타일 유지 ... */
.comm-container { animation: comm-fadeIn 0.5s ease-out; color: #e2e8f0; }
@keyframes comm-fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
.comm-card { background: #0f172a; border-radius: 20px; border: 1px solid #1e293b; padding: 25px; margin-bottom: 25px; transition: 0.3s; }
.comm-card:hover { border-color: #38bdf8; }
.custom-input { background: #020617 !important; border: 1px solid #334155 !important; border-radius: 12px; padding: 12px 16px; color: white !important; outline: none; width: 100%; transition: 0.3s; }
.custom-input:focus { border-color: #38bdf8; box-shadow: 0 0 0 2px rgba(56, 189, 248, 0.1); }
.comm-label { font-size: 11px; font-weight: 800; color: #64748b; text-transform: uppercase; margin-bottom: 8px; display: block; }
.badge-notice { font-size: 10px; font-weight: 900; padding: 4px 8px; border: 1px solid rgba(56, 189, 248, 0.3); color: #38bdf8; border-radius: 6px; }
.badge-pending { font-size: 10px; font-weight: 900; padding: 4px 8px; border: 1px solid rgba(251, 146, 60, 0.3); color: #fb923c; border-radius: 6px; }
.btn-action{
  font-size: 16px;
  padding: 6px 10px;
  border-radius: 10px;
  font-weight: 800;
  cursor: pointer;
  transition: 0.2s;
  background: none;
  border: none;
}
.btn-submit-main { background: #38bdf8; color: #020617; padding: 14px; border-radius: 12px; font-weight: 900; width: 100%; cursor: pointer; border: none; margin-top: 10px; }

/* 에디터 닫는 동안 detail의 transition 잠시 끄기(턱 방지) */
.comm-detail.no-trans {
  transition: none !important;
}
.comm-text {
  white-space: pre-line;
}

</style>

<div class="comm-container">
  <div class="flex justify-between items-end mb-8">
    <div>
      <h2 class="text-3xl font-black text-white uppercase tracking-tighter italic">Community</h2>
      <p class="text-slate-500 text-sm mt-1">공지사항 및 사용자 문의를 관리합니다.</p>
    </div>
    <div class="relative">
      <input type="text" class="custom-input !w-80" placeholder="제목 또는 내용 검색..." onkeyup="filterComm(this)">
    </div>
  </div>

  <div class="grid grid-cols-5 gap-8">
    <!-- 좌측: 공지 등록 -->
    <div class="col-span-2">
      <div class="comm-card" style="position: sticky; top: 20px; cursor: default;" onclick="event.stopPropagation()">
        <span class="comm-label">Post New</span>
        <h4 class="text-xl font-bold text-white mb-6">공지사항 등록</h4>
        <div class="space-y-4">
          <input type="text" id="newTitle" class="custom-input" placeholder="공지 제목" onclick="event.stopPropagation()">
          <textarea id="newContent" class="custom-input" rows="5" placeholder="공지 내용을 상세히 입력하세요" onclick="event.stopPropagation()"></textarea>
          <button class="btn-submit-main" onclick="publishNotice(); event.stopPropagation();">지금 게시하기</button>
        </div>
      </div>
    </div>

    <!-- 우측: 리스트 영역 -->
    <div class="col-span-3 space-y-6" id="commListArea">

<div class="flex items-center justify-between mt-1">
  <div class="flex items-center gap-3">
    <span class="text-[11px] font-black uppercase tracking-widest text-slate-500">NOTICE</span>
    <span class="h-[1px] flex-1 bg-slate-800/70"></span>
  </div>
</div>


<!-- ================= 공지사항 ================= -->
<div id="noticeList">

<c:choose>
  <c:when test="${not empty noticeList}">
    <c:forEach var="notice" items="${noticeList}">
      <div class="comm-card comm-item notice-card" onclick="toggleCard(this)">
        <div class="comm-header flex justify-between items-start mb-2">
          <div class="flex items-center gap-3">
            <span class="badge-notice">NOTICE</span>
            <h4 class="text-lg font-bold text-white comm-title">
              ${notice.noticeTitle}
            </h4>
          </div>

          <div class="flex items-center gap-3">
            <span class="text-[10px] text-slate-500 font-bold uppercase">
              ${notice.createDate}
            </span>
            <span class="comm-toggle-icon text-slate-400 font-black">▼</span>
          </div>
        </div>

        <div class="comm-detail notice-detail mt-2 border-t border-slate-800/50 pt-4">
          <p class="text-slate-400 text-sm leading-relaxed mb-6 comm-text">
            ${notice.noticeContent}
          </p>

          <div class="flex justify-end gap-3">
<button class="btn-action text-slate-500 hover:text-white"
        onclick="event.stopPropagation(); openNoticeEdit('${notice.noticeNo}', this);">
  수정
</button>
            <button class="btn-action text-red-500"
                    onclick="deleteNotice(this, '${notice.noticeNo}'); event.stopPropagation();">
              삭제
            </button>
          </div>
        </div>
      </div>
    </c:forEach>
  </c:when>

  <c:otherwise>
    <!-- ✅ 안내 박스: 네모박스는 보이되 토글/호버/커서 없음 -->
    <div class="comm-card comm-item is-empty">
      <div class="text-center py-12">
        <p class="text-slate-400 font-bold">
          등록된 공지사항이 없습니다.
        </p>
        <p class="text-slate-500 text-sm mt-2">
          왼쪽에서 새 공지사항을 등록해 주세요.
        </p>
      </div>
    </div>
  </c:otherwise>
</c:choose>

</div>


<div class="flex items-center justify-between mt-10">
  <div class="flex items-center gap-3 w-full">
    <span class="text-[11px] font-black uppercase tracking-widest text-slate-500">UNANSWERED QNA</span>
    <span class="h-[1px] flex-1 bg-slate-800/70"></span>
  </div>
</div>

<!-- ================= 미답변 QNA ================= -->
<c:choose>
  <c:when test="${not empty qnaList}">
    <c:forEach var="qna" items="${qnaList}">
      <div class="comm-card comm-item qna-card border-l-4 border-l-orange-500"
           onclick="toggleCard(this)">
        <div class="comm-header flex justify-between items-start mb-2">
          <div class="flex items-center gap-3">
            <span class="badge-pending">PENDING QUESTION</span>
            <h4 class="text-lg font-bold text-white italic comm-title">
              ${qna.qnaTitle}
            </h4>
          </div>

          <div class="flex items-center gap-3">
            <span class="text-[10px] text-slate-500 font-bold uppercase">
              ${qna.createDate}
            </span>
            <span class="comm-toggle-icon text-slate-400 font-black">▼</span>
          </div>
        </div>

        <div class="comm-detail qna-detail mt-2 border-t border-slate-800/50 pt-4">
          <p class="text-slate-400 text-sm leading-relaxed mb-6 qna-text comm-text">
            ${qna.qnaContent}
          </p>

          <textarea class="custom-input mb-4 text-sm"
                    rows="3"
                    placeholder="답변을 작성하세요"
                    id="reply_${qna.qnaId}"
                    onclick="event.stopPropagation()"></textarea>

          <button class="w-full bg-sky-500 text-black py-3 rounded-xl font-black text-sm hover:bg-sky-400 transition-colors"
                  onclick="saveAnswer('${qna.qnaId}'); event.stopPropagation();">
            답변 저장하기
          </button>
        </div>
      </div>
    </c:forEach>
  </c:when>

  <c:otherwise>
    <!-- ✅ 안내 박스: 네모박스는 보이되 토글/호버/커서 없음 -->
    <div class="comm-card comm-item is-empty">
      <div class="text-center py-12">
        <p class="text-slate-400 font-bold">
          처리할 문의가 없습니다.
        </p>
        <p class="text-slate-500 text-sm mt-2">
          모든 문의가 정상적으로 처리되었습니다 👍
        </p>
      </div>
    </div>
  </c:otherwise>
</c:choose>



    </div><!-- ✅ commListArea 닫힘 -->
  </div><!-- grid 닫힘 -->
</div><!-- comm-container 닫힘 -->


<script src="<%=request.getContextPath()%>/TEST/js/admin/community.js"></script>

