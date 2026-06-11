<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-purple-500 font-black text-xs uppercase tracking-widest mb-2">Promotion & Marketing</p>
            <h3 class="text-2xl font-black text-slate-800">쿠폰 마케팅 설정</h3>
        </div>
        <button onclick="location.href='addCoupon.do'" class="px-6 py-3 bg-slate-900 text-white rounded-2xl font-black text-xs hover:bg-purple-600 transition-all shadow-lg active:scale-95">
            <i class="fa-solid fa-plus mr-2"></i>새 쿠폰 제작
        </button>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <%-- 임시 데이터 (DB 연결 시 c:forEach로 순회) --%>
        <c:if test="${empty couponList}">
            <div id="coupon-1" class="group relative bg-white border border-slate-100 rounded-[30px] p-8 hover:border-purple-500 transition-all shadow-sm hover:shadow-xl hover:shadow-purple-500/5">
                <div class="flex justify-between items-start mb-6">
                    <div class="w-14 h-14 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                        <i class="fa-solid fa-ticket-simple"></i>
                    </div>
                    <button onclick="delCoupon(1, '오픈기념 5천원 할인')" class="w-10 h-10 bg-slate-50 text-slate-300 rounded-full flex items-center justify-center hover:bg-red-50 hover:text-red-500 transition-all group-hover:opacity-100">
                        <i class="fa-solid fa-trash-can text-sm"></i>
                    </button>
                </div>
                
                <h4 class="text-xl font-black text-slate-800 mb-1">오픈기념 5천원 할인</h4>
                <p class="text-xs font-bold text-slate-400 mb-8">30,000원 이상 주문 시 사용 가능</p>
                
                <div class="flex justify-between items-end border-t border-slate-50 pt-6">
                    <span class="text-4xl font-black text-purple-600 italic tracking-tighter">5,000<span class="text-sm not-italic ml-1">원</span></span>
                    <span class="px-3 py-1 bg-green-50 text-green-500 text-[10px] font-black rounded-lg uppercase">Active</span>
                </div>
            </div>

            <div id="coupon-2" class="group relative bg-white border border-slate-100 rounded-[30px] p-8 hover:border-purple-500 transition-all shadow-sm hover:shadow-xl hover:shadow-purple-500/5">
                <div class="flex justify-between items-start mb-6">
                    <div class="w-14 h-14 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                        <i class="fa-solid fa-percent"></i>
                    </div>
                    <button onclick="delCoupon(2, '재방문 10% 감사쿠폰')" class="w-10 h-10 bg-slate-50 text-slate-300 rounded-full flex items-center justify-center hover:bg-red-50 hover:text-red-500 transition-all group-hover:opacity-100">
                        <i class="fa-solid fa-trash-can text-sm"></i>
                    </button>
                </div>
                
                <h4 class="text-xl font-black text-slate-800 mb-1">재방문 10% 감사쿠폰</h4>
                <p class="text-xs font-bold text-slate-400 mb-8">최대 10,000원 할인 적용</p>
                
                <div class="flex justify-between items-end border-t border-slate-50 pt-6">
                    <span class="text-4xl font-black text-purple-600 italic tracking-tighter">10<span class="text-sm not-italic ml-1">%</span></span>
                    <span class="px-3 py-1 bg-green-50 text-green-500 text-[10px] font-black rounded-lg uppercase">Active</span>
                </div>
            </div>
        </c:if>
    </div>
    
    <c:if test="${not empty couponList && couponList.size() == 0}">
        <div class="flex flex-col items-center justify-center py-24 text-slate-300">
            <i class="fa-solid fa-ticket text-6xl mb-4 opacity-20"></i>
            <p class="font-bold">발행된 쿠폰이 없습니다.</p>
        </div>
    </c:if>
</div>

<script>
    /**
     * 쿠폰 삭제 함수
     * @param idx : 쿠폰 고유 번호
     * @param name : 쿠폰 이름 (알림창 표시용)
     */
    function delCoupon(idx, name) {
        // 한글 포함 메시지 처리
        const confirmMsg = "[" + name + "]\n해당 쿠폰을 정말 삭제하시겠습니까?\n삭제 후에는 복구가 불가능합니다.";
        
        if(confirm(confirmMsg)) {
            // 한글 파라미터가 없으므로 일반 location.href 사용
            // 만약 이름까지 서버로 보내야 한다면 encodeURIComponent(name) 사용 필수
            location.href = "deleteCoupon.do?idx=" + idx;
            
            // 만약 Ajax로 지우고 싶다면 아래 스타일 권장
            /*
            fetch('deleteCoupon.do?idx=' + idx)
                .then(res => res.json())
                .then(data => {
                    if(data.result === 'success') {
                        alert('삭제되었습니다.');
                        loadOwnerPage('coupon', '쿠폰관리.jsp'); // 화면 새로고침
                    }
                });
            */
        }
    }
</script>