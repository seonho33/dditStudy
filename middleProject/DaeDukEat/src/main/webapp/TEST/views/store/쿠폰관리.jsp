<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="couponSubContainer">
    <div class="flex justify-between items-end border-b pb-6 mb-8">
        <h3 class="text-2xl font-black text-slate-800">쿠폰 관리</h3>
        <button type="button" onclick="window.openCouponModal()"
                class="px-6 py-3 bg-slate-900 text-white rounded-2xl font-black shadow-lg hover:bg-orange-500 transition-all">
            <i class="fa-solid fa-plus mr-2"></i>새 쿠폰 제작
        </button>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <c:choose>
            <c:when test="${not empty couponList}">
                <c:forEach var="coupon" items="${couponList}">
                    <div class="bg-white border rounded-[30px] p-8 shadow-sm">
                        <h4 class="text-xl font-black text-slate-800">${coupon.couponName}</h4>
                        <p class="text-slate-500 text-sm mt-2">${coupon.couponContent}</p>
                        <div class="mt-8 flex justify-between items-end border-t pt-6">
                            <span class="text-3xl font-black text-orange-500 italic">
                                <fmt:formatNumber value="${coupon.deductedPrice}"/>원
                            </span>
                            <button type="button" 
                                    onclick="window.deleteCoupon('${coupon.couponId}')"
                                    class="text-red-400 font-bold hover:text-red-600 transition-colors">
                                삭제
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-span-2 py-20 text-center text-slate-400 font-bold">등록된 쿠폰이 없습니다.</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div id="couponModal" class="hidden fixed inset-0 bg-black/50 z-[100] items-center justify-center">
  <div class="bg-white rounded-[40px] p-10 max-w-lg w-full mx-4 shadow-2xl border border-slate-100">
    
    <div class="flex items-start justify-between mb-8">
      <div>
        <h3 class="text-2xl font-black text-slate-800">새 쿠폰 제작</h3>
        <p class="text-slate-400 text-sm font-bold mt-2">
          쿠폰 생성일 이후 작성된 리뷰를 기준으로 자동 발급됩니다.
        </p>
      </div>
      <button type="button" onclick="window.closeCouponModal()"
              class="w-10 h-10 rounded-2xl bg-slate-100 text-slate-500 font-black hover:bg-slate-200 transition">
        ✕
      </button>
    </div>

    <form id="couponForm">
      <div class="space-y-5">

        <!-- 쿠폰명 -->
        <div>
          <label class="block text-sm font-black text-slate-700 mb-2">쿠폰명</label>
          <input type="text" name="couponName" placeholder="예: 리뷰 감사 쿠폰" required
                 class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none font-bold focus:bg-white focus:border-slate-300 transition">
        </div>

        <!-- 상세설명 -->
        <div>
          <label class="block text-sm font-black text-slate-700 mb-2">쿠폰 상세 설명</label>
          <input type="text" name="couponContent" placeholder="예: 리뷰 작성해주셔서 감사합니다!"
                 class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none font-bold focus:bg-white focus:border-slate-300 transition">
        </div>

        <!-- 할인/최소주문 -->
        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-black text-slate-700 mb-2">할인액</label>
            <input type="number" name="deductedPrice" placeholder="0" min="0" required
                   class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none font-bold focus:bg-white focus:border-slate-300 transition">
          </div>
          <div>
            <label class="block text-sm font-black text-slate-700 mb-2">최소 주문금액</label>
            <input type="number" name="minPrice" placeholder="0" min="0" required
                   class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none font-bold focus:bg-white focus:border-slate-300 transition">
          </div>
        </div>

        <!-- 리뷰 조건 -->
        <div class="bg-slate-50 border border-slate-100 rounded-3xl p-5">
          <div class="flex items-center justify-between">
            <p class="font-black text-slate-800">리뷰 조건</p>
            <span class="text-xs font-black text-slate-500">자동 발급</span>
          </div>

          <div class="mt-4 flex items-center gap-3">
            <input type="number" name="reviewN" required min="1" value="10"
                   class="w-32 p-4 bg-white border border-slate-100 rounded-2xl outline-none font-black text-slate-800 focus:border-slate-300 transition"
                   placeholder="10">
            <p class="text-slate-600 font-bold">개 작성 시 쿠폰 지급</p>
          </div>

          <p class="mt-3 text-xs text-slate-400 font-bold leading-relaxed">
            * 쿠폰 생성일 이후 작성된 리뷰만 집계됩니다.<br/>
            * 동일 이용자에게 동일 쿠폰은 중복 발급되지 않습니다.
          </p>
        </div>

        <!-- 유효기간(만료일) -->
        <div>
          <div class="flex items-center justify-between mb-2">
            <label class="block text-sm font-black text-slate-700">유효기간 (만료일)</label>
            <span class="text-xs font-black text-slate-400">YYYY-MM-DD</span>
          </div>

          <div class="relative">
            <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
              <i class="fa-regular fa-calendar"></i>
            </span>
            <input type="date" name="expiredDate" required
                   class="w-full pl-12 p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none font-bold focus:bg-white focus:border-slate-300 transition">
          </div>

          <p class="mt-2 text-xs text-slate-400 font-bold">
            * 만료일이 지나면 쿠폰은 자동으로 사용 불가 처리됩니다.
          </p>
        </div>

        <input type="hidden" name="couponQty" value="999">
      </div>

      <div class="flex gap-4 mt-10">
        <button type="button" onclick="window.closeCouponModal()"
                class="flex-1 p-4 bg-slate-100 text-slate-600 rounded-2xl font-black hover:bg-slate-200 transition">
          취소
        </button>
        <button type="button" onclick="window.submitCoupon()"
                class="flex-1 p-4 bg-slate-900 text-white rounded-2xl font-black shadow-lg hover:bg-orange-500 transition-all">
          발행
        </button>
      </div>
    </form>

  </div>
