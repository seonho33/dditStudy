<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose>
    <c:when test="${empty unwrittenList}">
        <div class="empty-message">작성 가능한 리뷰가 없습니다.</div>
    </c:when>
    <c:otherwise>
        <c:forEach var="item" items="${unwrittenList}">
            <div class="review-card">
                <div class="store-info">
                    <div class="store-name">${item.storeName}</div>
                    <div class="reserv-date">
                        <fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>
                <div class="reservation-detail">
                    예약 시간: ${item.reservTime} | 인원: ${item.guestCount}명
                </div>
                <div class="review-actions">
                    <button class="btn btn-primary" onclick="openReviewModal(${item.reservId}, '${item.storeName}')">
                        리뷰 작성
                    </button>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>