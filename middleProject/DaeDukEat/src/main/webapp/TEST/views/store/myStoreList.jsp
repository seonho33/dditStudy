<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="store" value="${sessionScope.loginStore}" />

<div class="animate-fadeIn">

  <!-- 타이틀 -->
  <div class="mb-8">
    <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2">
      STORE OVERVIEW
    </p>
    <h3 class="text-3xl font-black text-slate-800 tracking-tight">
      가게 조회 <span class="text-sky-500">한눈에 보기</span>
    </h3>
    <p class="text-sm font-bold text-slate-400 mt-2">
      현재 로그인된 가게의 기본 정보를 표시합니다.
    </p>
  </div>

  <c:choose>

    <%-- 가게 없음 --%>
    <c:when test="${empty store}">
      <div class="owner-card text-center py-20">
        <div class="text-6xl mb-4">🏪</div>
        <p class="text-xl font-black text-slate-700 mb-2">가게 정보가 없습니다</p>
        <p class="text-slate-400 font-bold">가게 등록 후 이용해주세요.</p>
      </div>
    </c:when>

    <%-- 가게 있음 --%>
    <c:otherwise>
      <div class="grid grid-cols-12 gap-6 items-stretch">

        <!-- ✅ 왼쪽: 어두운 명함 스타일 가게 정보 -->
        <div class="col-span-12 lg:col-span-5">
          <div class="relative overflow-hidden border border-slate-400 bg-black shadow-lg" style="border-radius: 14px;">

            <!-- 배경 이미지 -->
            <div class="absolute inset-0">
              <img
                src="${pageContext.request.contextPath}/images/upload/store/${store.storePicture}"
                onerror="this.src='${pageContext.request.contextPath}/images/upload/store/default-store.png'"
                class="w-full h-full object-cover"
                style="opacity: 0.45;"
              />
              <!-- 어두운 오버레이 -->
              <div class="absolute inset-0 bg-black/45"></div>
            </div>

            <!-- 명함 내용 -->
            <div class="relative p-9 text-white">

              <!-- 상단 -->
              <div class="mb-9">
                <p class="text-[11px] font-bold tracking-widest opacity-70">
                  STORE CARD
                </p>

                <h4 class="text-3xl font-black tracking-tight mt-2">
                  ${store.storeName}
                </h4>

                <p class="mt-2 text-sm font-semibold opacity-85">
                  ${store.category}
                </p>
              </div>

              <!-- 정보 영역 -->
              <div class="space-y-3 text-sm font-medium leading-relaxed opacity-90">
                <p>${store.storeAddr} ${store.storeAddr2}</p>
                <p>${store.storePhone}</p>
                <p>${store.operationHours}</p>
              </div>

              <!-- 하단 -->
              <div class="mt-12 pt-4 border-t border-white/20 flex justify-between items-center">
                <span class="text-xs font-bold tracking-widest opacity-60">
                  D.D.M OWNER
                </span>
                <span class="text-xs font-semibold opacity-60">
                  SINCE ${store.createDate}
                </span>
              </div>

            </div>
          </div>
        </div>

        <!-- ✅ 오른쪽: 승인대기 예약 리스트 (빈공간 없이 꽉 채움) -->
        <div class="col-span-12 lg:col-span-7 h-full">
          <div class="bg-white border border-slate-200 rounded-3xl p-6 shadow-sm h-full flex flex-col min-h-0">

            <div class="flex items-center justify-between mb-4">
              <div>
                <h5 class="text-lg font-black text-slate-800">승인 대기 예약</h5>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest mt-1">
                  오늘 들어온 예약을 바로 처리하세요
                </p>
              </div>
<button
  type="button"
  class="text-xs font-black text-sky-600 hover:underline"
  onclick="loadOwnerPage('reservation','${pageContext.request.contextPath}/reservation/list.do')">
  전체 보기 →