</div>

<script>
    // 모든 함수를 window 객체에 할당하여 loadOwnerPage 이후에도 호출 가능하게 함
    window.openCouponModal = function() {
        document.getElementById('couponModal').style.display = 'flex';
    };

    window.closeCouponModal = function() {
        document.getElementById('couponModal').style.display = 'none';
        document.getElementById('couponForm').reset();
    };


        
    function validateCouponForm(form) {
        const reviewN = form.querySelector('[name="reviewN"]')?.value;

        /* ===============================
           📌 1️⃣ 리뷰 개수 유효성 검사
           (기능 그대로 유지)
           =============================== */
        if (!reviewN || Number(reviewN) < 1) {

            /* ===============================
               📌 2️⃣ 경고 모달 (스타일만 변경)
               =============================== */
            Swal.fire({
                html: `
                    <div class="w-24 h-24 bg-amber-50 text-amber-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <h2 class="text-3xl font-black text-slate-800 mb-3">
                        확인
                    </h2>
                    <p class="text-slate-500 font-bold text-sm">
                        리뷰 조건(개수)은 1 이상으로 입력해주세요.
                    </p>
                `,
                background: '#ffffff',

                // 🔹 처음 사용하던 커스텀 모달 스타일과 완전히 동일
                customClass: {
                    popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                    confirmButton:
                        'w-full py-5 px-14 bg-amber-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-amber-100'
                },

                confirmButtonText: '확인',
                buttonsStyling: false
            });
            // 🔹 기존 동작 그대로: 폼 제출 중단
            return false;
        }
        // 🔹 유효성 통과 (기존 로직 그대로)
        return true;
    }


    window.submitCoupon = function() {
        const form = document.getElementById('couponForm');
        if (!validateCouponForm(form)) return;

        const formData = new URLSearchParams(new FormData(form)).toString();

        fetch('${pageContext.request.contextPath}/addCoupon.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData
        })
        .then(res => res.text())
        .then(data => {
            const txt = (data || '').trim();

            /* ===============================
               📌 1️⃣ 쿠폰 발행 성공 모달
               =============================== */
            if (txt === "SUCCESS") {
                Swal.fire({
                    html: `
                        <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                            <i class="fa-solid fa-check"></i>
                        </div>
                        <h2 class="text-3xl font-black text-slate-800 mb-3">
                            성공
                        </h2>
                        <p class="text-slate-500 font-bold text-sm">
                            쿠폰이 발행되었습니다.
                        </p>
                    `,
                    background: '#ffffff',

                    // 🔹 처음 사용하던 모달 스타일과 완전히 동일
                    customClass: {
                        popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                        confirmButton:
                            'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
                    },

                    confirmButtonText: '확인',
                    buttonsStyling: false
                }).then(() => {
                    // 🔹 기존 동작 그대로 유지
                    window.closeCouponModal();
                    loadOwnerPage(
                        'coupon',
                        '${pageContext.request.contextPath}/couponList.do'
                    );
                });

            /* ===============================
               📌 2️⃣ 세션 만료 (로그인 필요)
               =============================== */
            } else if (txt === "LOGOUT") {
                Swal.fire({
                    html: `
                        <div class="w-24 h-24 bg-amber-50 text-amber-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                        </div>
                        <h2 class="text-3xl font-black text-slate-800 mb-3">
                            로그인 필요
                        </h2>
                        <p class="text-slate-500 font-bold text-sm">
                            세션이 만료되었습니다.<br>다시 로그인해주세요.
                        </p>
                    `,
                    background: '#ffffff',

                    customClass: {
                        popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                        confirmButton:
                            'w-full py-5 px-14 bg-amber-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-amber-100'
                    },

                    confirmButtonText: '확인',
                    buttonsStyling: false
                });

            /* ===============================
               📌 3️⃣ 쿠폰 등록 실패
               =============================== */
            } else {
                Swal.fire({
                    html: `
                        <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                            <i class="fa-solid fa-xmark"></i>
                        </div>
                        <h2 class="text-3xl font-black text-slate-800 mb-3">
                            오류
                        </h2>
                        <p class="text-slate-500 font-bold text-sm">
                            등록에 실패했습니다.
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
        });
    };

    
    window.deleteCoupon = function(couponId) {
        /* ===============================
           📌 1️⃣ 삭제 확인 모달 (경고)
           =============================== */
        Swal.fire({
            html: `
                <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <h2 class="text-3xl font-black text-slate-800 mb-3">
                    삭제하시겠습니까?
                </h2>
                <p class="text-slate-500 font-bold text-sm">
                    삭제된 쿠폰은 복구할 수 없습니다.
                </p>
            `,
            background: '#ffffff',

            // 🔹 처음 사용하던 커스텀 모달 스타일과 동일
            customClass: {
                popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100',
                cancelButton:
                    'w-full py-5 px-14 bg-slate-50 text-slate-400 rounded-[22px] font-black text-sm'
            },

            showCancelButton: true,
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            buttonsStyling: false
        }).then((result) => {

            /* ===============================
               📌 2️⃣ 삭제 확정 시 서버 요청
               (기존 기능 그대로)
               =============================== */
            if (result.isConfirmed) {
                fetch('${pageContext.request.contextPath}/deleteCoupon.do', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'couponId=' + couponId
                })
                .then(res => res.text())
                .then(data => {

                    /* ===============================
                       📌 3️⃣ 삭제 완료 모달
                       =============================== */
                    if ((data || '').trim() === "success") {
                        Swal.fire({
                            html: `
                                <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                                    <i class="fa-solid fa-check"></i>
                                </div>
                                <h2 class="text-3xl font-black text-slate-800 mb-3">
                                    완료
                                </h2>
                                <p class="text-slate-500 font-bold text-sm">
                                    삭제되었습니다.
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
                            // 🔹 기존 동작 그대로: 쿠폰 목록 새로고침
                            loadOwnerPage(
                                'coupon',
                                '${pageContext.request.contextPath}/couponList.do'
                            );
                        });
                    }
                });
            }
        });
    };


