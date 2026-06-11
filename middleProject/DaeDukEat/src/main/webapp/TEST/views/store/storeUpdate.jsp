<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 🔥 배경 블러 요소 -->
<div id="backgroundBlur" class="fixed inset-0 bg-slate-900/60 backdrop-blur-md hidden z-50"></div>


<div class="animate-fadeIn max-w-2xl mx-auto">
  <div class="text-center mb-12">
    <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Security & Profile</p>
    <h3 class="text-3xl font-black text-slate-800">내 정보 관리</h3>
    <p class="text-slate-400 text-sm font-bold mt-2">안전한 정보 수정을 위해 본인 확인이 필요합니다.</p>
  </div>

  <!-- 1) 비밀번호 확인 단계 -->
  <div id="pw-check-step" class="bg-white border-2 border-slate-100 rounded-[40px] p-12 shadow-sm transition-all">
    <input type="hidden" id="userId" value="${loginUser.userId}">

    <div class="flex flex-col items-center">
      <div class="w-20 h-20 bg-slate-50 text-slate-300 rounded-full flex items-center justify-center text-3xl mb-8">
        <i class="fa-solid fa-lock"></i>
      </div>

      <div class="w-full space-y-6">
        <div>
          <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">
            Current Password
          </label>
          <input
            type="password"
            id="confirm-pw"
            placeholder="현재 비밀번호를 입력하세요"
            class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700"
          />
        </div>

        <button
          type="button"
          onclick="verifyPassword()"
          class="w-full py-5 bg-slate-900 text-white rounded-[25px] font-black text-sm shadow-xl hover:bg-sky-500 transition-all active:scale-95"
        >
          본인 확인하기
        </button>
      </div>
    </div>
  </div>

  <!-- 2) 프로필 수정 단계 -->
  <div id="profile-edit-step" class="hidden bg-white border-2 border-slate-100 rounded-[40px] p-12 shadow-sm transition-all">
    <!-- ✅ form submit 막고 fetch로 처리 -->
    <form id="profileForm" onsubmit="return submitProfileUpdate(event);">
      <input type="hidden" name="userId" value="${loginUser.userId}">

      <div class="space-y-8">
        <div>
          <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">
            Owner ID
          </label>
          <input
            type="text"
            value="${loginUser.userId}"
            readonly
            class="w-full bg-slate-100 border-none rounded-2xl px-6 py-4 font-black text-slate-400 cursor-not-allowed"
          />
        </div>

        <div>
          <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">
            Owner Name
          </label>
          <input
            type="text"
            name="userName"
            id="edit-name"
            value="${loginUser.name}"
            placeholder="이름을 입력하세요"
            class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700"
          />
        </div>

        <div>
          <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">
            Email Address
          </label>
          <input
            type="email"
            name="userEmail"
            id="edit-email"
            value="${not empty loginStore ? loginStore.ownerEmail : ''}"
            placeholder="이메일을 입력하세요"
            class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700"
          />
          <p class="mt-2 ml-1 text-xs font-bold text-slate-400">
            * 이메일은 알림/계정확인에 사용됩니다.
          </p>
        </div>

        <div>
          <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">
            New Password
          </label>

          <input
            type="password"
            name="userPw"
            id="edit-pw"
            autocomplete="new-password"
            placeholder="변경할 비밀번호 (미입력 시 유지)"
            class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700"
          />

          <input
            type="password"
            id="edit-pw2"
            autocomplete="new-password"
            placeholder="새 비밀번호 확인"
            class="mt-3 w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700"
          />

          <p class="mt-2 ml-1 text-xs font-bold text-slate-400">
            * 비밀번호 변경 시 8자 이상 권장
          </p>
        </div>

        <div class="flex gap-4 pt-4">
          <button
            type="button"
            onclick="cancelProfileEdit()"
            class="flex-1 py-5 bg-slate-100 text-slate-500 rounded-[25px] font-black text-sm hover:bg-slate-200 transition-all"
          >
            취소
          </button>

          <button
            type="submit"
            class="flex-[2] px-12 py-5 bg-sky-500 text-white rounded-[25px] font-black text-sm shadow-lg shadow-sky-100 hover:bg-sky-600 transition-all active:scale-95"
          >
            정보 수정 완료
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>

/** =========================
 * 1) 비번 확인
 * ========================= */
