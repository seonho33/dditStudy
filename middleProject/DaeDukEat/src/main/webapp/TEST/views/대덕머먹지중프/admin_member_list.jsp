<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</style>

<div class="admin-scope">
    <div class="flex justify-between items-end mb-10">
        <div>
            <h2 class="text-3xl font-black text-white italic uppercase tracking-tighter">Admin Master Console</h2>
            <p class="text-slate-500 text-sm mt-1">승인 관리 및 회원 제재 통합 시스템</p>
        </div>
        <div class="relative">
            <i class="fa-solid fa-magnifying-glass absolute left-4 top-4 text-slate-500"></i>
            <input type="text" class="search-input-fancy" placeholder="아이디/상호명 검색..." onkeyup="filterRows(this)">
        </div>
    </div>

    <div class="admin-card">
        <h3 class="text-lg font-bold text-white mb-6 flex items-center gap-2">
            <span class="w-1.5 h-5 bg-sky-500 rounded-full"></span> 사장님 가입 승인
        </h3>
        <div id="ownerApplyList" class="space-y-3">
            <div class="row-item p-5 flex justify-between items-center">
                <div class="flex gap-10 items-center">
                    <div><span class="text-[10px] text-slate-500 block mb-1">APPLY DATE</span><span class="text-sm font-bold">2026.01.21</span></div>
                    <div><span class="text-[10px] text-slate-500 block mb-1">ID / COMPANY</span><span class="text-sm font-black text-sky-400">chef_hong</span> <span class="text-xs text-slate-400">| 홍길동 베이커리</span></div>
                    <div class="status-cell"><span class="badge badge-wait">Pending</span></div>
                </div>
                <div class="action-cell flex gap-2">
                    <button onclick="procOwner(this, 'APPROVE')" class="bg-emerald-600 text-white px-4 py-2 rounded-lg text-xs font-black">승인</button>
                    <button onclick="procOwner(this, 'REJECT')" class="bg-slate-700 text-slate-300 px-4 py-2 rounded-lg text-xs font-black hover:bg-red-600 hover:text-white">거절</button>
                </div>
            </div>
        </div>
    </div>

    <div class="admin-card">
        <h3 class="text-lg font-bold text-white mb-6 flex items-center gap-2">
            <span class="w-1.5 h-5 bg-orange-500 rounded-full"></span> 회원 제재 관리
        </h3>
        <div class="space-y-3">
            <div class="row-item p-5 flex justify-between items-center" id="user_row_member01">
                <div class="flex items-center gap-6">
                    <span class="text-white font-black member-id">member_01</span>
                    
                    <div class="ban-row-info">
                        <span class="text-[10px] bg-red-600 text-white px-2 py-0.5 rounded font-black">BANNED</span>
                        <span class="text-xs text-red-200 font-bold" id="ban_txt_member01">사유: - | 기간: -</span>
                    </div>
                </div>
                
                <div class="flex items-center gap-4">
                    <button onclick="openBanModal('member01')" class="btn-ban-trigger border border-red-500/50 text-red-500 px-4 py-2 rounded-lg text-xs font-black hover:bg-red-500 hover:text-white">제재하기</button>
                    <button onclick="unban('member01')" class="hidden unban-btn text-slate-500 text-[10px] font-bold hover:underline">해제</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="banModal" class="fixed inset-0 z-[500] hidden items-center justify-center p-5 bg-black/80 backdrop-blur-sm">
    <div class="bg-[#0f172a] w-full max-w-[400px] rounded-[30px] border border-slate-700 p-8 shadow-2xl">
        <h3 class="text-xl font-black text-white mb-6 uppercase">Restrict User</h3>
        <div class="space-y-5">
            <input type="hidden" id="targetId">
            <div>
                <label class="text-[10px] text-slate-500 font-black block mb-2 uppercase">Reason</label>
                <select id="reasonSel" class="custom-input-dark bg-slate-900 border border-slate-700 w-full p-3 rounded-xl text-white outline-none" onchange="toggleDir(this.value)">
                    <option value="비속어 사용">비속어 사용</option>
                    <option value="허위 도배">허위 도배</option>
                    <option value="DIRECT">직접 입력</option>
                </select>
                <input type="text" id="reasonDir" class="hidden mt-2 bg-slate-900 border border-slate-700 w-full p-3 rounded-xl text-white outline-none" placeholder="사유를 입력하세요">
            </div>
            <div>
                <label class="text-[10px] text-slate-500 font-black block mb-2 uppercase">Period</label>
                <div class="flex gap-2">
                    <label class="flex-1 cursor-pointer"><input type="radio" name="days" value="3" class="hidden peer" checked><div class="peer-checked:bg-red-600 peer-checked:text-white bg-slate-800 text-slate-500 py-2 text-center rounded-lg text-xs font-bold">3일</div></label>
                    <label class="flex-1 cursor-pointer"><input type="radio" name="days" value="7" class="hidden peer"><div class="peer-checked:bg-red-600 peer-checked:text-white bg-slate-800 text-slate-500 py-2 text-center rounded-lg text-xs font-bold">7일</div></label>
                    <label class="flex-1 cursor-pointer"><input type="radio" name="days" value="30" class="hidden peer"><div class="peer-checked:bg-red-600 peer-checked:text-white bg-slate-800 text-slate-500 py-2 text-center rounded-lg text-xs font-bold">30일</div></label>
                </div>
            </div>
            <div class="flex gap-3 pt-4">
                <button onclick="closeModal()" class="flex-1 text-slate-500 font-bold">취소</button>
                <button onclick="confirmBan()" class="flex-[2] bg-red-600 text-white py-4 rounded-2xl font-black shadow-lg shadow-red-900/40">제재 확정</button>
            </div>
        </div>
    </div>
