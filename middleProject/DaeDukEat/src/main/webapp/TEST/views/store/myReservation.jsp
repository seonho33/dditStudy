<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Jakarta EE 표준 타글립 선언 --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="animate-fadeIn">
    
    <%-- 1. 헤더 영역 --%>
    <div class="flex justify-between items-center mb-8">
        <h3 class="text-xl font-black text-slate-800 italic uppercase tracking-tighter">My Booking & History</h3>
    </div>

    <%-- 2. 시스템 메시지 (성공/에러) --%>
    <c:if test="${not empty sessionScope.message}">
        <div class="mb-6 p-4 rounded-2xl ${sessionScope.messageType eq 'success' ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'}">
            <div class="flex items-center gap-3">
                <i class="fa-solid ${sessionScope.messageType eq 'success' ? 'fa-check-circle text-green-600' : 'fa-exclamation-circle text-red-600'} text-xl"></i>
                <p class="text-sm font-bold ${sessionScope.messageType eq 'success' ? 'text-green-800' : 'text-red-800'}">
                    <c:out value="${sessionScope.message}"/>
                </p>
            </div>
        </div>
        <c:remove var="message" scope="session"/>
        <c:remove var="messageType" scope="session"/>
    </c:if>

    <div class="space-y-6">
        
        <%-- 3. 활성 예약 카드 리스트 --%>
<jsp:useBean id="now" class="java.util.Date" />
        <c:choose>
            <c:when test="${not empty activeReservations}">
                <c:forEach var="reserv" items="${activeReservations}">
<c:set var="rt" value="${reserv.reservTime}" />

<c:choose>
  <c:when test="${fn:length(rt) >= 19}">
    <fmt:parseDate value="${rt}" pattern="yyyy-MM-dd HH:mm:ss" var="reservDt" />
  </c:when>
  <c:otherwise>
    <fmt:parseDate value="${rt}" pattern="yyyy-MM-dd HH:mm" var="reservDt" />
  </c:otherwise>
</c:choose>

<c:set var="isPast" value="${now.time > reservDt.time}" />


<fmt:parseDate value="${reserv.reservTime}"
               pattern="yyyy-MM-dd HH:mm"
               var="reservDt" />

<c:set var="isPast" value="${now.time > reservDt.time}" />

<div class="p-8 text-white rounded-[40px] flex justify-between items-center shadow-2xl relative overflow-hidden transition-all border border-white/5
    ${isPast 
       ? 'bg-slate-800/90 text-white/80' 
       : 'bg-slate-900 hover:shadow-orange-500/10'}">
                        
                        <%-- 배경 장식 --%>
                        <div class="absolute -right-10 -bottom-10 text-white/5 text-9xl font-black italic select-none">DDM</div>

                        <%-- 예약 정보 영역 --%>
                        <div class="relative z-10">
                            <div class="flex items-center gap-2 mb-4">
                                <span class="w-2.5 h-2.5 ${reserv.reservStatus eq '승인' ? 'bg-green-400' : 'bg-yellow-400'} rounded-full animate-pulse shadow-[0_0_10px_rgba(74,222,128,0.5)]"></span>
                                <p class="text-[11px] font-black text-orange-500 tracking-[0.2em] uppercase">
                                    <c:out value="${reserv.reservStatus}"/>
                                </p>
                            </div>
                            
                            <h4 class="text-3xl font-black mb-2 tracking-tight">
                                <c:out value="${reserv.storeName}"/>
                            </h4>
                            
                            <p class="text-lg font-bold opacity-70 flex items-center gap-2">
                                <i class="fa-regular fa-clock text-sm"></i> ${reserv.reservTime} 
                                <span class="text-white/20">|</span> 
                                <i class="fa-regular fa-user text-sm"></i> ${reserv.guestCount}명
                            </p>
                            
                            <c:if test="${not empty reserv.note}">
                                <div class="mt-4 py-2 px-3 bg-white/5 rounded-xl border border-white/10 inline-block">
                                    <p class="text-[11px] opacity-60 italic font-medium">
                                        <i class="fa-solid fa-quote-left mr-1 text-[8px]"></i>
                                        <c:out value="${fn:substring(reserv.note, 0, 40)}"/>${fn:length(reserv.note) > 40 ? '...' : ''}
                                    </p>
                                </div>
                            </c:if>
                            
                            <p class="text-[10px] mt-6 font-mono opacity-30 tracking-widest uppercase">
                                REF-CODE: R${reserv.reservId}
                            </p>
                        </div>

                        <%-- 액션 버튼 영역 --%>
                        <div class="flex flex-col gap-3 relative z-10">
