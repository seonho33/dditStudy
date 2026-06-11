<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="animate-fadeIn space-y-8 p-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Customer Feedback</p>
            <h3 class="text-2xl font-black text-slate-800">리뷰 및 답글 관리</h3>
        </div>
        <div class="text-sm font-bold text-slate-400">
            총 <span class="text-sky-500">${fn:length(reviewList)}</span>건의 리뷰
        </div>
    </div>

    <div class="grid gap-6">
        <c:choose>
            <c:when test="${empty reviewList}">
                <div class="p-12 bg-slate-50 rounded-[30px] text-center border-2 border-dashed border-slate-200">
                    <p class="text-slate-400 font-bold text-lg">아직 등록된 리뷰가 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="review" items="${reviewList}">
                    <div class="p-8 bg-white border border-slate-100 rounded-[30px] shadow-sm hover:border-sky-500/30 transition-all">
                        <div class="flex justify-between items-start mb-4">
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 bg-sky-50 rounded-full flex items-center justify-center text-sky-500 font-black text-sm">
                                    ${fn:substring(review.userName, 0, 1)}
                                </div>
                                <div>
                                    <p class="text-sm font-black text-slate-800">${review.userName} 고객님</p>
                                    <div class="flex text-sky-400 text-[10px]">
                                        <c:forEach begin="1" end="${review.rating}">★</c:forEach>
                                        <c:forEach begin="1" end="${5 - review.rating}">☆</c:forEach>
                                    </div>
                                </div>
                            </div>
                            <span class="text-[10px] font-black text-slate-300">${review.userReviewDate}</span>
                        </div>

                        <p class="text-slate-600 font-bold mb-6">"${review.userReview}"</p>

                        <c:if test="${not empty review.reviewPicture}">
                            <div class="mb-6">
                                <img src="${pageContext.request.contextPath}${review.reviewPicture}" class="max-w-xs rounded-2xl shadow-md">
                            </div>
                        </c:if>

                        <div class="mt-4">
                            <c:choose>
                                <c:when test="${review.hasReply}">
                                    <div class="bg-sky-500/5 p-5 rounded-2xl border border-sky-500/10">
                                        <p class="text-[10px] font-black text-sky-500 uppercase mb-2 tracking-tighter">Owner Reply</p>
                                        <p id="content_${review.reservId}" class="text-sm font-bold text-slate-700 mb-3">${review.ceoReview}</p>
                                        
                                        <button onclick="toggleEditReply('${review.reservId}')" 
                                                class="text-[10px] text-slate-400 font-black hover:text-sky-500 transition-colors uppercase">
                                            <i class="fa-solid fa-pen-to-square mr-1"></i> 답글 수정
                                        </button>
                                        
                                        <div id="editForm_${review.reservId}" class="hidden mt-4 flex gap-3">
                                            <input type="text" id="editReply_${review.reservId}" value="${review.ceoReview}"
                                                   class="flex-1 bg-white border border-slate-200 rounded-xl px-4 py-2 text-sm font-bold focus:border-sky-500 outline-none">
                                            <button onclick="sendReply('${review.reservId}')" class="px-5 py-2 bg-slate-800 text-white rounded-xl text-[10px] font-black">수정</button>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-slate-50 p-4 rounded-2xl flex gap-3 border border-transparent focus-within:border-sky-500/30 transition-all">
                                        <input type="text" id="reply_${review.reservId}" placeholder="고객님께 답글을 남겨주세요..."
                                               class="flex-1 bg-transparent border-none text-sm font-bold outline-none px-2">
                                        <button onclick="sendReply('${review.reservId}')" class="px-5 py-2 bg-slate-800 text-white rounded-xl text-[10px] font-black hover:bg-sky-500 transition-all">등록</button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>

