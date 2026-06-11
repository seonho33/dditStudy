<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="w-full animate-fadeIn p-1">

    <div id="edit-auth-section" class="bg-white rounded-[40px] p-10 border-[3px] border-orange-200 shadow-sm text-center max-w-md mx-auto">
        <div class="w-20 h-20 bg-orange-50 text-orange-500 rounded-[25px] border-2 border-orange-100 flex items-center justify-center text-3xl mx-auto mb-6">
            <i class="fa-solid fa-shield-halved"></i>
        </div>
        <h3 class="text-2xl font-black text-slate-800 mb-2">본인 확인</h3>
        <p class="text-slate-400 text-sm mb-8 font-medium">안전한 정보 수정을 위해<br>현재 비밀번호를 입력해주세요.</p>
        <input type="password" id="confirm-pw"
               class="w-full p-4 bg-slate-50 border-2 border-slate-100 rounded-2xl focus:border-orange-400 focus:bg-white outline-none text-center text-xl transition-all font-black"
               placeholder="••••••••">
        <button type="button" onclick="verifyPassword()"
                class="w-full mt-6 bg-slate-900 text-white py-4 rounded-2xl font-black hover:bg-orange-600 transition-all shadow-xl active:scale-95">
            인증 및 수정하기
        </button>
    </div>

    <form id="edit-form-section" class="hidden animate-slideUp w-full"
          action="${pageContext.request.contextPath}/UpdateMember.do"
          method="post"
          enctype="multipart/form-data"
          onsubmit="return submitUpdate(event)">

        <div class="flex items-center gap-4 mb-6 px-2">
            <div class="w-1.5 bg-orange-500 h-6 rounded-full"></div>
            <h3 class="text-2xl font-black text-slate-800 tracking-tight">프로필 수정</h3>
        </div>

        <div class="bg-white rounded-[40px] border-[3px] border-orange-200 shadow-sm overflow-hidden w-full">
            <div class="flex flex-col lg:flex-row w-full">
                
                <div class="lg:w-72 p-8 bg-orange-50/30 border-b lg:border-b-0 lg:border-r-[3px] border-orange-100 flex flex-col items-center justify-center shrink-0">
                    <div id="preview-container" class="relative group">
                        <c:choose>
                            <c:when test="${not empty loginMember.profileImg}">
                                <img src="${pageContext.request.contextPath}/images/upload/profile/${loginMember.profileImg}"
                                     class="w-32 h-32 rounded-[35px] object-cover border-[4px] border-white shadow-lg ring-2 ring-orange-200"
                                     id="current-profile"
                                     onerror="this.src='${pageContext.request.contextPath}/images/default_profile.png';">
                            </c:when>
                            <c:otherwise>
                                <div id="current-profile-placeholder" class="w-32 h-32 rounded-[35px] bg-white flex items-center justify-center text-orange-200 border-2 border-dashed border-orange-200">
                                    <i class="fa-solid fa-user-astronaut text-4xl"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <label for="profileImg" class="mt-6 px-5 py-2.5 bg-white border-2 border-orange-200 rounded-xl font-black text-orange-500 text-xs cursor-pointer hover:bg-orange-500 hover:text-white transition-all shadow-sm whitespace-nowrap">
                        사진 변경
                    </label>
                    <input type="file" id="profileImg" name="profileImg" onchange="handleFileChange(this)" class="hidden" accept="image/*">
                </div>

                <div class="flex-1 p-8 space-y-5">
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                        <div class="sm:col-span-2">
                            <label class="text-[10px] font-black text-slate-400 ml-1 mb-1.5 block uppercase tracking-widest">이름</label>
                            <input type="text" name="name" value="${loginUser.name}"
                                   class="w-full p-3.5 bg-slate-50 border-2 border-transparent rounded-xl font-bold text-slate-700 outline-none focus:border-orange-200 focus:bg-white transition-all text-sm">
                        </div>

                        <div class="sm:col-span-2">
                            <label class="text-[10px] font-black text-slate-400 ml-1 mb-1.5 block uppercase tracking-widest">이메일</label>
                            <input type="email" id="mem_mail" name="mail" value="${loginMember.userMail}"
                                   class="w-full p-3.5 bg-slate-50 border-2 border-transparent rounded-xl font-bold text-slate-700 outline-none focus:border-orange-200 focus:bg-white transition-all text-sm">
                        </div>

                        <div class="sm:col-span-2">
                            <label class="text-[10px] font-black text-slate-400 ml-1 mb-1.5 block uppercase tracking-widest">새 비밀번호</label>
                            <input type="password" name="password"
                                   placeholder="변경 시에만 입력"
                                   class="w-full p-3.5 bg-slate-50 border-2 border-transparent rounded-xl font-bold text-slate-700 outline-none focus:border-orange-200 focus:bg-white transition-all text-sm">
                        </div>
                    </div>

                    <div class="flex gap-3 pt-4">
                        <button type="button"
                                onclick="loadPage('info', '${pageContext.request.contextPath}/SelectOne.do', null)"
                                class="px-6 py-3.5 bg-slate-100 text-slate-400 rounded-xl font-black hover:bg-slate-200 transition-all text-sm">
                            취소
                        </button>
                        <button type="submit"
                                class="flex-1 py-3.5 bg-orange-500 text-white rounded-xl font-black shadow-lg shadow-orange-100 hover:bg-orange-600 transition-all text-sm">
                            정보 수정 완료
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="current_pass" name="current_pass">
    </form>
