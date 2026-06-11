<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<style>
/* =========================
   영달봇 관리자(조각 JSP) 전용 스코프
   ========================= */
.yd-wrap{ font-family:'Pretendard', sans-serif; color:#e2e8f0; }
.yd-header{ display:flex; align-items:center; justify-content:space-between; margin-bottom:18px; }
.yd-title{ font-size:22px; font-weight:900; color:#fff; display:flex; align-items:center; gap:10px; }
.yd-sub{ color:#64748b; font-size:13px; margin-top:6px; }

.yd-card{ background:#0f172a; border:1px solid #1e293b; border-radius:20px; padding:28px; }
.yd-grid{ display:grid; grid-template-columns:1fr 1fr; gap:18px; }
.yd-full{ grid-column: span 2; }

.yd-label{ display:block; font-size:11px; font-weight:900; color:#64748b; letter-spacing:.08em; text-transform:uppercase; margin-bottom:8px; }
.yd-input, .yd-textarea{
  width:100%; background:#020617 !important; border:1px solid #334155 !important; border-radius:14px;
  padding:14px 14px; color:#fff !important; outline:none; transition:.2s; font-size:14px;
}
.yd-textarea{ min-height:110px; resize:none; }
.yd-input:focus, .yd-textarea:focus{ border-color:#38bdf8 !important; box-shadow:0 0 0 3px rgba(56,189,248,.12); }

.yd-row{ display:flex; gap:10px; align-items:center; }
.yd-pill{
  display:inline-flex; align-items:center; gap:8px; padding:8px 12px; border-radius:999px;
  border:1px solid #1e293b; color:#94a3b8; background:rgba(15,23,42,.35); font-size:12px; font-weight:800;
}

.yd-badge{ display:inline-block; padding:4px 10px; border-radius:999px; font-size:11px; font-weight:900; letter-spacing:.03em; }
.yd-badge-on{
  background:rgba(34,197,94,.12);
  color:#22c55e;
  border:1px solid rgba(34,197,94,.30);
}
.yd-badge-off{
  background:rgba(239,68,68,.10);      /* ✅ 약한 붉은 배경 */
  color:#f87171;                       /* ✅ 연한 붉은 글자 */
  border:1px solid rgba(239,68,68,.22);
}

.yd-btn{
  border:none; cursor:pointer; transition:.2s; border-radius:14px; font-weight:900;
  padding:12px 14px; font-size:13px; display:inline-flex; align-items:center; gap:8px;
}
.yd-btn-primary{ background:#38bdf8; color:#020617; }
.yd-btn-primary:hover{ background:#7dd3fc; transform:translateY(-1px); }
.yd-btn-ghost{ background:transparent; border:1px solid #1e293b; color:#94a3b8; }
.yd-btn-ghost:hover{ background:#1e293b; color:#fff; }

.yd-table{ width:100%; border-collapse:collapse; margin-top:18px; }
.yd-table th{
  text-align:left; padding:14px 12px; border-bottom:2px solid #1e293b; color:#64748b;
  font-size:11px; font-weight:900; text-transform:uppercase; letter-spacing:.08em;
}
.yd-table td{ padding:16px 12px; border-bottom:1px solid #1e293b; color:#cbd5e1; font-size:14px; vertical-align:top; }
.yd-muted{ color:#94a3b8; }
.yd-ans{ color:#e2e8f0; line-height:1.5; white-space:pre-wrap; }

/* ✅ 액션 버튼: 가로 정렬 + 줄바꿈 최소화 */
.yd-actions{
  display:flex;
  align-items:center;
  justify-content:flex-end;
  gap:8px;
  flex-wrap:nowrap;     /* ✅ 세로로 떨어지는거 방지 */
  white-space:nowrap;
}
/* 버튼 폭 줄여서 한 줄에 잘 들어가게 */
.yd-linkbtn{
  padding:8px 10px;
  border-radius:12px;
  font-size:12px;
}
.yd-linkbtn:hover{ background:#1e293b; color:#fff; }
.yd-linkbtn.danger:hover{ background:rgba(239,68,68,.12); border-color:rgba(239,68,68,.25); color:#ef4444; }

.yd-divider{ height:1px; background:#1e293b; margin:22px 0; }
.yd-toast{ margin-top:14px; padding:12px 14px; border-radius:14px; border:1px solid #1e293b; color:#94a3b8; display:none; }
.yd-toast.show{ display:block; }

/* ✅ 토글 스위치 – 컴팩트 버전 */
.yd-toggle{
  width:40px;          /* ⬅ 기존 54 → 40 */
  height:22px;         /* ⬅ 기존 30 → 22 */
  border-radius:999px;
  border:1px solid #1e293b;
  background:#111827;
  position:relative;
  cursor:pointer;
  transition:.2s;
  flex:0 0 auto;
}

.yd-toggle::after{
  content:"";
  position:absolute;
  top:3px;             /* ⬅ 중앙 정렬 */
  left:3px;
  width:16px;          /* ⬅ 기존 22 → 16 */
  height:16px;
  border-radius:999px;
  background:#64748b;
  transition:.2s;
}

/* ON (Y) */
.yd-toggle.on{
  background:rgba(34,197,94,.14);
  border-color:rgba(34,197,94,.35);
}
.yd-toggle.on::after{
  left:21px;           /* ⬅ width - knob - margin */
  background:#22c55e;
}

/* OFF (N) */
.yd-toggle.off{
  background:rgba(239,68,68,.10);
  border-color:rgba(239,68,68,.25);
}
.yd-toggle.off::after{
  background:#f87171;
}

</style>

<div class="yd-wrap">

  <div class="yd-header">
    <div>
      <div class="yd-title">
        <i class="fa-solid fa-robot" style="color:#38bdf8;"></i>
        영달봇 관리
      </div>
      <div class="yd-sub">카테고리/키워드 룰을 관리하고, 챗봇 응답 대사를 등록합니다.</div>
    </div>
  </div>

  <!-- 등록/수정 폼 카드 -->
  <div class="yd-card">
    <div class="yd-row" style="justify-content:space-between; margin-bottom:14px;">
      <div style="font-weight:900; color:#fff; font-size:16px;">
        <i class="fa-solid fa-pen-to-square" style="color:#38bdf8;"></i>
        룰/대사 등록 · 수정
      </div>
      <span class="yd-pill" id="ydModePill">
        <i class="fa-solid fa-circle-info"></i>
        현재 모드: <b style="color:#fff;">등록</b>
      </span>
    </div>

    <!-- hidden -->
    <input type="hidden" id="ydBotId" value="">
    <input type="hidden" id="ydActiveYn" value="Y">
    <input type="hidden" id="ydUserId" value="">

    <div class="yd-grid">
      <div>
        <label class="yd-label">카테고리 네임</label>
        <input id="ydCategoryName" class="yd-input" type="text" placeholder="예) 한식, 치킨, 카페 ...">
        <div class="yd-sub" style="margin-top:8px;">* 가게 검색 시 store.category에 매칭되는 값으로 사용할 예정</div>
      </div>

      <div class="yd-full">
        <label class="yd-label">대사(answer_content)</label>
        <textarea id="ydAnswerContent" class="yd-textarea"
          placeholder="예) 오키! 여기 3군데 추천해줄게 🍊&#10;1) ... 2) ... 3) ..."></textarea>
      </div>

      <div class="yd-full">
        <label class="yd-label">트리거 키워드(question_keyword)</label>
        <input id="ydQuestionKeyword" class="yd-input" type="text"
          placeholder="예) 치킨, 치맥, 닭, 후라이드 (콤마로 구분)">
        <div class="yd-sub" style="margin-top:8px;">
          * 사용자가 입력한 문장에 키워드가 포함되면 해당 카테고리로 추천 로직이 실행됩니다. (콤마 구분 추천)
        </div>
      </div>
    </div>

    <div class="yd-row" style="justify-content:flex-end; margin-top:16px;">
      <button class="yd-btn yd-btn-ghost" type="button" onclick="ydFormReset()">
        <i class="fa-solid fa-eraser"></i> 초기화
      </button>
      <button class="yd-btn yd-btn-primary" type="button" id="ydSaveBtn">
        <i class="fa-solid fa-floppy-disk"></i> 저장
      </button>
    </div>

    <div class="yd-toast" id="ydToast"></div>
  </div>

  <div class="yd-divider"></div>

  <!-- 리스트 카드 -->
  <div class="yd-card">
    <div class="yd-row" style="justify-content:space-between; margin-bottom:10px;">
      <div style="font-weight:900; color:#fff; font-size:16px;">
        <i class="fa-solid fa-list" style="color:#38bdf8;"></i>
        등록된 룰 목록
      </div>
      <span class="yd-sub">총 <b style="color:#fff;"><c:out value="${empty botList ? 0 : fn:length(botList)}"/></b> 건</span>
    </div>

    <table class="yd-table">
<thead>
  <tr>
    <th style="width:16%;">카테고리</th>
    <th style="width:20%;">키워드</th>
    <th style="width:40%;">대사</th>
    <th style="width:14%;">활성</th>
    <th style="width:10%;">관리</th>
  </tr>
</thead>

      <tbody id="ydTableBody">
        <c:choose>
          <c:when test="${empty botList}">
            <tr>
				<td colspan="5" class="yd-muted" style="padding:22px 12px;">
                아직 등록된 데이터가 없습니다. 위 폼에서 카테고리와 키워드를 등록해 주세요.
              </td>
            </tr>
          </c:when>

          <c:otherwise>
            <c:forEach var="b" items="${botList}">
              <tr data-bot-id="${b.botId}">
                <td>
                  <div class="yd-muted" style="font-size:12px; font-weight:900; letter-spacing:.04em;">CATEGORY</div>
                  <div data-role="category" style="font-weight:900; color:#fff; margin-top:6px;">
                    <c:out value="${b.categoryName}"/>
                  </div>
                </td>

                <td>
                  <div class="yd-sub yd-muted" style="margin-top:2px;">
                    <span data-role="keyword"><c:out value="${b.questionKeyword}"/></span>
                  </div>
                </td>

<td>
  <div class="yd-ans" data-role="answer"><c:out value="${b.answerContent}"/></div>
</td>


<td>
  <div class="yd-row" style="gap:10px; justify-content:flex-start;">
    <c:choose>
      <c:when test="${b.activeYn eq 'Y'}">
        <span class="yd-badge yd-badge-on" data-role="active">Y</span>
        <button class="yd-toggle on" type="button"
                title="활성 토글"
                onclick="ydToggleActive(this)"
                aria-label="toggle"></button>
      </c:when>
      <c:otherwise>
        <span class="yd-badge yd-badge-off" data-role="active">N</span>
        <button class="yd-toggle off" type="button"
                title="활성 토글"
                onclick="ydToggleActive(this)"
                aria-label="toggle"></button>
      </c:otherwise>
    </c:choose>
  </div>
</td>

<td>
  <div class="yd-actions">
    <button class="yd-linkbtn" type="button" onclick="ydEditFromRow(this)">
      <i class="fa-solid fa-pen"></i> 수정
    </button>
    <button class="yd-linkbtn danger" type="button" onclick="ydSoftDelete(this)">
      <i class="fa-solid fa-trash"></i> 삭제
    </button>
  </div>
  <div class="yd-sub yd-muted" style="margin-top:8px; text-align:right;">
    by <span data-role="userId"><c:out value="${b.userId}"/></span>
  </div>
</td>

              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

</div>

<script>
var ctx = window.ctx || '<%=request.getContextPath()%>';

/**
 * fragment 주입 후 실행되는 초기화 함수
 * - 메인 loadContent()에서 initYdBotAdmin(false) 호출해줘야 버튼 이벤트가 붙음
 */
function initYdBotAdmin(forceReload){
  if(forceReload){
    ydFormReset();
    ydToast("폼을 초기화했어요.");
  }

  const saveBtn = document.getElementById("ydSaveBtn");
  if(saveBtn && !saveBtn.dataset.bound){
    saveBtn.dataset.bound = "1";
    saveBtn.addEventListener("click", ydSave);
  }
}

/** 저장(등록/수정) */
function ydSave(){
  const payload = ydGetFormPayload();

  if(!payload.categoryName) return ydToast("카테고리 네임을 입력해 주세요.", true);
  if(!payload.answerContent) return ydToast("대사(answer_content)를 입력해 주세요.", true);

  const isUpdate = !!payload.botId;
  const url = ctx + (isUpdate ? "/admin/bot-update.do" : "/admin/bot-insert.do");

  ydPostJsonLike(url, {
    botId: payload.botId,
    categoryName: payload.categoryName,
    questionKeyword: payload.questionKeyword,
    answerContent: payload.answerContent
  })
  .then(() => {
    ydFormReset();
    const currentNav = document.querySelector(".nav-item.active");
    if (typeof loadContent === "function" && currentNav) {
      loadContent("/admin/bot.do", currentNav);
    }
  })
  .catch(err => ydToast(err.message, true));
} // ✅ 이 닫는 중괄호가 빠져있었음!


/** 삭제(진짜 삭제) */
function ydSoftDelete(btn){
  const tr = btn.closest("tr");
  const botId = tr.dataset.botId;

  if(!confirm("⚠ 정말 삭제할까요?\n삭제 후 복구할 수 없습니다.")) return;

  ydPostJsonLike(ctx + "/admin/bot-delete.do", { botId })
    .then(() => {
      tr.remove();
      // ✅ 성공 토스트도 빼고 싶으면 아래 줄 삭제해도 됨
      // ydToast("삭제 완료!");
    })
    .catch(err => ydToast(err.message, true));
}

/**
 * 공통 POST: x-www-form-urlencoded 전송 + 응답은 반드시 JSON이어야 함
 * - JSON 파싱 실패가 뜨면, 콘솔에 raw 응답을 찍어서 원인(HTML/에러페이지)을 바로 확인 가능
 */
function ydPostJsonLike(url, params){
  return fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
    body: new URLSearchParams(params).toString()
  })
  .then(async (res) => {
    const raw = await res.text(); // ✅ 먼저 text로 받기

    let data;
    try {
      data = JSON.parse(raw);
    } catch (e) {
      // ✅ 여기 raw가 HTML이면 바로 원인 확인 가능
      console.error("[YD BOT] Non-JSON response from:", url);
      console.error("[YD BOT] status:", res.status);
      console.error("[YD BOT] raw response:", raw);
      throw new Error("서버가 JSON이 아닌 응답을 반환했습니다. (F12 콘솔 raw 확인)");
    }

    if(res.status === 401) throw new Error(data.message || "로그인이 필요합니다.");
    if(res.status === 403) throw new Error(data.message || "관리자만 가능합니다.");
    if(!res.ok || !data.success) throw new Error(data.message || "요청 실패");

    return data;
  });
}

/** 폼 값 */
function ydGetFormPayload(){
  return {
    botId: document.getElementById("ydBotId")?.value?.trim() || "",
    categoryName: document.getElementById("ydCategoryName")?.value?.trim() || "",
    questionKeyword: document.getElementById("ydQuestionKeyword")?.value?.trim() || "",
    answerContent: document.getElementById("ydAnswerContent")?.value?.trim() || "",
  };
}

function ydFormReset(){
  document.getElementById("ydBotId").value = "";
  document.getElementById("ydCategoryName").value = "";
  document.getElementById("ydQuestionKeyword").value = "";
  document.getElementById("ydAnswerContent").value = "";
  document.getElementById("ydActiveYn").value = "Y";
  document.getElementById("ydUserId").value = "";

  document.getElementById("ydModePill").innerHTML =
    '<i class="fa-solid fa-circle-info"></i> 현재 모드: <b style="color:#fff;">등록</b>';
}

function ydEditFromRow(btn){
  const tr = btn.closest("tr");
  const botId = tr.dataset.botId;

  const categoryName = tr.querySelector("[data-role='category']")?.innerText?.trim() || "";
  const questionKeyword = tr.querySelector("[data-role='keyword']")?.innerText?.trim() || "";
  const answerContent = tr.querySelector("[data-role='answer']")?.innerText || "";
  const active = tr.querySelector("[data-role='active']")?.innerText?.trim() || "Y";
  const userId = tr.querySelector("[data-role='userId']")?.innerText?.trim() || "";

  document.getElementById("ydBotId").value = botId;
  document.getElementById("ydCategoryName").value = categoryName;
  document.getElementById("ydQuestionKeyword").value = questionKeyword;
  document.getElementById("ydAnswerContent").value = answerContent.trim();
  document.getElementById("ydActiveYn").value = (active === "N" ? "N" : "Y");
  document.getElementById("ydUserId").value = userId;

  document.getElementById("ydModePill").innerHTML =
    '<i class="fa-solid fa-pen"></i> 현재 모드: <b style="color:#fff;">수정</b> (ID: ' + botId + ')';

  ydToast("수정할 항목을 폼에 불러왔어요.");
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function ydToggleActive(btn){
	  const tr = btn.closest("tr");
	  const botId = tr.dataset.botId;

	  ydPostJsonLike(ctx + "/admin/bot-toggle.do", { botId })
	    .then(data => {
	      const badge = tr.querySelector("[data-role='active']");
	      const next = data.activeYn;

	      // 배지 업데이트
	      badge.innerText = next;
	      badge.classList.toggle("yd-badge-on", next === "Y");
	      badge.classList.toggle("yd-badge-off", next === "N");

	      // 토글 스위치 업데이트
	      btn.classList.toggle("on", next === "Y");
	      btn.classList.toggle("off", next === "N");
	    })
	    .catch(err => ydToast(err.message, true));
	}



function ydToast(msg, isError){
  const box = document.getElementById("ydToast");
  if(!box) return;
  box.classList.add("show");
  box.style.borderColor = isError ? "rgba(239,68,68,.35)" : "#1e293b";
  box.style.color = isError ? "#ef4444" : "#94a3b8";
  box.innerText = msg;
  clearTimeout(window.__ydToastTimer);
  window.__ydToastTimer = setTimeout(()=> box.classList.remove("show"), 2400);
}
// 관리자 목록: DB에 실제 개행이든 "\n" 문자열이든 둘 다 줄바꿈 처리
document.querySelectorAll('.yd-ans[data-role="answer"]').forEach(el => {
  const t = el.textContent || '';
  el.innerHTML = t
    .split('\\n').join('<br/>')   // 문자열 "\n"
    .split('\n').join('<br/>');   // 실제 개행
});
// fragment 주입 후 자동 초기화(안전)
initYdBotAdmin(false);
</script>
