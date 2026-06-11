<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="max-w-2xl mx-auto text-center animate-fadeIn">
    <div class="mb-10">
        <span class="text-6xl">😢</span>
        <h3 class="text-3xl font-black text-slate-800 mt-6 mb-2">정말로 탈퇴하시나요?</h3>
        <p class="text-slate-400 font-medium">D.D.M과 함께한 모든 데이터가 삭제됩니다.</p>
    </div>

    <div class="bg-red-50 rounded-[40px] p-10 text-left border border-red-100 mb-10">
        <h4 class="text-red-500 font-black flex items-center gap-2 mb-6">
            <i class="fa-solid fa-triangle-exclamation"></i> 탈퇴 전 꼭 확인해주세요!
        </h4>
        <ul class="space-y-4 text-slate-600 font-bold text-sm">
            <li class="flex items-center gap-3">
                <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
                보유하신 <b>${couponCount}장</b>의 쿠폰이 즉시 소멸됩니다.
            </li>
            <li class="flex items-center gap-3">
                <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
                잔여 포인트 <b>${userVO.mem_mileage}p</b>가 모두 사라집니다.
            </li>
        </ul>
    </div>

    <form action="deleteMember.do" method="post" class="flex gap-4 max-w-sm mx-auto">
        <input type="hidden" name="mem_id" value="${userVO.mem_id}">
        
        <button type="button" onclick="loadContent('mypage_info.jsp', this)" class="flex-1 py-5 bg-slate-900 text-white rounded-2xl font-black shadow-xl">더 써볼래요</button>
        <button type="submit" onclick="return confirm('정말 탈퇴하시겠습니까?')" class="flex-1 py-5 bg-white text-red-400 border border-red-100 rounded-2xl font-black hover:bg-red-500 hover:text-white transition-all">탈퇴 승인</button>
    </form>
</div>