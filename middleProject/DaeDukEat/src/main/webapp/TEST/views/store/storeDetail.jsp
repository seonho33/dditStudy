<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>D.D.M - ${store.storeName}</title>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <style>
    @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
    body { font-family: 'Noto Sans KR', sans-serif; background-color: #fafafa; color: #1a1a1a; letter-spacing: -0.05em; }
    .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
    :root { --main-orange: #f97316; }

    .content-grid { max-width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1fr 360px; gap: 40px; }
    .sticky-sidebar { position: sticky; top: 100px; height: fit-content; background: white; border-radius: 30px; border: 2px solid #f3f4f6; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
    .slider-container { position: relative; width: 100%; height: 500px; border-radius: 40px; overflow: hidden; border: 8px solid white; box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
    .slide-img { width: 100%; height: 100%; object-fit: cover; }

    .calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); text-align: center; }
    .day-box { aspect-ratio: 1/1; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 700; cursor: pointer; border-radius: 12px; transition: 0.2s; }
    .disabled { color: #e5e7eb !important; cursor: not-allowed !important; pointer-events: none; }
    .selected { background-color: var(--main-orange) !important; color: white !important; transform: scale(1.1); box-shadow: 0 5px 15px rgba(249, 115, 22, 0.3); }
    
    .time-chip { border: 2px solid #f3f4f6; padding: 10px 0; border-radius: 12px; font-size: 12px; font-weight: 800; text-align: center; cursor: pointer; transition: 0.2s; background: white; }
    .time-chip.active { background: #1f2937; color: white; border-color: #1f2937; }
    .time-chip.disabled { background-color: #f3f4f6 !important; color: #9ca3af !important; border-color: #e5e7eb !important; cursor: not-allowed !important; pointer-events: none !important; text-decoration: line-through; }
    
    .nav-btn-sm { width: 28px; height: 28px; display: flex; align-items: center; justify-content: center; background: #f3f4f6; border-radius: 50%; cursor: pointer; }

    /* ✅ 커스텀 모달 스타일 */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.7);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
      opacity: 0;
      transition: opacity 0.3s;
    }
    .modal-overlay.show {
      opacity: 1;
    }
    .modal-content {
      background: white;
      border-radius: 24px;
      padding: 40px;
      max-width: 500px;
      width: 90%;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      transform: scale(0.9);
      transition: transform 0.3s;
    }
    .modal-overlay.show .modal-content {
      transform: scale(1);
    }
    .modal-header {
      font-size: 24px;
      font-weight: 900;
      color: var(--main-orange);
      margin-bottom: 20px;
      text-align: center;
    }
    .modal-body {
      background: #f9fafb;
      padding: 20px;
      border-radius: 16px;
      margin-bottom: 30px;
    }
    .modal-row {
      display: flex;
      justify-content: space-between;
      padding: 12px 0;
      border-bottom: 1px solid #e5e7eb;
    }
    .modal-row:last-child {
      border-bottom: none;
    }
    .modal-label {
      color: #6b7280;
      font-weight: 600;
    }
    .modal-value {
      color: #1f2937;
      font-weight: 800;
    }
    .modal-buttons {
      display: flex;
      gap: 12px;
    }
    .modal-btn {
      flex: 1;
      padding: 16px;
      border-radius: 16px;
      font-weight: 800;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.2s;
      border: none;
    }
    .modal-btn-cancel {
      background: #f3f4f6;
      color: #6b7280;
    }
    .modal-btn-cancel:hover {
      background: #e5e7eb;
    }
    .modal-btn-confirm {
      background: var(--main-orange);
      color: white;
    }
    .modal-btn-confirm:hover {
      background: #ea580c;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(249, 115, 22, 0.4);
    }
  </style>
</head>

<body class="pt-24 pb-20">

  <!-- ✅ 커스텀 예약 확인 모달 -->
  <div id="reserveModal" class="modal-overlay" style="display: none;">
    <div class="modal-content">
      <div class="modal-header">
        <i class="fa-solid fa-calendar-check" style="color: var(--main-orange);"></i>
        예약 정보 확인
      </div>
      <div class="modal-body">
        <div class="modal-row">
          <span class="modal-label">가게</span>
          <span class="modal-value">${store.storeName}</span>
        </div>
        <div class="modal-row">
          <span class="modal-label">날짜</span>
          <span class="modal-value" id="modalDate"></span>
        </div>
        <div class="modal-row">
          <span class="modal-label">시간</span>
          <span class="modal-value" id="modalTime"></span>
        </div>
        <div class="modal-row">
          <span class="modal-label">인원</span>
          <span class="modal-value" id="modalGuest"></span>
        </div>
        <c:if test="${store.deposit > 0}">
          <div class="modal-row">
            <span class="modal-label">예약금</span>
            <span class="modal-value" style="color: var(--main-orange);">
              <fmt:formatNumber value="${store.deposit}" pattern="#,###"/>원
            </span>
          </div>
        </c:if>
      </div>
      <div class="modal-buttons">
        <button class="modal-btn modal-btn-cancel" onclick="closeReserveModal()">
          취소
        </button>
        <button class="modal-btn modal-btn-confirm" onclick="confirmReserve()">
          결제 페이지로
        </button>
      </div>
    </div>
  </div>

  <nav class="fixed top-0 left-0 right-0 bg-white border-b-4 border-orange-500 z-50 h-20 flex items-center px-6">
    <div class="max-w-[1100px] mx-auto w-full flex justify-between items-center">
     <%--  <span class="text-4xl b-grade-font text-orange-500 italic cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/main.do'">
        D.D.M <span class="text-gray-900 ml-2">${store.storeName}</span>
      </span> --%> 
    <span class="flex items-center text-4xl b-grade-font text-orange-500 cursor-pointer"
        onclick="location.href='${pageContext.request.contextPath}/main.do'">
      
        <img src="${pageContext.request.contextPath}/images/로고.png" 
             alt="D.D.M 로고"
             class="h-14 w-auto mr-2"
             onerror="this.style.display='none';">
      
        D.D.M
    </span>
      <div class="flex items-center gap-4">
        <c:choose>
          <c:when test="${empty userId}">
            <button onclick="location.href='${pageContext.request.contextPath}/login.do'" class="text-sm font-black text-gray-500 hover:text-orange-500">LOGIN</button>
          </c:when>
          <c:otherwise>
            <!-- 맛집리스트 버튼 -->
            <a href="${pageContext.request.contextPath}/storeSearch.do"
               class="bg-white hover:bg-orange-50 text-orange-600 px-4 py-1.5 rounded-full text-xs font-black hover:shadow-md transition-all duration-200 flex items-center gap-1.5">
               <i class="fa-solid fa-utensils text-xs"></i>
                <span>맛집리스트</span>
            </a>
            <!-- 마이페이지 버튼 -->
            <a href="${pageContext.request.contextPath}/mypage.do"
               class="bg-white hover:bg-orange-50 text-orange-600 px-4 py-1.5 rounded-full text-xs font-black hover:shadow-md transition-all duration-200 flex items-center gap-1.5">
                <i class="fa-solid fa-user text-xs"></i>
                <span>마이페이지</span>
            </a> 
   	                    <!-- 로그아웃 버튼 -->
            <a href="${pageContext.request.contextPath}/logout.do"
               class="text-gray-400 hover:text-orange-600 font-bold text-xs transition-all duration-200 flex items-center gap-1 px-2 py-1.5 hover:bg-orange-50 rounded-full">
                <i class="fa-solid fa-sign-out-alt text-xl"></i>
                <span>로그아웃</span>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </nav>

  <div class="content-grid px-6">
    <main class="space-y-10">
      <div class="slider-container">
        <img src="${pageContext.request.contextPath}/images/upload/store/${store.storePicture}" class="slide-img" onerror="this.src='${pageContext.request.contextPath}/images/default-store.png'">
      </div>

      <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100 relative">
        <div class="absolute top-10 right-10 flex gap-4 text-3xl">
          <i id="likeBtn" onclick="toggleAction('like')" class="${isLiked ? 'fa-solid fa-heart text-red-500' : 'fa-regular fa-heart text-gray-300'} cursor-pointer hover:scale-110 transition-all"></i>
          <i id="bookBtn" onclick="toggleAction('bookmark')" class="${isBookmarked ? 'fa-solid fa-bookmark text-yellow-500' : 'fa-regular fa-bookmark text-gray-300'} cursor-pointer hover:scale-110 transition-all"></i>
        </div>
        <span class="inline-block px-4 py-2 bg-orange-100 text-orange-600 rounded-full text-sm font-bold mb-4">${store.category}</span>
        <h2 class="text-5xl b-grade-font mb-6 text-gray-900">${store.storeName}</h2>
        <p class="text-gray-600 leading-9 text-xl font-medium mb-6">${store.storeContent}</p>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mt-8 pt-6 border-t text-sm font-bold">
          <div><p class="text-gray-400">영업시간</p><p>${store.operationHours}</p></div>
          <div><p class="text-gray-400">전화번호</p><p>${store.storePhone}</p></div>
          <div><p class="text-gray-400">평점</p><p>★ <fmt:formatNumber value="${store.rating}" pattern="0.0"/> (${store.reviewCount})</p></div>
          <div><p class="text-gray-400">찜</p><p>${store.dibsCount}명</p></div>
        </div>
      </section>

      <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
        <h3 class="text-3xl b-grade-font mb-8 text-orange-500 uppercase">Menu List</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <c:forEach var="menu" items="${menuList}">
            <div class="flex items-center gap-4 p-4 rounded-2xl border border-gray-50">
              <c:if test="${not empty menu.menuPicture}">
                <img src="${pageContext.request.contextPath}/images/upload/menu/${menu.menuPicture}" class="w-20 h-20 rounded-xl object-cover">
              </c:if>
              <div><h4 class="font-bold">${menu.menuName}</h4><p class="text-orange-500 font-black"><fmt:formatNumber value="${menu.menuPrice}"/>원</p></div>
            </div>
          </c:forEach>
        </div>
      </section>

      <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
        <h3 class="text-3xl b-grade-font mb-8 text-orange-500 uppercase">Reviews</h3>
        <c:choose>
          <c:when test="${not empty reviewList}">
            <div class="space-y-6">
              <c:forEach var="rev" items="${reviewList}">
                <div class="pb-6 border-b border-gray-50 last:border-0">
                  <div class="flex justify-between mb-2">
                    <span class="font-black">${rev.userName}</span>
                    <span class="text-orange-400 text-xs"><c:forEach begin="1" end="${rev.rating}">★</c:forEach></span>
                  </div>
                  <p class="text-gray-700">${rev.review}</p>
                  <c:if test="${not empty rev.ceoReview}">
                    <div class="mt-4 p-4 bg-orange-50 rounded-2xl border-l-4 border-orange-500 text-sm">
                      <p class="text-orange-600 font-bold mb-1">사장님 답글</p>
                      <p>${rev.ceoReview}</p>
                    </div>
                  </c:if>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise><p class="text-center text-gray-400 py-10">아직 리뷰가 없습니다.</p></c:otherwise>
        </c:choose>
      </section>

      <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
        <h3 class="text-3xl b-grade-font mb-6 text-orange-500 uppercase">Location</h3>
        <div id="map" class="rounded-[30px] overflow-hidden h-[400px] border-4 border-gray-50"></div>
        <p class="font-bold text-gray-800 text-lg mt-4"><i class="fa-solid fa-map-pin text-orange-500 mr-2"></i>${store.storeAddr}</p>
      </section>
    </main>

    <aside>
      <div class="sticky-sidebar">
        <h3 class="text-3xl b-grade-font mb-4 text-center uppercase">Reserve</h3>
        
        <c:if test="${store.deposit > 0}">
          <div class="bg-orange-50 p-3 rounded-2xl mb-6 text-center">
            <p class="text-xs text-orange-600 font-bold">예약금</p>
            <p class="text-2xl font-black text-orange-500"><fmt:formatNumber value="${store.deposit}"/>원</p>
          </div>
        </c:if>

        <div class="flex justify-between items-center mb-6 px-2">
          <button type="button" onclick="changeMonth(-1)"><i class="fa-solid fa-chevron-left text-gray-300"></i></button>
          <span id="calTitle" class="text-xl font-black"></span>
          <button type="button" onclick="changeMonth(1)"><i class="fa-solid fa-chevron-right text-gray-300"></i></button>
        </div>

        <div class="calendar-grid mb-2 text-xs font-bold text-gray-400">
          <div>일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div>토</div>
        </div>
        <div class="calendar-grid mb-8 border-t pt-4 gap-y-1" id="calDays"></div>

        <div id="timeSection" class="hidden opacity-0 transition-all border-t pt-6">
          <div class="flex justify-between items-center mb-4">
            <h4 class="font-bold text-gray-600 text-sm">시간 선택</h4>
            <div class="flex gap-2">
                <button type="button" onclick="prevTimePage()" class="nav-btn-sm"><i class="fa-solid fa-chevron-left text-[10px]"></i></button>
                <button type="button" onclick="nextTimePage()" class="nav-btn-sm"><i class="fa-solid fa-chevron-right text-[10px]"></i></button>
            </div>
          </div>
          <div class="grid grid-cols-5 gap-2" id="timeGrid"></div>
        </div>

        <div id="guestSection" class="hidden opacity-0 transition-all mt-6 border-t pt-6">
          <h4 class="font-bold text-gray-600 mb-4 text-sm">인원 선택</h4>
          <div class="flex items-center justify-center gap-6">
            <button type="button" onclick="changeGuest(-1)" class="w-10 h-10 rounded-full border-2 border-gray-200 font-bold hover:bg-gray-50">-</button>
            <span id="guestCount" class="text-3xl font-black">2</span>
            <button type="button" onclick="changeGuest(1)" class="w-10 h-10 rounded-full border-2 border-gray-200 font-bold hover:bg-gray-50">+</button>
          </div>
        </div>

        <form action="${pageContext.request.contextPath}/reservePay.do" method="POST" id="resForm">
          <input type="hidden" name="storeId" value="${store.storeId}">
          <input type="hidden" name="date" id="hiddenDate">
          <input type="hidden" name="time" id="hiddenTime">
          <input type="hidden" name="guestCount" id="hiddenGuest" value="2">
          <button type="button" id="finalBtn" onclick="submitReserve()"
                  class="w-full mt-10 py-6 bg-gray-100 text-gray-300 rounded-[20px] b-grade-font text-2xl pointer-events-none transition-all uppercase">
            Select Date
          </button>
        </form>
      </div>
    </aside>
  </div>

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7ed0b1ca9bb2803effb423c76255e900&libraries=services&autoload=false"></script>
  <script>
    const contextPath = '${pageContext.request.contextPath}';
    const storeId = '${store.storeId}';
    const userId = '${userId}';
    const holidays = [<c:forEach var="h" items="${storeHolidays}" varStatus="s">'${h}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const dayNames = ['일', '월', '화', '수', '목', '금', '토'];

    let vDate = new Date();
    let selDate = null; let selTime = null; let guestNum = 2;
    let allTimes = []; let currentTimePage = 0; const timesPerPage = 5;

    const today = new Date(); today.setHours(0,0,0,0);
    const maxDate = new Date(); maxDate.setMonth(maxDate.getMonth() + 2);

    document.addEventListener('DOMContentLoaded', () => { renderCalendar(); initKakaoMap(); });

    function renderCalendar() {
      const y = vDate.getFullYear(); const m = vDate.getMonth();
      document.getElementById('calTitle').innerText = y + "년 " + String(m+1).padStart(2,'0') + "월";
      const container = document.getElementById('calDays'); container.innerHTML = '';
      const firstDay = new Date(y, m, 1).getDay();
      const lastDate = new Date(y, m + 1, 0).getDate();
      for (let i = 0; i < firstDay; i++) container.appendChild(document.createElement('div'));
      for (let i = 1; i <= lastDate; i++) {
        const d = document.createElement('div'); d.className = 'day-box'; d.innerText = i;
        const curDate = new Date(y, m, i); curDate.setHours(0,0,0,0);
        if (curDate < today || curDate > maxDate || holidays.includes(dayNames[curDate.getDay()])) d.classList.add('disabled');
        else {
          d.onclick = () => {
            document.querySelectorAll('.day-box').forEach(b => b.classList.remove('selected'));
            d.classList.add('selected'); selDate = y + "-" + String(m+1).padStart(2,'0') + "-" + String(i).padStart(2,'0');
            document.getElementById('hiddenDate').value = selDate; generateTimes();
          };
        }
        container.appendChild(d);
      }
    }

    function generateTimes() {
      allTimes = []; const start = 10; const end = 22; const now = new Date();
      const isToday = (selDate === now.toISOString().split('T')[0]);
      let firstPossibleIdx = -1;

      for (let h = start; h <= end; h++) {
        for (let m = 0; m < 60; m += 30) {
          const hh = String(h).padStart(2,'0'); const mm = String(m).padStart(2,'0');
          let isPast = false;
          if (isToday) {
            const timeVal = parseInt(hh+mm);
            const nowVal = parseInt(String(now.getHours()).padStart(2,'0') + String(now.getMinutes()).padStart(2,'0'));
            if (timeVal <= nowVal) isPast = true;
          }
          if (!isPast && firstPossibleIdx === -1) firstPossibleIdx = allTimes.length;
          allTimes.push({ time: hh + ":" + mm, disabled: isPast });
        }
      }

      if (isToday && firstPossibleIdx !== -1) {
        currentTimePage = Math.floor(firstPossibleIdx / timesPerPage);
      } else {
        currentTimePage = 0;
      }

      selTime = null; renderTimeGrid();
      document.getElementById('timeSection').classList.remove('hidden');
      setTimeout(() => document.getElementById('timeSection').style.opacity = '1', 50);
      document.getElementById('guestSection').classList.add('hidden'); resetBtn();
    }

    function renderTimeGrid() {
      const grid = document.getElementById('timeGrid'); grid.innerHTML = '';
      const items = allTimes.slice(currentTimePage * timesPerPage, (currentTimePage + 1) * timesPerPage);
      items.forEach(item => {
        const chip = document.createElement('div');
        chip.className = 'time-chip' + (item.disabled ? ' disabled' : '');
        chip.innerText = item.time;
        if (!item.disabled) {
          if (selTime === item.time) chip.classList.add('active');
          chip.onclick = () => {
            document.querySelectorAll('.time-chip').forEach(c => c.classList.remove('active'));
            chip.classList.add('active'); selTime = item.time;
            document.getElementById('hiddenTime').value = selTime;
            document.getElementById('guestSection').classList.remove('hidden');
            setTimeout(() => document.getElementById('guestSection').style.opacity = '1', 50);
            updateBtn();
          };
        }
        grid.appendChild(chip);
      });
    }

    function nextTimePage() { if ((currentTimePage + 1) * timesPerPage < allTimes.length) { currentTimePage++; renderTimeGrid(); } }
    function prevTimePage() { if (currentTimePage > 0) { currentTimePage--; renderTimeGrid(); } }
    function changeGuest(n) { guestNum = Math.max(1, Math.min(80, guestNum + n)); document.getElementById('guestCount').innerText = guestNum; document.getElementById('hiddenGuest').value = guestNum; }
    
    function updateBtn() {
      const btn = document.getElementById('finalBtn');
      btn.className = "w-full mt-10 py-6 bg-orange-500 text-white rounded-[20px] b-grade-font text-2xl shadow-lg cursor-pointer hover:bg-black transition-all uppercase";
      btn.innerText = "Reserve Now"; btn.style.pointerEvents = "auto";
    }

    function resetBtn() {
      const btn = document.getElementById('finalBtn');
      btn.className = "w-full mt-10 py-6 bg-gray-100 text-gray-300 rounded-[20px] b-grade-font text-2xl pointer-events-none transition-all uppercase";
      btn.innerText = "Select Time"; btn.style.pointerEvents = "none";
    }

    function changeMonth(d) {
      const n = new Date(vDate); n.setMonth(n.getMonth() + d);
      if (n < new Date(today.getFullYear(), today.getMonth(), 1) || n > maxDate) return;
      vDate = n; renderCalendar();
    }

    function toggleAction(type) {
      if (!userId) { alert('로그인이 필요합니다.'); location.href = contextPath + "/login.do"; return; }
      const btn = (type === 'like') ? document.getElementById('likeBtn') : document.getElementById('bookBtn');
      const active = btn.classList.contains('fa-solid');
      fetch(contextPath + '/toggleAction.do', {
        method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'type=' + type + '&storeId=' + encodeURIComponent(storeId) + '&action=' + (active ? 'remove' : 'add')
      }).then(res => res.json()).then(data => {
        if (data.success) btn.className = (active ? 'fa-regular' : 'fa-solid') + (type === 'like' ? ' fa-heart ' + (active?'text-gray-300':'text-red-500') : ' fa-bookmark ' + (active?'text-gray-300':'text-yellow-500')) + ' cursor-pointer transition-all hover:scale-110';
      });
    }

    /** ✅ 커스텀 모달 표시 **/
    function submitReserve() {
      if (!selDate || !selTime) {
        alert('날짜와 시간을 선택해주세요.');
        return;
      }

      // 모달에 데이터 표시
      document.getElementById('modalDate').innerText = selDate;
      document.getElementById('modalTime').innerText = selTime;
      document.getElementById('modalGuest').innerText = guestNum + '명';

      // 모달 표시
      const modal = document.getElementById('reserveModal');
      modal.style.display = 'flex';
      setTimeout(() => modal.classList.add('show'), 10);
    }

    /** ✅ 모달 닫기 **/
    function closeReserveModal() {
      const modal = document.getElementById('reserveModal');
      modal.classList.remove('show');
      setTimeout(() => modal.style.display = 'none', 300);
    }

    /** ✅ 예약 확정 → 결제 페이지로 이동 **/
    function confirmReserve() {
      closeReserveModal();
      setTimeout(() => {
        document.getElementById('resForm').submit();
      }, 300);
    }

    function initKakaoMap() {
      kakao.maps.load(() => {
        const container = document.getElementById('map');
        const options = { center: new kakao.maps.LatLng(36.35041, 127.3845), level: 3 };
        const map = new kakao.maps.Map(container, options);
        new kakao.maps.services.Geocoder().addressSearch("${store.storeAddr}", (result, status) => {
          if (status === kakao.maps.services.Status.OK) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            new kakao.maps.Marker({ map: map, position: coords }); map.setCenter(coords);
          }
        });
      });
    }
  </script>
</body>
</html>