<%--                             <button 
                                onclick="shareReservation('${fn:escapeXml(reserv.storeName)}', '${reserv.reservTime}', ${reserv.reservId}, ${reserv.guestCount})" 
                                class="bg-orange-600 text-white px-8 py-4 rounded-2xl font-black text-sm hover:bg-orange-500 hover:scale-105 transition-all shadow-xl shadow-orange-950/40 group">
                                <i class="fa-solid fa-share-nodes mr-2 group-hover:rotate-12 transition-transform"></i> 예약 공유
                            </button> --%>
                            
							<!-- 예약 PDF 다운로드 -->
							<button 
							    onclick="downloadReservationPDF('${reserv.reservId}', '${not empty reserv.storeName ? fn:escapeXml(reserv.storeName) : "매장명없음"}')"
							    class="bg-orange-600 text-white px-8 py-4 rounded-2xl font-black text-sm hover:bg-orange-500 hover:scale-105 transition-all shadow-xl shadow-orange-950/40 group">
							    <i class="fa-solid fa-file-pdf mr-2 group-hover:rotate-12 transition-transform"></i> PDF 다운로드
							</button>

                            
							<button type="button"
							    <c:if test="${isPast}">disabled="disabled"</c:if>
							    <c:if test="${not isPast}">onclick="askCancel(${reserv.reservId}, this)"</c:if>
							    class="bg-white/10 text-white/50 px-8 py-4 rounded-2xl font-bold text-xs border border-transparent transition-all
							           ${isPast 
							              ? 'opacity-40' 
							              : 'hover:bg-red-500/20 hover:text-red-400 hover:border-red-500/30'}">
							    예약 취소
							</button>


                        </div>
                    </div>
                </c:forEach>
            </c:when>
            
            <c:otherwise>
                <div class="p-16 bg-slate-50 rounded-[40px] text-center border border-dashed border-slate-200">
                    <div class="w-16 h-16 bg-white rounded-2xl shadow-sm flex items-center justify-center mx-auto mb-4 text-slate-300">
                        <i class="fa-solid fa-calendar-xmark text-2xl"></i>
                    </div>
                    <p class="text-slate-400 font-bold">현재 진행 중인 예약이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/storeSearch.do" class="text-xs text-orange-500 font-black mt-3 inline-block underline underline-offset-4 uppercase tracking-widest">Book Now</a>
                </div>
            </c:otherwise>
        </c:choose>

        <%-- 4. 최근 알림 섹션 --%>
        <c:if test="${not empty notifications}">
            <div class="mt-12">
                <div class="flex items-center gap-3 mb-6">
                    <div class="h-[1px] flex-1 bg-slate-100"></div>
                    <h4 class="text-[11px] font-black text-slate-400 tracking-[0.3em] uppercase">Recent Alerts</h4>
                    <div class="h-[1px] flex-1 bg-slate-100"></div>
                </div>
                
                <div class="grid gap-3">
                    <c:forEach var="noti" items="${notifications}" varStatus="status" end="9">
                        <div class="p-5 bg-white border border-slate-100 rounded-[24px] flex items-center gap-5 shadow-sm hover:shadow-md transition-all group">
                            <div class="w-12 h-12 bg-slate-50 rounded-xl flex items-center justify-center text-slate-300 group-hover:bg-orange-50 group-hover:text-orange-400 transition-colors">
                                <i class="fa-solid fa-bell"></i>
                            </div>
                            <div class="flex-1 min-w-0">
                                <p class="text-sm font-black text-slate-800 truncate leading-tight">
                                    <c:out value="${noti.notificationTitle}"/>
                                </p>
                                <p class="text-[11px] text-slate-400 font-bold mt-1 uppercase tracking-tighter">
                                    <c:out value="${noti.notificationContent}"/>
                                </p>
                            </div>
                            <span class="text-[10px] font-bold text-slate-300 whitespace-nowrap bg-slate-50 px-2 py-1 rounded-md">
                                ${noti.relativeTime}
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>

