<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  .inv-container { color: #e2e8f0 !important; animation: inv-fadeIn 0.5s ease-out; padding: 40px; max-width: 1200px; margin: 0 auto; }
  @keyframes inv-fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

  .inv-card { background: #0f172a !important; border-radius: 20px; padding: 30px; border: 1px solid #1e293b; margin-bottom: 30px; }
  .inv-card-title { font-size: 18px; font-weight: 700; margin-bottom: 25px; color: #38bdf8; display: flex; align-items: center; gap: 8px; }

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

  .inv-input { width: 100%; padding: 12px; border: 1px solid #334155; border-radius: 10px; background: #020617 !important; color: white !important; box-sizing: border-box; outline: none; transition: 0.3s; }
  .inv-input:focus { border-color: #38bdf8; }

  .inv-type-btns { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
  .inv-type-btn { padding: 12px; border: 1px solid #334155; border-radius: 10px; text-align: center; cursor: pointer; font-weight: 700; background: #1e293b; color: #94a3b8; transition: 0.2s; user-select:none; }

  .inv-type-btn.active[data-type="갓세일"] { background: #0ea5e9 !important; border-color: #38bdf8 !important; color: #020617 !important; }
  .inv-type-btn.active[data-type="마감할인"] { background: #f97316 !important; border-color: #fb923c !important; color: #020617 !important; }
  .inv-type-btn.active[data-type="핫아이템"] { background: #ef4444 !important; border-color: #f87171 !important; color: #020617 !important; }

  .inv-table { width: 100%; border-collapse: collapse; }
  .inv-table th { text-align: left; padding: 15px; border-bottom: 2px solid #1e293b; color: #64748b; font-size: 13px; text-transform: uppercase; }
  .inv-table td { padding: 15px; border-bottom: 1px solid #1e293b; vertical-align: middle; color: #cbd5e1; }
  .inv-list-img { width: 50px; height: 50px; border-radius: 8px; object-fit: cover; background: #1e293b; }

  .inv-btn-submit { width: 100%; padding: 16px; background: #38bdf8; color: #020617; border-radius: 12px; font-weight: 800; cursor: pointer; margin-top: 20px; border: none; transition: 0.2s; }
  .inv-btn-submit:hover { background: #7dd3fc; transform: translateY(-2px); }

  .inv-btn-mini {
    padding: 8px 10px; border-radius: 10px; border: 1px solid #334155;
    background: #1e293b; color: #cbd5e1; cursor: pointer; font-weight: 800; font-size: 12px;
    transition: .15s; margin-right: 6px;
  }
  .inv-btn-mini:hover { background:#334155; color:#fff; }
  .inv-btn-mini.danger { border-color:#7f1d1d; background:#3f0b0b; }
  .inv-btn-mini.danger:hover { background:#7f1d1d; }

  .inv-muted { color:#64748b; font-size:12px; }
</style>

<div class="inv-container" id="gsInvRoot">
  <h2 style="font-size: 3rem; font-weight: 900; color: white; margin-bottom: 2rem; font-style: italic;">
    GS25 Inventory
  </h2>

  <div class="inv-card">
    <div class="inv-card-title"><i class="fa-solid fa-plus-circle"></i> 상품 등록 및 이미지 첨부</div>

    <form id="invProductForm" enctype="multipart/form-data">
      <div style="margin-bottom: 25px;">
        <label style="display:block; margin-bottom:10px; font-size:14px; color:#94a3b8;">상품 이미지 (Required)</label>
        <div class="inv-upload-wrapper">
          <div class="inv-preview-box" id="invPreviewBox">
            <i class="fas fa-camera"></i>
            <img id="invImgPreview" src="" alt="">
          </div>
          <div style="flex: 1;">
            <label for="invFileInput" class="inv-upload-btn">이미지 선택하기</label>
            <input type="file" id="invFileInput" name="prod_img" accept="image/*" hidden>
            <p class="inv-muted" style="margin-top: 8px;">* 추천 사이즈: 500x500px (JPG, PNG)</p>
          </div>
        </div>
      </div>

      <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
        <div style="grid-column: span 2;">
          <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">행사 분류</label>
          <div class="inv-type-btns" id="invTypeBtns">
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
          <input type="number" id="invPPrice" name="prod_price" class="inv-input" placeholder="0" min="0">
        </div>

        <div>
          <label style="display:block; margin-bottom:8px; font-size:14px; color:#94a3b8;">할인가 (원)</label>
          <input type="number" id="invPDiscount" name="prod_discount" class="inv-input" placeholder="0" min="0">
        </div>

        <div id="invDeadlineSection" style="display:none; grid-column: span 2;">
          <label style="display:block; margin-bottom:8px; font-size:14px; color:#f97316;">마감 시간 설정 (Only for 마감할인)</label>
          <input type="time" id="invPTime" name="prod_deadline" class="inv-input">
          <p class="inv-muted" style="margin-top:8px;">
            * 마감할인 선택 시 필수. (서버에서 날짜는 오늘로 합쳐 저장 권장)
          </p>
        </div>
      </div>

      <button type="button" class="inv-btn-submit" id="invSubmitBtn">인벤토리에 추가하기</button>
    </form>
  </div>

  <div class="inv-card">
    <div class="inv-card-title"><i class="fa-solid fa-list"></i> 실시간 상품 목록</div>

    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">
      <div class="inv-muted">* 등록/삭제 후 목록은 조각 재로딩으로 갱신됩니다.</div>
      <button type="button" class="inv-btn-mini" id="invRefreshBtn"><i class="fa-solid fa-rotate"></i> 새로고침</button>
    </div>

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
        <c:choose>
          <c:when test="${empty gsList}">
            <tr>
              <td colspan="6" style="padding:24px; color:#64748b;">등록된 상품이 없습니다.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="g" items="${gsList}">
              <tr>
                <td>
                  <img class="inv-list-img"
                       src="<%=request.getContextPath()%>/images/upload/GS/${g.productImageUrl}"
                       onerror="this.style.display='none'">
                </td>
                <td>${g.productDivision}</td>
                <td>${g.productName}</td>
                <td>
                  할인가: ${g.discountPrice}원<br/>
                  <span style="color:#64748b;">정가 ${g.originalPrice}원 · ${g.discountRate}%</span>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${g.productDivision eq '마감할인'}">
                      ${g.endTime}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <button type="button"
                          class="inv-btn-mini danger inv-delete-btn"
                          data-gsid="${g.gsId}">
                    <i class="fa-solid fa-trash"></i> 삭제
                  </button>
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
(function(){
	var CTX = window.CTX || '<%= request.getContextPath() %>';
  const API = {
    insert: CTX + '/gs25/insert.do',
    delete: CTX + '/gs25/delete.do'
  };

  const root = document.getElementById('gsInvRoot');
  if (!root) return;

  function qs(sel){ return root.querySelector(sel); }
  function qsa(sel){ return root.querySelectorAll(sel); }

  // ✅ 조각 재로딩(= 서버에서 다시 selectAll 해서 gsList로 렌더링)
  function reloadFragment(){
    if (typeof loadContent === 'function') {
      const nav = document.querySelector('.nav-item.active');
      loadContent('/admin/gs25.do', nav || document.querySelector('.nav-item[onclick*="gs25.do"]'));
    } else {
      location.reload();
    }
  }

  // 이미지 프리뷰
  function bindPreview(){
    const input = qs('#invFileInput');
    const img = qs('#invImgPreview');
    const icon = qs('#invPreviewBox i');
    if (!input || !img) return;

    input.addEventListener('change', function(){
      if (!this.files || !this.files[0]) return;
      const reader = new FileReader();
      reader.onload = function(e){
        img.src = e.target.result;
        img.style.display = 'block';
        if (icon) icon.style.display = 'none';
      };
      reader.readAsDataURL(this.files[0]);
    });
  }

  // 분류 버튼
  function bindTypeButtons(){
    const wrap = qs('#invTypeBtns');
    const typeInput = qs('#invSelectedType');
    const deadline = qs('#invDeadlineSection');
    if (!wrap || !typeInput) return;

    wrap.addEventListener('click', function(e){
      const btn = e.target.closest('.inv-type-btn');
      if (!btn) return;

      qsa('.inv-type-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const type = btn.getAttribute('data-type');
      typeInput.value = type;

      if (deadline) deadline.style.display = (type === '마감할인') ? 'block' : 'none';
    });
  }

  // 등록
  async function submitProduct(){
    const form = qs('#invProductForm');
    const name = qs('#invPName')?.value?.trim();
    const price = qs('#invPPrice')?.value;
    const discount = qs('#invPDiscount')?.value;
    const type = qs('#invSelectedType')?.value;
    const deadline = qs('#invPTime')?.value;
    const fileInput = qs('#invFileInput');

    if (!name || !price || !discount){
      alert('상품명과 가격 정보를 모두 입력해 주세요!');
      return;
    }

    const p = Number(price), d = Number(discount);
    if (p <= 0 || d <= 0){
      alert('가격은 0보다 커야 합니다.');
      return;
    }
    if (d > p){
      alert('할인가가 정상가보다 클 수 없습니다.');
      return;
    }
    if (type === '마감할인' && (!deadline || deadline.trim() === '')){
      alert('마감할인 선택 시 마감 시간을 입력해 주세요!');
      return;
    }

    const formData = new FormData(form);

    try{
      const res = await fetch(API.insert, { method:'POST', body: formData });
      const data = await res.json();

      if (data && data.success){
        alert('인벤토리에 추가되었습니다!');
        reloadFragment(); // ✅ 서버 재조회로 목록 갱신
      } else {
        alert((data && data.message) ? data.message : '등록 실패');
      }
    }catch(e){
      console.error(e);
      alert('서버 통신 중 오류가 발생했습니다.');
    }
  }

  // === delete (나중에 서블릿 만들면 바로 동작) ===
  async function deleteItem(gsId){
	  if (!confirm('정말 삭제할까요?')) return;

	  const body = new URLSearchParams({ gsId }).toString();
	  const res = await fetch(API.delete, {
	    method:'POST',
	    headers:{ 'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8' },
	    body
	  });

	  const data = await res.json();

	  if (data.success){
	    alert('삭제되었습니다.');
	    reloadFragment();
	  } else {
	    alert(data.message || '삭제 실패');
	  }
	}

  
  function bindActions(){
	  // ✅ 이미 바인딩했으면 더 이상 붙이지 않기
	  if (root.dataset.bound === '1') return;
	  root.dataset.bound = '1';

	  const btn = qs('#invSubmitBtn');
	  if (btn) btn.addEventListener('click', submitProduct);

	  const rbtn = qs('#invRefreshBtn');
	  if (rbtn) rbtn.addEventListener('click', reloadFragment);

	  const tbody = qs('#invTableBody');
	  if (tbody){
	    tbody.addEventListener('click', function(e){
	      const del = e.target.closest('.inv-delete-btn');
	      if (del){
	        const gsId = del.getAttribute('data-gsid');
	        if (gsId) deleteItem(gsId);
	      }
	    });
	  }
	}


  // === fragment init: 주입될 때마다 안전하게 동작 ===
  function init(){
    bindPreview();
    bindTypeButtons();
    bindActions();
/*     loadList(); */
  }

  // 전역 초기화 함수로도 노출(메인에서 주입 직후 호출하고 싶으면)
  window.initGsInventoryFragment = init;

  // 바로 실행(스크립트가 실행되는 환경이면)
  init();

})();
</script>
