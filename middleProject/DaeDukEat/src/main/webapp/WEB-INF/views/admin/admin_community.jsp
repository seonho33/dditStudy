<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* 스르륵 열림/닫힘 */
.comm-detail{
  overflow: hidden;
  max-height: 0;
  opacity: 0;
  transform: translateY(-6px);
  transition:
    max-height 0.45s ease,
    opacity 0.25s ease,
    transform 0.25s ease;
}

/* 열린 상태 */
.comm-card.is-open .comm-detail{
  opacity: 1;
  transform: translateY(0);
}

/* 헤더 클릭 표시 */
.comm-header { cursor: pointer; user-select:none; }

/* 화살표 회전(선택) */
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
    .btn-action { font-size: 12px; font-weight: 800; cursor: pointer; transition: 0.2s; background: none; border: none; }
    .btn-submit-main { background: #38bdf8; color: #020617; padding: 14px; border-radius: 12px; font-weight: 900; width: 100%; cursor: pointer; border: none; margin-top: 10px; }
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
        <div class="col-span-2">
            <div class="comm-card" style="position: sticky; top: 20px;">
                <span class="comm-label">Post New</span>
                <h4 class="text-xl font-bold text-white mb-6">공지사항 등록</h4>
                <div class="space-y-4">
                    <input type="text" id="newTitle" class="custom-input" placeholder="공지 제목">
                    <textarea id="newContent" class="custom-input" rows="5" placeholder="공지 내용을 상세히 입력하세요"></textarea>
                    <button class="btn-submit-main" onclick="publishNotice()">지금 게시하기</button>
                </div>
            </div>
        </div>

        <div class="col-span-3 space-y-6" id="commListArea">
            
<div class="comm-card comm-item notice-card">
  <div class="comm-header flex justify-between items-start mb-2" onclick="toggleCard(this)">
    <div class="flex items-center gap-3">
      <span class="badge-notice">NOTICE</span>
      <h4 class="text-lg font-bold text-white comm-title">정기 시스템 점검 안내</h4>
    </div>

    <div class="flex items-center gap-3">
      <span class="text-[10px] text-slate-500 font-bold uppercase">2026.01.20</span>
      <span class="comm-toggle-icon text-slate-400 font-black">▼</span>
    </div>
  </div>

  <!-- ✅ 스르륵 열릴 영역 -->
  <div class="comm-detail notice-detail mt-2 border-t border-slate-800/50 pt-4">
    <p class="text-slate-400 text-sm leading-relaxed mb-6 comm-text">
      안정적인 서비스 제공을 위해 서버 점검이 진행될 예정입니다.
    </p>

    <div class="flex justify-end gap-3">
      <button class="btn-action text-slate-500 hover:text-white">수정</button>
      <button class="btn-action text-red-500" onclick="deleteNotice(this, '글번호_PK'); event.stopPropagation();">삭제</button>
    </div>
  </div>
</div>

<div class="comm-card comm-item qna-card border-l-4 border-l-orange-500">
  <div class="comm-header flex justify-between items-start mb-2" onclick="toggleCard(this)">
    <div class="flex items-center gap-3">
      <span class="badge-pending">PENDING QUESTION</span>
      <h4 class="text-lg font-bold text-white italic comm-title">"로그인이 안 돼요, 어떻게 하죠?"</h4>
    </div>

    <div class="flex items-center gap-3">
      <span class="text-[10px] text-slate-500 font-bold uppercase">Today</span>
      <span class="comm-toggle-icon text-slate-400 font-black">▼</span>
    </div>
  </div>

  <div class="comm-detail qna-detail mt-2 border-t border-slate-800/50 pt-4">
    <p class="text-slate-400 text-sm leading-relaxed mb-6 qna-text">
      로그인 시 "아이디 또는 비밀번호가 올바르지 않습니다"가 계속 떠요.
    </p>

    <textarea class="custom-input mb-4 text-sm" rows="3"
              placeholder="답변을 작성하세요"
              id="reply_글번호PK"></textarea>

    <button class="w-full bg-sky-500 text-black py-3 rounded-xl font-black text-sm hover:bg-sky-400 transition-colors"
            onclick="saveAnswer('글번호PK'); event.stopPropagation();">
      답변 저장하기
    </button>
  </div>
</div>


<script>
    /**
     * [DB 연동 가이드 1] 공지사항 게시
     */
    async function publishNotice() {
        const title = document.getElementById('newTitle').value;
        const content = document.getElementById('newContent').value;

        if(!title || !content) return alert("내용을 입력해주세요!");

        /* [나중에 작성할 코드 예시]
           const res = await fetch('/InsertNotice.do', {
               method: 'POST',
               headers: {'Content-Type': 'application/x-www-form-urlencoded'},
               body: `title=\${encodeURIComponent(title)}&content=\${encodeURIComponent(content)}`
           });
           const result = await res.json();
           if(result.status === 'success') { 
               location.reload(); // 성공 시 리스트 새로고침
           }
        */

        // 지금은 화면에만 추가
        const html = `
            <div class="comm-card comm-item" style="animation: comm-fadeIn 0.5s ease-out;">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <span class="badge-notice">NOTICE</span>
                        <h4 class="text-lg font-bold text-white comm-title">\${title}</h4>
                    </div>
                    <span class="text-[10px] text-slate-500 font-bold uppercase">2026.01.20</span>
                </div>
                <p class="text-slate-400 text-sm leading-relaxed mb-6 comm-text">\${content}</p>
                <div class="flex justify-end gap-3 border-t border-slate-800/50 pt-4">
                    <button class="btn-action text-slate-500 hover:text-white">수정</button>
                    <button class="btn-action text-red-500" onclick="this.closest('.comm-card').remove()">삭제</button>
                </div>
            </div>
        `;
        document.getElementById('commListArea').insertAdjacentHTML('afterbegin', html);
        document.getElementById('newTitle').value = '';
        document.getElementById('newContent').value = '';
    }

    /**
     * [DB 연동 가이드 2] 답변 저장 로직
     */
    function saveAnswer(pk) {
        const reply = document.getElementById('reply_' + pk).value;
        if(!reply) return alert("답변을 작성해주세요.");

        /*
           [나중에 작성할 코드 예시]
           fetch('/UpdateAnswer.do', {
               method: 'POST',
               body: new URLSearchParams({ 'no': pk, 'content': reply })
           }).then(r => r.json()).then(data => {
               alert('성공적으로 답변이 저장되었습니다.');
           });
        */
        alert('답변이 전송되었습니다. (DB 연결 시 \${pk}번 글에 저장됨)');
    }

    /**
     * [DB 연동 가이드 3] 삭제 로직
     */
    function deleteNotice(btn, pk) {
        if(!confirm("정말 삭제하시겠습니까?")) return;

        /*
           [나중에 작성할 코드 예시]
           fetch('/DeleteNotice.do?no=' + pk).then(res => {
               if(res.ok) btn.closest('.comm-card').remove();
           });
        */
        btn.closest('.comm-card').remove();
    }

    /**
     * 검색 필터 (지금은 화면 내 검색, 나중엔 서버 검색 가능)
     */
    function filterComm(input) {
        const val = input.value.toLowerCase();
        const items = document.querySelectorAll('.comm-item');
        
        items.forEach(item => {
            const title = item.querySelector('.comm-title').innerText.toLowerCase();
            const text = item.querySelector('.comm-text')?.innerText.toLowerCase() || "";
            if(title.includes(val) || text.includes(val)) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    }
    
    /* ====== 공지 상세 토글(▼ 눌렀을 때) ====== */
    function toggleNotice(btn) {
      var card = btn.closest('.notice-card') || btn.closest('.comm-card');
      if (!card) return;

      var detail = card.querySelector('.notice-detail');
      if (!detail) return;

      // 토글
      if (detail.classList.contains('hidden')) {
        detail.classList.remove('hidden');
        btn.innerText = '▲';
      } else {
        detail.classList.add('hidden');
        btn.innerText = '▼';
      }
    }

    /* ====== QNA 상세 토글(▼ 눌렀을 때) ====== */
    function toggleQna(btn) {
      var card = btn.closest('.qna-card') || btn.closest('.comm-card');
      if (!card) return;

      var detail = card.querySelector('.qna-detail');
      if (!detail) return;

      if (detail.classList.contains('hidden')) {
        detail.classList.remove('hidden');
        btn.innerText = '▲';
      } else {
        detail.classList.add('hidden');
        btn.innerText = '▼';
      }
    }

    /* ====== 카드(공지/QNA) 공통 스르륵 토글 ====== */
function toggleCard(headerEl) {
  var card = headerEl.closest('.comm-card');
  if (!card) return;

  var detail = card.querySelector('.comm-detail');
  if (!detail) return;

  var isOpen = card.classList.contains('is-open');

  if (isOpen) {
    // 닫기: 현재 높이에서 0으로
    detail.style.maxHeight = detail.scrollHeight + 'px'; // 한번 잡아주고
    // 다음 프레임에 0으로 내려야 애니메이션이 먹음
    requestAnimationFrame(function () {
      detail.style.maxHeight = '0px';
      card.classList.remove('is-open');
    });
  } else {
    // 열기: 0에서 실제 높이로
    card.classList.add('is-open');
    detail.style.maxHeight = detail.scrollHeight + 'px';
  }
}


    
</script>