/*     function validateCouponForm(form) {
    const reviewN = form.querySelector('[name="reviewN"]')?.value;
    if (!reviewN || Number(reviewN) < 1) {
        Swal.fire('확인', '리뷰 조건(개수)은 1 이상으로 입력해주세요.', 'warning');
        return false;
    }
    return true;
} */    
    
  /*   window.submitCoupon = function() {
        const form = document.getElementById('couponForm');
        if (!validateCouponForm(form)) return;

        const formData = new URLSearchParams(new FormData(form)).toString();

        fetch('${pageContext.request.contextPath}/addCoupon.do', {
        	  method: 'POST',
        	  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        	  body: formData
        	})

        .then(res => res.text())
        .then(data => {
            const txt = (data || '').trim();
            if (txt === "SUCCESS") {
                Swal.fire('성공', '쿠폰이 발행되었습니다.', 'success').then(() => {
                    window.closeCouponModal();
                    loadOwnerPage('coupon', '${pageContext.request.contextPath}/couponList.do');
                });
            } else if (txt === "LOGOUT") {
                Swal.fire('로그인 필요', '세션이 만료되었습니다. 다시 로그인해주세요.', 'warning');
            } else {
                Swal.fire('오류', '등록 실패', 'error');
            }
        });
    }; */

/*     window.deleteCoupon = function(couponId) {
        Swal.fire({
            title: '삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '삭제',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                fetch('${pageContext.request.contextPath}/deleteCoupon.do', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'couponId=' + couponId
                })
                .then(res => res.text())
                .then(data => {
                    if((data || '').trim() === "success") {
                        Swal.fire('완료', '삭제되었습니다.', 'success').then(() => {
                            loadOwnerPage('coupon', '${pageContext.request.contextPath}/couponList.do');
                        });
                    }
                });
            }
        });
    }; */
</script>
