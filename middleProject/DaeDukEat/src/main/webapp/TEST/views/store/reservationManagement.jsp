<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="min-h-screen bg-[#f8fafc] p-8 animate-fadeIn">
    <div class="max-w-[1600px] mx-auto space-y-10">
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white p-8 rounded-[35px] shadow-[0_8px_30px_rgb(0,0,0,0.02)] border border-slate-100 flex items-center gap-6 group hover:border-sky-200 transition-colors">
                <div class="w-16 h-16 bg-sky-50 text-sky-500 rounded-[22px] flex items-center justify-center text-3xl group-hover:bg-sky-500 group-hover:text-white transition-all duration-300">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div>
                    <p class="text-sm font-bold text-slate-400 uppercase tracking-widest mb-1">총 예약 수</p>
                    <h4 class="text-3xl font-black text-slate-800">${reserveList.size()}건</h4>
                </div>
            </div>
            
            <div class="bg-white p-8 rounded-[35px] shadow-[0_8px_30px_rgb(0,0,0,0.02)] border border-slate-100 flex items-center gap-6 group hover:border-amber-200 transition-colors">
                <div class="w-16 h-16 bg-amber-50 text-amber-500 rounded-[22px] flex items-center justify-center text-3xl group-hover:bg-amber-500 group-hover:text-white transition-all duration-300">
                    <i class="fa-solid fa-bell-concierge"></i>
                </div>
                <div>
                    <p class="text-sm font-bold text-slate-400 uppercase tracking-widest mb-1">대기 중</p>
                    <h4 id="summaryWaiting" class="text-3xl font-black text-slate-800 text-amber-500">${waitingCount}건</h4>
                </div>
            </div>
            
            <div class="bg-white p-8 rounded-[35px] shadow-[0_8px_30px_rgb(0,0,0,0.02)] border border-slate-100 flex items-center gap-6 group hover:border-emerald-200 transition-colors">
                <div class="w-16 h-16 bg-emerald-50 text-emerald-500 rounded-[22px] flex items-center justify-center text-3xl group-hover:bg-emerald-500 group-hover:text-white transition-all duration-300">
                    <i class="fa-solid fa-wallet"></i>
                </div>
                <div>
                    <p class="text-sm font-bold text-slate-400 uppercase tracking-widest mb-1">총 결제 금액</p>
                    <h4 class="text-3xl font-black text-slate-800">
                        <c:set var="totalAmount" value="0"/>
                        <c:forEach var="r" items="${reserveList}">
                            <c:set var="totalAmount" value="${totalAmount + r.amount}"/>
                        </c:forEach>
                        <fmt:formatNumber value="${totalAmount}" type="number"/>원
                    </h4>
                </div>
            </div>
        </div>

        <div class="flex flex-col md:flex-row justify-between items-end gap-4 border-b border-slate-200/60 pb-8">
            <div>
                <div class="flex items-center gap-3 mb-2">
                    <span class="px-3 py-1 bg-slate-900 text-white text-[10px] font-black rounded-lg uppercase tracking-tighter">실시간 트래커</span>
                    <h3 class="text-4xl font-black text-slate-900 tracking-tight">예약 관리 시스템</h3>
                </div>
                <p class="text-slate-400 font-bold">접수된 예약을 확인하고 승인 또는 거절을 처리하세요.</p>
            </div>
            <div class="flex items-center gap-2 bg-white p-1.5 rounded-2xl border border-slate-100 shadow-sm">
                <button class="px-6 py-2.5 bg-slate-50 rounded-xl text-sm font-black text-slate-800 transition-all">최신 접수순</button>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 2xl:grid-cols-3 gap-8">
            <c:choose>
                <c:when test="${not empty reserveList}">
                    <c:forEach var="reserve" items="${reserveList}">
                    
                        <div id="reserve-${reserve.reservId}" 
                             class="bg-white rounded-[45px] p-9 border border-white shadow-[0_20px_50px_-20px_rgba(0,0,0,0.05)] hover:shadow-[0_40px_80px_-20px_rgba(0,0,0,0.15)] transition-all duration-500 group relative overflow-hidden flex flex-col justify-between min-h-[550px]">
                            
                            <div class="absolute -top-12 -right-12 w-40 h-40 ${reserve.reservStatus eq '대기' ? 'bg-amber-50' : 'bg-slate-50'} rounded-full opacity-30 group-hover:scale-125 transition-transform duration-700"></div>

                            <div class="relative flex-1">
                                <div class="flex justify-between items-start mb-10">
                                    <div class="flex items-center gap-5">
                                        <div class="w-16 h-16 bg-slate-50 rounded-3xl flex items-center justify-center text-3xl text-slate-300 group-hover:bg-slate-900 group-hover:text-white transition-all duration-500">
                                            <i class="fa-solid fa-circle-user"></i>
                                        </div>
                                        <div>
                                            <h5 class="text-2xl font-black text-slate-800">${reserve.userName} <span class="text-slate-300 text-sm ml-1">고객님</span></h5>
                                            <p class="text-xs font-black text-sky-500 tracking-widest uppercase mt-1">아이디: ${reserve.userId}</p>
                                        </div>
                                    </div>
                                    <span class="px-5 py-2 rounded-2xl text-[11px] font-black uppercase tracking-widest ${reserve.reservStatus eq '대기' ? 'bg-amber-400 text-white shadow-lg shadow-amber-100' : 'bg-slate-100 text-slate-400'}">
                                        ${reserve.reservStatus}
                                    </span>
                                </div>

                                <div class="grid grid-cols-2 gap-4 mb-10">
                                    <div class="bg-slate-50/80 p-5 rounded-[25px] border border-slate-50">
                                        <p class="text-[10px] font-black text-slate-400 uppercase mb-1 italic">예약 일시</p>
                                        <p class="text-sm font-black text-slate-700">${reserve.reservTime}</p>
                                    </div>
                                    <div class="bg-slate-50/80 p-5 rounded-[25px] border border-slate-50">
                                        <p class="text-[10px] font-black text-slate-400 uppercase mb-1 italic">예약 인원</p>
                                        <p class="text-sm font-black text-slate-700">${reserve.guestCount} 명</p>
                                    </div>
                                    <div class="col-span-2 bg-sky-50/30 p-5 rounded-[25px] border border-sky-50/50 flex justify-between items-center">
                                        <p class="text-[10px] font-black text-sky-400 uppercase italic">결제 예정 금액</p>
                                        <p class="text-lg font-black text-sky-600"><fmt:formatNumber value="${reserve.amount}" type="number"/>원</p>
                                    </div>
                                    
                                    <div class="col-span-2 min-h-[80px]">
                                        <c:if test="${not empty reserve.note}">
                                            <div class="bg-white p-5 rounded-[25px] border border-dashed border-slate-200 h-full">
                                                <p class="text-[10px] font-black text-slate-300 uppercase mb-2">요청 사항</p>
                                                <p class="text-xs font-bold text-slate-500 leading-relaxed italic">"${reserve.note}"</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div id="buttons-${reserve.reservId}" class="relative h-[64px] flex gap-4">
                                <c:choose>
                                    <c:when test="${reserve.reservStatus eq '대기'}">
                                        <button onclick="openConfirmModal(${reserve.reservId}, 'APPROVE')" 
                                                class="flex-1 h-full bg-slate-900 text-white rounded-[22px] font-black text-xs hover:bg-sky-500 transition-all shadow-xl shadow-slate-200 active:scale-95">
                                            예약 승인
                                        </button>
                                        <button onclick="openConfirmModal(${reserve.reservId}, 'REJECT')" 
                                                class="flex-1 h-full bg-white text-slate-400 border border-slate-200 rounded-[22px] font-black text-xs hover:text-red-500 hover:border-red-100 transition-all active:scale-95">
                                            거절
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-full flex items-center justify-center rounded-[22px] font-black text-xs ${reserve.reservStatus eq '승인' ? 'bg-sky-50 text-sky-500 border-sky-100' : 'bg-red-50 text-red-400 border-red-100'} border italic uppercase tracking-widest">
                                            처리 완료: ${reserve.reservStatus}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-span-full py-60 text-center bg-white rounded-[60px] border-2 border-dashed border-slate-100">
                        <div class="w-24 h-24 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fa-solid fa-calendar-xmark text-4xl text-slate-200"></i>
                        </div>
                        <p class="text-slate-400 font-black text-xl tracking-tight">현재 접수된 예약 내역이 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<div id="customModal" class="fixed inset-0 z-[100] hidden flex items-center justify-center p-4">
    <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-md"></div>
    <div class="relative bg-white w-full max-w-sm rounded-[50px] p-12 shadow-2xl animate-modalIn text-center">
        <div id="modalIcon" class="w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl"></div>
        <h4 id="modalTitle" class="text-3xl font-black text-slate-800 mb-3">알림</h4>
        <p id="modalMsg" class="text-slate-500 font-bold mb-10 leading-relaxed text-sm"></p>
        <div class="flex flex-col gap-3">
            <button id="modalConfirmBtn" class="w-full py-5 text-white rounded-[22px] font-black text-sm active:scale-95 transition-all shadow-lg"></button>
            <button onclick="closeModal()" class="w-full py-5 bg-slate-50 text-slate-400 rounded-[22px] font-black text-sm active:scale-95 transition-all">취소</button>
        </div>
    </div>
