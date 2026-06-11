<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .coupon-ticket { display: flex; background: #fff; border-radius: 25px; position: relative; border: 1px solid #ffeada; height: 160px; overflow: hidden; transition: 0.3s; }
    .coupon-left { width: 120px; background: #ff6b00; display: flex; flex-direction: column; justify-content: center; align-items: center; color: #fff; border-right: 2px dashed #ffd8be; }
    .coupon-right { flex: 1; padding: 25px; display: flex; flex-direction: column; justify-content: center; position: relative; }
    
    /* 쿠폰 절취선 홈 */
    .coupon-ticket::before, .coupon-ticket::after { content: ''; position: absolute; left: 110px; width: 20px; height: 20px; background: #f8fafc; border-radius: 50%; z-index: 5; border: 1px solid #ffeada; }
    .coupon-ticket::before { top: -11px; }
    .coupon-ticket::after { bottom: -11px; }

    /* 삭제 버튼 스타일 */
    .btn-coupon-del { position: absolute; top: 12px; right: 12px; color: #cbd5e1; transition: 0.2s; z-index: 10; }
    .btn-coupon-del:hover { color: #ef4444; transform: scale(1.2); }
</style>

<div class="animate-fadeIn">
    <div class="flex justify-between items-center mb-8">
        <div class="flex items-center gap-3">
            <h3 class="text-xl font-black text-slate-800 italic">MY COUPONS</h3>
            <span class="px-3 py-1 bg-orange-100 text-orange-600 text-[10px] font-black rounded-full">TOTAL 2</span>
        </div>
        <p class="text-xs font-bold text-slate-400">쿠폰은 유효기간 내에만 사용 가능합니다.</p>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <%-- (임시 데이터 1: 사용 가능 쿠폰) --%>
        <div id="coupon-card-1" class="coupon-ticket shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all">
            <button onclick="deleteCoupon('1')" class="btn-coupon-del" title="쿠폰 삭제">
                <i class="fa-solid fa-circle-xmark text-xl"></i>
            </button>

            <div class="coupon-left">
                <span class="text-[10px] font-black opacity-70 uppercase mb-1">Discount</span>
                <span class="text-3xl font-black">15%</span>
            </div>
            <div class="coupon-right">
                <h4 class="text-lg font-black text-slate-800">웰컴 가산점 쿠폰</h4>
                <p class="text-[11px] text-slate-400 font-bold mb-4">전 매장 사용 가능 / ~2026.12.31</p>
                
                <div class="flex gap-2">
                    <input type="text" id="code-1" class="flex-1 bg-slate-50 border-none rounded-xl px-3 py-2 text-[10px] font-bold outline-none focus:ring-2 focus:ring-orange-500/20" placeholder="확인 코드">
                    <button onclick="useCoupon('1', '1234')" class="bg-slate-900 text-white px-4 py-2 rounded-xl text-[10px] font-black hover:bg-orange-600 transition-all">사용</button>
                </div>
            </div>
        </div>

        <%-- (임시 데이터 2: 다른 혜택 쿠폰) --%>
        <div id="coupon-card-2" class="coupon-ticket shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all">
            <button onclick="deleteCoupon('2')" class="btn-coupon-del" title="쿠폰 삭제">
                <i class="fa-solid fa-circle-xmark text-xl"></i>
            </button>

            <div class="coupon-left bg-slate-800">
                <span class="text-[10px] font-black opacity-70 uppercase mb-1">Gift</span>
                <span class="text-2xl font-black text-orange-500"><i class="fa-solid fa-wine-glass"></i></span>
            </div>
            <div class="coupon-right">
                <h4 class="text-lg font-black text-slate-800">생일 축하 와인 쿠폰</h4>
                <p class="text-[11px] text-slate-400 font-bold mb-4">디너 타임 방문 시 제공</p>
                
                <div class="flex gap-2">
                    <input type="text" id="code-2" class="flex-1 bg-slate-50 border-none rounded-xl px-3 py-2 text-[10px] font-bold outline-none focus:ring-2 focus:ring-orange-500/20" placeholder="확인 코드">
                    <button onclick="useCoupon('2', '0000')" class="bg-slate-900 text-white px-4 py-2 rounded-xl text-[10px] font-black hover:bg-orange-600 transition-all">사용</button>
                </div>
            </div>
        </div>
    </div>

    <%-- 데이터 없을 때 표시 (hidden 처리해둠) --%>
    <div id="empty-coupon" class="hidden py-20 text-center">
        <i class="fa-solid fa-ticket-simple text-5xl text-slate-100 mb-4"></i>
        <p class="text-slate-400 font-bold">보유하신 쿠폰이 없습니다.</p>
    </div>
</div>

<script>
    /**
     * 쿠폰 사용 함수
     */
    function useCoupon(id, correctCode) {
        const inputCode = document.getElementById('code-' + id).value;
        if(inputCode === correctCode) {
            if(confirm("점원 확인이 완료되었습니까? 사용 후에는 취소할 수 없습니다.")) {
                alert("인증 성공! 쿠폰 사용이 완료되었습니다.");
                const card = document.getElementById('coupon-card-' + id);
                card.classList.add('opacity-40', 'grayscale');
                card.innerHTML = '<div class="flex-1 flex items-center justify-center font-black text-slate-400 italic">USED COUPON</div>';
            }
        } else {
            alert("잘못된 확인 코드입니다. 점원에게 다시 확인해주세요.");
        }
    }

    /**
     * 쿠폰 삭제 함수 (X 버튼)
     */
    function deleteCoupon(id) {
        if(confirm("정말로 이 쿠폰을 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.")) {
            const card = document.getElementById('coupon-card-' + id);
            card.style.transform = 'scale(0.8)';
            card.style.opacity = '0';
            
            setTimeout(() => {
                card.remove();
                // 모든 쿠폰이 삭제되었는지 체크
                const remaining = document.querySelectorAll('.coupon-ticket').length;
                if(remaining === 0) {
                    document.getElementById('empty-coupon').classList.remove('hidden');
                }
                alert("쿠폰이 삭제되었습니다.");
            }, 300);
        }
    }
</script>