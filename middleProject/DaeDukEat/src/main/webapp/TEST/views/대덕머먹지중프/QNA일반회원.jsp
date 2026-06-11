<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn">
    <div class="flex justify-between items-center mb-8">
        <h3 class="text-xl font-black text-slate-800 italic">MY Q&A LIST</h3>
        <button class="bg-slate-900 text-white px-6 py-2 rounded-xl font-black text-xs hover:bg-orange-600 transition-all">새 문의하기</button>
    </div>

    <div class="space-y-4">
        
        <%-- (임시 데이터 1: 답변 완료 케이스 - 나중에 지우세요) --%>
        <div class="group bg-white border border-slate-100 p-6 rounded-[30px] hover:border-orange-200 transition-all hover:shadow-xl hover:shadow-orange-500/5 relative overflow-hidden">
            <div class="flex justify-between items-start">
                <div>
                    <div class="flex items-center gap-3 mb-2">
                        <span class="px-3 py-1 bg-orange-500 text-white text-[10px] font-black rounded-lg shadow-lg shadow-orange-200 uppercase">Answered</span>
                        <span class="text-[11px] font-bold text-slate-300">2026.01.21</span>
                    </div>
                    <h4 class="text-lg font-black text-slate-800 mb-1">포인트 적립 관련 문의 (더미)</h4>
                    <p class="text-sm text-slate-500 font-medium">어제 성수점에서 결제했는데 포인트 적립이 안 된 것 같아요.</p>
                </div>
                <button class="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center text-slate-300 group-hover:bg-orange-50 group-hover:text-orange-500 transition-colors">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
            </div>
            <div class="mt-5 p-5 bg-orange-50/50 rounded-2xl border border-orange-100/50">
                <p class="text-[10px] font-black text-orange-400 mb-1 uppercase">D.D.M Official Reply</p>
                <p class="text-sm text-slate-700 font-bold">안녕하세요 마스터님! 누락된 포인트는 확인 후 즉시 적립해 드렸습니다. 이용에 불편을 드려 죄송합니다.</p>
            </div>
        </div>

        <%-- (임시 데이터 2: 답변 대기 케이스 - 나중에 지우세요) --%>
        <div class="group bg-white border border-slate-100 p-6 rounded-[30px] hover:border-orange-200 transition-all hover:shadow-xl hover:shadow-orange-500/5 relative overflow-hidden">
            <div class="flex justify-between items-start">
                <div>
                    <div class="flex items-center gap-3 mb-2">
                        <span class="px-3 py-1 bg-slate-100 text-slate-400 text-[10px] font-black rounded-lg uppercase">Waiting</span>
                        <span class="text-[11px] font-bold text-slate-300">2026.01.21</span>
                    </div>
                    <h4 class="text-lg font-black text-slate-800 mb-1">단체 예약 문의 (더미)</h4>
                    <p class="text-sm text-slate-500 font-medium">다음 주 금요일 15명 단체 예약 가능한가요?</p>
                </div>
                <button class="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center text-slate-300 group-hover:bg-orange-50 group-hover:text-orange-500 transition-colors">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
            </div>
        </div>
        <%-- (임시 데이터 끝) --%>

        <%-- 🔗 실제 데이터 연동 시 이 영역의 주석을 해제하고 위 더미를 지우세요 --%>
        <%--
        <c:forEach var="qna" items="${qnaList}">
            <div class="group bg-white border border-slate-100 p-6 rounded-[30px] ...">
                ... (기존 구조와 동일) ...
            </div>
        </c:forEach>
        --%>

        <%-- 데이터가 없을 때 표시 --%>
        <c:if test="${empty qnaList && empty dummyData}"> <%-- 테스트를 위해 empty dummyData 추가 --%>
            <div class="py-20 text-center">
                <i class="fa-solid fa-comments-slash text-5xl text-slate-100 mb-4"></i>
                <p class="text-slate-400 font-bold">등록된 문의 내역이 없습니다.</p>
            </div>
        </c:if>
    </div>
</div>