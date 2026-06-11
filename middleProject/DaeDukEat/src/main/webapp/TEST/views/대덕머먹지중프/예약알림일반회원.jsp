<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn">
    <div class="flex justify-between items-center mb-8">
        <h3 class="text-xl font-black text-slate-800 italic">RESERVATION / ALARM</h3>
    </div>

    <div class="space-y-6">
        <%-- (임시 데이터 1: 활성 예약) --%>
        <div class="p-8 bg-slate-900 text-white rounded-[40px] flex justify-between items-center shadow-2xl relative overflow-hidden">
            <div class="absolute -right-10 -bottom-10 text-white/5 text-9xl font-black italic">DDM</div>
            
            <div class="relative z-10">
                <div class="flex items-center gap-2 mb-4">
                    <span class="w-2 h-2 bg-green-400 rounded-full animate-pulse"></span>
                    <p class="text-xs font-black text-orange-500 tracking-widest uppercase">Confirmed</p>
                </div>
                <h4 class="text-3xl font-black mb-2">성수 D.D.M 키친</h4>
                <p class="text-lg font-bold opacity-70">2026.01.25(일) | 18:30 | 2명</p>
                <p class="text-[10px] mt-6 font-mono opacity-40">RESERVATION ID: R20260125-S01</p>
            </div>

            <div class="flex flex-col gap-3 relative z-10">
                <button onclick="shareReservation('성수 D.D.M 키친', '2026.01.25 18:30')" class="bg-orange-500 text-white px-8 py-4 rounded-2xl font-black text-sm hover:scale-105 transition-all shadow-xl shadow-orange-900/20">
                    <i class="fa-solid fa-share-nodes mr-2"></i> 예약 공유
                </button>
                <button class="bg-white/10 text-white/60 px-8 py-4 rounded-2xl font-bold text-xs hover:bg-red-500 hover:text-white transition-all">
                    예약 취소
                </button>
            </div>
        </div>

        <%-- (임시 데이터 2: 지난 알림) --%>
        <div class="p-6 bg-white border border-slate-100 rounded-[30px] flex items-center gap-6 shadow-sm">
            <div class="w-14 h-14 bg-slate-50 rounded-2xl flex items-center justify-center text-slate-400 text-xl">
                <i class="fa-solid fa-bell"></i>
            </div>
            <div>
                <p class="text-sm font-black text-slate-800">예약 확정 안내</p>
                <p class="text-xs text-slate-400 font-medium">강남 D.D.M 펍 예약이 확정되었습니다. (2026.01.20)</p>
            </div>
            <span class="ml-auto text-[10px] font-bold text-slate-300">1일 전</span>
        </div>
    </div>
</div>

<script>
    function shareReservation(shop, dateTime) {
        const shareText = `[D.D.M 예약 공유]\n매장: \${shop}\n일시: \${dateTime}\n함께 즐거운 시간 보내요!`;
        
        // 실제로는 공유용 페이지 주소를 복사
        const dummyUrl = "https://ddm.com/resv/view?id=R20260125-S01";
        
        navigator.clipboard.writeText(dummyUrl).then(() => {
            alert("예약 확인 링크가 복사되었습니다!\n친구에게 공유해보세요.");
        });
    }
</script>