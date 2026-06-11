<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn">

    <div class="mb-10">
        <p class="text-orange-400 font-black text-[11px] tracking-[3px] uppercase mb-2">
            Favorite Stores
        </p>
        <h3 class="text-2xl font-black text-slate-800">
            내가 찜한 가게
        </h3>
        <p class="text-slate-400 text-sm mt-2">
            찜을 누른 가게들을 한눈에 확인할 수 있어요
        </p>
    </div>

    <div class="grid grid-cols-3 gap-8">
        <c:forEach var="store" items="${DipsStoreList}">
			<div class="dips-card bg-white rounded-3xl shadow-lg overflow-hidden group hover:shadow-2xl transition">
                <div class="relative h-44 bg-slate-100">
                    <c:choose>
                        <c:when test="${not empty store.storePicture}">
                            <img src="${pageContext.request.contextPath}/images/upload/store/${store.storePicture}"
                                 class="w-full h-full object-cover"/>
                        </c:when>
                        <c:otherwise>
                            <div class="w-full h-full flex items-center justify-center text-slate-300 text-sm">
                                NO IMAGE
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <button
                        class="absolute top-4 right-4 w-10 h-10 rounded-full
                               bg-white flex items-center justify-center
                               text-red-500 shadow-md hover:scale-110 transition dip-cancel z-50 pointer-events-auto"
                        data-store-id="${store.storeId}"
                        data-store-name="${store.storeName}">
                        <i class="fa-solid fa-bookmark"></i>
                    </button>
                </div>

                <div class="p-6">
                    <h4 class="font-black text-lg text-slate-800 mb-1">
                        ${store.storeName}
                    </h4>
                    <p class="text-slate-400 text-sm mb-4">
                        ${store.storeAddr}
                    </p>

                    <div class="flex gap-3">
                        <a href="${pageContext.request.contextPath}/storeDetail.do?id=${store.storeId}"
                           class="flex-1 py-3 text-center rounded-xl bg-orange-500
                                  text-white font-black hover:bg-orange-600 transition">
                            가게 보기
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty DipsStoreList}">
        <div class="mt-24 text-center">
            <i class="fa-regular fa-heart text-6xl text-slate-300 mb-6"></i>
            <p class="text-xl font-black text-slate-400">
                아직 찜한 가게가 없어요
            </p>
        </div>
    </c:if>

</div>

<div id="customModal" class="fixed inset-0 z-[200] hidden">
    <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm animate-fadeIn"></div>
    <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[90%] max-w-sm bg-white rounded-[32px] p-8 shadow-2xl animate-slideUp">
        <div class="text-center">
            <div id="modalIcon" class="w-16 h-16 bg-slate-50 rounded-2xl flex items-center justify-center mx-auto mb-4 text-2xl">
                🔔
            </div>
            <h3 id="modalTitle" class="text-xl font-black text-slate-800 mb-2">알림</h3>
            <p id="modalMessage" class="text-slate-500 font-medium leading-relaxed mb-8"></p>
            
            <div class="flex gap-3" id="modalButtons">
                </div>
        </div>
    </div>
</div>

<script>
(function () {
  // Modal을 전역에 안전하게 등록/갱신
  window.Modal = window.Modal || {
    el: document.getElementById('customModal'),
    title: document.getElementById('modalTitle'),
    msg: document.getElementById('modalMessage'),
    icon: document.getElementById('modalIcon'),
    btns: document.getElementById('modalButtons'),
    show(options) {
      // 매번 DOM 다시 잡기 (SPA로 innerHTML 교체해도 안전)
      this.el = document.getElementById('customModal');
      this.title = document.getElementById('modalTitle');
      this.msg = document.getElementById('modalMessage');
      this.icon = document.getElementById('modalIcon');
      this.btns = document.getElementById('modalButtons');

      this.title.innerText = options.title || '알림';
      this.msg.innerHTML = options.message || '';
      this.icon.innerText = options.icon || '🔔';
      this.btns.innerHTML = '';

      if (options.type === 'confirm') {
        this.btns.innerHTML = `
          <button type="button" onclick="Modal.close()" class="flex-1 py-4 bg-slate-100 text-slate-400 font-black rounded-2xl hover:bg-slate-200 transition-all">취소</button>
          <button type="button" id="modalConfirmBtn" class="flex-1 py-4 bg-orange-500 text-white font-black rounded-2xl shadow-lg shadow-orange-200 hover:bg-orange-600 transition-all">확인</button>
        `;
        document.getElementById('modalConfirmBtn').onclick = () => {
          this.close();
          if (options.onConfirm) options.onConfirm();
        };
      } else {
        this.btns.innerHTML = `
          <button type="button" onclick="Modal.close()" class="w-full py-4 bg-slate-900 text-white font-black rounded-2xl shadow-lg shadow-slate-300 hover:bg-slate-800 transition-all">확인</button>
        `;
      }
      this.el.classList.remove('hidden');
    },
    close() {
      const el = document.getElementById('customModal');
      if (el) el.classList.add('hidden');
    }
  };

  // executeDipCancel도 전역에 안전하게
  window.executeDipCancel = function (storeId, card) {
    fetch("${pageContext.request.contextPath}/DipsDelete.do", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8" },
      body: "storeId=" + encodeURIComponent(storeId)
    })
    .then(res => res.json())
    .then(data => {
      if (data.success === true) {
        Modal.show({ title:'처리 완료', message:'찜 목록에서 정상적으로 삭제되었습니다.', icon:'✅' });

        if (card) {
          card.style.transition = "all 0.4s cubic-bezier(0.22, 1, 0.36, 1)";
          card.style.opacity = "0";
          card.style.transform = "scale(0.9) translateY(20px)";
          setTimeout(() => {
            card.remove();
            if (document.querySelectorAll(".dips-card").length === 0) location.reload();
          }, 400);
        }
      } else {
        Modal.show({ title:'실패', message:(data.message || "취소 처리에 실패했습니다."), icon:'❌' });
      }
    })
    .catch(err => {
      console.error("[DIPS] error:", err);
      Modal.show({ title:'오류', message:"서버 통신 중 오류가 발생했습니다.<br><small>" + err.message + "</small>", icon:'❗' });
    });
  };

  // 클릭 핸들러는 document에 1번만
  if (!window.__dipsClickBound) {
    window.__dipsClickBound = true;

    document.addEventListener("click", function (e) {
      const btn = e.target.closest(".dip-cancel");
      if (!btn) return;

      const storeId = btn.dataset.storeId;
      const storeName = btn.dataset.storeName || "이 가게";
      const card = btn.closest(".dips-card"); // ✅ 안정

      Modal.show({
        title: "찜 취소",
        message: "<strong>[" + storeName + "]</strong><br>찜 목록에서 제외할까요?",
        icon: "💔",
        type: "confirm",
        onConfirm: function () {
          window.executeDipCancel(storeId, card);
        }
      });
    });
  }

  // 배경 클릭 닫기 (1번만)
  if (!window.__dipsBackdropBound) {
    window.__dipsBackdropBound = true;
    window.addEventListener("click", (e) => {
      const modal = document.getElementById('customModal');
      if (!modal) return;
      if (e.target === modal.firstElementChild) Modal.close();
    });
  }
})();
</script>


<style>
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    @keyframes slideUp { 
        from { opacity: 0; transform: translate(-50%, -40%); } 
        to { opacity: 1; transform: translate(-50%, -50%); } 
    }
    .animate-fadeIn { animation: fadeIn 0.4s ease-out; }
    .animate-slideUp { animation: slideUp 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); }
</style>