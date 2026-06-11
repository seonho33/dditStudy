<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn p-2">
    <div class="bg-white rounded-[40px] p-10 border-[3px] border-orange-200 relative overflow-hidden mb-8 shadow-sm">
        <div class="absolute -right-6 -bottom-10 text-orange-50 text-[180px] font-black italic select-none leading-none opacity-50">DDM</div>
        
        <div class="relative z-10 flex items-center gap-10">
            <div class="relative">
                <div class="w-36 h-36 rounded-[42px] p-1 bg-orange-200 shadow-md">
                    <div class="w-full h-full rounded-[38px] overflow-hidden border-[5px] border-white bg-slate-50 flex items-center justify-center">
                        <c:choose>
                          <c:when test="${not empty memberVO.profileImg}">
                            <img src="${pageContext.request.contextPath}/images/upload/profile/${memberVO.profileImg}"
                                 id="profile-img-preview"
                                 class="w-full h-full object-cover"
                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-store.png';">
                          </c:when>
                          <c:otherwise>
                            <div id="profile-placeholder" class="text-6xl text-orange-200">
                              <i class="fa-solid fa-user-astronaut"></i>
                            </div>
                          </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="flex-1">
                <p class="text-[12px] font-black text-orange-400 mb-2 uppercase tracking-[3px]">Member Profile</p>
                <h3 class="text-5xl font-black text-slate-800 mb-4 tracking-tight">
                    ${userVO.name}
                    <span class="text-xl font-bold text-orange-500 ml-1">님</span>
                </h3>
                
                <div class="inline-flex items-center bg-orange-50/50 px-5 py-2.5 rounded-2xl border-2 border-orange-100 shadow-sm transition-all hover:bg-orange-50 group">
                    <div class="flex items-center whitespace-nowrap">
                        <span class="text-slate-400 font-bold text-sm mr-2 uppercase tracking-tighter">ID</span>
                        <span class="text-slate-800 font-black text-sm">${userVO.userId}</span>
                    </div>
                    
                    <div class="w-[1px] h-3 bg-orange-200 mx-4"></div>
                    
                    <div class="flex items-center whitespace-nowrap text-sm">
                        <span class="text-slate-400 font-bold mr-2 uppercase tracking-tighter">소속</span>
                        <span class="text-slate-500 font-bold mr-1.5">${memberVO.userNo}</span>
                        <span class="text-orange-600 font-black px-2 py-0.5 bg-white rounded-lg border border-orange-100 shadow-sm group-hover:bg-orange-600 group-hover:text-white transition-colors">
                            ${userVO.division}
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <div class="bg-white border-[3px] border-orange-200 rounded-[35px] p-8 shadow-sm flex justify-between items-center transition-all hover:border-orange-300 hover:bg-orange-50/30 group">
            <div>
                <p class="text-[11px] font-black text-slate-400 mb-1 uppercase tracking-widest">Birthday</p>
                <p class="text-2xl font-black text-slate-700">${memberVO.userBir}</p>
            </div>
            <div class="text-orange-200 text-3xl group-hover:text-orange-400 group-hover:scale-110 transition-all">
                <i class="fa-solid fa-cake-candles"></i>
            </div>
        </div>
        
        <div class="bg-white border-[3px] border-orange-200 rounded-[35px] p-8 shadow-sm flex justify-between items-center transition-all hover:border-orange-300 hover:bg-orange-50/30 group">
            <div>
                <p class="text-[11px] font-black text-slate-400 mb-1 uppercase tracking-widest">Email Address</p>
                <p class="text-2xl font-black text-slate-700">${memberVO.userMail}</p>
            </div>
            <div class="text-orange-200 text-3xl group-hover:text-orange-400 group-hover:scale-110 transition-all">
                <i class="fa-solid fa-envelope"></i>
            </div>
        </div>
    </div>

    <div class="mt-8 bg-white border-[3px] border-orange-200 rounded-[35px] p-10 flex justify-around items-center shadow-sm">
        <div class="text-center group">
            <p class="text-xs font-bold text-slate-400 uppercase mb-2 tracking-widest">나의 쿠폰</p>
            <p class="text-3xl font-black text-slate-800 group-hover:text-orange-500 transition-colors">${couponCount} <span class="text-sm font-bold text-slate-400">장</span></p>
        </div>
        <div class="w-[1px] h-10 bg-orange-100"></div>
        <div class="text-center group">
            <p class="text-xs font-bold text-slate-400 uppercase mb-2 tracking-widest">작성 리뷰</p>
            <p class="text-3xl font-black text-slate-800 group-hover:text-orange-500 transition-colors">${reviewCount} <span class="text-sm font-bold text-slate-400">건</span></p>
        </div>
    </div>
</div>