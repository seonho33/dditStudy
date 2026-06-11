<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!-- 배경 흐림 효과 추가 -->
<div id="backgroundBlur" class="fixed inset-0 bg-slate-900/60 backdrop-blur-md hidden z-50"></div>
	<!-- 메인 컨텐츠  -->
	<div class="animate-fadeIn">

    <div class="flex items-center justify-between mb-8">
        <div>
            <h2 class="text-3xl font-black text-slate-800 tracking-tight">
                <i class="fa-solid fa-utensils mr-3 text-sky-500"></i>
                <c:choose>
                    <c:when test="${not empty menu.menuId}">메뉴 수정</c:when>
                    <c:otherwise>새 메뉴 등록</c:otherwise>
                </c:choose>
            </h2>
            <p class="text-slate-400 font-bold mt-1">대시보드 내에서 안전하게 정보를 처리합니다.</p>
        </div>
        
        <button type="button" 
                onclick="closeModal(); loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)"
                class="px-5 py-2 text-slate-500 hover:text-slate-800 font-bold transition-colors">
            <i class="fa-solid fa-arrow-left mr-2"></i>목록으로 돌아가기
        </button>
    </div>

    <form id="menuDataForm" onsubmit="return false;" class="grid grid-cols-12 gap-8">
        
        <input type="hidden" name="menuId" value="${menu.menuId}">
        <input type="hidden" name="existingPicture" value="${menu.menuPicture}">

        <div class="col-span-12 lg:col-span-7 space-y-6">
            <div class="bg-slate-50 p-8 rounded-3xl border border-slate-100">
                <div class="mb-6">
                    <label class="block text-sm font-black text-slate-700 mb-3">메뉴명</label>
                    <input type="text" name="menuName" value="${menu.menuName}" required
                           class="w-full px-6 py-4 rounded-2xl border border-slate-200 focus:ring-4 focus:ring-sky-100 outline-none text-lg font-semibold">
                </div>

                <div>
                    <label class="block text-sm font-black text-slate-700 mb-3">가격 (원)</label>
                    <div class="relative">
                        <input type="number" name="menuPrice" value="${menu.menuPrice}" required
                               class="w-full px-6 py-4 rounded-2xl border border-slate-200 focus:ring-4 focus:ring-sky-100 outline-none text-lg font-semibold pr-12">
                        <span class="absolute right-5 top-1/2 -translate-y-1/2 font-bold text-slate-400">원</span>
                    </div>
                </div>
            </div>

            <div class="flex gap-4 pt-4">
                <button type="button" 
                        onclick="loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)" 
                        class="flex-1 px-8 py-5 rounded-2xl font-black text-slate-500 bg-white border border-slate-200 hover:bg-slate-50 transition-all">
                    취소
                </button>
                <button type="button" onclick="processMenuData()"
                        class="flex-[2] px-8 py-5 rounded-2xl font-black text-white bg-sky-500 hover:bg-sky-600 shadow-xl shadow-sky-200 transition-all text-lg">
                    <c:choose>
                        <c:when test="${not empty menu.menuId}">정보 수정하기</c:when>
                        <c:otherwise>메뉴 등록하기</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </div>

        <div class="col-span-12 lg:col-span-5">
            <div class="bg-white p-2 rounded-3xl border-2 border-dashed border-slate-200 h-full min-h-[400px] relative group hover:border-sky-400 transition-colors">
                <input type="file" name="menuPicture" id="fileInput" accept="image/*" class="absolute inset-0 opacity-0 cursor-pointer z-10">
                
                <div class="h-full w-full flex flex-col items-center justify-center p-6 text-center">
                    <div id="previewContainer" class="${not empty menu.menuPicture ? '' : 'hidden'} w-full h-full rounded-2xl overflow-hidden shadow-inner">
