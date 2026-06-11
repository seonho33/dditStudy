

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--
    쿠폰함 JSP (마이페이지 연동)
    
    [필요 데이터]
    - ${couponList} : List<CouponhamVO>
    - ${totalCount} : Integer
    
    [VO 필드]
    - couponBoxId, couponName, storeName, expiredDate
    - deductedPrice (할인금액), minPrice (최소주문금액)
    - availability (AVAILABLE/USED/EXPIRED)
    - useYn, usedDate
    
    [AJAX]
    - POST /couponham/use.do
    - POST /couponham/delete.do
-->

<style>
    @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap');
    
    .coupon-ticket { display: flex; background: #fff; border-radius: 25px; position: relative; border: 1px solid #ffeada; height: 160px; overflow: hidden; transition: 0.3s; }
    .coupon-left { width: 120px; background: #ff6b00; display: flex; flex-direction: column; justify-content: center; align-items: center; color: #fff; border-right: 2px dashed #ffd8be; }
    .coupon-right { flex: 1; padding: 25px; display: flex; flex-direction: column; justify-content: center; position: relative; }
    .coupon-ticket::before, .coupon-ticket::after { content: ''; position: absolute; left: 110px; width: 20px; height: 20px; background: #f8fafc; border-radius: 50%; z-index: 5; border: 1px solid #ffeada; }
    .coupon-ticket::before { top: -11px; }
    .coupon-ticket::after { bottom: -11px; }
    .btn-coupon-del { position: absolute; top: 12px; right: 12px; color: #cbd5e1; transition: 0.2s; z-index: 10; cursor: pointer; border: none; background: none; }
    .btn-coupon-del:hover { color: #ef4444; transform: scale(1.2); }
    .coupon-used { opacity: 0.4; filter: grayscale(100%); }
    .coupon-used .btn-coupon-del { pointer-events: auto; }
    .coupon-expired { opacity: 0.5; background: #f1f5f9; }
    
    /* ✨✨✨ [추가] 프리미엄 모달 스타일 ✨✨✨ */
    .alert-modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(8px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 20000;
        padding: 20px;
        font-family: 'Outfit', 'Pretendard', sans-serif;
    }
    
    .alert-modal-overlay.active {
        display: flex !important;
        animation: fadeIn 0.3s ease-out;
    }
    
    .alert-modal-overlay.closing {
        animation: fadeOut 0.3s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    @keyframes fadeOut {
        from { opacity: 1; }
        to { opacity: 0; }
    }
    
    .alert-modal-content {
        background: white;
        border-radius: 30px;
        width: 100%;
        max-width: 500px;
        box-shadow: 0 30px 90px rgba(0,0,0,0.4);
        animation: modalZoomIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
        overflow: hidden;
        margin: auto;
    }
    
    @keyframes modalZoomIn {
        from {
            opacity: 0;
            transform: scale(0.8) translateY(50px);
        }
        to {
            opacity: 1;
            transform: scale(1) translateY(0);
        }
    }
    
    @keyframes modalZoomOut {
        from {
            opacity: 1;
            transform: scale(1) translateY(0);
        }
        to {
            opacity: 0;
            transform: scale(0.8) translateY(50px);
        }
    }
    
    .alert-modal-overlay.closing .alert-modal-content {
        animation: modalZoomOut 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    .alert-modal-body {
        padding: 60px 40px 40px 40px;
        text-align: center;
    }
    
    .alert-modal-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 30px auto;
        font-size: 48px;
        position: relative;
    }
    
    .alert-modal-icon.info {
        background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
        color: #1e40af;
    }
    
    .alert-modal-icon.success {
        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
        color: #065f46;
    }
    
    .alert-modal-icon.error {
        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        color: #991b1b;
    }
    
    .alert-modal-icon.warning {
        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
        color: #92400e;
    }
    
    .alert-modal-icon::before {
        content: '';
        position: absolute;
        width: 120%;
        height: 120%;
        border-radius: 50%;
        opacity: 0.2;
        animation: pulse 2s ease-in-out infinite;
    }
    
    @keyframes pulse {
        0%, 100% { transform: scale(1); opacity: 0.2; }
        50% { transform: scale(1.1); opacity: 0.1; }
    }
    
    .alert-modal-icon.info::before {
        background: #3b82f6;
    }
    
    .alert-modal-icon.success::before {
        background: #10b981;
    }
    
    .alert-modal-icon.error::before {
        background: #ef4444;
    }
    
    .alert-modal-icon.warning::before {
        background: #f59e0b;
    }
    
    .alert-modal-title {
        font-size: 28px;
        font-weight: 900;
        color: #1e293b;
        margin: 0 0 15px 0;
        line-height: 1.3;
    }
    
    .alert-modal-message {
        font-size: 16px;
        color: #64748b;
        line-height: 1.7;
        margin: 0 0 30px 0;
        font-weight: 500;
        white-space: pre-line;
    }
    
    .alert-modal-buttons {
        display: flex;
        gap: 12px;
    }
    
    .alert-modal-btn {
        flex: 1;
        padding: 16px 24px;
        border-radius: 16px;
        font-weight: 800;
        font-size: 15px;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .alert-modal-btn-primary {
        background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
    }
    
    .alert-modal-btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(59, 130, 246, 0.4);
    }
    
    .alert-modal-btn-secondary {
        background: #f1f5f9;
        color: #64748b;
    }
    
    .alert-modal-btn-secondary:hover {
        background: #e2e8f0;
        color: #475569;
        transform: translateY(-2px);
    }
    
    .alert-modal-btn-success {
        background: linear-gradient(135deg, #10b981 0%, #34d399 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
    }
    
    .alert-modal-btn-success:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(16, 185, 129, 0.4);
    }
    
    .alert-modal-btn-danger {
        background: linear-gradient(135deg, #ef4444 0%, #f87171 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(239, 68, 68, 0.3);
    }
    
    .alert-modal-btn-danger:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(239, 68, 68, 0.4);
    }
    
    /* 프롬프트 입력창 스타일 */
    .alert-modal-input {
        width: 100%;
        padding: 16px 20px;
        border: 2px solid #e2e8f0;
        border-radius: 16px;
        font-size: 15px;
        font-weight: 500;
        color: #1e293b;
        transition: all 0.3s;
        font-family: 'Outfit', sans-serif;
        background: white;
        margin-bottom: 30px;
    }
    
    .alert-modal-input:focus {
        outline: none;
        border-color: #ff6b00;
        box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
        transform: translateY(-2px);
    }
    
    /* 반응형 */
    @media (max-width: 768px) {
        .alert-modal-body {
            padding: 40px 20px 30px 20px;
        }
        
        .alert-modal-icon {
            width: 80px;
            height: 80px;
            font-size: 36px;
        }
        
        .alert-modal-title {
            font-size: 24px;
        }
        
        .alert-modal-buttons {
            flex-direction: column;
        }
    }
    /* ✨✨✨ [추가 끝] ✨✨✨ */
</style>

<div class="animate-fadeIn">
    <div class="flex justify-between items-center mb-8">
        <div class="flex items-center gap-3">
            <h3 class="text-xl font-black text-slate-800 italic">MY COUPONS</h3>
            <span class="px-3 py-1 bg-orange-100 text-orange-600 text-[10px] font-black rounded-full">
                TOTAL ${totalCount}
            </span>
        </div>
        <p class="text-xs font-bold text-slate-400">쿠폰은 유효기간 내에만 사용 가능합니다.</p>
    </div>

    <div class="grid grid-cols-2 gap-6" id="coupon-container">
        <c:choose>
            <c:when test="${not empty couponList}">
                <c:forEach var="coupon" items="${couponList}">
                    <div id="coupon-card-${coupon.couponBoxId}" 
                         class="coupon-ticket shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all
                                ${coupon.availability == 'USED' ? 'coupon-used' : ''}
                                ${coupon.availability == 'EXPIRED' ? 'coupon-expired' : ''}">
                        
                        <%-- 삭제 버튼 (사용 가능한 쿠폰만) --%>
                        <c:if test="${coupon.availability != 'EXPIRED'}">
                            <button onclick="deleteCoupon(${coupon.couponBoxId})" class="btn-coupon-del" title="쿠폰 삭제">
                                <i class="fa-solid fa-circle-xmark text-xl"></i>
                            </button>
                        </c:if>

                        <%-- 좌측: 할인금액 표시 --%>
                        <div class="coupon-left">
                            <span class="text-[10px] font-black opacity-70 uppercase mb-1">Discount</span>
                            <span class="text-2xl font-black">
                                <fmt:formatNumber value="${coupon.deductedPrice}" pattern="#,###"/>
                            </span>
                            <span class="text-[10px] font-bold opacity-80 mt-1">원 할인</span>
                        </div>

                        <%-- 우측: 쿠폰 정보 --%>
                        <div class="coupon-right">
                            <h4 class="text-lg font-black text-slate-800 mb-1">${coupon.couponName}</h4>
                            <p class="text-[11px] text-slate-400 font-bold mb-3">
                                ${coupon.storeName} · ~<fmt:formatDate value="${coupon.expiredDate}" pattern="yyyy.MM.dd"/>
                                <c:if test="${coupon.availability == 'USED'}">
                                    <span class="text-red-500 ml-2">(사용완료)</span>
                                </c:if>
                                <c:if test="${coupon.availability == 'EXPIRED'}">
                                    <span class="text-gray-500 ml-2">(만료됨)</span>
                                </c:if>
                            </p>
                            
                            <%-- 최소 주문금액 표시 --%>
                            <p class="text-[10px] text-orange-500 font-bold mb-3">
                                최소주문 <fmt:formatNumber value="${coupon.minPrice}" pattern="#,###"/>원
                            </p>
                            
                            <%-- 사용 가능한 쿠폰: 사용 버튼 --%>
                            <c:if test="${coupon.availability == 'AVAILABLE'}">
                                <button onclick="useCoupon(${coupon.couponBoxId})" 
                                        class="w-full bg-slate-900 text-white px-4 py-2 rounded-xl text-[11px] font-black hover:bg-orange-600 transition-all">
                                    사용하기
                                </button>
                            </c:if>
                            
                            <%-- 사용 완료된 쿠폰 --%>
                            <c:if test="${coupon.availability == 'USED'}">
                                <div class="text-center font-black text-slate-400 italic text-sm">USED COUPON</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <div class="col-span-2 py-20 text-center" id="empty-coupon">
                    <i class="fa-solid fa-ticket-simple text-5xl text-slate-100 mb-4"></i>
                    <p class="text-slate-400 font-bold">보유하신 쿠폰이 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- ✨✨✨ [추가] 프리미엄 알림 모달 HTML ✨✨✨ -->
<div id="alertModal" class="alert-modal-overlay">
    <div class="alert-modal-content">
        <div class="alert-modal-body">
            <div id="alert-icon" class="alert-modal-icon">
                <i id="alert-icon-element"></i>
            </div>
            <h3 id="alert-title" class="alert-modal-title">알림</h3>
            <div id="alert-message" class="alert-modal-message"></div>
            <input type="text" id="alert-input" class="alert-modal-input" style="display: none;" placeholder="입력해주세요">
            <div id="alert-buttons" class="alert-modal-buttons"></div>
        </div>
    </div>
</div>
<!-- ✨✨✨ [추가 끝] ✨✨✨ -->

<script>
    /* ✨✨✨ [추가] 프리미엄 모달 함수들 ✨✨✨ */
    // 네임스페이스 객체
    window.CouponApp = window.CouponApp || {
        modalCallback: null,
        modalResolve: null,
        modalReject: null
    };
    
    // 프리미엄 알림 함수
    function showPremiumAlert(type, title, message, buttons) {
        var modal = document.getElementById('alertModal');
        var icon = document.getElementById('alert-icon');
        var iconElement = document.getElementById('alert-icon-element');
        var titleElement = document.getElementById('alert-title');
        var messageElement = document.getElementById('alert-message');
        var inputElement = document.getElementById('alert-input');
        var buttonsContainer = document.getElementById('alert-buttons');
        
        // 입력창 숨김
        inputElement.style.display = 'none';
        inputElement.value = '';
        
        // 아이콘 설정
        icon.className = 'alert-modal-icon ' + type;
        if (type === 'success') {
            iconElement.className = 'fa-solid fa-check';
        } else if (type === 'error') {
            iconElement.className = 'fa-solid fa-xmark';
        } else if (type === 'warning') {
            iconElement.className = 'fa-solid fa-triangle-exclamation';
        } else {
            iconElement.className = 'fa-solid fa-circle-info';
        }
        
        // 제목과 메시지 설정
        titleElement.textContent = title;
        messageElement.textContent = message;
        
        // 버튼 생성
        buttonsContainer.innerHTML = '';
        buttons.forEach(function(btn) {
            var button = document.createElement('button');
            button.className = 'alert-modal-btn ' + (btn.className || 'alert-modal-btn-primary');
            button.textContent = btn.text;
            button.onclick = function() {
                closePremiumModal();
                if (btn.onClick) btn.onClick();
            };
            buttonsContainer.appendChild(button);
        });
        
        // 모달 표시
        modal.style.display = 'block';
        setTimeout(function() {
            modal.classList.add('active');
        }, 10);
    }
    
    // 프리미엄 프롬프트 함수 (입력창 포함)
    function showPremiumPrompt(type, title, message, placeholder) {
        return new Promise(function(resolve, reject) {
            var modal = document.getElementById('alertModal');
            var icon = document.getElementById('alert-icon');
            var iconElement = document.getElementById('alert-icon-element');
            var titleElement = document.getElementById('alert-title');
            var messageElement = document.getElementById('alert-message');
            var inputElement = document.getElementById('alert-input');
            var buttonsContainer = document.getElementById('alert-buttons');
            
            // 입력창 표시
            inputElement.style.display = 'block';
            inputElement.value = '';
            inputElement.placeholder = placeholder || '입력해주세요';
            
            // 아이콘 설정
            icon.className = 'alert-modal-icon ' + type;
            if (type === 'info') {
                iconElement.className = 'fa-solid fa-circle-info';
            } else if (type === 'warning') {
                iconElement.className = 'fa-solid fa-triangle-exclamation';
            } else {
                iconElement.className = 'fa-solid fa-question';
            }
            
            // 제목과 메시지 설정
            titleElement.textContent = title;
            messageElement.textContent = message;
            
            // 버튼 생성
            buttonsContainer.innerHTML = '';
            
            // 확인 버튼
            var confirmBtn = document.createElement('button');
            confirmBtn.className = 'alert-modal-btn alert-modal-btn-primary';
            confirmBtn.textContent = '확인';
            confirmBtn.onclick = function() {
                var value = inputElement.value.trim();
                closePremiumModal();
                resolve(value);
            };
            buttonsContainer.appendChild(confirmBtn);
            
            // 취소 버튼
            var cancelBtn = document.createElement('button');
            cancelBtn.className = 'alert-modal-btn alert-modal-btn-secondary';
            cancelBtn.textContent = '취소';
            cancelBtn.onclick = function() {
                closePremiumModal();
                resolve(null);
            };
            buttonsContainer.appendChild(cancelBtn);
            
            // 모달 표시
            modal.style.display = 'block';
            setTimeout(function() {
                modal.classList.add('active');
                inputElement.focus();
            }, 10);
            
            // Enter 키 이벤트
            inputElement.onkeypress = function(e) {
                if (e.key === 'Enter') {
                    confirmBtn.click();
                }
            };
        });
    }
    
    // 프리미엄 확인 함수 (confirm 대체)
    function showPremiumConfirm(type, title, message) {
        return new Promise(function(resolve) {
            var modal = document.getElementById('alertModal');
            var icon = document.getElementById('alert-icon');
            var iconElement = document.getElementById('alert-icon-element');
            var titleElement = document.getElementById('alert-title');
            var messageElement = document.getElementById('alert-message');
            var inputElement = document.getElementById('alert-input');
            var buttonsContainer = document.getElementById('alert-buttons');
            
            // 입력창 숨김
            inputElement.style.display = 'none';
            
            // 아이콘 설정
            icon.className = 'alert-modal-icon ' + type;
            iconElement.className = 'fa-solid fa-triangle-exclamation';
            
            // 제목과 메시지 설정
            titleElement.textContent = title;
            messageElement.textContent = message;
            
            // 버튼 생성
            buttonsContainer.innerHTML = '';
            
            // 확인 버튼
            var confirmBtn = document.createElement('button');
            confirmBtn.className = 'alert-modal-btn alert-modal-btn-danger';
            confirmBtn.textContent = '확인';
            confirmBtn.onclick = function() {
                closePremiumModal();
                resolve(true);
            };
            buttonsContainer.appendChild(confirmBtn);
            
            // 취소 버튼
            var cancelBtn = document.createElement('button');
            cancelBtn.className = 'alert-modal-btn alert-modal-btn-secondary';
            cancelBtn.textContent = '취소';
            cancelBtn.onclick = function() {
                closePremiumModal();
                resolve(false);
            };
            buttonsContainer.appendChild(cancelBtn);
            
            // 모달 표시
            modal.style.display = 'block';
            setTimeout(function() {
                modal.classList.add('active');
            }, 10);
        });
    }
    
    // 모달 닫기
    function closePremiumModal() {
        var modal = document.getElementById('alertModal');
        modal.classList.remove('active');
        modal.classList.add('closing');
        
        setTimeout(function() {
            modal.style.display = 'none';
            modal.classList.remove('closing');
        }, 300);
    }
    
    // 모달 외부 클릭 시 닫기
    document.addEventListener('click', function(e) {
        var modal = document.getElementById('alertModal');
        if (e.target === modal) {
            closePremiumModal();
        }
    });
    /* ✨✨✨ [추가 끝] ✨✨✨ */
    
    /**
     * ✨ [수정] 쿠폰 사용 처리 - 프리미엄 모달 적용 ✨
     */
    async function useCoupon(couponBoxId) {
        // 프롬프트로 가게 ID 입력받기
        const inputStoreId = await showPremiumPrompt(
            'info',
            '가게 ID 입력',
            '가게 ID를 입력하세요 (점원 확인용)',
            '가게 ID 입력'
        );
        
        if (!inputStoreId || !inputStoreId.trim()) {
            showPremiumAlert('warning', '알림', '가게 ID를 입력해야 쿠폰을 사용할 수 있습니다.', [
                { text: '확인', className: 'alert-modal-btn-primary' }
            ]);
            return;
        }
        
        // 확인 대화상자
        const confirmed = await showPremiumConfirm(
            'warning',
            '쿠폰 사용 확인',
            '점원 확인이 완료되었습니까?\n사용 후에는 취소할 수 없습니다.'
        );
        
        if (!confirmed) return;
        
        fetch('${pageContext.request.contextPath}/couponham/use.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body: 'couponBoxId=' + encodeURIComponent(couponBoxId)
                + '&inputStoreId=' + encodeURIComponent(inputStoreId.trim())
        })
        .then(res => res.json())
        .then(data => {
            if (!data.success) {
                showPremiumAlert('error', '오류', '쿠폰 사용 실패: ' + (data.message || '알 수 없는 오류'), [
                    { text: '확인', className: 'alert-modal-btn-danger' }
                ]);
                return;
            }
            
            showPremiumAlert('success', '완료', '쿠폰 사용이 완료되었습니다.', [
                {
                    text: '확인',
                    className: 'alert-modal-btn-success',
                    onClick: function() {
                        const card = document.getElementById('coupon-card-' + couponBoxId);
                        if (!card) return;
                        
                        card.classList.add('coupon-used');
                        
                        // 사용하기 버튼만 제거
                        const useBtn = card.querySelector('.coupon-right button');
                        if (useBtn) useBtn.remove();
                        
                        // 사용완료 텍스트를 정보 영역에 추가(없으면)
                        if (!card.querySelector('.coupon-used-badge')) {
                            const badge = document.createElement('div');
                            badge.className = 'coupon-used-badge mt-2 text-center text-[11px] font-black text-red-500';
                            badge.textContent = '✔ 사용 완료';
                            card.querySelector('.coupon-right').appendChild(badge);
                        }
                    }
                }
            ]);
        })
        .catch(err => {
            console.error(err);
            showPremiumAlert('error', '오류', '네트워크 오류가 발생했습니다.', [
                { text: '확인', className: 'alert-modal-btn-danger' }
            ]);
        });
    }

    /**
     * ✨ [수정] 쿠폰 삭제 - 프리미엄 모달 적용 ✨
     */
    async function deleteCoupon(couponBoxId) {
        const confirmed = await showPremiumConfirm(
            'warning',
            '쿠폰 삭제',
            '정말로 이 쿠폰을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.'
        );
        
        if (!confirmed) return;
        
        fetch('${pageContext.request.contextPath}/couponham/delete.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body: 'couponBoxId=' + encodeURIComponent(couponBoxId)
        })
        .then(res => res.json())
        .then(data => {
            if (!data.success) {
                showPremiumAlert('error', '오류', '쿠폰 삭제 실패: ' + (data.message || '알 수 없는 오류'), [
                    { text: '확인', className: 'alert-modal-btn-danger' }
                ]);
                return;
            }
            
            const card = document.getElementById('coupon-card-' + couponBoxId);
            if (!card) return;
            
            card.style.transform = 'scale(0.8)';
            card.style.opacity = '0';
            
            setTimeout(() => {
                card.remove();
                
                const remaining = document.querySelectorAll('.coupon-ticket').length;
                if (remaining === 0) {
                    document.getElementById('coupon-container').innerHTML =
                        '<div class="col-span-2 py-20 text-center" id="empty-coupon">' +
                        '<i class="fa-solid fa-ticket-simple text-5xl text-slate-100 mb-4"></i>' +
                        '<p class="text-slate-400 font-bold">보유하신 쿠폰이 없습니다.</p>' +
                        '</div>';
                }
                
                showPremiumAlert('success', '완료', '쿠폰이 삭제되었습니다.', [
                    { text: '확인', className: 'alert-modal-btn-success' }
                ]);
            }, 300);
        })
        .catch(err => {
            console.error(err);
            showPremiumAlert('error', '오류', '네트워크 오류가 발생했습니다.', [
                { text: '확인', className: 'alert-modal-btn-danger' }
            ]);
        });
    }
</script>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--
    쿠폰함 JSP (마이페이지 연동)
    
    [필요 데이터]
    - ${couponList} : List<CouponhamVO>
    - ${totalCount} : Integer
    
    [VO 필드]
    - couponBoxId, couponName, storeName, expiredDate
    - deductedPrice (할인금액), minPrice (최소주문금액)
    - availability (AVAILABLE/USED/EXPIRED)
    - useYn, usedDate
    
    [AJAX]
    - POST /couponham/use.do
    - POST /couponham/delete.do
-->

<style>
    .coupon-ticket { display: flex; background: #fff; border-radius: 25px; position: relative; border: 1px solid #ffeada; height: 160px; overflow: hidden; transition: 0.3s; }
    .coupon-left { width: 120px; background: #ff6b00; display: flex; flex-direction: column; justify-content: center; align-items: center; color: #fff; border-right: 2px dashed #ffd8be; }
    .coupon-right { flex: 1; padding: 25px; display: flex; flex-direction: column; justify-content: center; position: relative; }
    .coupon-ticket::before, .coupon-ticket::after { content: ''; position: absolute; left: 110px; width: 20px; height: 20px; background: #f8fafc; border-radius: 50%; z-index: 5; border: 1px solid #ffeada; }
    .coupon-ticket::before { top: -11px; }
    .coupon-ticket::after { bottom: -11px; }
    .btn-coupon-del { position: absolute; top: 12px; right: 12px; color: #cbd5e1; transition: 0.2s; z-index: 10; cursor: pointer; border: none; background: none; }
    .btn-coupon-del:hover { color: #ef4444; transform: scale(1.2); }
.coupon-used { opacity: 0.4; filter: grayscale(100%); }
.coupon-used .btn-coupon-del { pointer-events: auto; }
    .coupon-expired { opacity: 0.5; background: #f1f5f9; }
</style>

<div class="animate-fadeIn">
    <div class="flex justify-between items-center mb-8">
        <div class="flex items-center gap-3">
            <h3 class="text-xl font-black text-slate-800 italic">MY COUPONS</h3>
            <span class="px-3 py-1 bg-orange-100 text-orange-600 text-[10px] font-black rounded-full">
                TOTAL ${totalCount}
            </span>
        </div>
        <p class="text-xs font-bold text-slate-400">쿠폰은 유효기간 내에만 사용 가능합니다.</p>
    </div>

    <div class="grid grid-cols-2 gap-6" id="coupon-container">
        <c:choose>
            <c:when test="${not empty couponList}">
                <c:forEach var="coupon" items="${couponList}">
                    <div id="coupon-card-${coupon.couponBoxId}" 
                         class="coupon-ticket shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all
                                ${coupon.availability == 'USED' ? 'coupon-used' : ''}
                                ${coupon.availability == 'EXPIRED' ? 'coupon-expired' : ''}">
                        
                        삭제 버튼 (사용 가능한 쿠폰만)
<c:if test="${coupon.availability != 'EXPIRED'}">
    <button onclick="deleteCoupon(${coupon.couponBoxId})" class="btn-coupon-del" title="쿠폰 삭제">
        <i class="fa-solid fa-circle-xmark text-xl"></i>
    </button>
</c:if>


                        좌측: 할인금액 표시
                        <div class="coupon-left">
                            <span class="text-[10px] font-black opacity-70 uppercase mb-1">Discount</span>
                            <span class="text-2xl font-black">
                                <fmt:formatNumber value="${coupon.deductedPrice}" pattern="#,###"/>
                            </span>
                            <span class="text-[10px] font-bold opacity-80 mt-1">원 할인</span>
                        </div>

                        우측: 쿠폰 정보
                        <div class="coupon-right">
                            <h4 class="text-lg font-black text-slate-800 mb-1">${coupon.couponName}</h4>
                            <p class="text-[11px] text-slate-400 font-bold mb-3">
                                ${coupon.storeName} · ~<fmt:formatDate value="${coupon.expiredDate}" pattern="yyyy.MM.dd"/>
                                <c:if test="${coupon.availability == 'USED'}">
                                    <span class="text-red-500 ml-2">(사용완료)</span>
                                </c:if>
                                <c:if test="${coupon.availability == 'EXPIRED'}">
                                    <span class="text-gray-500 ml-2">(만료됨)</span>
                                </c:if>
                            </p>
                            
                            최소 주문금액 표시
                            <p class="text-[10px] text-orange-500 font-bold mb-3">
                                최소주문 <fmt:formatNumber value="${coupon.minPrice}" pattern="#,###"/>원
                            </p>
                            
                            사용 가능한 쿠폰: 사용 버튼
                            <c:if test="${coupon.availability == 'AVAILABLE'}">
                                <button onclick="useCoupon(${coupon.couponBoxId})" 
                                        class="w-full bg-slate-900 text-white px-4 py-2 rounded-xl text-[11px] font-black hover:bg-orange-600 transition-all">
                                    사용하기
                                </button>
                            </c:if>
                            
                            사용 완료된 쿠폰
                            <c:if test="${coupon.availability == 'USED'}">
                                <div class="text-center font-black text-slate-400 italic text-sm">USED COUPON</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <div class="col-span-2 py-20 text-center" id="empty-coupon">
                    <i class="fa-solid fa-ticket-simple text-5xl text-slate-100 mb-4"></i>
                    <p class="text-slate-400 font-bold">보유하신 쿠폰이 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    /**
     * 쿠폰 사용 처리 (AJAX)
     */
     function useCoupon(couponBoxId) {
    	  const inputStoreId = prompt("가게 ID를 입력하세요 (점원 확인용):");
    	  if (!inputStoreId || !inputStoreId.trim()) {
    	    alert("가게 ID를 입력해야 쿠폰을 사용할 수 있습니다.");
    	    return;
    	  }

    	  if (!confirm("점원 확인이 완료되었습니까? 사용 후에는 취소할 수 없습니다.")) return;

    	  fetch('${pageContext.request.contextPath}/couponham/use.do', {
    	    method: 'POST',
    	    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    	    body: 'couponBoxId=' + encodeURIComponent(couponBoxId)
    	        + '&inputStoreId=' + encodeURIComponent(inputStoreId.trim())
    	  })
    	  .then(res => res.json())
    	  .then(data => {
    	    if (!data.success) {
    	      alert("쿠폰 사용 실패: " + (data.message || '알 수 없는 오류'));
    	      return;
    	    }

    	    alert("쿠폰 사용이 완료되었습니다.");

    	    const card = document.getElementById('coupon-card-' + couponBoxId);
    	    if (!card) return;

    	    card.classList.add('coupon-used');

    	    // 사용하기 버튼만 제거
    	    const useBtn = card.querySelector('.coupon-right button');
    	    if (useBtn) useBtn.remove();

    	    // 사용완료 텍스트를 정보 영역에 추가(없으면)
    	    if (!card.querySelector('.coupon-used-badge')) {
    	      const badge = document.createElement('div');
    	      badge.className = 'coupon-used-badge mt-2 text-center text-[11px] font-black text-red-500';
    	      badge.textContent = '✔ 사용 완료';
    	      card.querySelector('.coupon-right').appendChild(badge);
    	    }
    	  })
    	  .catch(err => {
    	    console.error(err);
    	    alert("네트워크 오류가 발생했습니다.");
    	  });
    	}


    /**
     * 쿠폰 삭제 (AJAX)
     */
     function deleteCoupon(couponBoxId) {
    	  if (!confirm("정말로 이 쿠폰을 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.")) return;

    	  fetch('${pageContext.request.contextPath}/couponham/delete.do', {
    	    method: 'POST',
    	    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    	    body: 'couponBoxId=' + encodeURIComponent(couponBoxId)
    	  })
    	  .then(res => res.json())
    	  .then(data => {
    	    if (!data.success) {
    	      alert("쿠폰 삭제 실패: " + (data.message || '알 수 없는 오류'));
    	      return;
    	    }

    	    const card = document.getElementById('coupon-card-' + couponBoxId);
    	    if (!card) return;

    	    card.style.transform = 'scale(0.8)';
    	    card.style.opacity = '0';

    	    setTimeout(() => {
    	      card.remove();

    	      const remaining = document.querySelectorAll('.coupon-ticket').length;
    	      if (remaining === 0) {
    	        document.getElementById('coupon-container').innerHTML =
    	          '<div class="col-span-2 py-20 text-center" id="empty-coupon">' +
    	          '<i class="fa-solid fa-ticket-simple text-5xl text-slate-100 mb-4"></i>' +
    	          '<p class="text-slate-400 font-bold">보유하신 쿠폰이 없습니다.</p>' +
    	          '</div>';
    	      }

    	      alert("쿠폰이 삭제되었습니다.");
    	    }, 300);
    	  })
    	  .catch(err => {
    	    console.error(err);
    	    alert("네트워크 오류가 발생했습니다.");
    	  });
    	}
</script> --%>