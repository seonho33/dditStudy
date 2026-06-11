<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- ============================================================ -->
<!-- [VIEW LAYER] 예약 상세 정보 (공유 링크용)                   -->
<!-- ============================================================ -->
<!-- AUTHOR     : Senior Architect                                -->
<!-- DATE       : 2025-01-23                                      -->
<!-- CONTROLLER : ViewReservationController.java                  -->
<!-- URL        : /reservation/view.do?id=R{reservId}             -->
<!-- DATA       : reservation (ReservationVO)                     -->
<!-- PURPOSE    : 예약 공유 링크를 통한 예약 정보 조회           -->
<!-- ============================================================ -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="D.D.M 예약 상세 정보">
    <title>예약 상세 - D.D.M</title>
    
    <%-- Tailwind CSS CDN --%>
    <script src="https://cdn.tailwindcss.com"></script>
    
    <%-- Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeIn {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body class="bg-slate-50 min-h-screen">

    <div class="container mx-auto px-4 py-12 max-w-4xl">
        
        <%-- ==================== 헤더 ==================== --%>
        <div class="text-center mb-12 animate-fadeIn">
            <div class="inline-flex items-center gap-3 mb-4">
                <i class="fa-solid fa-utensils text-4xl text-orange-500"></i>
                <h1 class="text-4xl font-black text-slate-800 italic">D.D.M</h1>
            </div>
            <p class="text-slate-400 text-sm font-medium">RESERVATION DETAILS</p>
        </div>

        <%-- ==================== 예약 정보 카드 ==================== --%>
        <c:if test="${not empty reservation}">
            <%-- 
                DATA SOURCE: ViewReservationController → service.getReservationDetail()
                ReservationVO 필드 (STORE, PAYMENT JOIN 포함):
                - reservId: 예약 ID
                - storeName: 가게명
                - storeAddr: 가게 주소
                - storePhone: 가게 전화번호
                - reservTime: 예약 시간
                - guestCount: 인원 수
                - reservStatus: 예약 상태
                - amount: 결제 예상 금액
                - note: 요청사항
                - payStatus: 결제 상태 (nullable)
                - createDate: 예약 생성일자
            --%>
            <div class="bg-white rounded-[40px] shadow-2xl overflow-hidden animate-fadeIn">
                
                <%-- 상단: 상태 표시 --%>
                <div class="p-8 bg-gradient-to-r from-slate-900 to-slate-800 text-white relative overflow-hidden">
                    <div class="absolute -right-20 -top-20 text-white/5 text-9xl font-black italic">DDM</div>
                    
                    <div class="relative z-10">
                        <div class="flex items-center gap-2 mb-4">
                            <span class="w-3 h-3 ${reservation.reservStatus eq '승인' ? 'bg-green-400' : reservation.reservStatus eq '대기' ? 'bg-yellow-400' : 'bg-red-400'} rounded-full animate-pulse"></span>
                            <p class="text-xs font-black text-orange-500 tracking-widest uppercase">
                                <c:out value="${reservation.reservStatus}"/>
                            </p>
                        </div>
                        
                        <h2 class="text-4xl font-black mb-2">
                            <c:out value="${reservation.storeName}"/>
                        </h2>
                        
                        <p class="text-sm opacity-60 font-mono">
                            RESERVATION ID: R${reservation.reservId}
                        </p>
                    </div>
                </div>

                <%-- 중간: 예약 상세 정보 --%>
                <div class="p-8 space-y-6">
                    
                    <%-- 예약 시간 & 인원 --%>
                    <div class="flex items-start gap-6">
                        <div class="w-16 h-16 bg-orange-50 rounded-2xl flex items-center justify-center flex-shrink-0">
                            <i class="fa-solid fa-calendar-check text-2xl text-orange-500"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Reservation Time</p>
                            <p class="text-2xl font-black text-slate-800">${reservation.reservTime}</p>
                            <p class="text-sm text-slate-500 mt-1">
                                <i class="fa-solid fa-users mr-2"></i>${reservation.guestCount}명
                            </p>
                        </div>
                    </div>

                    <hr class="border-slate-100">

                    <%-- 가게 정보 --%>
                    <div class="flex items-start gap-6">
                        <div class="w-16 h-16 bg-slate-50 rounded-2xl flex items-center justify-center flex-shrink-0">
                            <i class="fa-solid fa-store text-2xl text-slate-400"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Store Information</p>
                            <p class="text-lg font-black text-slate-800 mb-2">
                                <c:out value="${reservation.storeName}"/>
                            </p>
                            <p class="text-sm text-slate-500">
                                <i class="fa-solid fa-location-dot mr-2"></i>
                                <c:out value="${reservation.storeAddr}"/>
                            </p>
                            <p class="text-sm text-slate-500 mt-1">
                                <i class="fa-solid fa-phone mr-2"></i>
                                ${reservation.storePhone}
                            </p>
                        </div>
                    </div>

                    <hr class="border-slate-100">

                    <%-- 결제 정보 --%>
                    <div class="flex items-start gap-6">
                        <div class="w-16 h-16 bg-blue-50 rounded-2xl flex items-center justify-center flex-shrink-0">
                            <i class="fa-solid fa-credit-card text-2xl text-blue-500"></i>
                        </div>
                        <div class="flex-1">
                            <p class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Payment Information</p>
                            <p class="text-2xl font-black text-slate-800">
                                <fmt:formatNumber value="${reservation.amount}" type="number" groupingUsed="true"/>원
                            </p>
                            <c:if test="${not empty reservation.payStatus}">
                                <p class="text-sm text-slate-500 mt-1">
                                    상태: <span class="font-bold"><c:out value="${reservation.payStatus}"/></span>
                                </p>
                            </c:if>
                        </div>
                    </div>

                    <%-- 요청사항 (있는 경우만) --%>
                    <c:if test="${not empty reservation.note}">
                        <hr class="border-slate-100">
                        <div class="flex items-start gap-6">
                            <div class="w-16 h-16 bg-purple-50 rounded-2xl flex items-center justify-center flex-shrink-0">
                                <i class="fa-solid fa-message text-2xl text-purple-500"></i>
                            </div>
                            <div class="flex-1">
                                <p class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-1">Special Request</p>
                                <p class="text-sm text-slate-700 leading-relaxed">
                                    <c:out value="${reservation.note}"/>
                                </p>
                            </div>
                        </div>
                    </c:if>

                    <%-- 예약 생성일 --%>
                    <hr class="border-slate-100">
                    <div class="text-center py-4">
                        <p class="text-xs text-slate-400 font-medium">
                            예약 생성일: <fmt:formatDate value="${reservation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </p>
                    </div>

                </div>

                <%-- 하단: 액션 버튼 --%>
                <div class="p-8 bg-slate-50 border-t border-slate-100">
                    <div class="flex gap-4">
                        <a href="${pageContext.request.contextPath}/" 
                           class="flex-1 bg-orange-500 text-white py-4 rounded-2xl font-black text-center hover:bg-orange-600 transition-all shadow-lg">
                            <i class="fa-solid fa-home mr-2"></i>홈으로 이동
                        </a>
                        <button 
                            onclick="window.print()" 
                            class="flex-1 bg-slate-200 text-slate-700 py-4 rounded-2xl font-bold text-center hover:bg-slate-300 transition-all">
                            <i class="fa-solid fa-print mr-2"></i>예약 정보 인쇄
                        </button>
                    </div>
                </div>

            </div>
        </c:if>

        <%-- ==================== 예약 정보 없음 ==================== --%>
        <c:if test="${empty reservation}">
            <div class="bg-white rounded-[40px] shadow-2xl p-12 text-center animate-fadeIn">
                <i class="fa-solid fa-exclamation-circle text-6xl text-slate-300 mb-6"></i>
                <h2 class="text-2xl font-black text-slate-800 mb-2">예약 정보를 찾을 수 없습니다</h2>
                <p class="text-slate-400 mb-8">올바른 예약 링크인지 확인해주세요.</p>
                <a href="${pageContext.request.contextPath}/" 
                   class="inline-block bg-orange-500 text-white px-8 py-4 rounded-2xl font-black hover:bg-orange-600 transition-all">
                    홈으로 이동
                </a>
            </div>
        </c:if>

    </div>

</body>
</html>