const contextPath = '${pageContext.request.contextPath}';

    // ✅ 모달 수동 생성 함수 (페이지 리로드 대응)
    function ensureModalExists() {
        if (!document.getElementById('customModal')) {
            const modalHtml = `
                <div id="customModal" class="fixed inset-0 z-[200] hidden">
                    <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm animate-fadeIn"></div>
                    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[90%] max-w-sm bg-white rounded-[32px] p-8 shadow-2xl animate-slideUp">
                        <div class="text-center">
                            <div id="modalIcon" class="w-16 h-16 bg-slate-50 rounded-2xl flex items-center justify-center mx-auto mb-4 text-2xl">🔔</div>
                            <h3 id="modalTitle" class="text-xl font-black text-slate-800 mb-2">알림</h3>
                            <p id="modalMessage" class="text-slate-500 font-medium leading-relaxed mb-8"></p>
                            <div class="flex gap-3" id="modalButtons"></div>
                        </div>
                    </div>
                </div>`;
            document.body.insertAdjacentHTML('beforeend', modalHtml);
            
            // 배경 클릭 시 닫기 이벤트 다시 걸기
            document.getElementById('customModal').addEventListener('click', (e) => {
                if (e.target.classList.contains('bg-slate-900/60')) Modal.close();
            });
        }
    }

    // --- [모달 제어 객체] ---
    const Modal = {
        show(options) {
            ensureModalExists(); // 실행 전 항상 확인
            const el = document.getElementById('customModal');
            const title = document.getElementById('modalTitle');
            const msg = document.getElementById('modalMessage');
            const icon = document.getElementById('modalIcon');
            const btns = document.getElementById('modalButtons');

            title.innerText = options.title || '알림';
            msg.innerHTML = options.message || '';
            icon.innerText = options.icon || '🔔';
            btns.innerHTML = '';

            if (options.type === 'confirm') {
                btns.innerHTML = `
                    <button onclick="Modal.close()" class="flex-1 py-4 bg-slate-100 text-slate-400 font-black rounded-2xl hover:bg-slate-200 transition-all">취소</button>
                    <button id="modalConfirmBtn" class="flex-1 py-4 bg-red-500 text-white font-black rounded-2xl shadow-lg shadow-red-200 hover:bg-red-600 transition-all">확인</button>
                `;
                document.getElementById('modalConfirmBtn').onclick = () => {
                    this.close();
                    if (options.onConfirm) options.onConfirm();
                };
            } else {
                btns.innerHTML = `
                    <button onclick="Modal.close()" class="w-full py-4 bg-slate-900 text-white font-black rounded-2xl shadow-lg shadow-slate-300 transition-all">확인</button>
                `;
            }
            el.classList.remove('hidden');
        },

        close() {
            const el = document.getElementById('customModal');
            if (el) el.classList.add('hidden');
        }
    };

    function shareReservation(storeName, reservTime, reservId, guestCount) {
        const fullContent = `[D.D.M 예약 확정 메시지]\n\n🏨 매장: \${storeName}\n📅 일시: \${reservTime}\n👥 인원: \${guestCount}명\n🎫 번호: R\${reservId}`;
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(fullContent).then(() => {
                Modal.show({ title: '공유 성공', message: '예약 메시지가 클립보드에 복사되었습니다!', icon: '✅' });
            }).catch(() => fallbackCopy(fullContent));
        } else {
            fallbackCopy(fullContent);
        }
    }
    
    /* 예약공유 PDF 다운로드 */
		function downloadReservationPDF(reservId, storeName) {
    		
			 // ★ 디버깅 1: 함수에 전달된 파라미터 확인
/* 		    console.log("=== PDF 다운로드 디버깅 ===");
		    console.log("1. 전달받은 reservId:", reservId);
		    console.log("2. 전달받은 storeName:", storeName);
		    console.log("3. storeName 타입:", typeof storeName);
		    console.log("4. storeName 길이:", storeName ? storeName.length : 'null/undefined'); */
		    
    	
			if (!reservId || reservId === '' || reservId === 'null') {
		        alert('예약 ID가 없습니다.');
		        return;
		    }
			 
			    // storeName이 없으면 fallback
			    if (!storeName || storeName === 'null') storeName = "UnknownStore";
		
				 console.log("다운로드 예약 - 가게 이름:", storeName); 

			    const url = contextPath
			      + '/reservation/downloadPDF.do?reservId=' + encodeURIComponent(reservId)
			      + '&storeName=' + encodeURIComponent(storeName);
			      
			    fetch(url)
		        .then(res => {
		            if (!res.ok) throw new Error('PDF 다운로드 실패');
		            
		            // ★ 서버의 Content-Disposition 헤더에서 파일명 추출
		            const disposition = res.headers.get('Content-Disposition');
		            console.log('Content-Disposition:', disposition);
		            
		            let fileName = 'Reservation.pdf'; // 기본값
		            
		            // ★ filename*=UTF-8'' 형식에서 파일명 추출
		            if (disposition && disposition.includes("filename*=UTF-8''")) {
		                const matches = disposition.match(/filename\*=UTF-8''(.+?)(?:;|$)/);
		                if (matches && matches[1]) {
		                    fileName = decodeURIComponent(matches[1]);
		                    console.log('추출된 파일명:', fileName);
		                }
		            }
		            
		            return res.blob().then(blob => ({ blob, fileName }));
		        })
		        .then(({ blob, fileName }) => {
		            const link = document.createElement('a');
		            link.href = URL.createObjectURL(blob);
		            link.download = fileName; // ★ 서버에서 받은 파일명 사용
		            document.body.appendChild(link); // iOS / Safari용 안전한 처리
		            
		            link.click();
		            document.body.removeChild(link);
		            URL.revokeObjectURL(link.href);
		        })
		        .catch(err => alert(err.message));
		}


    

    function askCancel(reservId, btnEl) {
        Modal.show({
            title: '예약 취소',
            message: '정말로 예약을 취소하시겠습니까?<br><span class="text-xs text-red-400">취소 후에는 복구가 불가능합니다.</span>',
            icon: '⚠️',
            type: 'confirm',
            onConfirm: () => confirmCancel(reservId, btnEl)
        });
    }

    function confirmCancel(reservId, btnEl) {
        if (!reservId) return;
        if (btnEl) {
            btnEl.disabled = true;
            btnEl.style.opacity = "0.6";
        }

        fetch(contextPath + '/reservation/cancel.do', {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
            body: "reservId=" + encodeURIComponent(reservId)
        })
        .then(async (res) => {
            const text = await res.text();
            let data;
            try { data = JSON.parse(text); } catch(e) { throw new Error("서버 응답 오류"); }
            if (!res.ok) throw new Error(data.message || "HTTP " + res.status);
            return data;
        })
        .then((data) => {
            if (data.success === true) {
                Modal.show({ title: '취소 성공', message: '예약이 정상적으로 취소되었습니다.', icon: '🗑️' });
                const card = btnEl ? btnEl.closest(".p-8.bg-slate-900") : null;
                if (card) {
                    card.style.transition = "all 0.25s ease";
                    card.style.opacity = "0";
                    setTimeout(() => card.remove(), 250);
                }
                setTimeout(() => reloadMyReservationFragment(), 1000);
            } else {
                throw new Error(data.message || "취소 실패");
            }
        })
        .catch(err => {
            Modal.show({ title: '오류', message: err.message, icon: '❌' });
            if (btnEl) {
                btnEl.disabled = false;
                btnEl.style.opacity = "1";
            }
        });
    }

    function reloadMyReservationFragment() {
        if (typeof loadPage === "function") {
        	loadPage('resv', contextPath + '/myReservation.do');
        	} else {
            const content = document.getElementById("mypage-content") || document.getElementById("content-area") || document.body;
            fetch(contextPath + '/myReservation.do', {
                method: "GET",
                headers: { "X-Requested-With": "fetch" }
            })
            .then(r => r.text())
            .then(html => { content.innerHTML = html; });
        }
    }

    function fallbackCopy(text) {
        const t = document.createElement("textarea");
        t.value = text;
        document.body.appendChild(t);
        t.select();
        document.execCommand('copy');
        document.body.removeChild(t);
        Modal.show({ title: '복사 완료', message: '메시지가 복사되었습니다!', icon: '✅' });
    }

    // 최초 로드 시 모달 생성
    ensureModalExists();
</script>

<style>
    @keyframes fadeIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
    @keyframes slideUp { 
        from { opacity: 0; transform: translate(-50%, -40%); } 
        to { opacity: 1; transform: translate(-50%, -50%); } 
    }
    .animate-fadeIn { animation: fadeIn 0.6s cubic-bezier(0.22, 1, 0.36, 1); }
    .animate-slideUp { animation: slideUp 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
    .truncate { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
</style>