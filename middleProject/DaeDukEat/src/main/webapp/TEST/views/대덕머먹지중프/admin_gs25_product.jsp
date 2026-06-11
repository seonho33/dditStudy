<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 1. 배경 및 레이아웃 애니메이션 */
    .inv-container { color: #e2e8f0 !important; animation: inv-fadeIn 0.5s ease-out; }
    @keyframes inv-fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* 2. 카드 및 타이틀 디자인 */
    .inv-card { background: #0f172a !important; border-radius: 20px; padding: 30px; border: 1px solid #1e293b; margin-bottom: 30px; }
    .inv-card-title { font-size: 18px; font-weight: 700; margin-bottom: 25px; color: #38bdf8; display: flex; align-items: center; gap: 8px; }

    /* 3. 이미지 업로드 섹션 */
    .inv-upload-wrapper { display: flex; gap: 20px; align-items: center; margin-bottom: 20px; }
    .inv-preview-box { 
        width: 120px; height: 120px; border-radius: 12px; border: 2px dashed #334155; 
        overflow: hidden; display: flex; align-items: center; justify-content: center; 
        background: #020617; position: relative; transition: 0.3s;
    }
    .inv-preview-box:hover { border-color: #38bdf8; }
    .inv-preview-box img { width: 100%; height: 100%; object-fit: cover; display: none; }
    .inv-preview-box i { font-size: 32px; color: #475569; }
    
    .inv-upload-btn { 
        padding: 10px 20px; background: #1e293b; border: 1px solid #334155; 
        border-radius: 10px; color: #cbd5e1; cursor: pointer; font-size: 13px; font-weight: 600; 
        transition: 0.2s; display: inline-block;
    }
    .inv-upload-btn:hover { background: #334155; color: #fff; }

    /* 4. 입력창 및 버튼 공통 스타일 */
    .inv-input { width: 100%; padding: 12px; border: 1px solid #334155; border-radius: 10px; background: #020617 !important; color: white !important; outline: none; transition: 0.3s; }
    .inv-input:focus { border-color: #38bdf8; }
    
    .inv-type-btns { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
    .inv-type-btn { padding: 12px; border: 1px solid #334155; border-radius: 10px; text-align: center; cursor: pointer; font-weight: 700; background: #1e293b; color: #94a3b8; transition: 0.2s; }
    
    /* 5. 행사 타입별 활성화 컬러 */
    .inv-type-btn.active[data-type="갓세일"] { background: #0ea5e9 !important; border-color: #38bdf8 !important; color: #020617 !important; }
    .inv-type-btn.active[data-type="마감할인"] { background: #f97316 !important; border-color: #fb923c !important; color: #020617 !important; }
    .inv-type-btn.active[data-type="핫아이템"] { background: #ef4444 !important; border-color: #f87171 !important; color: #020617 !important; }

    /* 6. 테이블 디자인 */
    .inv-table { width: 100%; border-collapse: collapse; }
    .inv-table th { text-align: left; padding: 15px; border-bottom: 2px solid #1e293b; color: #64748b; font-size: 13px; text-transform: uppercase; }
    .inv-table td { padding: 15px; border-bottom: 1px solid #1e293b; vertical-align: middle; color: #cbd5e1; }
    .inv-list-img { width: 50px; height: 50px; border-radius: 8px; object-fit: cover; background: #1e293b; }

    .inv-badge { padding: 4px 8px; border-radius: 6px; font-size: 11px; font-weight: bold; color: #020617; }
    .inv-badge-god { background: #38bdf8; }
    .inv-badge-finish { background: #fb923c; }
    .inv-badge-hot { background: #f87171; }

    .inv-btn-submit { width: 100%; padding: 16px; background: #38bdf8; color: #020617; border-radius: 12px; font-weight: 800; cursor: pointer; margin-top: 20px; border: none; transition: 0.2s; }
    .inv-btn-submit:hover { background: #7dd3fc; transform: translateY(-2px); }
</style>

<div class="inv-container">
    <h2 class="text-5xl b-grade-font text-white mb-8 uppercase italic">GS25 Inventory</h2>

    <div class="inv-card">
        <div class="inv-card-title"><i class="fa-solid fa-plus-circle"></i> 상품 등록 및 이미지 첨부</div>
        <form id="invProductForm">
            <div style="margin-bottom: 25px;">
                <label style="display:block; margin-bottom:10px; font-size:14px; color:#94a3b8;">상품 이미지 (Required)</label>
                <div class="inv-upload-wrapper">
                    <div class="inv-preview-box" id="invPreviewBox">
                        <i class="fas fa-camera"></i>
                        <img id="invImgPreview" src="">
                    </div>
                    <div style="flex: 1;">
                        <label for="invFileInput" class="inv-upload-btn">이미지 선택하기</label>
                        <input type="file" id="invFileInput" name="prod_img" accept="image/*" hidden onchange="handleInvImg(this)">
                        <p style="font-size: 12px; color: #475569; margin-top: 8px;">* 추천 사이즈: 500x500px (JPG, PNG)</p>
                    </div>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
                <div style="grid-column: span 2;">
                    <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">행사 분류</label>
                    <div class="inv-type-btns">
                        <div class="inv-type-btn active" data-type="갓세일">갓세일</div>
                        <div class="inv-type-btn" data-type="마감할인">마감할인</div>
                        <div class="inv-type-btn" data-type="핫아이템">핫아이템</div>
                    </div>
                    <input type="hidden" id="invSelectedType" name="prod_category" value="갓세일">
                </div>

                <div style="grid-column: span 2;">
                    <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">상품명</label>
                    <input type="text" id="invPName" name="prod_name" class="inv-input" placeholder="GS25 상품 이름을 입력하세요">
                </div>

                <div>
                    <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">정상가 (원)</label>
                    <input type="number" id="invPPrice" name="prod_price" class="inv-input" placeholder="0">
                </div>
                <div>
                    <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">할인가 (원)</label>
                    <input type="number" id="invPDiscount" name="prod_discount" class="inv-input" placeholder="0">
                </div>

                <div id="invDeadlineSection" style="display: none; grid-column: span 2;">
                    <label style="display:block; margin-bottom:8px; font-size:14px; color:#f97316;">마감 시간 설정 (Only for 마감할인)</label>
                    <input type="time" id="invPTime" name="prod_deadline" class="inv-input">
                </div>
            </div>
            <button type="button" class="inv-btn-submit" onclick="submitInvProduct()">인벤토리에 추가하기</button>
        </form>
    </div>

    <div class="inv-card">
        <div class="inv-card-title"><i class="fa-solid fa-list"></i> 실시간 상품 목록</div>
        <table class="inv-table">
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>분류</th>
                    <th>상품명</th>
                    <th>가격 정보</th>
                    <th>비고</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="invTableBody">
                </tbody>
        </table>
    </div>
</div>

<script>
    // 이미지 임시 저장을 위한 변수
    var invCurrentImgData = '';

    /**
     * 이미지 미리보기 기능
     */
    window.handleInvImg = function(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.getElementById('invImgPreview');
                img.src = e.target.result;
                img.style.display = 'block';
                document.querySelector('#invPreviewBox i').style.display = 'none';
                invCurrentImgData = e.target.result; // [DB 연동 전] 임시 미리보기 데이터
            }
            reader.readAsDataURL(input.files[0]);
        }
    };

    /**
     * 탭 버튼 이벤트 초기화
     */
    function initInvEvents() {
        const btns = document.querySelectorAll('.inv-type-btn');
        const deadline = document.getElementById('invDeadlineSection');
        const typeInput = document.getElementById('invSelectedType');

        btns.forEach(btn => {
            btn.onclick = function() {
                btns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                const type = this.getAttribute('data-type');
                typeInput.value = type;
                
                // '마감할인' 선택 시에만 시간 설정 노출
                if(deadline) deadline.style.display = (type === '마감할인') ? 'block' : 'none';
            };
        });
    }

    /**
     * [DB 연동 시 수정될 핵심 함수] 상품 등록 제출
     */
    window.submitInvProduct = function() {
        const type = document.getElementById('invSelectedType').value;
        const name = document.getElementById('invPName').value;
        const price = document.getElementById('invPPrice').value;
        const discount = document.getElementById('invPDiscount').value;
        const time = document.getElementById('invPTime').value || '-';
        const imgPath = invCurrentImgData || 'https://via.placeholder.com/50?text=No+Img';

        // 유효성 검사
        if(!name || !price || !discount) { 
            alert("상품명과 가격 정보를 모두 입력해 주세요!"); 
            return; 
        }

        /* [DB 연동 팁] 
           1. 아래 row 생성 코드는 fetch() 성공 후에 실행되도록 옮겨야 합니다.
           2. 실제 DB 연동 시에는 FormData 객체를 사용하여 서버로 전송하세요.
           ex) let formData = new FormData(document.getElementById('invProductForm'));
        */

        const badgeClass = type === '마감할인' ? 'inv-badge-finish' : (type === '핫아이템' ? 'inv-badge-hot' : 'inv-badge-god');

        const row = `
            <tr style="animation: inv-fadeIn 0.4s ease-out;">
                <td><img src="\${imgPath}" class="inv-list-img"></td>
                <td><span class="inv-badge \${badgeClass}">\${type}</span></td>
                <td><strong class="text-white">\${name}</strong></td>
                <td>
                    <span style="color:#ef4444; font-weight:bold;">₩\${parseInt(discount).toLocaleString()}</span><br>
                    <small style="color:#64748b; text-decoration:line-through;">₩\${parseInt(price).toLocaleString()}</small>
                </td>
                <td>\${type === '마감할인' ? '<span style="color:#f97316; font-size:12px; font-weight:bold;">' + time + ' 마감</span>' : '-'}</td>
                <td>
                    <button class="hover:text-white transition-colors" 
                            style="color:#ef4444; cursor:pointer; background:none; border:none; font-weight:bold; font-size:12px;" 
                            onclick="removeInvItem(this, '글번호_PK')">삭제</button>
                </td>
            </tr>
        `;

        document.getElementById('invTableBody').insertAdjacentHTML('afterbegin', row);
        
        // 제출 후 폼 초기화
        document.getElementById('invProductForm').reset();
        document.getElementById('invImgPreview').style.display = 'none';
        document.querySelector('#invPreviewBox i').style.display = 'block';
        invCurrentImgData = '';
    };

    /**
     * [DB 연동 시 수정될 삭제 함수]
     */
    window.removeInvItem = function(btn, pkid) {
        if(confirm("해당 상품을 인벤토리에서 영구 삭제하시겠습니까?")) {
            /* [DB 연동 시] fetch('/DeleteProduct.do?id=' + pkid) 등의 요청 필요 */
            btn.parentElement.parentElement.remove();
        }
    }

    // 초기 이벤트 바인딩 실행
    initInvEvents();
</script>