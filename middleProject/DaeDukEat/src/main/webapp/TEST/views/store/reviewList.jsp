<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--
    리뷰 관리 JSP (일반회원)
    
    [서버 연동]
    - Controller: /review/list.do (GET)
    - 데이터: ${reviewableList}, ${myReviewList}
    
    [AJAX 통신]
    - 리뷰 작성: POST /review/write.do
    - 리뷰 삭제: POST /review/delete.do
-->

<style>
    /* 탭 버튼 스타일 */
    .tab-active {
        background: #1e293b !important;
        color: white !important;
    }
    .tab-inactive {
        background: white;
        color: #cbd5e1;
        border: 1px solid #f1f5f9;
    }
</style>

<div class="animate-fadeIn">
    <%-- 탭 버튼 --%>
    <div class="flex gap-4 mb-8">
        <button id="tab-reviewable" onclick="switchTab('reviewable')" 
                class="tab-active px-6 py-2 rounded-full text-xs font-black shadow-lg transition-all">
            작성 가능한 리뷰
        </button>
        <button id="tab-myreviews" onclick="switchTab('myreviews')" 
                class="tab-inactive px-6 py-2 rounded-full text-xs font-bold hover:bg-slate-50 transition-all">
            내가 쓴 리뷰
        </button>
    </div>

    <%-- 작성 가능한 리뷰 섹션 --%>
    <div id="section-reviewable" class="grid grid-cols-1 gap-4 mb-12">
        <p class="text-[11px] font-black text-orange-400 uppercase tracking-widest ml-2 mb-2">
            Wait for Review
        </p>

        <c:choose>
            <c:when test="${not empty reviewableList}">
                <c:forEach var="reserv" items="${reviewableList}">
                    <div class="bg-white border-2 border-dashed border-slate-100 p-6 rounded-[35px] flex justify-between items-center shadow-sm">
                        <div class="flex items-center gap-5">
                            <div class="w-16 h-16 bg-slate-100 rounded-2xl flex items-center justify-center text-slate-300 text-2xl">
                                <i class="fa-solid fa-utensils"></i>
                            </div>
                            <div>
                                <p class="text-lg font-black text-slate-800">${reserv.storeName}</p>
                                <p class="text-xs text-slate-400 font-bold">
                                    <fmt:formatDate value="${reserv.reservDate}" pattern="yyyy.MM.dd"/> 방문
                                </p>
                            </div>
                        </div>
                        <button onclick="openReviewModal(${reserv.reservId}, '${reserv.storeName}')" 
                                class="bg-orange-500 text-white px-8 py-3 rounded-2xl font-black text-sm shadow-lg shadow-orange-100 hover:scale-105 transition-all">
                            리뷰 작성
                        </button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="bg-slate-50 p-12 rounded-3xl text-center">
                    <i class="fa-solid fa-pen-nib text-4xl text-slate-200 mb-3"></i>
                    <p class="text-slate-400 font-bold">작성 가능한 리뷰가 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 내가 쓴 리뷰 섹션 --%>
    <div id="section-myreviews" class="hidden grid-cols-2 gap-6">
        <p class="col-span-2 text-[11px] font-black text-slate-400 uppercase tracking-widest ml-2 mb-2">
            My Stories
        </p>

        <c:choose>
            <c:when test="${not empty myReviewList}">
                <c:forEach var="review" items="${myReviewList}">
                    <div id="review-card-${review.reservId}" 
                         class="bg-white border border-slate-100 p-6 rounded-[35px] shadow-sm hover:shadow-md transition-shadow">
                        <%-- 별점 & 작성일 --%>
                        <div class="flex items-center gap-3 mb-4">
                            <div class="flex text-orange-400 text-xs">
                                <c:forEach begin="1" end="${review.rating}">★ </c:forEach>
                            </div>
                            <span class="text-[10px] font-black text-slate-300">
                                <fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd"/> 작성
                            </span>
                        </div>
                        
                        <%-- 리뷰 내용 --%>
                        <p class="text-slate-800 font-bold mb-4 line-clamp-3">
                            "${review.review}"
                        </p>
                        
                        <%-- 하단: 가게명 & 삭제 버튼 --%>
                        <div class="flex items-center justify-between mt-auto pt-4 border-t border-slate-50">
                            <span class="text-xs font-black text-orange-500 tracking-tighter uppercase">
                                ${review.storeName}
                            </span>
                            <button onclick="deleteReview(${review.reservId})" 
                                    class="text-[10px] font-black text-slate-300 hover:text-red-500 transition-colors">
                                삭제
                            </button>
                        </div>
                        
                        <%-- 사장님 답글 (있는 경우) --%>
                        <c:if test="${review.hasCeoReply == 'Y'}">
                            <div class="mt-4 p-3 bg-slate-50 rounded-2xl">
                                <p class="text-[10px] font-black text-slate-500 mb-1">사장님 답글</p>
                                <p class="text-xs text-slate-600">${review.ceoReview}</p>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-span-2 bg-slate-50 p-12 rounded-3xl text-center">
                    <i class="fa-solid fa-star text-4xl text-slate-200 mb-3"></i>
                    <p class="text-slate-400 font-bold">작성한 리뷰가 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%-- 리뷰 작성 모달 --%>