<img id="imagePreview"
     src="${not empty menu.menuPicture 
           ? pageContext.request.contextPath.concat('/images/upload/menu/').concat(menu.menuPicture) 
           : '#'}"
     class="w-full h-full object-cover">

                    </div>
                    
                    <div id="uploadPrompt" class="${not empty menu.menuPicture ? 'hidden' : ''} space-y-4">
                        <div class="w-20 h-20 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto">
                            <i class="fa-solid fa-image text-3xl"></i>
                        </div>
                        <p class="text-lg font-black text-slate-700">이미지 변경/업로드</p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    document.getElementById('fileInput').addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                document.getElementById('imagePreview').src = e.target.result;
                document.getElementById('previewContainer').classList.remove('hidden');
                document.getElementById('uploadPrompt').classList.add('hidden');
            };
            reader.readAsDataURL(file);
        }
    });
    
    function processMenuData() {
        const form = document.getElementById('menuDataForm');
        const formData = new FormData(form);
        
        // 🔹 menuId 기준으로 수정 / 등록 구분 (기능 유지)
        const isUpdate = form.menuId.value !== "";
        const url = isUpdate
            ? '${pageContext.request.contextPath}/menu/update.do'
            : '${pageContext.request.contextPath}/menu/insert.do';

        // 🔹 SweetAlert 띄우기 전 배경 블러 ON (기존 기능)
        openModal();        

        /* ===============================
           📌 1️⃣ 확인 모달 (question)
           customModal 스타일 이식
           =============================== */
        Swal.fire({
            html: `
                <!-- 🔵 customModal 아이콘 스타일 그대로 -->
                <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-circle-question"></i>
                </div>

                <!-- 제목 -->
                <h2 class="text-3xl font-black text-slate-800 mb-3">
                    ${isUpdate ? '정보를 수정할까요?' : '메뉴를 등록할까요?'}
                </h2>

                <!-- 설명 -->
                <p class="text-slate-500 font-bold text-sm leading-relaxed">
                    확인을 누르면 해당 작업이 즉시 반영됩니다.
                </p>
            `,
            background: '#ffffff',

            // 🔹 customModal 배경 느낌 유지
            backdrop: `
                rgba(15, 23, 42, 0.6)
                fixed
            `,

            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',

            /* 🎨 버튼 / 박스 스타일 */
            customClass: {
                popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100',
                cancelButton:
                    'w-full py-5 px-14 bg-slate-50 text-slate-400 rounded-[22px] font-black text-sm'
            },

            buttonsStyling: false // SweetAlert 기본 버튼 스타일 제거
        }).then((result) => {
            if (result.isConfirmed) {

                /* ===============================
                   📌 2️⃣ 실제 데이터 전송 (기능 그대로)
                   =============================== */
                fetch(url, {
                    method: 'POST',
                    body: formData,
                    headers: { 'X-Requested-With': 'fetch' }
                })
                .then(res => res.text())
                .then(data => {
                    if (data.trim() === "SUCCESS") {

                        /* ===============================
                           📌 3️⃣ 성공 모달
                           =============================== */
                        Swal.fire({
                            html: `
                                <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                                    <i class="fa-solid fa-check"></i>
                                </div>
                                <h2 class="text-3xl font-black text-slate-800 mb-3">
                                    완료
                                </h2>
                                <p class="text-slate-500 font-bold text-sm">
                                    처리가 완료되었습니다.
                                </p>
                            `,
                            background: '#ffffff',
                            showConfirmButton: false,
                            timer: 1300,

                            customClass: {
                                popup: 'rounded-[50px] p-12 shadow-2xl text-center'
                            }
                        }).then(() => {
                            closeModal(); // 🔹 성공 후 블러 해제
                            loadOwnerPage(
                                'menu',
                                '${pageContext.request.contextPath}/menu/list.do',
                                null
                            );
                        });

                    } else {

                        /* ===============================
                           📌 4️⃣ 실패 모달
                           =============================== */
                        Swal.fire({
                            html: `
                                <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                                <h2 class="text-3xl font-black text-slate-800 mb-3">
                                    오류
                                </h2>
                                <p class="text-slate-500 font-bold text-sm">
                                    실패: ${data}
                                </p>
                            `,
                            background: '#ffffff',
                            confirmButtonText: '확인',

                            customClass: {
                                popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                                confirmButton:
                                    'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
                            },

                            buttonsStyling: false
                        }).then(() => {
                            closeModal(); // 🔹 실패 시에도 블러 해제
                            loadOwnerPage(
                                'menu',
                                '${pageContext.request.contextPath}/menu/list.do',
                                null
                            );
                        });
                    }
                });

            } else {
                // 🔹 취소 버튼 클릭 시 블러 효과 제거
                closeModal();
            }
        });
    }


/*     function processMenuData() {
        const form = document.getElementById('menuDataForm');
        const formData = new FormData(form);
        
        // 🔥 여기도 menuId로 수정
        const isUpdate = form.menuId.value !== "";
        const url = isUpdate ? '${pageContext.request.contextPath}/menu/update.do' : '${pageContext.request.contextPath}/menu/insert.do';

        // 모달(SweetAlert) 열기 전 배경 블러 효과 활성화
        openModal();        
        
        Swal.fire({
            title: isUpdate ? '정보를 수정할까요?' : '메뉴를 등록할까요?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#0ea5e9',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                fetch(url, {
                    method: 'POST',
                    body: formData,
                    headers: { 'X-Requested-With': 'fetch' }
                })
                .then(res => res.text())
                .then(data => {
                    if(data.trim() === "SUCCESS") {
                        Swal.fire('완료', '처리가 완료되었습니다.', 'success')
                        .then(() => {
                           	    closeModal(); // 성공 후 블러 효과 제거 
                        		loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)});
                    } else {
                        Swal.fire('오류', '실패: ' + data, 'error')
                        .then(() => {
	                        	closeModal(); // 실패 시에도 블러 효과 제거
	                    		loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)});
                    }
                });
            } else {
                // 취소 버튼 클릭 시 블러 효과 제거
                closeModal();
            }
        });
    } */
    
 	// 🔥 수정: openModal 함수 간소화
    function openModal() {
        const backgroundBlur = document.getElementById('backgroundBlur');
        backgroundBlur.classList.remove('hidden');  // 배경 블러 효과 표시
    }

    // 🔥 수정: closeModal 함수 수정
    function closeModal() {
        const backgroundBlur = document.getElementById('backgroundBlur');
        
        // 배경 블러 효과만 숨기기 (페이지 이동은 버튼에서 처리)
        backgroundBlur.classList.add('hidden');
    }
    	


    
</script>