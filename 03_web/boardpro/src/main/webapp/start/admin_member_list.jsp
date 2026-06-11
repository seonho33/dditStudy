<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 1. 기본 스타일 및 애니메이션 */
    .mem-container { animation: mem-fadeIn 0.5s ease-out; color: #e2e8f0; }
    @keyframes mem-fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* 2. 상단 통계 카드 디자인 */
    .stat-card { background: #0f172a; padding: 24px; border-radius: 20px; border: 1px solid #1e293b; transition: 0.3s; }
    .stat-card:hover { border-color: #38bdf8; transform: translateY(-5px); }

    /* 3. 테이블 디자인 */
    .mem-table-wrapper { background: #0f172a; border-radius: 20px; border: 1px solid #1e293b; overflow: hidden; }
    .mem-table { width: 100%; text-align: left; border-collapse: collapse; }
    .mem-table thead { background: #1e293b; color: #94a3b8; font-size: 11px; font-weight: 800; text-transform: uppercase; }
    .mem-table th { padding: 15px 20px; letter-spacing: 0.05em; }
    .mem-table td { padding: 18px 20px; border-top: 1px solid #1e293b; }
    .mem-table tr:hover { background: #1e293b/50; }

    /* 4. 역할 필터 탭 스타일 */
    .role-tab-container { display: flex; background: #0f172a; padding: 6px; border-radius: 14px; border: 1px solid #1e293b; margin-bottom: 25px; width: fit-content; }
    .role-tab { 
        padding: 10px 24px; border-radius: 10px; font-size: 13px; font-weight: 800; 
        cursor: pointer; transition: 0.3s; color: #64748b; text-transform: uppercase;
    }
    .role-tab.active { background: #38bdf8; color: #020617; }
    .role-tab:not(.active):hover { color: #fff; background: #1e293b; }

    /* 5. 검색창 스타일 (돋보기 아이콘 제거 버전) */
    .search-input { 
        background: #020617; border: 1px solid #334155; border-radius: 12px; 
        padding: 10px 18px; color: white; font-size: 14px; width: 320px; 
        transition: 0.3s; outline: none;
    }
    .search-input:focus { border-color: #38bdf8; box-shadow: 0 0 0 2px rgba(56, 189, 248, 0.1); }

    /* 6. 액션 버튼 */
    .btn-manage { background: #1e293b; color: #94a3b8; padding: 6px 12px; border-radius: 8px; font-size: 12px; font-weight: bold; border: 1px solid #334155; cursor: pointer; transition: 0.2s; }
    .btn-manage:hover { background: #334155; color: #fff; }
    .btn-kick { color: #ef4444; margin-left: 8px; font-size: 12px; font-weight: bold; cursor: pointer; border: none; background: none; }
</style>

<div class="mem-container">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h2 class="text-3xl font-black text-white uppercase tracking-tighter italic">User Management</h2>
            <p class="text-slate-500 text-sm mt-1">회원 유형별 권한 및 상태를 실시간 관리합니다.</p>
        </div>
        <div class="relative">
            <input type="text" class="search-input" placeholder="회원 이름 또는 이메일 검색..." onkeyup="filterUsers()">
        </div>
    </div>

    <div class="role-tab-container">
        <div class="role-tab active" onclick="filterRole('ALL', this)">전체보기</div>
        <div class="role-tab" onclick="filterRole('USER', this)">일반회원</div>
        <div class="role-tab" onclick="filterRole('OWNER', this)">사장님</div>
    </div>

    <div class="grid grid-cols-3 gap-6 mb-8">
        <div class="stat-card">
            <p class="text-slate-500 text-[10px] font-black uppercase mb-1">Total Members</p>
            <h3 class="text-3xl font-black text-white" id="totalCount">1,250</h3>
        </div>
        <div class="stat-card">
            <p class="text-sky-500 text-[10px] font-black uppercase mb-1">Active Now</p>
            <h3 class="text-3xl font-black text-sky-500">482</h3>
        </div>
        <div class="stat-card">
            <p class="text-red-500 text-[10px] font-black uppercase mb-1">Blacklisted</p>
            <h3 class="text-3xl font-black text-red-500">12</h3>
        </div>
    </div>

    <div class="mem-table-wrapper">
        <table class="mem-table">
            <thead>
                <tr>
                    <th>User Information</th>
                    <th>Role</th> 
                    <th>Join Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <tr data-role="USER">
                    <td>
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-sky-500 font-bold">이</div>
                            <div>
                                <div class="font-bold text-white user-name">이영달</div>
                                <div class="text-xs opacity-50 user-email">youngdal@test.com</div>
                            </div>
                        </div>
                    </td>
                    <td><span class="text-[10px] font-bold text-slate-500 border border-slate-700 px-2 py-0.5 rounded">일반회원</span></td>
                    <td class="text-xs font-medium text-slate-500">2026-01-20</td>
                    <td><span class="bg-green-500/10 text-green-500 px-2 py-1 rounded text-[10px] font-bold badge-status">ACTIVE</span></td>
                    <td>
                        <button class="btn-manage" onclick="toggleStatus(this, 'USER_ID_PK')">상태변경</button>
                        <button class="btn-kick" onclick="removeUser(this, 'USER_ID_PK')">강퇴</button>
                    </td>
                </tr>
                <tr data-role="OWNER">
                    <td>
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-orange-500 font-bold">김</div>
                            <div>
                                <div class="font-bold text-white user-name">김철수</div>
                                <div class="text-xs opacity-50 user-email">chulsoo@gs25.com</div>
                            </div>
                        </div>
                    </td>
                    <td><span class="text-[10px] font-bold text-orange-500 border border-orange-500/30 px-2 py-0.5 rounded">사장님</span></td>
                    <td class="text-xs font-medium text-slate-500">2026-01-18</td>
                    <td><span class="bg-red-500/10 text-red-500 px-2 py-1 rounded text-[10px] font-bold badge-status">BANNED</span></td>
                    <td>
                        <button class="btn-manage" onclick="toggleStatus(this, 'OWNER_ID_PK')">상태변경</button>
                        <button class="btn-kick" onclick="removeUser(this, 'OWNER_ID_PK')">강퇴</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
    let currentRole = 'ALL';

    /**
     * 역할 필터링 (탭 클릭 시)
     */
    function filterRole(role, element) {
        currentRole = role;
        document.querySelectorAll('.role-tab').forEach(tab => tab.classList.remove('active'));
        element.classList.add('active');
        filterUsers();
    }

    /**
     * [DB 연동 포인트] 실시간 검색 및 필터링
     * 나중에 전체 회원이 많아지면 서버에 검색어를 보내 쿼리를 다시 실행하는 방식으로 변경 권장
     */
    function filterUsers() {
        const searchVal = document.querySelector('.search-input').value.toLowerCase();
        const rows = document.querySelectorAll('#userTableBody tr');
        
        rows.forEach(row => {
            const rowRole = row.getAttribute('data-role');
            const name = row.querySelector('.user-name').innerText.toLowerCase();
            const email = row.querySelector('.user-email').innerText.toLowerCase();
            
            const roleMatch = (currentRole === 'ALL' || currentRole === rowRole);
            const searchMatch = (name.includes(searchVal) || email.includes(searchVal));
            
            row.style.display = (roleMatch && searchMatch) ? '' : 'none';
        });
    }

    /**
     * [DB 가이드] 회원 상태 변경 (ACTIVE <-> BANNED)
     */
    function toggleStatus(btn, userId) {
        const badge = btn.parentElement.parentElement.querySelector('.badge-status');
        const currentStatus = badge.innerText;
        const nextStatus = (currentStatus === 'ACTIVE') ? 'BANNED' : 'ACTIVE';

        /* [나중에 작성할 코드]
           fetch('/UpdateUserStatus.do', {
               method: 'POST',
               body: new URLSearchParams({ id: userId, status: nextStatus })
           }).then(res => res.json()).then(data => { ... UI 업데이트 ... });
        */

        // UI 즉시 반영 로직
        if (nextStatus === 'BANNED') {
            badge.innerText = 'BANNED';
            badge.className = 'bg-red-500/10 text-red-500 px-2 py-1 rounded text-[10px] font-bold badge-status';
        } else {
            badge.innerText = 'ACTIVE';
            badge.className = 'bg-green-500/10 text-green-500 px-2 py-1 rounded text-[10px] font-bold badge-status';
        }
    }

    /**
     * [DB 가이드] 회원 강제 퇴장 (DELETE)
     */
    function removeUser(btn, userId) {
        if (confirm("정말로 이 회원을 강제 퇴장시키겠습니까?\n이 작업은 DB에서 취소할 수 없습니다.")) {
            /* [나중에 작성할 코드]
               fetch('/DeleteUser.do?id=' + userId).then(res => {
                   if(res.ok) { // 애니메이션 후 삭제 로직 진행 }
               });
            */
            const row = btn.parentElement.parentElement;
            row.style.opacity = '0';
            row.style.transform = 'translateX(20px)';
            row.style.transition = '0.3s';
            setTimeout(() => {
                row.remove();
                // [DB 연동 팁] 삭제 후 상단 Total Count 숫자도 서버에서 다시 받아오거나 -1 처리합니다.
                const total = document.getElementById('totalCount');
                total.innerText = (parseInt(total.innerText.replace(',', '')) - 1).toLocaleString();
            }, 300);
        }
    }
</script>