/////사장님 답글 수정되나 확인필요
function sendReply(reservId) {

    /* ===============================
       📌 1️⃣ 수정 / 신규 입력 판단
       =============================== */
    const isEdit = !!document.getElementById('editReply_' + reservId);
    const inputId = isEdit ? 'editReply_' + reservId : 'reply_' + reservId;
    const content = document.getElementById(inputId).value.trim();

    /* ===============================
       📌 2️⃣ 내용 미입력 시 경고 모달
       =============================== */
    if (!content) {
        Swal.fire({
            html: `
                <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-exclamation"></i>
                </div>
                <h2 class="text-2xl font-black text-slate-800 mb-2">
                    내용 입력
                </h2>
                <p class="text-slate-500 font-bold text-sm">
                    답글 내용을 입력해주세요.
                </p>
            `,
            background: '#ffffff',
            customClass: {
                popup: 'rounded-[40px] p-10 text-center shadow-2xl',
                confirmButton:
                    'w-full py-4 px-14 bg-sky-500 text-white rounded-[20px] font-black text-sm shadow-xl shadow-sky-100'
            },
            confirmButtonText: '확인',
            buttonsStyling: false
        });
        return;
    }

    /* ===============================
       📌 3️⃣ 서버 전송 파라미터 구성
       (기존 기능 그대로)
       =============================== */
    const params = new URLSearchParams();
    params.append('reservId', reservId);
    params.append('content', content);

    /* ===============================
       📌 4️⃣ 답글 저장 요청
       =============================== */
    fetch('${pageContext.request.contextPath}/owner/saveReply.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(res => res.json())
    .then(data => {

        /* ===============================
           📌 5️⃣ 저장 성공 모달
           =============================== */
        if (data.success) {
            Swal.fire({
                html: `
                    <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                        <i class="fa-solid fa-check"></i>
                    </div>
                    <h2 class="text-3xl font-black text-slate-800 mb-3">
                        저장 완료
                    </h2>
                    <p class="text-slate-500 font-bold text-sm">
                        답글이 성공적으로 반영되었습니다.
                    </p>
                `,
                background: '#ffffff',
                customClass: {
                    popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                    confirmButton:
                        'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
                },
                confirmButtonText: '확인',
                buttonsStyling: false
            }).then(() => {
                // 🔹 기존 동작 유지: 리뷰 목록만 새로고침
                loadOwnerPage(
                    'review',
                    '${pageContext.request.contextPath}/owner/reviewList.do',
                    null
                );
            });

        /* ===============================
           📌 6️⃣ 저장 실패 모달
           =============================== */
        } else {
            Swal.fire({
                html: `
                    <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                        <i class="fa-solid fa-xmark"></i>
                    </div>
                    <h2 class="text-3xl font-black text-slate-800 mb-3">
                        실패
                    </h2>
                    <p class="text-slate-500 font-bold text-sm">
                        저장에 실패했습니다.
                    </p>
                `,
                background: '#ffffff',
                customClass: {
                    popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                    confirmButton:
                        'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
                },
                confirmButtonText: '확인',
                buttonsStyling: false
            });
        }
    })
    .catch(err => {

        /* ===============================
           📌 7️⃣ 서버 오류 모달
           =============================== */
        console.error('Error:', err);

        Swal.fire({
            html: `
                <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <h2 class="text-3xl font-black text-slate-800 mb-3">
                    오류
                </h2>
                <p class="text-slate-500 font-bold text-sm">
                    서버 통신 중 문제가 발생했습니다.
                </p>
            `,
            background: '#ffffff',
            customClass: {
                popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
            },
            confirmButtonText: '확인',
            buttonsStyling: false
        });
    });
}



/* function sendReply(reservId) {
    const isEdit = !!document.getElementById('editReply_' + reservId);
    const inputId = isEdit ? 'editReply_' + reservId : 'reply_' + reservId;
    const content = document.getElementById(inputId).value.trim();
    
    if (!content) {
        Swal.fire({ icon: 'warning', title: '내용 입력', text: '답글 내용을 입력해주세요.', confirmButtonColor: '#0ea5e9' });
        return;
    }

    // AJAX로 데이터 전송
    const params = new URLSearchParams();
    params.append('reservId', reservId);
    params.append('content', content);

    fetch('${pageContext.request.contextPath}/owner/saveReply.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(res => res.json())
    .then(data => {
        if(data.success) {
            Swal.fire({
                title: '저장 완료',
                html: `<span class="font-bold text-slate-600">답글이 성공적으로 반영되었습니다.</span>`,
                icon: 'success',
                confirmButtonColor: '#0ea5e9',
                customClass: { popup: 'rounded-[30px]' }
            }).then(() => {
                // 대시보드 리스트만 새로고침
                loadOwnerPage('review', '${pageContext.request.contextPath}/owner/reviewList.do', null);
            });
        } else {
            Swal.fire('실패', '저장에 실패했습니다.', 'error');
        }
    })
    .catch(err => {
        console.error('Error:', err);
        Swal.fire('오류', '서버 통신 중 문제가 발생했습니다.', 'error');
    });
} */

function toggleEditReply(reservId) {
    const editForm = document.getElementById('editForm_' + reservId);
    editForm.classList.toggle('hidden');
}
</script>