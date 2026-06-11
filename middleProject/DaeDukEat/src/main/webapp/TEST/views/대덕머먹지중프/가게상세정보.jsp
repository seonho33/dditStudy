<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- 💡 [DB연동 1] Controller에서 request.setAttribute("storeVO", vo)로 보낸 객체의 이름을 사용 --%>
    <title>D.D.M - ${storeVO.sName}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fafafa; color: #1a1a1a; letter-spacing: -0.05em; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        :root { --main-orange: #f97316; }

        .content-max { max-width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1fr 360px; gap: 40px; }
        .sticky-sidebar { position: sticky; top: 100px; height: fit-content; background: white; border-radius: 30px; border: 2px solid #f3f4f6; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }

        .slider-container { position: relative; width: 100%; height: 500px; border-radius: 40px; overflow: hidden; border: 8px solid white; box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
        .slider-wrapper { display: flex; transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1); width: 400%; height: 100%; }
        .slide-img { width: 25%; height: 100%; object-fit: cover; flex-shrink: 0; }

        .calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); text-align: center; }
        .day-box { aspect-ratio: 1/1; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 700; cursor: pointer; border-radius: 12px; transition: 0.2s; }
        .disabled { color: #e5e7eb !important; cursor: not-allowed !important; pointer-events: none; }
        .selected { background-color: var(--main-orange) !important; color: white !important; transform: scale(1.1); box-shadow: 0 5px 15px rgba(249, 115, 22, 0.3); }
        .time-chip { border: 2px solid #f3f4f6; padding: 10px; border-radius: 12px; font-size: 13px; font-weight: 800; text-align: center; cursor: pointer; transition: 0.2s; }
        .time-chip.active { background: #1f2937; color: white; border-color: #1f2937; }
    </style>
</head>
<body class="pt-24 pb-20">

    <nav class="fixed top-0 left-0 right-0 bg-white border-b-4 border-orange-500 z-50 h-20 flex items-center px-6">
        <div class="content-max w-full flex justify-between items-center">
            <span class="text-4xl b-grade-font text-orange-500 italic cursor-pointer" onclick="location.href='main.do'">
                D.D.M <span class="text-gray-900 ml-2">${storeVO.sName}</span>
            </span>
            <div class="flex items-center gap-6">
                <%-- 💡 [DB연동 2] 세션에 저장된 로그인 아이디 확인 --%>
                <c:choose>
                    <c:when test="${empty sessionScope.userId}">
                        <button onclick="location.href='login.do'" class="text-sm font-black text-gray-500 hover:text-orange-500 transition-colors">LOGIN</button>
                    </c:when>
                    <c:otherwise>
                        <span class="text-xs font-bold text-gray-400 italic">${sessionScope.userName}님 환영합니다</span>
                        <button onclick="location.href='logout.do'" class="text-sm font-black text-gray-500 hover:text-red-500 transition-colors">LOGOUT</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>

    <div class="content-max px-6">
        <main class="space-y-10">
            <div class="slider-container group">
                <div id="mainSlider" class="slider-wrapper">
                    <img src="https://images.unsplash.com/photo-1552611052-33e04de081de?w=1200" class="slide-img">
                    <img src="https://images.unsplash.com/photo-1585032226651-759b368d7246?w=1200" class="slide-img">
                    <img src="https://img-cf.kurly.com/hdims/resize/%3E720x/quality/90/src/shop/data/goodsview/20230803/gv20000714335_1.jpg" class="slide-img">
                    <img src="https://images.unsplash.com/photo-1526318896980-cf78c088247c?w=1200" class="slide-img">
                </div>
                <button onclick="moveSlide(-1)" class="absolute left-6 top-1/2 -translate-y-1/2 w-12 h-12 bg-white/80 rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity"><i class="fa-solid fa-chevron-left"></i></button>
                <button onclick="moveSlide(1)" class="absolute right-6 top-1/2 -translate-y-1/2 w-12 h-12 bg-white/80 rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity"><i class="fa-solid fa-chevron-right"></i></button>
            </div>

            <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100 relative">
                <div class="absolute top-10 right-10 flex gap-4 text-3xl">
                    <%-- 💡 [DB연동 3] 회원이 이 가게를 좋아요/찜 했는지 여부를 boolean(isLiked)으로 받아와서 클래스 분기 --%>
                    <i id="likeBtn" onclick="toggleAction('like')" 
                       class="${isLiked ? 'fa-solid fa-heart text-red-500' : 'fa-regular fa-heart text-gray-300'} cursor-pointer transition-all hover:scale-110"></i>
                    <i id="bookBtn" onclick="toggleAction('bookmark')" 
                       class="${isBookmarked ? 'fa-solid fa-bookmark text-yellow-500' : 'fa-regular fa-bookmark text-gray-300'} cursor-pointer transition-all hover:scale-110"></i>
                </div>
                <h2 class="text-5xl b-grade-font mb-6 text-gray-900">차원이 다른 <span class="text-orange-500">불맛</span></h2>
                <p class="text-gray-600 leading-9 text-xl font-medium">
                    <%-- 💡 [DB연동 4] VO 객체의 필드값 출력 --%>
                    ${storeVO.sContent}
                </p>
            </section>

            <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
                <h3 class="text-3xl b-grade-font mb-8 italic text-orange-500 uppercase">Menu List</h3>
                <div id="menuGrid" class="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-2">
                    <%-- 💡 [DB연동 5] List<MenuVO> 형태의 데이터를 반복문으로 출력 --%>
                    <c:forEach var="menu" items="${menuList}">
                        <div class="flex justify-between py-3 border-b border-dashed border-gray-100 font-bold">
                            <span>${menu.mName}</span>
                            <span class="text-orange-500"><fmt:formatNumber value="${menu.mPrice}"/>원</span>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
                <h3 class="text-3xl b-grade-font mb-8 italic text-orange-500 uppercase">Reviews</h3>
                <div class="space-y-6">
                    <%-- 💡 [DB연동 6] 리뷰 테이블 연동 --%>
                    <c:forEach var="rev" items="${reviewList}">
                        <div class="pb-6 border-b border-gray-50">
                            <div class="flex justify-between mb-2">
                                <span class="font-black text-gray-800">${rev.uName}</span>
                                <span class="text-orange-400 tracking-tighter">
                                    <%-- 평점에 따른 별 개수 처리 --%>
                                    <c:forEach begin="1" end="${rev.rating}"><i class="fa-solid fa-star text-[10px]"></i></c:forEach>
                                </span>
                            </div>
                            <p class="text-gray-500 font-medium">${rev.content}</p>
                            <%-- 사장님 답글 유무 확인 --%>
                            <c:if test="${not empty rev.reply}">
                                <div class="mt-3 ml-6 p-4 bg-gray-50 rounded-2xl border-l-4 border-orange-500 text-sm font-bold text-gray-600">
                                    ${rev.reply}
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <section class="bg-white p-10 rounded-[40px] shadow-sm border border-gray-100">
                <h3 class="text-3xl b-grade-font mb-6 italic">LOCATION</h3>
                <div class="rounded-[30px] overflow-hidden h-[350px]">
                    <iframe src="http://googleusercontent.com/maps.google.com/4" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
                <p class="mt-4 font-bold text-gray-500"><i class="fa-solid fa-map-pin text-orange-500 mr-2"></i> ${storeVO.sAddress}</p>
            </section>
        </main>

        <aside>
            <div class="sticky-sidebar">
                <h3 class="text-3xl b-grade-font mb-8 text-center uppercase tracking-widest">Reserve</h3>
                <div class="flex justify-between items-center mb-6 px-2">
                    <button onclick="changeMonth(-1)"><i class="fa-solid fa-chevron-left text-gray-300"></i></button>
                    <span id="calTitle" class="text-xl font-black italic"></span>
                    <button onclick="changeMonth(1)"><i class="fa-solid fa-chevron-right text-gray-300"></i></button>
                </div>
                <div class="calendar-grid mb-8 border-t pt-4 gap-y-1" id="calDays"></div>

                <div id="timeSection" class="hidden opacity-0 transition-all duration-500">
                    <div class="grid grid-cols-3 gap-3" id="timeGrid">
                        <div class="time-chip" onclick="selectTime(this)">11:30</div>
                        <div class="time-chip" onclick="selectTime(this)">12:30</div>
                        <div class="time-chip" onclick="selectTime(this)">17:30</div>
                        <div class="time-chip" onclick="selectTime(this)">18:30</div>
                    </div>
                </div>

                <%-- 💡 [DB연동 7] 사용자가 선택한 날짜/시간을 DB로 보내기 위한 폼태그 --%>
                <form action="reserve.do" method="POST" id="resForm">
                    <%-- 💡 name 속성값이 서버(Controller)의 파라미터 이름이 됨 --%>
                    <input type="hidden" name="resDate" id="hiddenDate">
                    <input type="hidden" name="resTime" id="hiddenTime">
                    <input type="hidden" name="storeId" value="${storeVO.sId}">
                    <button type="button" id="finalBtn" onclick="submitReserve()" class="w-full mt-10 py-6 bg-gray-100 text-gray-300 rounded-[20px] b-grade-font text-2xl pointer-events-none transition-all uppercase">Select Date</button>
                </form>
            </div>
        </aside>
    </div>

    <script>
        // 💡 [DB연동 8] 비동기 데이터 업데이트 (Ajax/Fetch)
        function toggleAction(type) {
            const userId = "${sessionScope.userId}";
            if(!userId) { alert("로그인하세요"); return; }

            const btn = type === 'like' ? document.getElementById('likeBtn') : document.getElementById('bookBtn');
            const isActive = btn.classList.contains('fa-solid');

            // 페이지 새로고침 없이 DB 값만 바꿀 때 fetch 사용
            fetch('toggleAction.do?type=' + type + '&active=' + !isActive + '&storeId=${storeVO.sId}')
                .then(res => res.json())
                .then(data => {
                    if(data.result === 'success') {
                        // DB 업데이트 성공 시 아이콘 모양 변경
                        if(isActive) {
                            btn.className = (type === 'like' ? 'fa-regular fa-heart text-gray-300' : 'fa-regular fa-bookmark text-gray-300') + " cursor-pointer transition-all hover:scale-110";
                        } else {
                            btn.className = (type === 'like' ? 'fa-solid fa-heart text-red-500' : 'fa-solid fa-bookmark text-yellow-500') + " cursor-pointer transition-all hover:scale-110";
                        }
                    }
                });
        }

        // 💡 [DB연동 9] 날짜 에러 방지용 포맷팅 로직
        let vDate = new Date();
        let selDate = null; let selTime = null;

        function renderCalendar() {
            const y = vDate.getFullYear(), m = vDate.getMonth();
            document.getElementById('calTitle').innerText = (m + 1) + " / " + y;
            const container = document.getElementById('calDays'); container.innerHTML = '';
            const first = new Date(y, m, 1).getDay(), last = new Date(y, m + 1, 0).getDate();
            const today = new Date().setHours(0,0,0,0);

            for (let i = 0; i < first; i++) container.appendChild(document.createElement('div'));
            for (let i = 1; i <= last; i++) {
                const d = document.createElement('div'); d.className = 'day-box'; d.innerText = i;
                if (new Date(y, m, i) < today) d.classList.add('disabled');
                else d.onclick = () => {
                    document.querySelectorAll('.day-box').forEach(b => b.classList.remove('selected'));
                    d.classList.add('selected'); 
                    
                    // 💡 DB가 인식하기 가장 좋은 'YYYY-MM-DD' 포맷 생성
                    const mm = (m + 1) < 10 ? '0' + (m + 1) : (m + 1);
                    const dd = i < 10 ? '0' + i : i;
                    selDate = y + "-" + mm + "-" + dd;
                    
                    // 히든 input에 저장 (form 전송용)
                    document.getElementById('hiddenDate').value = selDate;
                    document.getElementById('timeSection').classList.remove('hidden');
                    setTimeout(() => document.getElementById('timeSection').style.opacity = '1', 50);
                    updateBtn();
                };
                container.appendChild(d);
            }
        }

        function selectTime(el) {
            document.querySelectorAll('.time-chip').forEach(c => c.classList.remove('active'));
            el.classList.add('active'); 
            selTime = el.innerText;
            document.getElementById('hiddenTime').value = selTime;
            updateBtn();
        }

        function updateBtn() {
            const btn = document.getElementById('finalBtn');
            if(selDate && selTime) {
                btn.className = "w-full mt-10 py-6 bg-orange-500 text-white rounded-[20px] b-grade-font text-2xl shadow-lg cursor-pointer hover:bg-black transition-all";
                btn.innerText = "Reserve Now";
                btn.style.pointerEvents = "auto";
            }
        }

        function submitReserve() {
            // 💡 [DB연동 10] 최종 예약 정보를 서버의 reserve.do 서블릿으로 전송
            if(confirm(selDate + " " + selTime + " 예약하시겠습니까?")) {
                document.getElementById('resForm').submit();
            }
        }

        function changeMonth(d) { vDate.setMonth(vDate.getMonth() + d); renderCalendar(); }
        window.onload = renderCalendar;
    </script>
</body>
</html>