</div>

<script>
let currentTargetId = null;
let currentStatus = null;

function openConfirmModal(id, status) {
    currentTargetId = id;
    currentStatus = status;
    const modal = document.getElementById('customModal');
    const title = document.getElementById('modalTitle');
    const msg = document.getElementById('modalMsg');
    const icon = document.getElementById('modalIcon');
    const confirmBtn = document.getElementById('modalConfirmBtn');

    if(status === 'APPROVE') {
        title.innerText = "예약 승인";
        msg.innerHTML = "해당 예약을 승인하시겠습니까?<br>승인 시 고객님께 알림이 전송됩니다.";
        icon.className = "w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl";
        icon.innerHTML = '<i class="fa-solid fa-check"></i>';
        confirmBtn.innerText = "네, 승인하겠습니다";
        confirmBtn.className = "w-full py-5 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100";
    } else {
        title.innerText = "예약 거절";
        msg.innerHTML = "해당 예약을 거절하시겠습니까?<br>거절된 예약은 다시 승인할 수 없습니다.";
        icon.className = "w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl";
        icon.innerHTML = '<i class="fa-solid fa-xmark"></i>';
        confirmBtn.innerText = "네, 거절합니다";
        confirmBtn.className = "w-full py-5 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100";
    }

    confirmBtn.onclick = executeUpdate;
    modal.classList.remove('hidden');
}

