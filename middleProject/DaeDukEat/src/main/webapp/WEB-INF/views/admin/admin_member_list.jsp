<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>window.ctx = "<%=request.getContextPath()%>";</script>

<style>
    /* [기초 테마] */
    .admin-scope { background: #020617; color: #e2e8f0; padding: 40px; border-radius: 30px; font-family: 'Noto Sans KR', sans-serif; }
    .admin-card { background: #0f172a; border-radius: 24px; border: 1px solid #1e293b; padding: 30px; margin-bottom: 30px; }
    
    /* [테이블/리스트] */
    .row-item { background: rgba(15, 23, 42, 0.5); border: 1px solid #1e293b; border-radius: 16px; transition: 0.3s; margin-bottom: 12px; }
    .row-item:hover { border-color: #38bdf8; background: rgba(30, 41, 59, 0.8); }

    /* [벤 상태 - 한 줄 표시 핵심] */
    .ban-row-info { display: none; align-items: center; gap: 10px; background: rgba(239, 68, 68, 0.1); padding: 4px 12px; border-radius: 8px; border: 1px solid rgba(239, 68, 68, 0.2); }
    .is-banned .ban-row-info { display: flex; } /* 벤 활성화 시 보임 */
    .is-banned .btn-ban-trigger { display: none; } /* 벤 활성화 시 버튼 숨김 */

    /* [상태 뱃지] */
    .badge { font-size: 10px; font-weight: 900; padding: 4px 8px; border-radius: 6px; text-transform: uppercase; }
    .badge-wait { background: #334155; color: #94a3b8; }
    .badge-ok { background: #064e3b; color: #10b981; }
    .badge-no { background: #7f1d1d; color: #ef4444; }

    /* [검색창] */
    .search-input-fancy { background: #020617 !important; border: 2px solid #334155 !important; border-radius: 15px; padding: 12px 20px 12px 45px; color: white !important; outline: none; transition: 0.3s; width: 300px; }
    .search-input-fancy:focus { border-color: #38bdf8 !important; width: 350px; }

    /* [헤더 영역] */
    .header-section {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 2.5rem;
    }

    .header-title {
        font-size: 1.875rem;
        font-weight: 900;
        color: white;
        font-style: italic;
        text-transform: uppercase;
        letter-spacing: -0.05em;
    }

    .header-subtitle {
        color: #64748b;
        font-size: 0.875rem;
        margin-top: 0.25rem;
    }

    .search-wrapper {
        position: relative;
    }

    .search-icon {
        position: absolute;
        left: 1rem;
        top: 1rem;
        color: #64748b;
    }

    /* [섹션 타이틀] */
    .section-title {
        font-size: 1.125rem;
        font-weight: 700;
        color: white;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .title-bar {
        width: 0.375rem;
        height: 1.25rem;
        border-radius: 9999px;
    }

    .title-bar-sky {
        background-color: #0ea5e9;
    }

    .title-bar-orange {
        background-color: #f97316;
    }

    /* [컨텐츠 리스트] */
    .content-list {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    /* [Row 아이템 내부] */
    .row-content {
        padding: 1.25rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .row-info-group {
        display: flex;
        gap: 2.5rem;
        align-items: center;
    }

    .info-block {
        display: flex;
        flex-direction: column;
    }

    .info-label {
        font-size: 0.625rem;
        color: #64748b;
        display: block;
        margin-bottom: 0.25rem;
    }

    .info-value {
        font-size: 0.875rem;
        font-weight: 700;
    }

    .info-id {
        font-weight: 900;
        color: #38bdf8;
    }

    .info-company {
        font-size: 0.75rem;
        color: #94a3b8;
    }

    /* [버튼 그룹] */
    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }

    .btn-approve {
        background-color: #059669;
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.75rem;
        font-weight: 900;
        border: none;
        cursor: pointer;
    }

    .btn-reject {
        background-color: #334155;
        color: #cbd5e1;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.75rem;
        font-weight: 900;
        border: none;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn-reject:hover {
        background-color: #dc2626;
        color: white;
    }

    .processed-text {
        font-size: 0.625rem;
        color: #475569;
        font-weight: 900;
        font-style: italic;
    }

    /* [회원 제재 영역] */
    .member-row-content {
        padding: 1.25rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .member-info-group {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }

    .member-id {
        color: white;
        font-weight: 900;
    }

    .ban-badge {
        font-size: 0.625rem;
        background-color: #dc2626;
        color: white;
        padding: 0.125rem 0.5rem;
        border-radius: 0.25rem;
        font-weight: 900;
    }

    .ban-detail {
        font-size: 0.75rem;
        color: #fecaca;
        font-weight: 700;
    }

    .member-actions {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .btn-ban {
        border: 1px solid rgba(239, 68, 68, 0.5);
        color: #ef4444;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.75rem;
        font-weight: 900;
        background: transparent;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn-ban:hover {
        background-color: #ef4444;
        color: white;
    }

    .btn-unban {
        color: #64748b;
        font-size: 0.625rem;
        font-weight: 700;
        background: none;
        border: none;
        cursor: pointer;
    }

    .btn-unban:hover {
        text-decoration: underline;
    }

    /* [모달] */
    .modal-overlay {
        position: fixed;
        inset: 0;
        z-index: 500;
        align-items: center;
        justify-content: center;
        padding: 1.25rem;
        background-color: rgba(0, 0, 0, 0.8);
        backdrop-filter: blur(4px);
    }

    .modal-container {
        background-color: #0f172a;
        width: 100%;
        max-width: 400px;
        border-radius: 30px;
        border: 1px solid #334155;
        padding: 2rem;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    }

    .modal-title {
        font-size: 1.25rem;
        font-weight: 900;
        color: white;
        margin-bottom: 1.5rem;
        text-transform: uppercase;
    }

    .modal-form {
        display: flex;
        flex-direction: column;
        gap: 1.25rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-label {
        font-size: 0.625rem;
        color: #64748b;
        font-weight: 900;
        display: block;
        margin-bottom: 0.5rem;
        text-transform: uppercase;
    }

    .form-select,
    .form-input {
        background-color: #0f172a;
        border: 1px solid #334155;
        width: 100%;
        padding: 0.75rem;
        border-radius: 0.75rem;
        color: white;
        outline: none;
    }

    .form-input-hidden {
        margin-top: 0.5rem;
    }

    /* [라디오 버튼 그룹] */
    .radio-group {
        display: flex;
        gap: 0.5rem;
    }

    .radio-label {
        flex: 1;
        cursor: pointer;
    }

    .radio-input {
        display: none;
    }

    .radio-box {
        background-color: #1e293b;
        color: #64748b;
        padding: 0.5rem;
        text-align: center;
        border-radius: 0.5rem;
        font-size: 0.75rem;
        font-weight: 700;
        transition: 0.3s;
    }

    .radio-input:checked + .radio-box {
        background-color: #dc2626;
        color: white;
    }

    /* [모달 버튼] */
    .modal-buttons {
        display: flex;
        gap: 0.75rem;
        padding-top: 1rem;
    }

    .btn-cancel {
        flex: 1;
        color: #64748b;
        font-weight: 700;
        background: none;
        border: none;
        cursor: pointer;
    }

    .btn-confirm {
        flex: 2;
        background-color: #dc2626;
        color: white;
        padding: 1rem;
        border-radius: 1rem;
        font-weight: 900;
        box-shadow: 0 10px 15px -3px rgba(127, 29, 29, 0.4);
        border: none;
        cursor: pointer;
    }

    /* [빈 상태 메시지] */
    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: #475569;
    }

    .empty-state-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
        opacity: 0.3;
    }

    .empty-state-text {
        font-size: 0.875rem;
        font-weight: 600;
    }

    /* [유틸리티] */
    .hidden {
        display: none;
    }

    .flex {
        display: flex;
    }
    
    .member-user { color: orange; }
	.member-owner { color: #818CF8; }
	
	
	/* 해제 버튼 (Ban 버튼과 동일한 사이즈 & 스타일) */
.btn-unban-solid {
    border: 1px solid rgba(56, 189, 248, 0.6); /* sky-400 */
    color: #38bdf8;
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    font-size: 0.75rem;
    font-weight: 900;
    background: transparent;
    cursor: pointer;
    transition: 0.3s;
}

.btn-unban-solid:hover {
    background-color: #38bdf8;
    color: #020617; /* 다크 배경 대비 */
}
	
    
</style>

<div class="admin-scope">
    <div class="header-section">
        <div>
            <h2 class="header-title">Admin Master Console</h2>
            <p class="header-subtitle">승인 관리 및 회원 제재 통합 시스템</p>
        </div>
        <div class="search-wrapper">
            <i class="fa-solid fa-magnifying-glass search-icon"></i>
            <input type="text" class="search-input-fancy" placeholder="아이디/상호명 검색..." onkeyup="filterRows(this)">
        </div>
    </div>

    <!-- ✅ 핵심 수정: 데이터가 있을 때만 카드 전체 렌더링 -->
<div class="admin-card">
    <h3 class="section-title">
        <span class="title-bar title-bar-sky"></span> 사장님 가입 승인
    </h3>

<c:choose>
  <c:when test="${not empty ownerApplyList}">
    <div id="ownerApplyList" class="content-list">
      <c:forEach var="apply" items="${ownerApplyList}">
        <div class="row-item">
          <!-- procOwner가 읽을 userId (숨김) -->
          <div class="info-id" style="display:none;">${apply.userId}</div>

          <div class="row-content">
            <div class="row-info-group">
              <div class="info-block">
                <span class="info-label">APPLY DATE</span>
                <span class="info-value">${apply.createDate}</span>
              </div>

              <div class="info-block">
                <span class="info-label">NAME / COMPANY</span>
                <span class="info-value">
                  <span class="info-id-text">${apply.name}</span>
                  <span class="info-company">| ${apply.storeName}</span>
                </span>
              </div>

              <div class="status-cell">
                <span class="badge badge-wait">${apply.status}</span>
              </div>
            </div>

            <div class="action-cell action-buttons">
              <button type="button" onclick="procOwner(this, 'APPROVE')" class="btn-approve">승인</button>
              <button type="button" onclick="procOwner(this, 'REJECT')" class="btn-reject">거절</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:when>

  <c:otherwise>
    <div class="empty-state">
      <div class="empty-state-icon"><i class="fa-solid fa-clipboard-check"></i></div>
      <p class="empty-state-text">처리할 승인 요청이 없습니다.</p>
    </div>
  </c:otherwise>
</c:choose>

</div>

    
    <!-- ✅ 핵심 수정: 데이터가 있을 때만 카드 전체 렌더링 -->
    <c:if test="${not empty memberList}">
        <div class="admin-card">
            <h3 class="section-title">
                <span class="title-bar title-bar-orange"></span> 회원 제재 관리
            </h3>
            <div class="content-list">
                <c:forEach var="member" items="${memberList}">
					<div class="row-item ${member.blockYn eq 'Y' ? 'is-banned' : ''}" id="user_row_${member.userId}">
                        <div class="member-row-content">
                            <div class="member-info-group">
                                <span class="member-id">${member.userId}</span>
									<c:choose>
									    <c:when test="${member.division == '일반회원'}">
									        <span class="member-name member-user">${member.name}</span>
									    </c:when>
									    <c:when test="${member.division == '점주'}">
									        <span class="member-name member-owner">${member.name}</span>
									        <span class="member-name member-owner">${member.storeName}</span>
									    </c:when>
									</c:choose>

                                <div class="ban-row-info">
                                    <c:choose>
										<c:when test="${member.blockYn eq 'Y'}">
                                            <span class="ban-badge">BANNED</span>
                                            <span class="ban-detail" id="ban_txt_${member.userId}">
                                                사유: ${member.blockReason} | 
 												기간: ${fn:replace(member.blockDate, '-', '.')} ~ ${fn:replace(member.blockEndDate, '-', '.')}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="ban-badge">ACTIVE</span>
                                            <span class="ban-detail" id="ban_txt_${member.userId}">제재 없음</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

								<div class="member-actions">
								  <c:choose>
									<c:when test="${member.blockYn eq 'Y'}">
									  <button onclick="unban('${member.userId}')" class="btn-unban-solid">제재 해제</button>
									</c:when>
									<c:otherwise>
									  <button onclick="openBanModal('${member.userId}')" class="btn-ban btn-ban-trigger">제재하기</button>
									</c:otherwise>
								  </c:choose>
								</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- ✅ 추가: 모든 데이터가 없을 때 표시할 빈 상태 -->
    <c:if test="${empty ownerApplyList and empty memberList}">
        <div class="admin-card">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fa-solid fa-clipboard-check"></i>
                </div>
                <p class="empty-state-text">처리할 승인 요청이나 관리할 회원이 없습니다.</p>
            </div>
        </div>
    </c:if>
</div>

<!-- ✅ 모달은 항상 존재 (JavaScript로 제어) -->
<div id="banModal" class="modal-overlay hidden">
    <div class="modal-container">
        <h3 class="modal-title">Restrict User</h3>
        <div class="modal-form">
            <input type="hidden" id="targetId">
            <div class="form-group">
                <label class="form-label">Reason</label>
                <select id="reasonSel" class="form-select" onchange="toggleDir(this.value)">
                    <option value="비속어 사용">비속어 사용</option>
                    <option value="허위 도배">허위 도배</option>
                    <option value="DIRECT">직접 입력</option>
                </select>
                <input type="text" id="reasonDir" class="hidden form-input form-input-hidden" placeholder="사유를 입력하세요">
            </div>
            <div class="form-group">
                <label class="form-label">Period</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="days" value="3" class="radio-input" checked>
                        <div class="radio-box">3일</div>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="days" value="7" class="radio-input">
                        <div class="radio-box">7일</div>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="days" value="30" class="radio-input">
                        <div class="radio-box">30일</div>
                    </label>
                </div>
            </div>
            <div class="modal-buttons">
                <button onclick="closeModal()" class="btn-cancel">취소</button>
                <button onclick="confirmBan()" class="btn-confirm">제재 확정</button>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript" src="${pageContext.request.contextPath}/TEST/js/admin/adminevent.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/TEST/js/admin/admin.js"></script> 