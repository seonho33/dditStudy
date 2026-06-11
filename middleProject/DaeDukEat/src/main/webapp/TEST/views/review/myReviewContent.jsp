<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose>
    <%-- 컨트롤러에서 담은 이름인 myReviewList가 비어있는지 확인 --%>
    <c:when test="${empty myReviewList}">
        <div class="empty-message" style="text-align:center; padding:50px; color:#999;">
            <p>아직 작성하신 리뷰가 없습니다.</p>
            <p>맛있는 음식을 드시고 첫 리뷰를 남겨보세요!</p>
        </div>
    </c:when>
    <c:otherwise>
        <%-- 리뷰 목록 반복 시작 --%>
        <c:forEach var="item" items="${myReviewList}">
            <div class="review-card">
                <div class="store-info">
                    <div class="store-name">${item.storeName}</div>
                    <div class="reserv-date">
                        <fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>
                
                <%-- 별점 표시 (점수에 따라 채워진 별/빈 별 출력) --%>
                <div class="rating-stars" style="color: #FFD700; font-size: 1.2rem; margin: 5px 0;">
                    <c:forEach begin="1" end="${item.rating}">★</c:forEach>
                    <c:forEach begin="${item.rating + 1}" end="5">☆</c:forEach>
                    <span style="color: #666; font-size: 0.9rem; margin-left: 5px;">(${item.rating}점)</span>
                </div>
                
                <%-- 리뷰 본문 --%>
                <div class="review-text" style="margin: 10px 0; line-height: 1.5; color: #444;">
                    ${item.review}
                </div>
                
                <%-- 리뷰 이미지가 있을 경우에만 표시 --%>
                <c:if test="${not empty item.reviewPicture}">
                    <div class="review-image" style="margin-top: 10px;">
                        <img src="${pageContext.request.contextPath}${item.reviewPicture}" 
                             alt="리뷰 사진" 
                             style="max-width: 200px; border-radius: 5px; border: 1px solid #eee;">
                    </div>
                </c:if>
                
                <div class="review-actions" style="margin-top: 15px; border-top: 1px dashed #eee; padding-top: 10px;">
                    <%-- 삭제 버튼 (reservId를 인자로 전달) --%>
                    <button class="btn btn-danger" 
                            style="background-color: #ff4d4d; color: white; border: none; padding: 5px 12px; border-radius: 4px; cursor: pointer;"
                            onclick="deleteReview(${item.reservId})">
                        삭제하기
                    </button>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>