</div>


<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- FontAwesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<!-- contextPath JS 변수로 분리 (JSP + JS 충돌 방지) -->
<script>
  const CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>

<style>
/* SweetAlert가 화면 뒤로 가는 문제 방지 */
.swal2-container {
  z-index: 99999 !important;
}
</style>


<script>

//1. 비밀번호 인증 함수
function verifyPassword() {
    const currentPass = document.getElementById('confirm-pw')?.value || '';

    if (!currentPass) {
        Swal.fire({
            html: `
              <div class="w-24 h-24 bg-green-50 text-green-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                <i class="fa-solid fa-triangle-exclamation"></i>
              </div>
              <h2 class="text-3xl font-black text-slate-800 mb-3">안내</h2>
              <p class="text-slate-500 font-bold text-sm">
                비밀번호를 입력해주세요.
              </p>
            `,
            background: '#ffffff',
            confirmButtonText: '확인',
            buttonsStyling: false,
            customClass: {
                popup: 'rounded-[30px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-green-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-green-100'
            }
        });
        return;
    }

    fetch(CONTEXT_PATH + '/checkPassword.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: 'password=' + encodeURIComponent(currentPass)
    })
    .then(res => res.json())
    .then(data => {
        if (data.result === "success") {
            document.getElementById('current_pass').value = currentPass;
            document.getElementById('edit-auth-section').classList.add('hidden');
            document.getElementById('edit-form-section').classList.remove('hidden');
        } else {
            Swal.fire({
                html: `
                  <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-xmark"></i>
                  </div>
                  <h2 class="text-3xl font-black text-slate-800 mb-3">실패</h2>
                  <p class="text-slate-500 font-bold text-sm">
                    ${data.message || '비밀번호가 일치하지 않습니다.'}
                  </p>
                `,
                background: '#ffffff',
                confirmButtonText: '확인',
                buttonsStyling: false,
                customClass: {
                    popup: 'rounded-[30px] p-12 shadow-2xl text-center',
                    confirmButton:
                        'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
                }
            }).then(() => {
                const pw = document.getElementById('confirm-pw');
                if (pw) {
                    pw.value = '';
                    pw.focus();
                }
            });
        }
    })
    .catch(() => {
        Swal.fire({
            html: `
              <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                <i class="fa-solid fa-xmark"></i>
              </div>
              <h2 class="text-3xl font-black text-slate-800 mb-3">오류</h2>
              <p class="text-slate-500 font-bold text-sm">
                서버 통신 오류가 발생했습니다.
              </p>
            `,
            background: '#ffffff',
            confirmButtonText: '확인',
            buttonsStyling: false,
            customClass: {
                popup: 'rounded-[30px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
            }
        });
    });
}


// 2. 사진 변경 핸들러 (기존 로직 그대로)
function handleFileChange(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            let preview = document.getElementById('current-profile');
            const placeholder = document.getElementById('current-profile-placeholder');

            if (!preview) {
                if (placeholder) placeholder.remove();
                preview = document.createElement('img');
                preview.id = 'current-profile';
                preview.className =
                  'w-32 h-32 rounded-[35px] object-cover border-[4px] border-white shadow-lg ring-2 ring-orange-200';
                document.getElementById('preview-container').appendChild(preview);
            }
            preview.src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    }
}


