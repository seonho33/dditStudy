<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
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
            
            <div class="comm-card comm-item">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <span class="badge-notice">NOTICE</span>
                        <h4 class="text-lg font-bold text-white comm-title">정기 시스템 점검 안내</h4>
                    </div>
                    <span class="text-[10px] text-slate-500 font-bold uppercase">2026.01.20</span>
                </div>
                <p class="text-slate-400 text-sm leading-relaxed mb-6 comm-text">안정적인 서비스 제공을 위해 서버 점검이 진행될 예정입니다.</p>
                <div class="flex justify-end gap-3 border-t border-slate-800/50 pt-4">
                    <button class="btn-action text-slate-500 hover:text-white">수정</button>
                    <button class="btn-action text-red-500" onclick="deleteNotice(this, '글번호_PK')">삭제</button>
                </div>
            </div>

            <div class="comm-card comm-item border-l-4 border-l-orange-500">
                <div class="flex justify-between items-start mb-2">
                    <span class="badge-pending">PENDING QUESTION</span>
                    <span class="text-[10px] text-slate-500 font-bold uppercase">Today</span>
                </div>
                <h4 class="text-lg font-bold text-white mb-4 italic comm-title">"로그인이 안 돼요, 어떻게 하죠?"</h4>
                <textarea class="custom-input mb-4 text-sm" rows="3" placeholder="답변을 작성하세요" id="reply_글번호PK"></textarea>
                
                <button class="w-full bg-sky-500 text-black py-3 rounded-xl font-black text-sm hover:bg-sky-400 transition-colors" onclick="saveAnswer('글번호PK')">답변 저장하기</button>
            </div>

        </div>
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
</script>