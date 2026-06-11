<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn">
    <div class="bg-orange-50 rounded-[40px] p-10 border border-orange-100 relative overflow-hidden mb-8">
        <div class="absolute -right-6 -bottom-10 text-orange-100 text-[180px] font-black italic select-none">DDM</div>
        
        <div class="relative z-10 flex items-center gap-8">
            <div class="relative group">
                <div class="w-32 h-32 rounded-[35px] overflow-hidden border-4 border-white shadow-xl bg-white flex items-center justify-center">
                    <c:choose>
                        <c:when test="${not empty memberVO.profile_img}">
                            <img src="${memberVO.profile_img}" id="profile-img-preview" class="w-full h-full object-cover">
                        </c:when>
                        <c:otherwise>
                            <div id="profile-placeholder" class="text-5xl text-orange-200">
                                <i class="fa-solid fa-user-astronaut"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <button onclick="document.getElementById('profile-upload').click()" 
                        class="absolute -bottom-2 -right-2 bg-slate-900 text-white w-10 h-10 rounded-2xl flex items-center justify-center shadow-lg hover:bg-orange-600 transition-all">
                    <i class="fa-solid fa-camera text-sm"></i>
                </button>
                <input type="file" id="profile-upload" class="hidden" accept="image/*" onchange="previewImage(this)">
            </div>
            
            <div class="flex-1">
                <p class="text-[11px] font-black text-orange-400 mb-2 uppercase tracking-[2px]">회원 정보 확인</p>
                <h3 class="text-4xl font-black text-slate-800 mb-2">
                    ${userVO.name}
                    <span class="text-lg font-bold text-orange-500 ml-1">님</span>
                </h3>
                <div class="flex gap-4">
                    <p class="text-slate-500 font-bold">계정 ID : <span class="text-slate-800">${userVO.user_id}</span></p>
                    <div class="w-[1px] h-4 bg-orange-200 self-center"></div>
                    <p class="text-slate-500 font-bold">소속 : <span class="text-orange-600 font-black">${userVO.division}</span></p>
                </div>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-2 gap-6">
        <div class="bg-white border-2 border-slate-50 rounded-3xl p-8 shadow-sm flex justify-between items-center">
            <div>
                <p class="text-[10px] font-black text-slate-400 mb-1 uppercase tracking-widest">생년월일</p>
                <p class="text-2xl font-black text-slate-700">${memberVO.bir}</p>
            </div>
            <div class="text-slate-100 text-3xl"><i class="fa-solid fa-cake-candles"></i></div>
        </div>
        
        <div class="bg-white border-2 border-slate-50 rounded-3xl p-8 shadow-sm flex justify-between items-center">
            <div>
                <p class="text-[10px] font-black text-slate-400 mb-1 uppercase tracking-widest">이메일 주소</p>
                <p class="text-2xl font-black text-slate-700">${memberVO.mail}</p>
            </div>
            <div class="text-slate-100 text-3xl"><i class="fa-solid fa-envelope"></i></div>
        </div>
    </div>

    <div class="mt-8 p-8 bg-slate-50 rounded-3xl flex justify-around items-center border border-slate-100">
        <div class="text-center">
            <p class="text-xs font-bold text-slate-400 uppercase mb-1">나의 쿠폰</p>
            <p class="text-2xl font-black text-slate-800">${couponCount}장</p>
        </div>
        <div class="w-[1px] h-8 bg-slate-200"></div>
        <div class="text-center">
            <p class="text-xs font-bold text-slate-400 uppercase mb-1">작성 리뷰</p>
            <p class="text-2xl font-black text-slate-800">${reviewCount}건</p>
        </div>
    </div>
</div>

<script>
// 이미지 미리보기 함수
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            // 이미지가 이미 있으면 src 교체, 없으면 새로 생성
            let imgPreview = document.getElementById('profile-img-preview');
            const placeholder = document.getElementById('profile-placeholder');
            
            if (!imgPreview) {
                imgPreview = document.createElement('img');
                imgPreview.id = 'profile-img-preview';
                imgPreview.className = 'w-full h-full object-cover';
                placeholder.parentNode.appendChild(imgPreview);
                placeholder.classList.add('hidden');
            }
            
            imgPreview.src = e.target.result;
            
            // 여기서 서버로 이미지를 업로드하는 AJAX 코드를 작성하면 됩니다.
            console.log("파일 업로드 준비 완료:", input.files[0].name);
        };
        
        reader.readAsDataURL(input.files[0]);
    }
}
</script>