function verifyPassword() {
  const pw = document.getElementById('confirm-pw').value.trim();

  if (!pw) {
    openModal();
    Swal.fire({
      html: `
        <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
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
          'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
      }
    }).then(() => closeModal());
    return;
  }

  fetch('<%=request.getContextPath()%>/checkPassword.do', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body: 'password=' + encodeURIComponent(pw)
  })
  .then(r => r.json())
  .then(data => {
    if (data.result === 'success') {
      document.getElementById('pw-check-step').classList.add('hidden');
      document.getElementById('profile-edit-step').classList.remove('hidden');
      document.getElementById('confirm-pw').value = '';
    } else {
      openModal();
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
      }).then(() => closeModal());
    }
  })
  .catch(err => {
    console.error(err);
    openModal();
    Swal.fire({
      html: `
        <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
          <i class="fa-solid fa-xmark"></i>
        </div>
        <h2 class="text-3xl font-black text-slate-800 mb-3">오류</h2>
        <p class="text-slate-500 font-bold text-sm">
          오류가 발생했습니다. 다시 시도해주세요.
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
    }).then(() => closeModal());
  });
}


/** =========================
 * 2) 프로필 업데이트
 * ========================= */
function submitProfileUpdate(e) {
  e.preventDefault();

  const name = document.getElementById('edit-name').value.trim();
  const pw1 = document.getElementById('edit-pw').value;
  const pw2 = document.getElementById('edit-pw2').value;

  if (!name) {
    openModal();
    Swal.fire({
      html: `
        <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
          <i class="fa-solid fa-triangle-exclamation"></i>
        </div>
        <h2 class="text-3xl font-black text-slate-800 mb-3">안내</h2>
        <p class="text-slate-500 font-bold text-sm">
          이름을 입력해주세요.
        </p>
      `,
      background: '#ffffff',
      confirmButtonText: '확인',
      buttonsStyling: false,
      customClass: {
        popup: 'rounded-[30px] p-12 shadow-2xl text-center',
        confirmButton:
          'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
      }
    }).then(() => closeModal());
    return false;
  }

  if (pw1 || pw2) {
    if (pw1.length < 8) {
      openModal();
      Swal.fire({
        html: `
          <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
            <i class="fa-solid fa-triangle-exclamation"></i>
          </div>
          <h2 class="text-3xl font-black text-slate-800 mb-3">안내</h2>
          <p class="text-slate-500 font-bold text-sm">
            비밀번호는 8자 이상 권장합니다.
          </p>
        `,
        background: '#ffffff',
        confirmButtonText: '확인',
        buttonsStyling: false,
        customClass: {
          popup: 'rounded-[30px] p-12 shadow-2xl text-center',
          confirmButton:
            'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
        }
      }).then(() => closeModal());
      return false;
    }

    if (pw1 !== pw2) {
      openModal();
      Swal.fire({
        html: `
          <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
            <i class="fa-solid fa-triangle-exclamation"></i>
          </div>
          <h2 class="text-3xl font-black text-slate-800 mb-3">안내</h2>
          <p class="text-slate-500 font-bold text-sm">
            새 비밀번호 확인이 일치하지 않습니다.
          </p>
        `,
        background: '#ffffff',
        confirmButtonText: '확인',
        buttonsStyling: false,
        customClass: {
          popup: 'rounded-[30px] p-12 shadow-2xl text-center',
          confirmButton:
            'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
        }
      }).then(() => closeModal());
      return false;
    }
  }

  const form = document.getElementById('profileForm');
  const body = new URLSearchParams(new FormData(form)).toString();

  fetch('${pageContext.request.contextPath}/updateProfile.do', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body
  })
  .then(r => r.text())
  .then(text => {
    let data;
    try {
      data = JSON.parse(text);
    } catch {
      data = { ok: true };
    }

    if (data.ok === true) {
      const message =
        typeof data.message === 'string' && data.message.trim()
          ? data.message
          : '정보가 수정되었습니다.';

      openModal();
      Swal.fire({
        html: `
          <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
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
        allowOutsideClick: false,
        customClass: {
          popup: 'rounded-[30px] p-12 shadow-2xl text-center',
          confirmButton:
            'w-full py-5 px-14 bg-sky-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-sky-100'
        }
      }).then(() => {
        closeModal();
        location.href = '${pageContext.request.contextPath}/owner/dashboard.do';
      });

    } else {
      throw new Error(
        typeof data.message === 'string'
          ? data.message
          : '정보 수정에 실패했습니다.'
      );
    }
  })
  .catch(err => {
    console.error(err);
    openModal();
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
    }).then(() => closeModal());
  });

  return false;

}


/** =========================
 * 3) 취소 버튼
 * ========================= */
function cancelProfileEdit() {
  if (typeof loadOwnerPage === 'function') {
    loadOwnerPage(
      'storeSearch',
      '${pageContext.request.contextPath}/store/list.do',
      document.querySelector('.nav-link.active')
    );
  } else {
    location.href = '${pageContext.request.contextPath}/owner/dashboard.do';
  }
}


<%-- /** =========================
 * 1) 비번 확인 (기존 유지)
 * ========================= */
function verifyPassword() {
  const pw = document.getElementById('confirm-pw').value.trim();
  if (!pw) {
	openModal(); // 🔥 블러 켜기
    Swal.fire('안내', '비밀번호를 입력해주세요.', 'warning')
    .then(() => closeModal()); // 🔥 모달 닫히면 블러 끄기
    return;
  }

  fetch('<%=request.getContextPath()%>/checkPassword.do', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body: 'password=' + encodeURIComponent(pw)
  })
  .then(r => r.json())
  .then(data => {
    if (data.result === 'success') {
      document.getElementById('pw-check-step').classList.add('hidden');
      document.getElementById('profile-edit-step').classList.remove('hidden');
      document.getElementById('confirm-pw').value = '';
    } else {
      openModal(); // 🔥 블러 켜기
      Swal.fire('실패', data.message || '비밀번호가 일치하지 않습니다.', 'error')
      .then(() => closeModal()); // 🔥 블러 끄기
    }
  })
  .catch(err => {
    console.error(err);
    Swal.fire('오류', '오류가 발생했습니다. 다시 시도해주세요.', 'error');
  });
}

/** =========================
 * 2) 프로필 업데이트 (SPA 친화: fetch)
 * ========================= */
function submitProfileUpdate(e) {
  e.preventDefault();

  const name = document.getElementById('edit-name').value.trim();
  const pw1 = document.getElementById('edit-pw').value;
  const pw2 = document.getElementById('edit-pw2').value;

  if (!name) {
	openModal(); // 블러 켜기
    Swal.fire('안내', '이름을 입력해주세요.', 'warning')
    .then(() => closeModal()); // 모달 닫히면 블러 끄기
    return false;
  }

  // 비번은 입력했을 때만 검사
  if (pw1 || pw2) {
    if (pw1.length < 8) {
   	  openModal();
   	  setTimeout(() => {
   	    Swal.fire('안내', '비밀번호는 8자 이상 권장합니다.', 'warning')
   	        .then(() => closeModal());
   	  }, 10); // 10ms 정도 기다리면 블러가 정상 반영됨
   	  return false;
    }
    if (pw1 !== pw2) {
      openModal(); // 블러 켜기
      Swal.fire('안내', '새 비밀번호 확인이 일치하지 않습니다.', 'warning')
      .then(() => closeModal());
      return false;
    }
  }

  const form = document.getElementById('profileForm');
  const body = new URLSearchParams(new FormData(form)).toString();

  fetch('${pageContext.request.contextPath}/updateProfile.do', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body
  })
  .then(async (r) => {
    // 서버가 JSON으로 주는 버전(추천) / 혹시 text로 오면 방어
    const text = await r.text();
    try {
      return { okHttp: r.ok, ...JSON.parse(text) };
    } catch {
      // JSON이 아니면 그냥 실패 처리
      return { okHttp: r.ok, ok: r.ok, message: r.ok ? '정보가 수정되었습니다.' : '정보 수정에 실패했습니다.' };
    }
  })
  .then(data => {
    if ((data.okHttp && data.ok !== false) || data.ok === true) {
    	openModal(); // 블러 켜기
        Swal.fire('완료', data.message || '정보가 수정되었습니다.', 'success')
        .then(() => {
          // ✅ 대시보드 메인으로 확실히 이동
          location.href = '${pageContext.request.contextPath}/owner/dashboard.do';
        });
    } else {
      openModal();
      Swal.fire('실패', data.message || '정보 수정에 실패했습니다.', 'error')
      .then(() => closeModal());
    }
  })
  .catch(err => {
    console.error(err);
    openModal();
    Swal.fire('오류', '서버 오류가 발생했습니다.', 'error')
    .then(() => closeModal());
  });

  return false;
}

/** =========================
 * 3) 취소 버튼 동작 (SPA에 맞게)
 * ========================= */
function cancelProfileEdit() {
  // "가게 조회"로 돌아가기 (원하면 profile 재로드로 바꿔도 됨)
  if (typeof loadOwnerPage === 'function') {
    loadOwnerPage('storeSearch', '${pageContext.request.contextPath}/store/list.do', document.querySelector('.nav-link.active'));
  } else {
    location.href = '${pageContext.request.contextPath}/owner/dashboard.do';
  }
}
  --%>
 
//🔥 모달 열 때 배경 블러 표시
 function openModal() {
     const backgroundBlur = document.getElementById('backgroundBlur');
     if (backgroundBlur) backgroundBlur.classList.remove('hidden');
 }

 // 🔥 모달 닫을 때 배경 블러 숨기기
 function closeModal() {
     const backgroundBlur = document.getElementById('backgroundBlur');
     if (backgroundBlur) backgroundBlur.classList.add('hidden');
 }

 
</script>