// 3. 최종 수정 제출
function submitUpdate(e) {
    e.preventDefault();

    Swal.fire({
        html: `
          <div class="w-24 h-24 bg-green-50 text-green-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
            <i class="fa-solid fa-question"></i>
          </div>
          <h2 class="text-3xl font-black text-slate-800 mb-3">확인</h2>
          <p class="text-slate-500 font-bold text-sm">
            정보를 수정하시겠습니까?
          </p>
        `,
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소',
        buttonsStyling: false,
        background: '#ffffff',
        customClass: {
            popup: 'rounded-[30px] p-12 shadow-2xl text-center',
            confirmButton:
                'w-full py-5 px-14 bg-green-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-green-100',
            cancelButton:
                'w-full py-5 px-14 mt-3 bg-slate-200 text-slate-600 rounded-[22px] font-black text-sm'
        }
    }).then(result => {
        if (!result.isConfirmed) return;

        const form = document.getElementById('edit-form-section');
        const fd = new FormData(form);

        fetch(CONTEXT_PATH + '/UpdateMember.do', {
            method: 'POST',
            body: fd
        })
        .then(res => res.json())
  .then(data => {
    if (data.success === true || data.success === 'true' || data.success === 'success') {

        // ✅ [수정 포인트] message가 "정상 문자열"일 때만 사용
        const message =
            typeof data.message === 'string' && data.message.trim() !== ''
                ? data.message
                : '수정되었습니다.';

        Swal.fire({
            html: `
              <div class="w-24 h-24 bg-green-50 text-green-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                <i class="fa-solid fa-check"></i>
              </div>
              <h2 class="text-3xl font-black text-slate-800 mb-3">완료</h2>
              <p class="text-slate-500 font-bold text-sm">
                ${message}
              </p>
            `,
            background: '#ffffff',
            confirmButtonText: '확인',
            buttonsStyling: false,
            customClass: {
                popup: 'rounded-[30px] p-12 shadow-2xl text-center',
                confirmButton:
                    'w-full py-5 px-14 bg-green-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-green-100'
            }
        }).then(() => {
            loadPage('info', CONTEXT_PATH + '/SelectOne.do', null);
        });

    } else {
        throw new Error(
            typeof data.message === 'string' && data.message.trim()
                ? data.message
                : '수정 실패'
        );
    }
})

        .catch(err => {
            Swal.fire({
                html: `
                  <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
                    <i class="fa-solid fa-xmark"></i>
                  </div>
                  <h2 class="text-3xl font-black text-slate-800 mb-3">실패</h2>
                  <p class="text-slate-500 font-bold text-sm">
                    ${err.message}
                  </p>
                `,
                background: '#ffffff',
                confirmButtonText: '확인',
                buttonsStyling: false,
                customClass: {
                    popup: 'rounded-[30px] p-12 shadow-2xl text-center',
                    confirmButton:
                        'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100'
                }
            });
        });
    });

    return false;
}



/* // 1. 비밀번호 인증 함수
function verifyPassword() {
    const currentPass = document.getElementById('confirm-pw').value;
    if (!currentPass) { alert("비밀번호를 입력해주세요."); return; }

    fetch('${pageContext.request.contextPath}/checkPassword.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: 'password=' + encodeURIComponent(currentPass)
    })
    .then(res => res.json())
    .then(data => {
        if (data.result === "success") {
            // 인증 성공 시 실행
            document.getElementById('current_pass').value = currentPass;
            document.getElementById('edit-auth-section').classList.add('hidden');
            document.getElementById('edit-form-section').classList.remove('hidden'); // hidden 해제
        } else {
            alert(data.message || "비밀번호가 일치하지 않습니다.");
            document.getElementById('confirm-pw').value = "";
            document.getElementById('confirm-pw').focus();
        }
    })
    .catch(err => {
        console.error(err);
        alert("서버 통신 오류가 발생했습니다.");
    });
}

// 2. 사진 변경 핸들러
function handleFileChange(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            let preview = document.getElementById('current-profile');
            const placeholder = document.getElementById('current-profile-placeholder');
            
            if (!preview) {
                if (placeholder) placeholder.remove();
                preview = document.createElement('img');
                preview.id = 'current-profile';
                preview.className = 'w-32 h-32 rounded-[35px] object-cover border-[4px] border-white shadow-lg ring-2 ring-orange-200';
                document.getElementById('preview-container').appendChild(preview);
            }
            preview.src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}

// 3. 최종 수정 제출
function submitUpdate(e) {
    e.preventDefault();
    if (!confirm("정보를 수정하시겠습니까?")) return false;

    const form = document.getElementById('edit-form-section');
    const fd = new FormData(form);

    fetch('${pageContext.request.contextPath}/UpdateMember.do', {
        method: 'POST',
        body: fd
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert(data.message || "수정되었습니다.");
            loadPage('info', '${pageContext.request.contextPath}/SelectOne.do', null);
        } else {
            alert(data.message || "수정 실패");
        }
    })
    .catch(err => alert("수정 중 오류 발생"));
    
    return false;
} */
</script>