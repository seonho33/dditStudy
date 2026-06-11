<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 배경 흐림 효과 추가 -->
<div id="backgroundBlur" class="fixed inset-0 bg-slate-900/60 backdrop-blur-md hidden z-50"></div>

<div class="animate-fadeIn space-y-8">
    <div class="flex justify-between items-end border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Store Operations</p>
            <h3 class="text-2xl font-black text-slate-800">가게 정보 설정</h3>
        </div>

    </div>

    <form id="storeUpdateForm" enctype="multipart/form-data" class="grid grid-cols-2 gap-x-12 gap-y-8">
        
        <div class="space-y-6">
            <h4 class="text-sm font-black text-slate-800 border-l-4 border-sky-500 pl-3">가게 대표 사진</h4>
            
            <div onclick="document.getElementById('storeImage').click()" 
                 class="relative group aspect-video bg-slate-50 rounded-2xl overflow-hidden border-2 border-dashed border-slate-200 flex items-center justify-center cursor-pointer hover:border-sky-500 transition-all shadow-sm">
                
<img id="imagePreview"
     src="${not empty shopDTO.storePicture ? pageContext.request.contextPath.concat('/images/upload/store/').concat(shopDTO.storePicture) : ''}"
     class="absolute inset-0 w-full h-full object-cover ${empty shopDTO.storePicture ? 'hidden' : ''}">

                
<div id="imagePlaceholder" class="text-center ${not empty shopDTO.storePicture ? 'hidden' : ''}">

                    <i class="fa-solid fa-camera text-slate-300 text-4xl mb-2"></i>
                    <p class="text-xs font-bold text-slate-400">대표 사진 추가</p>
                    <p class="text-[10px] text-slate-300 mt-1">클릭하여 이미지 선택</p>
                </div>

                <input type="file" name="storeImage" id="storeImage" class="hidden" 
                       accept="image/*" onchange="previewImage(this)">
            </div>
            <p class="text-[10px] text-slate-400 ml-2 font-medium italic">
                이미지를 클릭하면 사진을 변경할 수 있습니다. (최대 10MB)
            </p>

            <div class="pt-4">
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
                    가게 이름 (Shop Name)
                </label>
                <input type="text" name="storeName" value="${shopDTO.storeName}" 
                       placeholder="가게명을 입력하세요" required
                       class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 focus:ring-2 focus:ring-sky-500/20 outline-none transition-all">
            </div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
                    카테고리
                </label>
                <select name="category" 
                        class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none appearance-none cursor-pointer">
                    <option value="한식" ${shopDTO.category == '한식' ? 'selected' : ''}>한식/다이닝</option>
                    <option value="양식" ${shopDTO.category == '양식' ? 'selected' : ''}>스테이크/양식</option>
                    <option value="일식" ${shopDTO.category == '일식' ? 'selected' : ''}>일식/스시</option>
                    <option value="중식" ${shopDTO.category == '중식' ? 'selected' : ''}>중식</option>
                    <option value="카페" ${shopDTO.category == '카페' ? 'selected' : ''}>카페/디저트</option>
                    <option value="펍" ${shopDTO.category == '펍' ? 'selected' : ''}>펍/바</option>
                </select>
            </div>
        </div>

        <div class="space-y-6">
            <h4 class="text-sm font-black text-slate-800 border-l-4 border-sky-500 pl-3">상세 운영 정보</h4>

<div class="grid grid-cols-2 gap-4">
    <!-- 운영 시간 -->
    <div>
        <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
            운영 시간
        </label>
        <input type="text" name="operationHours" value="${shopDTO.operationHours}"
               placeholder="예: 11:00 - 22:00"
               class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
    </div>

    <!-- 가게 전화번호 ✅ 추가 -->
    <div>
        <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
            가게 전화번호
        </label>
        <input type="text" name="storePhone" value="${shopDTO.storePhone}"
               placeholder="예: 042-123-4567"
               class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
    </div>
</div>

<!-- 기본 예약금은 아래로 내려서 한 줄로 깔끔하게 -->
<div>
    <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
        기본 예약금
    </label>
    <div class="relative">
        <input type="number" name="deposit" value="${shopDTO.deposit}" min="0" step="1000"
               class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none pr-10">
        <span class="absolute right-4 top-4 font-bold text-slate-400">원</span>
    </div>
