<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="max-w-2xl mx-auto text-center animate-fadeIn">

  <div class="mb-12">
    <span class="text-6xl">🚨</span>
    <h3 class="text-3xl font-black text-slate-800 mt-6 mb-3">
      정말로 사장님 계정을 탈퇴하시나요?
    </h3>
    <p class="text-slate-400 font-bold">
      가게 정보, 메뉴, 예약, 리뷰 데이터가 모두 삭제됩니다.
    </p>
  </div>

  <div class="bg-red-50 rounded-[35px] p-10 text-left border border-red-100 mb-12">
    <h4 class="text-red-500 font-black flex items-center gap-2 mb-6">
      <i class="fa-solid fa-triangle-exclamation"></i> 탈퇴 전 꼭 확인하세요
    </h4>

    <ul class="space-y-4 text-slate-600 font-bold text-sm">
      <li class="flex items-center gap-3">
        <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
        등록된 <b>가게 및 메뉴 정보</b>가 모두 삭제됩니다.
      </li>
      <li class="flex items-center gap-3">
        <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
        진행 중인 <b>예약 내역</b>은 자동 취소됩니다.
      </li>
      <li class="flex items-center gap-3">
        <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
        이 작업은 <b>되돌릴 수 없습니다.</b>
      </li>
    </ul>
  </div>

  <form action="${pageContext.request.contextPath}/deleteOwner.do" method="post" class="flex gap-4 max-w-sm mx-auto">
    <button
      type="button"
      onclick="loadOwnerPage('store','${pageContext.request.contextPath}/store/detail.do', document.querySelector('.nav-link.active'))"
      class="flex-1 py-5 bg-slate-900 text-white rounded-2xl font-black shadow-xl">
      더 운영할게요
    </button>

    <button
      type="submit"
      onclick="return confirm('정말로 탈퇴하시겠습니까?')"
      class="flex-1 py-5 bg-white text-red-400 border border-red-100 rounded-2xl font-black
             hover:bg-red-500 hover:text-white transition-all">
      탈퇴 승인
    </button>
  </form>
</div>