</div>

<script>
    /* 1. 사장님 승인 시스템 로직 */
    function procOwner(btn, type) {
        const row = btn.closest('.row-item');
        const statusCell = row.querySelector('.status-cell');
        const actionCell = row.querySelector('.action-cell');

        if(type === 'APPROVE') {
            statusCell.innerHTML = '<span class="badge badge-ok">Approved</span>';
        } else {
            statusCell.innerHTML = '<span class="badge badge-no">Rejected</span>';
        }
        actionCell.innerHTML = '<span class="text-[10px] text-slate-600 font-black italic">PROCESSED</span>';
    }

    /* 2. 벤 시스템 로직 */
    function openBanModal(id) {
        document.getElementById('targetId').value = id;
        document.getElementById('banModal').classList.remove('hidden');
        document.getElementById('banModal').classList.add('flex');
    }
    function closeModal() {
        document.getElementById('banModal').classList.add('hidden');
        document.getElementById('banModal').classList.remove('flex');
    }
    function toggleDir(val) {
        document.getElementById('reasonDir').classList.toggle('hidden', val !== 'DIRECT');
    }

    /* 3. 벤 확정 - 화면 안돌아가고 그 자리에서 한 줄로 표시 */
    function confirmBan() {
        const id = document.getElementById('targetId').value;
        const sel = document.getElementById('reasonSel').value;
        const dir = document.getElementById('reasonDir').value;
        const reason = (sel === 'DIRECT') ? dir : sel;
        const days = document.querySelector('input[name="days"]:checked').value;

        if(sel === 'DIRECT' && !dir) return alert("사유 입력해!");

        // 화면 즉시 반영
        const row = document.getElementById('user_row_' + id);
        const banTxt = document.getElementById('ban_txt_' + id);
        
        // 날짜 계산
        const d = new Date();
        d.setDate(d.getDate() + parseInt(days));
        const dateStr = `\${d.getFullYear()}.\${d.getMonth()+1}.\${d.getDate()}`;

        // 한 줄 사유 주입
        banTxt.innerText = `사유: \${reason} | 해제일: \${dateStr} (\${days}일간)`;
        
        // 레이아웃 변경
        row.classList.add('is-banned');
        row.querySelector('.unban-btn').classList.remove('hidden');

        closeModal();
    }

    function unban(id) {
        const row = document.getElementById('user_row_' + id);
        row.classList.remove('is-banned');
        row.querySelector('.unban-btn').classList.add('hidden');
    }

    function filterRows(input) {
        const val = input.value.toLowerCase();
        document.querySelectorAll('.row-item').forEach(r => {
            r.style.display = r.innerText.toLowerCase().includes(val) ? 'flex' : 'none';
        });
    }
</script>