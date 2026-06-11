<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 결제 - D.D.M</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
    </style>
</head>
<body class="py-12">

    <div class="max-w-[1000px] mx-auto grid grid-cols-1 lg:grid-cols-3 gap-8 px-4">
        <div class="lg:col-span-2 space-y-8">
            <section class="bg-white p-8 rounded-[24px] shadow-sm border border-orange-50">
                <div class="flex items-center gap-5 mb-8 pb-8 border-b border-gray-100">
                    <img src="${shop.img1}" class="w-20 h-20 rounded-2xl object-cover" onerror="this.src='https://via.placeholder.com/80/ff6b35/ffffff?text=FOOD'">
                    <div>
                        <h2 class="text-2xl font-bold">${shop.name}</h2>
                        <p class="text-gray-400 text-sm">예약 정보를 확인해주세요</p>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4 mb-8">
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-400 uppercase">방문 날짜</label>
                        <input type="date" id="resDate" class="input-box" value="${param.date}">
                    </div>
                    <div class="space-y-2">
                        <label class="text-xs font-bold text-gray-400 uppercase">방문 시간</label>
                        <select id="resTime" class="input-box">
                            <option value="11:30" ${param.time == '11:30' ? 'selected' : ''}>11:30</option>
                            <option value="13:00" ${param.time == '13:00' ? 'selected' : ''}>13:00</option>
                            <option value="17:30" ${param.time == '17:30' ? 'selected' : ''}>17:30</option>
                            <option value="19:00" ${param.time == '19:00' ? 'selected' : ''}>19:00</option>
                        </select>
                    </div>
                </div>

                <label class="text-xs font-bold text-gray-400 uppercase mb-3 block">방문 인원</label>
                <div class="grid grid-cols-5 gap-3 mb-8">
                    <div class="count-btn active" onclick="changeCount(this, '2명')">2명</div>
                    <div class="count-btn" onclick="changeCount(this, '3명')">3명</div>
                    <div class="count-btn" onclick="changeCount(this, '4명')">4명</div>
                    <div class="count-btn" onclick="changeCount(this, '5명')">5명</div>
                    <div class="count-btn" onclick="changeCount(this, '단체')">단체</div>
                </div>

                <div class="space-y-4 mb-8">
                    <input type="text" id="buyerName" placeholder="성함" class="input-box" value="${sessionScope.user.name}">
                    <input type="tel" id="buyerTel" placeholder="연락처" class="input-box" value="${sessionScope.user.tel}">
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
                    <div class="pg-option" id="pg-payco" onclick="changePG('payco.AUTOPAY', 'pg-payco')">
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
                    <div class="flex justify-between"><span>날짜</span><span id="viewDate" class="font-bold">${param.date}</span></div>
                    <div class="flex justify-between"><span>시간</span><span id="viewTime" class="font-bold">${param.time}</span></div>
                    <div class="flex justify-between"><span>인원</span><span id="viewCount" class="font-bold">2명</span></div>
                </div>
                <div class="border-t border-dashed my-6"></div>
                <div class="flex justify-between items-center mb-8">
                    <span class="font-bold text-gray-500">예약금</span>
                    <span class="text-2xl font-black text-[#ff6b35]">
                        <fmt:formatNumber value="${shop.deposit}" pattern="#,###"/>원
                    </span>
                </div>
                <button type="button" onclick="requestPay()" class="orange-btn w-full py-5 rounded-2xl font-bold text-xl shadow-lg">
                    결제하기
                </button>
            </div>
        </aside>
    </div>

    <script>
        // 전역 변수 설정 (DB 데이터)
        const shopId = "${shop.id}";
        const shopName = "${shop.name}";
        const depositAmount = Number("${shop.deposit}"); // 숫자로 강제 변환
        let selectedPG = "kakaopay.TC0ONETIME";

        /** [동작 보장 1] 인원 선택 버튼 **/
        function changeCount(el, value) {
            document.querySelectorAll('.count-btn').forEach(btn => btn.classList.remove('active'));
            el.classList.add('active');
            document.getElementById('viewCount').innerText = value;
        }

        /** [동작 보장 2] PG사 선택 버튼 **/
        function changePG(pgCode, id) {
            document.querySelectorAll('.pg-option').forEach(opt => opt.classList.remove('active'));
            document.getElementById(id).classList.add('active');
            selectedPG = pgCode;
        }

        /** [동작 보장 3] 날짜/시간 실시간 업데이트 **/
        document.getElementById('resDate').addEventListener('change', (e) => {
            document.getElementById('viewDate').innerText = e.target.value;
        });
        document.getElementById('resTime').addEventListener('change', (e) => {
            document.getElementById('viewTime').innerText = e.target.value;
        });

        /** [핵심] 아임포트 결제 프로세스 **/
        function requestPay() {
            console.log("결제 요청 시작"); // 디버깅용
            
            const buyerName = document.getElementById('buyerName').value;
            const buyerTel = document.getElementById('buyerTel').value;

            if(!buyerName || !buyerTel) {
                alert("성함과 연락처를 입력해주세요.");
                return;
            }

            // 아임포트 초기화
            const { IMP } = window;
            IMP.init("imp12217307"); 

            // 결제 요청
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
                    alert("예약 결제가 완료되었습니다!");
                    // 성공 시 서버로 데이터 전송 (컨트롤러 이동)
                    location.href = `reserveComplete.do?shopId=` + shopId +
                                    `&date=` + document.getElementById('resDate').value +
                                    `&time=` + document.getElementById('resTime').value +
                                    `&count=` + document.getElementById('viewCount').innerText +
                                    `&imp_uid=` + rsp.imp_uid;
                } else {
                    alert("결제 실패: " + rsp.error_msg);
                }
            });
        }
    </script>
</body>
</html>