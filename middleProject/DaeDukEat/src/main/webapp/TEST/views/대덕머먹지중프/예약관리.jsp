<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Live Reservations</p>
            <h3 class="text-2xl font-black text-slate-800">예약 현황 관리</h3>
        </div>
        <div class="flex gap-2">
            <span class="bg-slate-100 px-4 py-2 rounded-xl text-xs font-black text-slate-500">대기 3건</span>
        </div>
    </div>

    <div class="space-y-4">
        <%-- 임시 데이터 반복 (DB 연결 시 c:forEach로 교체) --%>
        <c:if test="${empty reserveList}">
            <c:set var="tempList" value="1,2,3" />
            <c:forEach var="item" items="${tempList}">
                <div class="flex items-center justify-between p-6 bg-slate-50 border border-slate-100 rounded-[25px] hover:bg-white hover:shadow-xl hover:shadow-slate-200/50 transition-all group">
                    <div class="flex items-center gap-6">
                        <div class="w-14 h-14 bg-white rounded-2xl flex items-center justify-center font-black text-slate-400 text-xl border border-slate-100 shadow-sm">
                            <i class="fa-solid fa-user text-slate-200"></i>
                        </div>
                        <div>
                            <div class="flex items-center gap-3 mb-1">
                                <span class="text-lg font-black text-slate-800">김손님${item}</span>
                                <span class="text-xs font-bold text-slate-400">010-1234-567${item}</span>
                            </div>
                            <p class="text-sm font-bold text-slate-500">
                                <span class="text-sky-500 font-black">2026-01-21</span> 
                                <span class="mx-2">|</span> 19:30 <span class="mx-2">|</span> 4명 <span class="mx-2 text-slate-200">|</span> 20,000원 결제완료
                            </p>
                        </div>
                    </div>
                    <div class="flex gap-2">
                        <button onclick="updateRes(${item}, 'APPROVE')" class="px-6 py-3 bg-slate-800 text-white rounded-2xl font-black text-xs hover:bg-sky-500 transition-all">승인</button>
                        <button onclick="updateRes(${item}, 'REJECT')" class="px-6 py-3 bg-white text-slate-400 border border-slate-200 rounded-2xl font-black text-xs hover:text-red-500 hover:border-red-200 transition-all">거절</button>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>

<script>
    function updateRes(idx, status) {
        const msg = status === 'APPROVE' ? "예약을 승인하시겠습니까?" : "예약을 거절하시겠습니까?";
        if(confirm(msg)) {
            // 한글 파라미터가 없으므로 그대로 전송
            location.href = "updateRes.do?idx=" + idx + "&status=" + status;
        }
    }
</script>