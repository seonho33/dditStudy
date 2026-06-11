<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 완료 - D.D.M</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');
        body { font-family: 'Pretendard', sans-serif; background-color: #fefaf8; }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    
    <div class="max-w-[600px] w-full mx-4">
        <div class="bg-white rounded-[32px] shadow-2xl p-12 text-center">
            
            <div class="mb-8">
                <i class="fa-solid fa-circle-check text-green-500 text-8xl"></i>
            </div>
            
            <h1 class="text-4xl font-black mb-4 text-gray-900">예약 완료!</h1>
            <p class="text-gray-500 mb-12">예약이 성공적으로 완료되었습니다.</p>
            
            <div class="bg-gray-50 rounded-2xl p-8 mb-8 text-left">
                <div class="flex justify-between mb-4 pb-4 border-b">
                    <span class="text-gray-500">예약번호</span>
                    <span class="font-bold">${reservId}</span>
                </div>
                <div class="flex justify-between mb-4 pb-4 border-b">
                    <span class="text-gray-500">가게</span>
                    <span class="font-bold">${store.storeName}</span>
                </div>
                <div class="flex justify-between mb-4 pb-4 border-b">
                    <span class="text-gray-500">예약시간</span>
                    <span class="font-bold">${reservation.reservTime}</span>
                </div>
                <div class="flex justify-between mb-4 pb-4 border-b">
                    <span class="text-gray-500">인원</span>
                    <span class="font-bold">${reservation.guestCount}명</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-500">결제금액</span>
                    <span class="font-bold text-orange-500">
                        <fmt:formatNumber value="${reservation.amount}" pattern="#,###"/>원
                    </span>
                </div>
            </div>
            
            <div class="flex gap-4">
                <button onclick="location.href='${pageContext.request.contextPath}/main.do'" 
                        class="flex-1 py-4 bg-gray-200 text-gray-700 rounded-2xl font-bold hover:bg-gray-300">
                    메인으로
                </button>
<button
  onclick="location.href='${pageContext.request.contextPath}/mypage.do?tab=resv'"
  class="flex-1 py-4 bg-orange-500 text-white rounded-2xl font-bold hover:bg-orange-600">
  예약 확인
</button>

            </div>
        </div>
    </div>

</body>
</html>
