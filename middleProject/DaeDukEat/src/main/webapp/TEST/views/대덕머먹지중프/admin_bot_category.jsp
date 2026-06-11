<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 1. 영달봇 섹션 전체 컨테이너 (관리자 메인 본문 영역에 맞춤) */
    .yd-admin-section { 
        padding: 10px; 
        font-family: 'Pretendard', sans-serif; 
        color: #e2e8f0; 
        animation: yd-fadeIn 0.5s ease-out;
    }

    /* 2. 상단 통합 탭 디자인 (왼쪽 바 대신 여기서 메뉴 이동) */
    .yd-tab-container { 
        display: flex; 
        gap: 10px; 
        margin-bottom: 30px; 
        border-bottom: 1px solid #1e293b; 
        padding-bottom: 15px;
    }
    .yd-tab-item { 
        padding: 10px 24px; 
        border-radius: 12px; 
        cursor: pointer; 
        font-size: 14px; 
        font-weight: 800; 
        color: #64748b; 
        transition: 0.3s;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .yd-tab-item:hover { color: #fff; background: #1e293b; }
    .yd-tab-item.active { background: #38bdf8; color: #020617; }

    /* 3. 섹션 카드 스타일 */
    .yd-content-card { 
        background: #0f172a; 
        border: 1px solid #1e293b; 
        border-radius: 20px; 
        padding: 35px; 
        display: none; 
    }
    .yd-content-card.active { display: block; }
    @keyframes yd-fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

    .yd-title-row { margin-bottom: 30px; }
    .yd-title-row h3 { font-size: 20px; font-weight: 900; color: #fff; display: flex; align-items: center; gap: 10px; }
    .yd-title-row i { color: #38bdf8; }

    /* 4. 입력 폼 디자인 */
    .yd-form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
    .yd-full-width { grid-column: span 2; }
    .yd-input-label { display: block; font-size: 12px; font-weight: 800; color: #64748b; margin-bottom: 10px; text-transform: uppercase; }
    
    .yd-input-field { 
        width: 100%; padding: 15px; 
        background: #020617 !important; 
        border: 1px solid #334155 !important; 
        border-radius: 14px; 
        color: white !important; 
        outline: none; 
        transition: 0.3s;
        font-size: 14px;
    }
    .yd-input-field:focus { border-color: #38bdf8; box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.1); }

    /* 5. 버튼 */
    .yd-btn-main { 
        background: #38bdf8; color: #020617; padding: 16px; border-radius: 14px; 
        font-weight: 900; cursor: pointer; border: none; width: 100%; 
        transition: 0.3s; margin-top: 10px; font-size: 14px;
    }
    .yd-btn-main:hover { background: #7dd3fc; transform: translateY(-2px); }

    /* 6. 데이터 리스트 테이블 */
    .yd-data-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .yd-data-table th { text-align: left; padding: 15px; border-bottom: 2px solid #1e293b; color: #64748b; font-size: 11px; font-weight: 800; text-transform: uppercase; }
    .yd-data-table td { padding: 20px 15px; border-bottom: 1px solid #1e293b; font-size: 14px; color: #94a3b8; }
    .yd-highlight { color: #f8fafc; font-weight: 700; }
    .yd-badge-sky { background: rgba(56, 189, 248, 0.1); color: #38bdf8; padding: 4px 10px; border-radius: 6px; font-weight: 800; font-size: 11px; }

    .yd-delete-btn { color: #475569; cursor: pointer; transition: 0.2s; background: none; border: none; }
    .yd-delete-btn:hover { color: #ef4444; }
</style>

<div class="yd-admin-section">
    <div class="yd-tab-container">
        <div class="yd-tab-item active" onclick="moveYdTab(0, this)">
            <i class="fas fa-utensils"></i> 맛집 데이터 관리
        </div>
        <div class="yd-tab-item" onclick="moveYdTab(1, this)">
            <i class="fas fa-robot"></i> 챗봇 시나리오 설정
        </div>
        <div class="yd-tab-item" onclick="location.reload()">
            <i class="fas fa-sync"></i> 새로고침
        </div>
    </div>

    <div id="yd-panel-0" class="yd-content-card active">
        <div class="yd-title-row">
            <h3><i class="fas fa-plus-circle"></i> 신규 맛집 정보 등록</h3>
        </div>
        <div class="yd-form-grid">
            <div>
                <label class="yd-input-label">카테고리</label>
                <select class="yd-input-field" id="newCat">
                    <option>한식</option><option>일식</option><option>중식</option><option>양식</option><option>고기</option><option>카페</option>
                </select>
            </div>
            <div>
                <label class="yd-input-label">가게 명칭</label>
                <input type="text" class="yd-input-field" id="newName" placeholder="식당 이름을 입력하세요">
            </div>
            <div class="yd-full-width">
                <label class="yd-input-label">추천 리뷰 (영달봇 대사)</label>
                <textarea class="yd-input-field" id="newReview" style="height: 100px; resize: none;" placeholder="사용자에게 보여질 영달이의 한 줄 평을 입력하세요."></textarea>
            </div>
        </div>
        <button class="yd-btn-main" onclick="addRow()">시스템에 데이터 추가하기</button>

        <div class="yd-title-row" style="margin-top: 60px;">
            <h3><i class="fas fa-list-ul"></i> 현재 활성화된 데이터 리스트</h3>
        </div>
        <table class="yd-data-table">
            <thead>
                <tr>
                    <th width="15%">분류</th>
                    <th width="20%">가게명</th>
                    <th width="50%">리뷰 내용</th>
                    <th width="15%">삭제</th>
                </tr>
            </thead>
            <tbody id="ydTableBody">
                <tr>
                    <td><span class="yd-badge-sky">한식</span></td>
                    <td class="yd-highlight">한영식당</td>
                    <td>백종원이 극찬한 닭볶음탕! 감자가 포슬포슬하니 일품이에요.</td>
                    <td>
                        <button class="yd-delete-btn" onclick="this.closest('tr').remove()"><i class="fas fa-trash-alt"></i></button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="yd-panel-1" class="yd-content-card">
        <div class="yd-title-row">
            <h3><i class="fas fa-comment-dots"></i> 챗봇 시스템 멘트 설정</h3>
        </div>
        <div style="display: flex; flex-direction: column; gap: 30px;">
            <div>
                <label class="yd-input-label">첫 접속 환영 메시지</label>
                <input type="text" class="yd-input-field" value="반갑습니다! 프로 맛잘러 영달봇입니다. 🍊">
            </div>
            <div>
                <label class="yd-input-label">검색 결과 헤더 멘트</label>
                <input type="text" class="yd-input-field" value="요청하신 맛집을 영달이가 싹 긁어왔어요! 🍊">
            </div>
            <div>
                <label class="yd-input-label">정보 없음 안내 문구</label>
                <textarea class="yd-input-field" style="height: 120px; resize: none;">음... 잘 모르겠어요. 다시 말씀해 주시겠어요? 😅</textarea>
            </div>
            <button class="yd-btn-main" style="width: 240px;" onclick="alert('시스템에 반영되었습니다.')">설정값 저장하기</button>
        </div>
    </div>
</div>

<script>
    /**
     * 탭 이동 함수
     */
    function moveYdTab(idx, el) {
        // 모든 패널 숨기기
        document.querySelectorAll('.yd-content-card').forEach(p => p.classList.remove('active'));
        // 모든 탭 비활성화
        document.querySelectorAll('.yd-tab-item').forEach(t => t.classList.remove('active'));
        
        // 선택한 요소만 활성화
        document.getElementById('yd-panel-' + idx).classList.add('active');
        el.classList.add('active');
    }

    /**
     * 데이터 추가 (가상 로직)
     */
    function addRow() {
        const cat = document.getElementById('newCat').value;
        const name = document.getElementById('newName').value;
        const review = document.getElementById('newReview').value;

        if(!name || !review) return alert('내용을 모두 입력해주세요!');

        const row = `
            <tr style="animation: yd-fadeIn 0.3s ease-out;">
                <td><span class="yd-badge-sky">\${cat}</span></td>
                <td class="yd-highlight">\${name}</td>
                <td>\${review}</td>
                <td><button class="yd-delete-btn" onclick="this.closest('tr').remove()"><i class="fas fa-trash-alt"></i></button></td>
            </tr>
        `;
        document.getElementById('ydTableBody').insertAdjacentHTML('afterbegin', row);
        
        document.getElementById('newName').value = "";
        document.getElementById('newReview').value = "";
        alert('성공적으로 등록되었습니다!');
    }
</script>