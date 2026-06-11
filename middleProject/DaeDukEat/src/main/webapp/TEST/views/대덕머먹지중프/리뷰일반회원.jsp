<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn">
    <div class="flex gap-4 mb-8">
        <button class="px-6 py-2 bg-slate-900 text-white rounded-full text-xs font-black shadow-lg">작성 가능한 리뷰</button>
        <button class="px-6 py-2 bg-white text-slate-400 border border-slate-100 rounded-full text-xs font-bold hover:bg-slate-50">내가 쓴 리뷰</button>
    </div>

    <div class="grid grid-cols-1 gap-4 mb-12">
        <p class="text-[11px] font-black text-orange-400 uppercase tracking-widest ml-2 mb-2">Wait for Review</p>
        
        <%-- (임시 데이터 시작: 나중에 c:forEach로 교체 시 이 영역을 지우세요) --%>
        <div class="bg-white border-2 border-dashed border-slate-100 p-6 rounded-[35px] flex justify-between items-center shadow-sm">
            <div class="flex items-center gap-5">
                <div class="w-16 h-16 bg-slate-100 rounded-2xl flex items-center justify-center text-slate-300 text-2xl">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <div>
                    <p class="text-lg font-black text-slate-800">성수 DDM 키친 (더미)</p>
                    <p class="text-xs text-slate-400 font-bold">2026.01.20 방문</p>
                </div>
            </div>
            <button onclick="openReviewModal('RES_DUMMY_001')" class="bg-orange-500 text-white px-8 py-3 rounded-2xl font-black text-sm shadow-lg shadow-orange-100 hover:scale-105 transition-all">
                리뷰 작성
            </button>
        </div>
        <%-- (임시 데이터 끝) --%>

        <%-- 실 데이터 연동 시 주석 해제 --%>
        <%-- 
        <c:forEach var="visit" items="${unwrittenList}">
            <div class="bg-white border-2 border-dashed border-slate-100 p-6 rounded-[35px] flex justify-between items-center">
                ... (위 더미와 동일 구조) ...
            </div>
        </c:forEach>
        --%>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <p class="col-span-2 text-[11px] font-black text-slate-400 uppercase tracking-widest ml-2 mb-2">My Stories</p>
        
        <%-- (임시 데이터 시작: 나중에 c:forEach로 교체 시 이 영역을 지우세요) --%>
        <div class="bg-white border border-slate-100 p-6 rounded-[35px] shadow-sm hover:shadow-md transition-shadow">
            <div class="flex items-center gap-3 mb-4">
                <div class="flex text-orange-400 text-xs">
                    ★ ★ ★ ★ ★
                </div>
                <span class="text-[10px] font-black text-slate-300">2026.01.15 작성</span>
            </div>
            <p class="text-slate-800 font-bold mb-4 line-clamp-3">"여기 스테이크 진짜 미쳤어요! 분위기도 너무 좋고 직원분들이 너무 친절하셔서 가산점 드리고 싶네요."</p>
            <div class="flex items-center justify-between mt-auto pt-4 border-t border-slate-50">
                <span class="text-xs font-black text-orange-500 tracking-tighter uppercase">강남 DDM 펍</span>
                <button class="text-[10px] font-black text-slate-300 hover:text-red-500">삭제</button>
            </div>
        </div>
        <%-- (임시 데이터 끝) --%>

        <%-- 실 데이터 연동 시 주석 해제 --%>
        <%--
        <c:forEach var="rev" items="${myReviewList}">
            <div class="bg-white border border-slate-100 p-6 rounded-[35px] shadow-sm">
                ... (위 더미와 동일 구조) ...
            </div>
        </c:forEach>
        --%>
    </div>
</div>

<script>
    function openReviewModal(resId) {
        alert("선택된 예약번호 [" + resId + "]에 대한 리뷰 작성 폼을 엽니다.");
    }
</script>