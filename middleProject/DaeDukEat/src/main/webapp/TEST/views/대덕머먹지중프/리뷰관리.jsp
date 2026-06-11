<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-orange-500 font-black text-xs uppercase tracking-widest mb-2">Customer Feedback</p>
            <h3 class="text-2xl font-black text-slate-800">리뷰 및 답글 관리</h3>
        </div>
    </div>

    <div class="grid gap-6">
        <%-- 임시 데이터 --%>
        <c:if test="${empty reviewList}">
            <div class="p-8 bg-white border border-slate-100 rounded-[30px] shadow-sm hover:border-sky-500/30 transition-all">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-orange-50 rounded-full flex items-center justify-center text-orange-500 font-black text-sm">이</div>
                        <div>
                            <p class="text-sm font-black text-slate-800">이단골 고객님</p>
                            <div class="flex text-orange-400 text-[10px]">★★★★★</div>
                        </div>
                    </div>
                    <span class="text-[10px] font-black text-slate-300">2026.01.20</span>
                </div>
                <p class="text-slate-600 font-bold mb-6">"성수점에서 먹은 스테이크 중에 제일 맛있었어요! 분위기도 최고!"</p>
                
                <div class="bg-slate-50 p-4 rounded-2xl flex gap-3">
                    <input type="text" id="reply_1" placeholder="답글을 남겨주세요..." 
                           class="flex-1 bg-transparent border-none text-sm font-bold outline-none focus:ring-0 px-2">
                    <button onclick="sendReply(1)" class="px-5 py-2 bg-slate-800 text-white rounded-xl text-[10px] font-black">등록</button>
                </div>
            </div>
            
            <div class="p-8 bg-white border border-slate-100 rounded-[30px] shadow-sm">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-slate-100 rounded-full flex items-center justify-center text-slate-400 font-black text-sm">박</div>
                        <div>
                            <p class="text-sm font-black text-slate-800">박나그네 고객님</p>
                            <div class="flex text-orange-400 text-[10px]">★★★★☆</div>
                        </div>
                    </div>
                    <span class="text-[10px] font-black text-slate-300">2026.01.19</span>
                </div>
                <p class="text-slate-600 font-bold mb-6">"예약하고 갔는데 바로 안내받아서 좋았습니다. 소스가 약간 달긴 했지만 괜찮았어요."</p>
                <div class="bg-sky-500/5 p-4 rounded-2xl border border-sky-500/10">
                    <p class="text-[10px] font-black text-sky-500 uppercase mb-1">Owner Reply</p>
                    <p class="text-sm font-bold text-slate-700">방문해주셔서 감사합니다! 소스 부분은 셰프님과 상의해서 개선하겠습니다. 다음에 또 봬요!</p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>
    function sendReply(idx) {
        const replyVal = document.getElementById('reply_' + idx).value;
        if(!replyVal) return alert("답글을 입력하세요.");
        // 한글 깨짐 방지: encodeURIComponent
        location.href = "saveReply.do?idx=" + idx + "&content=" + encodeURIComponent(replyVal);
    }
</script>