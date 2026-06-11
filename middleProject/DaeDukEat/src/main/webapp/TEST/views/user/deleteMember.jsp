<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.user.vo.UserVO" %>
<%
    UserVO userVO = (UserVO) request.getAttribute("userVO");
    
    if (userVO == null) {
        userVO = (UserVO) session.getAttribute("loginUser");
    }
    
    String userName = "회원";
    String userId = "";
    
    if (userVO != null) {
        if (userVO.getName() != null) {
            userName = userVO.getName();
        }
        if (userVO.getUserId() != null) {
            userId = userVO.getUserId();
        }
    }
%>

<div class="max-w-2xl mx-auto text-center animate-fadeIn">
    <div class="mb-10">
        <span class="text-6xl">😢</span>
        <h3 class="text-3xl font-black text-slate-800 mt-6 mb-2">정말로 탈퇴하시나요?</h3>
        <p class="text-slate-400 font-medium">D.D.M과 함께한 모든 데이터가 삭제됩니다.</p>
    </div>

    <% if (request.getAttribute("msg") != null) { %>
        <div class="bg-red-100 text-red-600 p-4 rounded-2xl mb-6 font-bold">
            <%= request.getAttribute("msg") %>
        </div>
    <% } %>

    <div class="bg-red-50 rounded-[40px] p-10 text-left border border-red-100 mb-10">
        <h4 class="text-red-500 font-black flex items-center gap-2 mb-6">
            <i class="fa-solid fa-triangle-exclamation"></i>
            탈퇴 전 꼭 확인해주세요!
        </h4>
        <ul class="space-y-4 text-slate-600 font-bold text-sm">
            <li class="flex items-center gap-3">
                <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
                <b><%= userName %></b> (<%= userId %>) 님의 모든 개인정보가 삭제됩니다.
            </li>
            <li class="flex items-center gap-3">
                <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
                작성하신 모든 리뷰와 활동 내역이 삭제됩니다.
            </li>
            <li class="flex items-center gap-3">
                <div class="w-1.5 h-1.5 bg-red-400 rounded-full"></div>
                보유하신 쿠폰과 포인트가 모두 소멸됩니다.
            </li>
        </ul>
    </div>

    <form action="<%=request.getContextPath()%>/DeleteMember.do"
      method="post"
      onsubmit="return confirm('정말 탈퇴하시겠습니까?');"
      class="flex gap-4 max-w-sm mx-auto">

  <button type="button" onclick="loadPage('info', '<%=request.getContextPath()%>/SelectOne.do', document.querySelector('.nav-item'))" class="flex-1 py-5 bg-slate-900 text-white rounded-2xl font-black shadow-xl">
            더 써볼래요
        </button>
    <button type="submit"
            class="flex-1 py-5 bg-white text-red-400 border border-red-100 rounded-2xl font-black hover:bg-red-500 hover:text-white transition-all">
        탈퇴 승인
    </button>
</form>

</div>