</button>


            </div>

            <!-- 리스트 영역: 남은 높이 전부 + 내부 스크롤 -->
            <div class="flex-1 min-h-0 overflow-auto rounded-2xl border border-slate-100 bg-white p-3">
              <c:choose>

                <c:when test="${empty dashboard.todayPendingList}">
                  <div class="h-full flex flex-col items-center justify-center text-center py-10">
                    <div class="w-12 h-12 rounded-2xl bg-slate-100 flex items-center justify-center mb-3">
                      <i class="fa-solid fa-inbox text-slate-500 text-xl"></i>
                    </div>
                    <p class="text-sm font-black text-slate-700">승인 대기 예약이 없습니다</p>
                    <p class="text-xs font-bold text-slate-400 mt-2">예약이 들어오면 여기에 표시돼요.</p>
                  </div>
                </c:when>

                <c:otherwise>
                  <div class="space-y-2" id="pending-list-wrap">
                    <c:forEach var="r" items="${dashboard.todayPendingList}" begin="0" end="50">
                      <div id="reserv-row-${r.reservId}"
                           class="flex items-center justify-between gap-3 rounded-xl border border-slate-100 px-3 py-3 hover:bg-slate-50 transition">

                        <div class="min-w-0">
                          <p class="text-sm font-black text-slate-800">
                            <c:out value="${r.reservTime}" default="--:--"/>
                            <span class="ml-2 text-xs font-bold text-slate-400">
                              <c:out value="${r.userName}" default="손님"/>
                              · <c:out value="${r.guestCount}" default="1"/>명
                            </span>
                          </p>

                          <p class="text-[11px] font-bold text-slate-400 truncate">
                            요청사항: <c:out value="${r.note}" default="요청사항 없음"/>
                          </p>
                        </div>

                        <div class="flex items-center gap-2 shrink-0">
                          <span class="px-2.5 py-1 rounded-full text-[11px] font-black bg-yellow-50 text-yellow-700">
                           	대기
                          </span>

                          <button type="button"
                                  class="px-3 py-2 rounded-xl text-xs font-black bg-slate-100 text-slate-700 hover:bg-slate-200 transition"
                                  onclick="updateReservStatus(${r.reservId}, 'REJECT')">
                            거절
                          </button>

                          <button type="button"
                                  class="px-3 py-2 rounded-xl text-xs font-black bg-green-500 text-white hover:brightness-110 transition"
                                  onclick="updateReservStatus(${r.reservId}, 'APPROVE')">
                            승인
                          </button>
                        </div>

                      </div>
                    </c:forEach>
                  </div>
                </c:otherwise>

              </c:choose>
            </div>

          </div>
        </div>

      </div>
    </c:otherwise>
  </c:choose>

</div>

<script>
/**
 * 대시보드 승인/거절 처리
 * - 기존 /reservation/updateStatus.do 재사용
 * - 성공 시: 알림 -> (1) row 제거 -> (2) 대시보드 조각 재로딩
 */
function updateReservStatus(reservId, action) {
  const isApprove = action === 'APPROVE';
  const title = isApprove ? '예약을 승인할까요?' : '예약을 거절할까요?';
  const confirmText = isApprove ? '승인' : '거절';

  Swal.fire({
    title: title,
    text: '처리 후에는 상태가 변경됩니다.',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: confirmText,
    cancelButtonText: '취소',
    confirmButtonColor: isApprove ? '#22c55e' : '#ef4444'
  }).then((result) => {
    if (!result.isConfirmed) return;

    const url = "${pageContext.request.contextPath}/reservation/updateStatus.do?idx=" + reservId + "&status=" + action;

    fetch(url, {
      method: 'GET',
      headers: { 'X-Requested-With': 'XMLHttpRequest' } // ✅ isAjax 인식
    })
    .then(res => res.json())
    .then(data => {
      if (!data.success) {
        Swal.fire('실패', data.message || '처리에 실패했습니다.', 'error');
        return;
      }

      // ✅ 성공 알림 (옵션만 넣기!)
      Swal.fire({
        title: '완료',
        text: data.message || '처리되었습니다.',
        icon: 'success',
        timer: 900,
        showConfirmButton: false
      });

      // ✅ row 제거
      const row = document.getElementById("reserv-row-" + reservId);
      if (row) {
        row.style.transition = 'all .25s ease';
        row.style.opacity = '0';
        row.style.transform = 'translateX(10px)';
        setTimeout(() => row.remove(), 250);
      }

      // ✅ 통계 숫자(있으면) 즉시 감소
      const pendingEl = document.getElementById('stat-pending');
      if (pendingEl) {
        const n = parseInt(pendingEl.textContent || '0', 10);
        if (!isNaN(n) && n > 0) pendingEl.textContent = String(n - 1);
      }

      // ✅ (선택) 리스트 비었으면 비움 UI
      setTimeout(checkEmptyPendingList, 260);

      // ✅ 진짜 핵심: 승인/거절 후 "가게조회 조각" 다시 로드해서 최신 상태로 맞추기
      setTimeout(() => {
        loadOwnerPage(
          'storeSearch',
          '${pageContext.request.contextPath}/store/list.do'
          // element 굳이 안 넣어도 됨 (넣으면 active 처리까지 되고 싶을 때만)
        );
      }, 350);

    })
    .catch(err => {
      console.error(err);
      Swal.fire('오류', '서버 통신 중 오류가 발생했습니다.', 'error');
    });
  });
}

function checkEmptyPendingList() {
  const listWrap = document.querySelector('#pending-list-wrap');
  if (!listWrap) return;

  const rows = listWrap.querySelectorAll('[id^="reserv-row-"]');
  if (rows.length === 0) {
    listWrap.innerHTML = `
      <div class="h-full flex flex-col items-center justify-center text-center py-10">
        <div class="w-12 h-12 rounded-2xl bg-slate-100 flex items-center justify-center mb-3">
          <i class="fa-solid fa-inbox text-slate-500 text-xl"></i>
        </div>
        <p class="text-sm font-black text-slate-700">대기 예약이 없습니다</p>
        <p class="text-xs font-bold text-slate-400 mt-2">예약이 들어오면 여기에 표시돼요.</p>
      </div>
    `;
  }
}
</script>
