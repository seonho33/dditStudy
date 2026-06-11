<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Store Operations</p>
            <h3 class="text-2xl font-black text-slate-800">가게 정보 설정</h3>
        </div>
        <div class="flex bg-slate-100 p-1 rounded-xl">
            <button type="button" onclick="setStatus('ON')" id="status-on" class="px-6 py-2 rounded-lg text-xs font-black bg-green-500 text-white shadow-sm transition-all">영업중</button>
            <button type="button" onclick="setStatus('OFF')" id="status-off" class="px-6 py-2 rounded-lg text-xs font-black text-slate-400 transition-all">준비중</button>
        </div>
    </div>

    <form action="updateStore.do" method="post" enctype="multipart/form-data" class="grid grid-cols-2 gap-x-12 gap-y-8">
        
        <div class="space-y-6">
            <h4 class="text-sm font-black text-slate-800 border-l-4 border-sky-500 pl-3">가게 사진 관리 (최대 4장)</h4>
            
            <div class="grid grid-cols-2 gap-4">
                <c:forEach var="i" begin="1" end="4">
                    <c:set var="imgKey" value="shop_img${i}" />
                    <c:set var="imgPath" value="${shopDTO[imgKey]}" />

                    <div onclick="document.getElementById('file${i}').click()" 
                         class="relative group aspect-video bg-slate-50 rounded-2xl overflow-hidden border-2 border-dashed border-slate-200 flex items-center justify-center cursor-pointer hover:border-sky-500 transition-all shadow-sm">
                        
                        <img id="preview${i}" src="${imgPath}" 
                             class="absolute inset-0 w-full h-full object-cover ${empty imgPath ? 'hidden' : ''}">
                        
                        <div id="plus${i}" class="text-center ${not empty imgPath ? 'hidden' : ''}">
                            <i class="fa-solid fa-camera text-slate-300 text-2xl mb-1"></i>
                            <p class="text-[10px] font-bold text-slate-400">사진 ${i} 추가</p>
                        </div>

                        <input type="file" name="file${i}" id="file${i}" class="hidden" accept="image/*" onchange="readURL(this, ${i})">
                    </div>
                </c:forEach>
            </div>
            <p class="text-[10px] text-slate-400 ml-2 font-medium italic">* 이미지를 클릭하면 사진을 변경할 수 있습니다.</p>

            <div class="pt-4">
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">가게 이름 (Shop Name)</label>
                <input type="text" name="shop_name" value="${shopDTO.shop_name}" placeholder="가게명을 입력하세요" 
                       class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 focus:ring-2 focus:ring-sky-500/20 outline-none transition-all">
            </div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">카테고리</label>
                <select name="shop_category" class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none appearance-none">
                    <option value="steak" ${shopDTO.shop_category == 'steak' ? 'selected' : ''}>스테이크/양식</option>
                    <option value="pub" ${shopDTO.shop_category == 'pub' ? 'selected' : ''}>펍/바</option>
                    <option value="cafe" ${shopDTO.shop_category == 'cafe' ? 'selected' : ''}>카페/디저트</option>
                    <option value="korean" ${shopDTO.shop_category == 'korean' ? 'selected' : ''}>한식/다이닝</option>
                </select>
            </div>
        </div>

        <div class="space-y-6">
            <h4 class="text-sm font-black text-slate-800 border-l-4 border-sky-500 pl-3">상세 운영 정보</h4>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">운영 시간</label>
                    <input type="text" name="shop_time" value="${shopDTO.shop_time}" 
                           class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
                </div>
                <div>
                    <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">기본 예약금</label>
                    <div class="relative">
                        <input type="number" name="shop_deposit" value="${shopDTO.shop_deposit}" 
                               class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none pr-10">
                        <span class="absolute right-4 top-4 font-bold text-slate-400">원</span>
                    </div>
                </div>
            </div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">가게 주소</label>
                <div class="flex gap-2 mb-2">
                    <input type="text" name="shop_addr" value="${shopDTO.shop_addr}" 
                           class="flex-1 p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
                    <button type="button" class="px-6 bg-slate-800 text-white rounded-2xl font-black text-xs">검색</button>
                </div>
                <input type="text" name="shop_addr_detail" value="${shopDTO.shop_addr_detail}" placeholder="상세주소를 입력하세요" 
                       class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
            </div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">가게 소개 (Introduction)</label>
                <textarea name="shop_content" rows="6" 
                          class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 focus:ring-2 focus:ring-sky-500/20 outline-none resize-none transition-all">${shopDTO.shop_content}</textarea>
            </div>

            <div class="flex gap-4 pt-4">
                <button type="reset" class="flex-1 py-5 bg-slate-100 text-slate-400 rounded-2xl font-black hover:bg-slate-200 transition-all">초기화</button>
                <button type="submit" class="flex-[2] py-5 bg-sky-500 text-white rounded-2xl font-black shadow-lg shadow-sky-100 hover:bg-sky-600 transition-all active:scale-95 text-lg">
                    저장하고 반영하기
                </button>
            </div>
        </div>
    </form>
</div>

<script>
    function readURL(input, num) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                const preview = document.getElementById('preview' + num);
                const plus = document.getElementById('plus' + num);
                
                // 이미지 데이터 바인딩
                preview.src = e.target.result;
                preview.classList.remove('hidden'); // 이미지 보이기
                plus.classList.add('hidden');       // 아이콘 숨기기
            };
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    function setStatus(status) {
        const onBtn = document.getElementById('status-on');
        const offBtn = document.getElementById('status-off');
        
        if(status === 'ON') {
            onBtn.className = 'px-6 py-2 rounded-lg text-xs font-black bg-green-500 text-white shadow-sm transition-all';
            offBtn.className = 'px-6 py-2 rounded-lg text-xs font-black text-slate-400 transition-all';
        } else {
            onBtn.className = 'px-6 py-2 rounded-lg text-xs font-black text-slate-400 transition-all';
            offBtn.className = 'px-6 py-2 rounded-lg text-xs font-black bg-red-500 text-white shadow-sm transition-all';
        }
    }
</script>