</div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
                    가게 주소
                </label>
                <div class="flex gap-2 mb-2">
                    <input type="text" name="storeAddr" id="storeAddr" value="${shopDTO.storeAddr}" 
                           placeholder="주소를 입력하세요" required
                           class="flex-1 p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
                    <button type="button" onclick="alert('주소 검색 기능 준비중')" 
                            class="px-6 bg-slate-800 text-white rounded-2xl font-black text-xs hover:bg-slate-700 transition-all">
                        검색
                    </button>
                </div>
                <input type="text" name="storeAddr2" value="${shopDTO.storeAddr2}" 
                       placeholder="상세주소를 입력하세요" 
                       class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none">
            </div>

            <div>
                <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">
                    가게 소개 (Introduction)
                </label>
                <textarea name="storeContent" rows="6" 
                          placeholder="가게를 소개하는 글을 작성해주세요."
                          class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 focus:ring-2 focus:ring-sky-500/20 outline-none resize-none transition-all">${shopDTO.storeContent}</textarea>
            </div>

            <div class="flex gap-4 pt-4">
                <button type="reset" 
                        class="flex-1 py-5 bg-slate-100 text-slate-400 rounded-2xl font-black hover:bg-slate-200 transition-all">
                    초기화
                </button>
                <button type="button" onclick="saveStoreInfo()" 
                        class="flex-[2] py-5 bg-sky-500 text-white rounded-2xl font-black shadow-lg shadow-sky-100 hover:bg-sky-600 transition-all active:scale-95 text-lg">
                    저장
                </button>
            </div>
        </div>
    </form>
</div>

<script>

function saveStoreInfo() {
    const form = document.getElementById('storeUpdateForm');
    const formData = new FormData(form);

    // 🔹 배경 블러 활성화 (기존 기능 유지)
    openModal(); 

    // 1️⃣ 저장 시작 로딩 모달
    Swal.fire({
        title: '정보 저장 중',
        html: `
            <!-- 🔵 customModal에서 쓰던 아이콘 스타일 그대로 -->
            <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                <i class="fa-solid fa-floppy-disk"></i>
            </div>
            <p class="text-slate-500 font-bold text-sm leading-relaxed">
                가게 정보를 업데이트하고 있습니다.
            </p>
        `,
        allowOutsideClick: false,

        didOpen: () => {
            Swal.showLoading(); // 🔹 로딩 기능 유지
        },

        /* ===============================
           🎨 customModal 스타일 이식 영역
           =============================== */

        background: '#ffffff', // customModal과 동일한 흰 배경

        backdrop: `
            rgba(15, 23, 42, 0.6)
            fixed
        `, // 어두운 반투명 배경 (블러 느낌)

        customClass: {
            // 🔹 모달 박스 (customModal 컨테이너 스타일)
            popup: 'rounded-[50px] p-12 shadow-2xl text-center',

            // 🔹 제목 스타일
            title: 'text-3xl font-black text-slate-800 mb-3',

            // 🔹 내용 영역 (html 내부 p 태그가 있어서 최소화)
            htmlContainer: 'p-0',

            // 🔹 확인 버튼 (이번 모달에선 숨김이지만 통일성 유지)
            confirmButton:
                'w-full py-5 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
        },

        showConfirmButton: false, // 🔹 저장 중에는 버튼 없음
        buttonsStyling: false     // Tailwind 클래스 강제 적용
    });

    // 2️⃣ 비동기 전송 (기존 기능 그대로)
    fetch('${pageContext.request.contextPath}/store/updateStore.do', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            // 3️⃣ 성공 모달 (customModal 성공 스타일 적용)
            Swal.fire({
                html: `
                    <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                        <i class="fa-solid fa-check"></i>
                    </div>
                    <h2 class="text-3xl font-black text-slate-800 mb-3">저장 완료</h2>
                    <p class="text-slate-500 font-bold text-sm">
                        가게 정보가 성공적으로 변경되었습니다.
                    </p>
                `,
                background: '#ffffff',
                showConfirmButton: false,
                timer: 1500,

                customClass: {
                    popup: 'rounded-[50px] p-12 shadow-2xl text-center'
                }
            }).then(() => {
                closeModal(); // 🔹 블러 해제
                loadOwnerPage(
                    'store',
                    '${pageContext.request.contextPath}/store/detail.do',
                    null
                );
            });
        } else {
            closeModal();
            throw new Error('전송 실패');
        }
    })
    .catch(error => {
        console.error('Error:', error);

        // 4️⃣ 실패 모달 (customModal 거절 스타일 활용)
        Swal.fire({
            html: `
                <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <h2 class="text-3xl font-black text-slate-800 mb-3">저장 실패</h2>
                <p class="text-slate-500 font-bold text-sm">
                    서버와의 통신 중 오류가 발생했습니다.
                </p>
            `,
            background: '#ffffff',
            confirmButtonText: '확인',

            customClass: {
                popup: 'rounded-[50px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
            },

            buttonsStyling: false
        });
    });
}