<div id="reviewModal" class="hidden fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center">
    <div class="bg-white rounded-3xl p-8 w-[500px] max-w-[90%]">
        <h3 class="text-2xl font-black text-slate-800 mb-6">리뷰 작성</h3>
        
        <input type="hidden" id="modal-reservId">
        
        <%-- 가게명 표시 --%>
        <p id="modal-storeName" class="text-sm font-bold text-orange-500 mb-4"></p>
        
        <%-- 별점 선택 --%>
        <div class="mb-6">
            <label class="block text-xs font-black text-slate-600 mb-2">별점</label>
            <div class="flex gap-2">
                <c:forEach begin="1" end="5" var="star">
                    <button type="button" onclick="setRating(${star})" 
                            class="star-btn text-3xl text-slate-200 hover:text-orange-400 transition-colors">
                        ★
                    </button>
                </c:forEach>
            </div>
            <input type="hidden" id="modal-rating" value="5">
        </div>
        
        <%-- 리뷰 내용 --%>
        <div class="mb-6">
            <label class="block text-xs font-black text-slate-600 mb-2">리뷰 내용</label>
            <textarea id="modal-review" 
                      class="w-full h-32 p-4 border border-slate-200 rounded-2xl text-sm resize-none focus:outline-none focus:ring-2 focus:ring-orange-500/20" 
                      placeholder="최소 10자 이상 입력해주세요..."></textarea>
        </div>
        
        <%-- 버튼 --%>
        <div class="flex gap-3">
            <button onclick="closeReviewModal()" 
                    class="flex-1 bg-slate-100 text-slate-600 py-3 rounded-2xl font-black hover:bg-slate-200 transition-all">
                취소
            </button>
            <button onclick="submitReview()" 
                    class="flex-1 bg-orange-500 text-white py-3 rounded-2xl font-black hover:bg-orange-600 transition-all">
                작성 완료
            </button>
        </div>
    </div>
</div>

<script>
    /**
     * 탭 전환
     */
    function switchTab(tab) {
        if(tab === 'reviewable') {
            // 작성 가능한 리뷰 탭
            document.getElementById('tab-reviewable').className = 'tab-active px-6 py-2 rounded-full text-xs font-black shadow-lg transition-all';
            document.getElementById('tab-myreviews').className = 'tab-inactive px-6 py-2 rounded-full text-xs font-bold hover:bg-slate-50 transition-all';
            document.getElementById('section-reviewable').classList.remove('hidden');
            document.getElementById('section-myreviews').classList.add('hidden');
        } else {
            // 내가 쓴 리뷰 탭
            document.getElementById('tab-reviewable').className = 'tab-inactive px-6 py-2 rounded-full text-xs font-bold hover:bg-slate-50 transition-all';
            document.getElementById('tab-myreviews').className = 'tab-active px-6 py-2 rounded-full text-xs font-black shadow-lg transition-all';
            document.getElementById('section-reviewable').classList.add('hidden');
            document.getElementById('section-myreviews').classList.remove('hidden');
            document.getElementById('section-myreviews').style.display = 'grid';
        }
    }
    
    /**
     * 리뷰 작성 모달 열기
     */
    function openReviewModal(reservId, storeName) {
        document.getElementById('modal-reservId').value = reservId;
        document.getElementById('modal-storeName').textContent = storeName;
        document.getElementById('modal-review').value = '';
        setRating(5); // 기본 별점 5
        document.getElementById('reviewModal').classList.remove('hidden');
    }
    
    /**
     * 리뷰 작성 모달 닫기
     */
    function closeReviewModal() {
        document.getElementById('reviewModal').classList.add('hidden');
    }
    
    /**
     * 별점 선택
     */
    function setRating(rating) {
        document.getElementById('modal-rating').value = rating;
        const stars = document.querySelectorAll('.star-btn');
        stars.forEach((star, index) => {
            if(index < rating) {
                star.classList.remove('text-slate-200');
                star.classList.add('text-orange-400');
            } else {
                star.classList.remove('text-orange-400');
                star.classList.add('text-slate-200');
            }
        });
    }
    
    /**
     * 리뷰 작성 제출 (AJAX)
     */
    function submitReview() {
        const reservId = document.getElementById('modal-reservId').value;
        const rating = document.getElementById('modal-rating').value;
        const review = document.getElementById('modal-review').value.trim();
        
        // 검증
        if(review.length < 10) {
            alert('리뷰 내용은 최소 10자 이상 입력해주세요.');
            return;
        }
        
        // AJAX 요청
        fetch('${pageContext.request.contextPath}/review/write.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'reservId=' + reservId + '&rating=' + rating + '&review=' + encodeURIComponent(review)
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('리뷰가 작성되었습니다!');
                closeReviewModal();
                location.reload(); // 페이지 새로고침
            } else {
                alert('리뷰 작성 실패: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('네트워크 오류가 발생했습니다.');
        });
    }
    
    /**
     * 리뷰 삭제 (AJAX)
     */
    function deleteReview(reservId) {
        if(!confirm('정말로 이 리뷰를 삭제하시겠습니까?')) {
            return;
        }
        
        fetch('${pageContext.request.contextPath}/review/delete.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'reservId=' + reservId
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('리뷰가 삭제되었습니다.');
                // 카드 제거 애니메이션
                const card = document.getElementById('review-card-' + reservId);
                card.style.opacity = '0';
                card.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    card.remove();
                    // 남은 리뷰 체크
                    const remaining = document.querySelectorAll('[id^="review-card-"]').length;
                    if(remaining === 0) {
                        location.reload();
                    }
                }, 300);
            } else {
                alert('리뷰 삭제 실패: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('네트워크 오류가 발생했습니다.');
        });
    }
</script>