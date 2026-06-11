<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 관리 - DaeDukEat</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeIn {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body class="bg-slate-50">

<!-- 배경 흐림 효과 추가 -->
<div id="backgroundBlur" class="fixed inset-0 bg-slate-900/60 backdrop-blur-md hidden z-50"></div>

<div class="animate-fadeIn space-y-8 p-8">
    <!-- ============================================================
         Header Section
         - 새 메뉴 등록 버튼
         ============================================================ -->
    <div class="flex justify-between items-center border-b border-slate-100 pb-6">
        <div>
            <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Menu List</p>
            <h3 class="text-2xl font-black text-slate-800">메뉴 관리</h3>
        </div>
       <button onclick="loadOwnerPage('${pageContext.request.contextPath}/menu/insert.do')"
                class="bg-slate-900 text-white px-6 py-3 rounded-2xl font-black text-xs hover:bg-sky-500 transition-all shadow-lg shadow-slate-200">
            <i class="fa-solid fa-plus mr-2"></i> 새 메뉴 등록
        </button>
    </div>

    <!-- ============================================================
         Menu List Grid
         - JSTL c:forEach로 menuList 반복
         - Jakarta EE 표준 태그 사용
         ============================================================ -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        <c:choose>
            <%-- 메뉴가 없을 경우 --%>
            <c:when test="${empty menuList}">
                <div class="col-span-2 text-center py-20">
                    <i class="fa-solid fa-utensils text-slate-300 text-6xl mb-4"></i>
                    <p class="text-slate-400 font-bold text-lg mb-2">등록된 메뉴가 없습니다.</p>
                    <p class="text-slate-300 text-sm mb-6">첫 번째 메뉴를 등록하고 고객에게 선보이세요!</p>
                    <button onclick="loadOwnerPage('${pageContext.request.contextPath}/menu/insert.do')"
                            class="bg-sky-500 text-white px-8 py-3 rounded-xl font-bold hover:bg-sky-600 transition-colors shadow-lg">
                        <i class="fa-solid fa-plus mr-2"></i> 첫 메뉴 등록하기
                    </button>
                </div>
            </c:when>
            
            <%-- 메뉴 목록 출력 --%>
            <c:otherwise>
                <c:forEach var="menu" items="${menuList}" varStatus="status">
                    <div class="bg-white p-6 rounded-[30px] border border-slate-100 flex gap-6 relative group transition-all hover:shadow-xl hover:border-sky-200">
                        
                        <%-- 메뉴 이미지 --%>
                        <div class="w-24 h-24 bg-slate-100 rounded-2xl overflow-hidden shadow-inner flex-shrink-0">
                            <c:choose>
								<c:when test="${not empty menu.menuPicture}">
								  <img src="${pageContext.request.contextPath}/images/upload/menu/${menu.menuPicture}"
								       alt="${menu.menuName}"
								       class="w-full h-full object-cover"
								       onerror="this.parentElement.innerHTML='<div class=\'w-full h-full flex items-center justify-center text-slate-400 text-xs\'>No Image</div>'">
								</c:when>
                                <c:otherwise>
                                    <div class="w-full h-full flex items-center justify-center text-slate-400 text-xs">
                                        <i class="fa-solid fa-image text-2xl"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <%-- 메뉴 정보 --%>
                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-start gap-3">
                                <div class="flex-1 min-w-0">
                                    <%-- 베스트 뱃지 (임시: 첫 번째 메뉴에만 표시) --%>
                                    <c:if test="${status.index == 0}">
                                        <span class="inline-block px-2 py-0.5 bg-sky-100 text-sky-600 text-[9px] font-black rounded uppercase mb-1">
                                            Best
                                        </span>
                                    </c:if>
                                    
                                    <h4 class="text-lg font-black text-slate-800 truncate" title="${menu.menuName}">
                                        ${menu.menuName}
                                    </h4>
									                                    
                                    <p class="text-xs text-slate-400 font-bold mt-1">
                                        <c:choose>
                                            <c:when test="${not empty menu.createDate}">
                                                <fmt:formatDate value="${menu.createDate}" pattern="yyyy-MM-dd 등록"/>
                                            </c:when>
                                            <c:otherwise>
                                                등록일 정보 없음
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                
                                <%-- 가격 --%>
                                <p class="font-black text-slate-800 text-right whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${not empty menu.menuPrice and menu.menuPrice > 0}">
                                            <fmt:formatNumber value="${menu.menuPrice}" pattern="#,###"/>원
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-slate-400 text-sm">가격 미정</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            
                            <%-- 액션 버튼 --%>
                            <div class="flex gap-2 mt-4 items-center">
								<button type="button"
										onclick="loadOwnerPage('${pageContext.request.contextPath}/menu/update.do?menuId=${menu.menuId}')"
								        class="text-[10px] font-black text-slate-400 hover:text-sky-500 transition-colors uppercase">
								    <i class="fa-solid fa-pen-to-square mr-1"></i> 수정
								</button>
                                <button onclick="deleteMenu(${menu.menuId}, '${menu.menuName}')" 
                                        class="text-[10px] font-black text-slate-400 hover:text-red-500 transition-colors uppercase">
                                    <i class="fa-solid fa-trash mr-1"></i> 삭제
                                </button>
                                
                                <%-- 상태 표시 (MENU_STATUS 컬럼 있을 경우 주석 해제) --%>
                                <%-- 
                                <c:choose>
                                    <c:when test="${menu.menuStatus eq '판매중'}">
                                        <button class="ml-auto px-3 py-1 bg-green-50 border border-green-200 rounded-lg text-[10px] font-black text-green-600">
                                            <i class="fa-solid fa-circle-check mr-1"></i> 판매중
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="ml-auto px-3 py-1 bg-slate-100 border border-slate-200 rounded-lg text-[10px] font-black text-slate-500">
                                            <i class="fa-solid fa-circle-xmark mr-1"></i> 품절
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                --%>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
    </div>
    
    <%-- 통계 정보 (선택사항) --%>
    <c:if test="${not empty menuList}">
        <div class="mt-8 text-center">
            <p class="text-slate-400 text-sm font-bold">
                총 <span class="text-sky-600 font-black">${menuList.size()}</span>개의 메뉴가 등록되어 있습니다.
            </p>
        </div>
    </c:if>
</div>

<!-- ============================================================
     JavaScript: 메뉴 삭제 AJAX 처리
     - fetch API 사용
     - JSON 응답 처리
     ============================================================ -->
<script>


function deleteMenu(menuId, menuName) {

	  // 🔥 SweetAlert 띄우기 전 배경 블러 ON
	  openModal();

	  // 1️⃣ 삭제 확인 모달 (맨 처음 모달 스타일)
	  Swal.fire({
	    html: `
	      <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
	        <i class="fa-solid fa-triangle-exclamation"></i>
	      </div>
	      <h2 class="text-3xl font-black text-slate-800 mb-3">메뉴 삭제</h2>
	      <p class="text-slate-500 font-bold text-sm">
	        "<span class="font-black text-slate-800">\${menuName}</span>"을(를) 삭제하시겠습니까?<br>
	        <span class="text-xs text-red-400">삭제된 메뉴는 복구할 수 없습니다.</span>
	      </p>
	    `,
	    background: '#ffffff',
	    showCancelButton: true,
	    reverseButtons: true,
	    confirmButtonText: '삭제',
	    cancelButtonText: '취소',
	    buttonsStyling: false,
	    customClass: {
	      popup: 'rounded-[30px] p-12 shadow-2xl text-center',
	      confirmButton:
	        'w-full py-5 px-14 bg-red-500 text-white rounded-[22px] font-black text-sm shadow-xl shadow-red-100',
	      cancelButton:
	        'w-full py-5 px-14 mt-3 bg-slate-100 text-slate-500 rounded-[22px] font-black text-sm'
	    }
	  }).then((result) => {

	    if (result.isConfirmed) {
	      // 2️⃣ 삭제 요청 (기존 로직 유지)
	      const params = new URLSearchParams();
	      params.append('menuId', menuId);

	      fetch('${pageContext.request.contextPath}/menu/delete.do', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	        body: params.toString()
	      })
	      .then(res => res.json())
	      .then(data => {
	        if (data.success) {

	          // 3️⃣ 삭제 성공 모달 (동일 스타일)
	          Swal.fire({
	            html: `
	              <div class="w-24 h-24 bg-sky-50 text-sky-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
	                <i class="fa-solid fa-check"></i>
	              </div>
	              <h2 class="text-3xl font-black text-slate-800 mb-3">삭제 완료</h2>
	              <p class="text-slate-500 font-bold text-sm">
	                메뉴가 성공적으로 제거되었습니다.
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
	          }).then(() => {
	            closeModal(); // 🔥 블러 OFF
	            loadOwnerPage(
	              'menu',
	              '${pageContext.request.contextPath}/menu/list.do',
	              null
	            );
	          });

	        } else {
	          Swal.fire({
	            html: `
	              <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
	                <i class="fa-solid fa-xmark"></i>
	              </div>
	              <h2 class="text-3xl font-black text-slate-800 mb-3">오류</h2>
	              <p class="text-slate-500 font-bold text-sm">
	                ${data.message}
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
	          }).then(() => {
	            closeModal();
	            loadOwnerPage(
	              'menu',
	              '${pageContext.request.contextPath}/menu/list.do',
	              null
	            );
	          });
	        }
	      })
	      .catch(() => {
	        Swal.fire({
	          html: `
	            <div class="w-24 h-24 bg-red-50 text-red-500 rounded-full flex items-center justify-center mx-auto mb-8 text-4xl">
	              <i class="fa-solid fa-xmark"></i>
	            </div>
	            <h2 class="text-3xl font-black text-slate-800 mb-3">통신 오류</h2>
	            <p class="text-slate-500 font-bold text-sm">
	              서버와 연결할 수 없습니다.
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
	          closeModal();
	          loadOwnerPage(
	            'menu',
	            '${pageContext.request.contextPath}/menu/list.do',
	            null
	          );
	        });
	      });

	    } else {
	      // ❌ 취소 시
	      closeModal();
	      loadOwnerPage(
	        'menu',
	        '${pageContext.request.contextPath}/menu/list.do',
	        null
	      );
	    }
	  });
	}


	// 페이지 로드 로그 (그대로 유지)
	document.addEventListener('DOMContentLoaded', function() {
	  console.log('메뉴 관리 페이지 로드 완료');
	  console.log('총 메뉴 개수: ${menuList != null ? menuList.size() : 0}');
	});



/*
 * 메뉴 삭제 함수
 * @param {number} menuId - 삭제할 메뉴 ID
 * @param {string} menuName - 메뉴명 (확인 메시지용)

 function deleteMenu(menuId, menuName) {
     
	 // 모달(SweetAlert) 열기 전 배경 블러 효과 활성화
     openModal();  
	 
	    // 1. 확인창을 아주 예쁘게 띄웁니다.
	    Swal.fire({
	        title: '메뉴 삭제',
	        html: `<span class="font-black text-slate-800">"\${menuName}"</span>을(를) 삭제하시겠습니까?<br><span class="text-xs text-red-400">삭제된 메뉴는 복구할 수 없습니다.</span>`,
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#0ea5e9', // 스카이 블루 (사장님 스타일)
	        cancelButtonColor: '#f1f5f9',  // 연한 그레이
	        confirmButtonText: '확인',
	        cancelButtonText: '<span class="text-slate-500">취소</span>',
	        reverseButtons: true,
	        customClass: {
	            popup: 'rounded-[30px] border-none shadow-2xl',
	            title: 'font-black text-slate-800'
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // 2. 삭제 진행 (서블릿 통신)
	            const params = new URLSearchParams();
	            params.append('menuId', menuId);
	            
	            fetch('${pageContext.request.contextPath}/menu/delete.do', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                body: params.toString()
	            })
	            .then(res => res.json())
	            .then(data => {
	                if (data.success) {
	                    // 성공 알림도 예쁘게!
	                    Swal.fire({
	                        title: '삭제 완료',
	                        text: '메뉴가 성공적으로 제거되었습니다.',
	                        icon: 'success',
	                        confirmButtonColor: '#0ea5e9',
	                        customClass: { popup: 'rounded-[30px]' }
	                    }).then(() => {
	                    	closeModal(); // 블러 효과 제거 
	                        loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)});
	                } else {
	                    Swal.fire('오류 발생', data.message, 'error')
                        .then(() => {
                        	closeModal(); //블러 효과 제거
                    		loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)});
	                }
	            })
	            .catch(err => {
	                Swal.fire('통신 에러', '서버와 연결할 수 없습니다.', 'error')
                    .then(() => {
                    	closeModal(); // 블러 효과 제거
                		loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null)});
	            });
	        } else {
            // 취소 버튼 클릭 시, 페이지 이동 처리 (목록 페이지로 돌아가기)
            closeModal(); // 블러 효과 제거
            loadOwnerPage('menu', '${pageContext.request.contextPath}/menu/list.do', null); // 목록으로 이동
	        }
	    });
	}

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    console.log('메뉴 관리 페이지 로드 완료');
    console.log('총 메뉴 개수: ${menuList != null ? menuList.size() : 0}');
});*/



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

</body>
</html>