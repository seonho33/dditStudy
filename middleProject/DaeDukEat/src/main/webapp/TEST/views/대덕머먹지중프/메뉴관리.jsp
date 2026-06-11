<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-center border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Menu List</p>
            <h3 class="text-2xl font-black text-slate-800">메뉴 관리</h3>
        </div>
        <button class="bg-slate-900 text-white px-6 py-3 rounded-2xl font-black text-xs hover:bg-sky-500 transition-all shadow-lg shadow-slate-200">
            <i class="fa-solid fa-plus mr-2"></i> 새 메뉴 등록
        </button>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        <%-- (임시 데이터 1: 판매 중 메뉴) --%>
        <div class="bg-slate-50 p-6 rounded-[30px] border border-slate-100 flex gap-6 relative group transition-all hover:bg-white hover:shadow-xl">
            <div class="w-24 h-24 bg-slate-200 rounded-2xl overflow-hidden shadow-inner">
                <div class="w-full h-full flex items-center justify-center text-slate-400 text-xs">No Image</div>
            </div>
            <div class="flex-1">
                <div class="flex justify-between items-start">
                    <div>
                        <span class="px-2 py-0.5 bg-sky-100 text-sky-600 text-[9px] font-black rounded uppercase">Best</span>
                        <h4 class="text-lg font-black text-slate-800 mt-1">DDM 시그니처 스테이크</h4>
                        <p class="text-xs text-slate-400 font-bold mt-1">최고급 안심과 특제 소스</p>
                    </div>
                    <p class="font-black text-slate-800">38,000원</p>
                </div>
                <div class="flex gap-2 mt-4">
                    <button class="text-[10px] font-black text-slate-400 hover:text-sky-500 transition-colors">수정</button>
                    <button class="text-[10px] font-black text-slate-400 hover:text-red-500 transition-colors">삭제</button>
                    <button class="ml-auto px-3 py-1 bg-white border border-slate-200 rounded-lg text-[10px] font-black text-green-500">판매중</button>
                </div>
            </div>
        </div>

        <%-- (임시 데이터 2: 품절 메뉴) --%>
        <div class="bg-slate-50 p-6 rounded-[30px] border border-slate-100 flex gap-6 opacity-60">
            <div class="w-24 h-24 bg-slate-200 rounded-2xl flex items-center justify-center text-slate-400 text-xs italic">Sold Out</div>
            <div class="flex-1">
                <div class="flex justify-between items-start">
                    <div>
                        <h4 class="text-lg font-black text-slate-800 mt-1">트러플 오일 파스타</h4>
                        <p class="text-xs text-slate-400 font-bold mt-1">풍미 가득한 트러플향</p>
                    </div>
                    <p class="font-black text-slate-800">22,000원</p>
                </div>
                <div class="flex gap-2 mt-4">
                    <button class="text-[10px] font-black text-slate-400">수정</button>
                    <button class="text-[10px] font-black text-slate-400">삭제</button>
                    <button class="ml-auto px-3 py-1 bg-slate-200 rounded-lg text-[10px] font-black text-slate-500 uppercase font-black">Sold Out</button>
                </div>
            </div>
        </div>

    </div>
</div>