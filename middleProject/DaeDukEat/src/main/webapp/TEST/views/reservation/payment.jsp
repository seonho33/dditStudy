<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 결제 - D.D.M</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');
        body { font-family: 'Pretendard', sans-serif; background-color: #fefaf8; color: #191f28; }
        :root { --main-orange: #ff6b35; --soft-orange: #fff1eb; }
        .orange-btn { background-color: var(--main-orange); color: white; transition: 0.2s; border: none; cursor: pointer; }
        .orange-btn:hover { background-color: #e85a24; transform: translateY(-1px); }
        .input-box { width: 100%; padding: 14px; border: 1px solid #e5e8eb; border-radius: 12px; font-size: 15px; }
        .count-btn { border: 1px solid #e5e8eb; background: white; padding: 10px 0; border-radius: 10px; font-weight: 600; cursor: pointer; text-align: center; }
        .count-btn.active { border-color: var(--main-orange); background-color: var(--soft-orange); color: var(--main-orange); }
        .pg-option { border: 2px solid #e5e8eb; padding: 15px; border-radius: 16px; cursor: pointer; display: flex; flex-direction: column; align-items: center; gap: 6px; background: white; }
        .pg-option.active { border-color: var(--main-orange); background-color: var(--soft-orange); color: var(--main-orange); }
        
        /* ✅ 커스텀 모달 스타일 */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .modal-overlay.show {
            opacity: 1;
        }
        .modal-content {
            background: white;
            border-radius: 24px;
            padding: 40px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            transform: scale(0.9);
            transition: transform 0.3s;
        }
        .modal-overlay.show .modal-content {
            transform: scale(1);
        }
        .modal-header {
            font-size: 24px;
            font-weight: 900;
            color: var(--main-orange);
            margin-bottom: 20px;
            text-align: center;
        }
        .modal-body {
            background: #f9fafb;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 30px;
        }
        .modal-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .modal-row:last-child {
            border-bottom: none;
        }
        .modal-label {
            color: #6b7280;
            font-weight: 600;
        }
        .modal-value {
            color: #1f2937;
            font-weight: 800;
        }
        .modal-buttons {
            display: flex;
            gap: 12px;
        }
        .modal-btn {
            flex: 1;
            padding: 16px;
            border-radius: 16px;
            font-weight: 800;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }
        .modal-btn-cancel {
            background: #f3f4f6;
            color: #6b7280;
        }
        .modal-btn-cancel:hover {
            background: #e5e7eb;
        }
        .modal-btn-confirm {
            background: var(--main-orange);
            color: white;
        }
        .modal-btn-confirm:hover {
            background: #e85a24;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.4);
        }

        /* ✅ Alert 모달 스타일 */
        .alert-modal {
            text-align: center;
        }
        .alert-modal .modal-header {
            margin-bottom: 15px;
        }
        .alert-modal .modal-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        .alert-modal .modal-message {
            font-size: 16px;
            color: #4b5563;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .alert-modal .modal-btn-single {
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            font-weight: 800;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }
        
        /* 성공 모달 */
        .modal-success .modal-icon { color: #10b981; }
        .modal-success .modal-header { color: #10b981; }
        .modal-success .modal-btn-single { background: #10b981; color: white; }
        .modal-success .modal-btn-single:hover { background: #059669; }
        
        /* 에러 모달 */
        .modal-error .modal-icon { color: #ef4444; }
        .modal-error .modal-header { color: #ef4444; }
        .modal-error .modal-btn-single { background: #ef4444; color: white; }
        .modal-error .modal-btn-single:hover { background: #dc2626; }
        
        /* 경고 모달 */
        .modal-warning .modal-icon { color: #f59e0b; }
        .modal-warning .modal-header { color: #f59e0b; }
        .modal-warning .modal-btn-single { background: #f59e0b; color: white; }
        .modal-warning .modal-btn-single:hover { background: #d97706; }
    </style>
</head>
<body class="py-12">

    <!-- ✅ 예약 정보 확인 모달 -->
    <div id="confirmModal" class="modal-overlay" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <i class="fa-solid fa-circle-check" style="color: var(--main-orange);"></i>
                예약 정보 확인
            </div>
            <div class="modal-body">
                <div class="modal-row">
                    <span class="modal-label">가게</span>
                    <span class="modal-value" id="modalShop"></span>
                </div>
                <div class="modal-row">
                    <span class="modal-label">날짜</span>
                    <span class="modal-value" id="modalDate"></span>
                </div>
                <div class="modal-row">
                    <span class="modal-label">시간</span>
                    <span class="modal-value" id="modalTime"></span>
                </div>
                <div class="modal-row">
                    <span class="modal-label">인원</span>
                    <span class="modal-value" id="modalGuest"></span>
                </div>
                <div class="modal-row">
                    <span class="modal-label">예약금</span>
                    <span class="modal-value" id="modalAmount" style="color: var(--main-orange);"></span>
                </div>
            </div>
            <div class="modal-buttons">
                <button class="modal-btn modal-btn-cancel" onclick="closeModal('confirmModal')">
                    취소
                </button>
                <button class="modal-btn modal-btn-confirm" onclick="proceedPayment()">
                    결제하기
                </button>
            </div>
        </div>
    </div>

    <!-- ✅ Alert 모달 (성공/에러/경고 공용) -->
    <div id="alertModal" class="modal-overlay" style="display: none;">
        <div class="modal-content alert-modal" id="alertModalContent">
            <div class="modal-icon" id="alertIcon"></div>
            <div class="modal-header" id="alertTitle"></div>
            <div class="modal-message" id="alertMessage"></div>
            <button class="modal-btn-single" id="alertBtn" onclick="closeAlertModal()">확인</button>
        </div>
    </div>

    <div class="max-w-[1000px] mx-auto grid grid-cols-1 lg:grid-cols-3 gap-8 px-4">
        <div class="lg:col-span-2 space-y-8">
            <section class="bg-white p-8 rounded-[24px] shadow-sm border border-orange-50">
                <div class="flex items-center gap-5 mb-8 pb-8 border-b border-gray-100">
                    <img
						  src="${pageContext.request.contextPath}/images/upload/store/${empty shop.storePicture ? 'default-store.png' : shop.storePicture}"
						  class="w-20 h-20 rounded-2xl object-cover"
						  onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'">

                    <div>
                        <h2 class="text-2xl font-bold">${shop.storeName}</h2>
                        <p class="text-gray-400 text-sm">예약 정보를 확인해주세요</p>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4 mb-8">
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-400 uppercase">방문 날짜</label>
                        <input type="date" id="resDate" class="input-box" 
                               value="${not empty param.date ? param.date : ''}" readonly>
                    </div>
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-400 uppercase">방문 시간</label>
                        <input type="text" id="resTime" class="input-box" 
                               value="${not empty param.time ? param.time : ''}" readonly>
                    </div>
                </div>

                <label class="text-xs font-bold text-gray-400 uppercase mb-3 block">방문 인원</label>
                <div class="grid grid-cols-5 gap-3 mb-8" id="guestBtns"></div>

                <div class="space-y-4 mb-8">
                    <input type="text" id="buyerName" placeholder="성함" class="input-box" 
                           value="${sessionScope.loginUser.name}">
                    <input type="tel" id="buyerTel" placeholder="연락처 (010-1234-5678)" class="input-box">
                    <textarea id="buyerNote" placeholder="요청사항을 입력하세요" class="input-box h-24"></textarea>
                </div>

                <div class="grid grid-cols-3 gap-4 mb-8">
                    <div class="pg-option active" id="pg-kakao" onclick="changePG('kakaopay.TC0ONETIME', 'pg-kakao')">
                        <i class="fa-solid fa-comment text-[#FEE500] text-xl"></i>
                        <span class="text-xs font-bold">카카오페이</span>
                    </div>
                    <div class="pg-option" id="pg-toss" onclick="changePG('tosspay.tosstest', 'pg-toss')">
                        <i class="fa-solid fa-bolt text-[#0050FF] text-xl"></i>
                        <span class="text-xs font-bold">토스페이</span>
                    </div>
                    <div class="pg-option" id="pg-payco" onclick="changePG('payco.PARTNERTEST', 'pg-payco')">
                        <i class="fa-solid fa-p text-[#ff002b] text-xl font-black"></i>
                        <span class="text-xs font-bold">페이코</span>
                    </div>
                </div>
            </section>
        </div>

        <aside>
            <div class="bg-white p-8 rounded-[24px] shadow-lg border border-orange-100 sticky top-10">
                <h3 class="text-lg font-bold mb-6">최종 확인</h3>
                <div class="space-y-4 text-sm mb-8">
                    <div class="flex justify-between">
                        <span>날짜</span>
                        <span id="viewDate" class="font-bold">${param.date}</span>
                    </div>
                    <div class="flex justify-between">
                        <span>시간</span>
                        <span id="viewTime" class="font-bold">${param.time}</span>
                    </div>
                    <div class="flex justify-between">
                        <span>인원</span>
                        <span id="viewCount" class="font-bold"></span>
                    </div>
                </div>
                <div class="border-t border-dashed my-6"></div>
                <div class="flex justify-between items-center mb-8">
                    <span class="font-bold text-gray-500">예약금</span>
                    <span class="text-2xl font-black text-[#ff6b35]">
                        <fmt:formatNumber value="${shop.deposit}" pattern="#,###"/>원
                    </span>
                </div>
                <button type="button" onclick="showConfirmModal()" 
                        class="orange-btn w-full py-5 rounded-2xl font-bold text-xl shadow-lg">
                    결제하기
                </button>
            </div>
        </aside>
    </div>

    <script>
        const shopId = "${shop.storeId}";
        const shopName = "${fn:escapeXml(shop.storeName)}";
        const depositAmount = Number("${shop.deposit}");
        
        const receivedDate = "${param.date}";
        const receivedTime = "${param.time}";
        const receivedGuest = "${param.guestCount}";
        
        let selectedPG = "kakaopay.TC0ONETIME";
        let currentGuest = receivedGuest ? parseInt(receivedGuest) : 2;

        document.addEventListener('DOMContentLoaded', () => {
            initGuestButtons();
            initSummary();
        });

        function initGuestButtons() {
            const container = document.getElementById('guestBtns');
            const guests = ['2명', '3명', '4명', '5명', '단체'];
            
            guests.forEach(guest => {
                const btn = document.createElement('div');
                btn.className = 'count-btn';
                btn.innerText = guest;
                btn.onclick = () => changeCount(btn, guest);
                
                const guestNum = guest.replace('명', '');
                if (guestNum === receivedGuest || (receivedGuest > 5 && guest === '단체')) {
                    btn.classList.add('active');
                }
                
                container.appendChild(btn);
            });
        }

        function initSummary() {
            if (receivedGuest) {
                const guestText = receivedGuest > 5 ? receivedGuest + '명 (단체)' : receivedGuest + '명';
                document.getElementById('viewCount').innerText = guestText;
            } else {
                document.getElementById('viewCount').innerText = '2명';
            }
        }

        function changeCount(el, value) {
            document.querySelectorAll('.count-btn').forEach(btn => btn.classList.remove('active'));
            el.classList.add('active');
            document.getElementById('viewCount').innerText = value;
            currentGuest = value === '단체' ? 10 : parseInt(value.replace('명', ''));
        }

        function changePG(pgCode, id) {
            document.querySelectorAll('.pg-option').forEach(opt => opt.classList.remove('active'));
            document.getElementById(id).classList.add('active');
            selectedPG = pgCode;
        }

        /** ✅ 커스텀 Alert 표시 함수 **/
        function showAlert(type, title, message, callback) {
            const modal = document.getElementById('alertModal');
            const content = document.getElementById('alertModalContent');
            const icon = document.getElementById('alertIcon');
            const titleEl = document.getElementById('alertTitle');
            const messageEl = document.getElementById('alertMessage');
            const btn = document.getElementById('alertBtn');

            // 타입별 스타일 초기화
            content.classList.remove('modal-success', 'modal-error', 'modal-warning');
            
            if (type === 'success') {
                content.classList.add('modal-success');
                icon.innerHTML = '<i class="fa-solid fa-circle-check"></i>';
            } else if (type === 'error') {
                content.classList.add('modal-error');
                icon.innerHTML = '<i class="fa-solid fa-circle-xmark"></i>';
            } else if (type === 'warning') {
                content.classList.add('modal-warning');
                icon.innerHTML = '<i class="fa-solid fa-triangle-exclamation"></i>';
            }

            titleEl.innerText = title;
            messageEl.innerText = message;

            // 콜백 저장
            btn.onclick = () => {
                closeAlertModal();
                if (callback) setTimeout(callback, 300);
            };

            // 모달 표시
            modal.style.display = 'flex';
            setTimeout(() => modal.classList.add('show'), 10);
        }

        /** ✅ Alert 모달 닫기 **/
        function closeAlertModal() {
            const modal = document.getElementById('alertModal');
            modal.classList.remove('show');
            setTimeout(() => modal.style.display = 'none', 300);
        }

        /** ✅ 예약 정보 확인 모달 표시 **/
        function showConfirmModal() {
            const buyerName = document.getElementById('buyerName').value;
            const buyerTel = document.getElementById('buyerTel').value;
            const finalDate = document.getElementById('resDate').value;
            const finalTime = document.getElementById('resTime').value;
            const finalCount = document.getElementById('viewCount').innerText;

            // 필수 입력 확인
            if(!buyerName || !buyerTel) {
                showAlert('warning', '입력 오류', '성함과 연락처를 입력해주세요.');
                return;
            }

            if(!finalDate || !finalTime) {
                showAlert('warning', '선택 오류', '예약 날짜와 시간이 선택되지 않았습니다.');
                return;
            }

            // 전화번호 검증
            const telPattern = /^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$/;
            if(!telPattern.test(buyerTel)) {
                showAlert('warning', '형식 오류', '올바른 전화번호 형식을 입력해주세요.\n(예: 010-1234-5678)');
                return;
            }

            // ✅ 모달에 데이터 표시
            document.getElementById('modalShop').innerText = shopName;
            document.getElementById('modalDate').innerText = finalDate;
            document.getElementById('modalTime').innerText = finalTime;
            document.getElementById('modalGuest').innerText = finalCount;
            document.getElementById('modalAmount').innerText = depositAmount.toLocaleString() + '원';

            // ✅ 모달 표시
            const modal = document.getElementById('confirmModal');
            modal.style.display = 'flex';
            setTimeout(() => modal.classList.add('show'), 10);
        }

        /** ✅ 모달 닫기 **/
        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.classList.remove('show');
            setTimeout(() => modal.style.display = 'none', 300);
        }

        /** ✅ 결제 진행 **/
        function proceedPayment() {
            closeModal('confirmModal');
            
            setTimeout(() => {
                const finalDate = document.getElementById('resDate').value;
                const finalTime = document.getElementById('resTime').value;
                const finalCount = document.getElementById('viewCount').innerText;
                const buyerName = document.getElementById('buyerName').value;
                const buyerTel = document.getElementById('buyerTel').value;

                const { IMP } = window;
                IMP.init("imp12217307");

                IMP.request_pay({
                    pg: selectedPG,
                    pay_method: "card",
                    merchant_uid: "DDM_" + new Date().getTime(),
                    name: shopName + " 예약금",
                    amount: depositAmount,
                    buyer_name: buyerName,
                    buyer_tel: buyerTel
                }, function (rsp) {
                    if (rsp.success) {
                        console.log("✅ 결제 성공:", rsp);
                        
                        showAlert('success', '결제 완료', '예약 결제가 완료되었습니다!', () => {
                            location.href = "${pageContext.request.contextPath}/reserveComplete.do" +
                                            "?shopId=" + encodeURIComponent(shopId) +
                                            "&date=" + encodeURIComponent(finalDate) +
                                            "&time=" + encodeURIComponent(finalTime) +
                                            "&count=" + encodeURIComponent(finalCount) +
                                            "&imp_uid=" + encodeURIComponent(rsp.imp_uid);
                        });
                    } else {
                        console.log("❌ 결제 실패:", rsp);
                        showAlert('error', '결제 실패', rsp.error_msg || '결제 처리 중 오류가 발생했습니다.');
                    }
                });
            }, 500);
        }
    </script>
</body>
</html>