/*     // [핵심] 비동기 저장 및 SweetAlert2 적용 함수
    function saveStoreInfo() {
        const form = document.getElementById('storeUpdateForm');
        const formData = new FormData(form);
        
   	 // 모달(SweetAlert) 열기 전 배경 블러 효과 활성화
        openModal(); 

        // 1. 저장 시작 로딩 표시
        Swal.fire({
            title: '정보 저장 중',
            html: '가게 정보를 업데이트하고 있습니다.',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
            
         // 아래 추가: 커스텀 스타일 적용
            background: '#ffffff', // 배경색: 흰색 (customModal 배경과 동일)
            backdrop: `
              rgba(15, 23, 42, 0.6)
              url('') /* 블러효과나 배경 이미지 넣어도 됨 
              left top
              no-repeat
              fixed
            `, // 배경 어둡고 고정 (customModal의 배경과 비슷)

            // SweetAlert2 기본 모달 컨테이너 커스텀 클래스 지정
            customClass: {
              popup: 'rounded-[50px] p-12 shadow-2xl animate-modalIn text-center', // customModal 박스 스타일과 동일하게
              title: 'text-3xl font-black text-slate-800 mb-3', // 제목 스타일 복사
              content: 'text-slate-500 font-bold mb-10 leading-relaxed text-sm', // 메시지 스타일 복사
              confirmButton: 'w-full py-5 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl', // 확인 버튼 스타일 (예시)
              cancelButton: 'w-full py-5 bg-slate-50 text-slate-400 rounded-[22px] font-black text-sm' // 취소 버튼 스타일
            },

            showCancelButton: true,
            confirmButtonText: '네, 저장합니다',
            cancelButtonText: '취소',
            
            buttonsStyling: false // 버튼 스타일을 우리가 지정한 클래스로 강제 적용
        });

        // 2. Fetch API를 이용한 비동기 전송
        fetch('${pageContext.request.contextPath}/store/updateStore.do', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (response.ok) {
                // 3. 성공 시 알림창 띄우기 (페이지는 유지됨)
                Swal.fire({
                    icon: 'success',
                    title: '저장 완료',
                    text: '가게 정보가 성공적으로 변경되었습니다.',
                    showConfirmButton: false,
                    timer: 1500,
                    iconColor: '#0ea5e9',
                    background: '#ffffff',
                    color: '#1e293b'
                }).then(() => {
                	closeModal(); // 블러 효과 제거
                	loadOwnerPage('store', '${pageContext.request.contextPath}/store/detail.do', null)});
            } else {
            	closeModal(); // 블러 효과 제거 
                throw new Error('전송 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            Swal.fire({
                icon: 'error',
                title: '저장 실패',
                text: '서버와의 통신 중 오류가 발생했습니다.',
                confirmButtonColor: '#0ea5e9'
            });
        });
    } */
/////////////////////////////////////////////////////////////////////////
    // 이미지 미리보기 함수
    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById('imagePreview');
                const placeholder = document.getElementById('imagePlaceholder');
                preview.src = e.target.result;
                preview.classList.remove('hidden');
                placeholder.classList.add('hidden');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    
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