function closeModal() {
    document.getElementById('customModal').classList.add('hidden');
}

function executeUpdate() {
    closeModal();
    const url = '${pageContext.request.contextPath}/reservation/updateStatus.do?idx=' + currentTargetId + '&status=' + currentStatus;
    
    fetch(url, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
    .then(res => {
        if(res.ok) {
            updateUINow(currentTargetId, currentStatus);
            showFancyToast(currentStatus === 'APPROVE' ? '예약이 성공적으로 승인되었습니다.' : '거절 처리가 완료되었습니다.', 'success');
        }
    });
}

function updateUINow(id, status) {
    const area = document.getElementById('buttons-' + id);
    const isApprove = (status === 'APPROVE');
    const color = isApprove ? 'bg-sky-50 text-sky-500 border-sky-100' : 'bg-red-50 text-red-400 border-red-100';
    const text = isApprove ? '승인 완료' : '거절 완료';

    area.innerHTML = `
        <div class="w-full h-full flex items-center justify-center rounded-[22px] font-black text-xs \${color} border animate-fadeIn uppercase tracking-tighter italic">
            처리 완료: \${text}
        </div>
    `;
    
    const summaryWaiting = document.getElementById('summaryWaiting');
    let count = parseInt(summaryWaiting.innerText);
    if(count > 0) summaryWaiting.innerText = (count - 1) + '건';
}

function showFancyToast(msg, type) {
    const toast = document.createElement('div');
    toast.className = 'fixed bottom-12 left-1/2 -translate-x-1/2 px-12 py-6 bg-slate-900 text-white rounded-[35px] font-black text-sm z-[200] shadow-2xl animate-modalIn flex items-center gap-4';
    toast.innerHTML = '<i class="fa-solid fa-circle-check text-sky-400"></i>' + msg;
    document.body.appendChild(toast);
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translate(-50%, 30px)';
        toast.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
        setTimeout(() => toast.remove(), 600);
    }, 3000);
}
</script>

<style>
@keyframes modalIn {
    from { opacity: 0; transform: scale(0.9) translateY(40px); }
    to { opacity: 1; transform: scale(1) translateY(0); }
}
.animate-modalIn { animation: modalIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1); }
.animate-fadeIn { animation: fadeIn 0.8s ease-out; }
@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }

/* 스크롤바 커스텀 */
::-webkit-scrollbar { width: 10px; }
::-webkit-scrollbar-track { background: #f8fafc; }
::-webkit-scrollbar-thumb { background: #e2e8f0; border-radius: 20px; border: 3px solid #f8fafc; }
::-webkit-scrollbar-thumb:hover { background: #cbd5e1; }
</style>