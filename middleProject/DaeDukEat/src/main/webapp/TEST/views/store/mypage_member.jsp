<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>D.D.M MYPAGE SUPREME</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@1,900&family=Pretendard:wght@400;700;900&display=swap');
        
        
        @keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-fadeIn {
    animation: fadeIn 0.5s ease-out;
}
        
        body { background-color: #fff5eb; margin: 0; overflow: hidden; font-family: 'Pretendard', sans-serif; }
        .ddm-wrapper { display: flex; height: 100vh; padding: 25px; gap: 25px; }
        
        /* [1] 사이드바 디자인 */
        .ddm-sidebar { 
            width: 300px; background: #ffffff; border-radius: 40px;
            box-shadow: 0 20px 50px rgba(255, 126, 0, 0.08);
            padding: 45px 20px; display: flex; flex-direction: column;
        }
       .ddm-brand { 
            font-family: 'Montserrat', sans-serif; font-size: 36px; font-weight: 900; 
            color: #ff6b00; margin-bottom: 10px; text-align: center; cursor: pointer; 
            font-style: normal;  /* ← 이 줄 추가 */
       }
        
        .nav-scroll { flex: 1; overflow-y: auto; }
        .nav-scroll::-webkit-scrollbar { width: 0; }

        .nav-label { font-size: 11px; font-weight: 900; color: #ff6b00; opacity: 0.4; letter-spacing: 2px; margin: 25px 0 10px 15px; text-transform: uppercase; display: block; }
        
        .nav-item { 
            display: flex; align-items: center; gap: 14px; padding: 14px 20px; 
            color: #64748b; font-weight: 700; border-radius: 20px; cursor: pointer; 
            transition: 0.3s ease; margin-bottom: 4px; font-size: 15px;
        }
        .nav-item:hover { background: #fff0e0; color: #ff6b00; transform: translateX(5px); }
        .nav-item.active { background: #ff7e00; color: #ffffff; box-shadow: 0 10px 20px rgba(255, 126, 0, 0.2); }

        .btn-logout {
            margin-top: 20px; width: 100%; display: flex; align-items: center; justify-content: center; gap: 10px;
            padding: 16px; border-radius: 22px; background: #fff1f2; color: #f43f5e;
            font-weight: 800; border: none; cursor: pointer; transition: 0.3s;
        }
        .btn-logout:hover { background: #f43f5e; color: #ffffff; transform: translateY(-3px); }

        /* [2] 메인 영역 디자인 */
        .ddm-container { flex: 1; display: flex; flex-direction: column; gap: 20px; }
        
        .ddm-header { 
            background: #ffffff; padding: 30px 45px; border-radius: 35px;
            box-shadow: 0 15px 40px rgba(255, 126, 0, 0.05);
            display: flex; justify-content: space-between; align-items: center;
        }
        .header-title-main { 
            font-size: 30px; font-weight: 900; color: #1e293b; letter-spacing: -1px;
            background: linear-gradient(to right, #1e293b, #64748b);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }

        .ddm-content-area { 
            flex: 1; background: #ffffff; border-radius: 40px; padding: 50px; 
            box-shadow: 0 25px 70px rgba(255, 126, 0, 0.1);
            overflow-y: auto; position: relative;
        }
        
            .ddm-logo {
          width: 100px;
          height: 100px;          /* ← 정사각형 */
          display: flex;
          align-items: center;
          justify-content: center;
          margin-bottom: 8px;    /* 로고와 D.D.M 간격 */
        }
        
        .ddm-logo img {
          width: 100%;
          height: 100%;
          object-fit: contain;   /* ← 비율 유지 + 정사각형 */
          display: block;
        }
        
        .ddm-logo {
            margin: 0 auto 8px auto;   /* ← 가로 가운데 정렬 */
         }
                
        /* 로딩 애니메이션 */
        .loading-overlay { opacity: 0.4; pointer-events: none; transition: 0.3s; }
        
        /* ✅ 스크롤바 숨김 방식 교체 */
.nav-scroll {
  flex: 1;
  overflow-y: auto;
  scrollbar-width: none;
  -ms-overflow-style: none;
  padding-bottom: 10px;
}
.nav-scroll::-webkit-scrollbar {
  display: none;
}

/* ✅ hover 이동 제거(일단 문제 확인용) */
.nav-item:hover {
  background: #fff0e0;
  color: #ff6b00;
  transform: none;
}

/* ✅ 경계 클리핑 */
.ddm-sidebar {
  overflow: hidden;
}
        
    </style>
</head>
<body>

<div class="ddm-wrapper">
    <aside class="ddm-sidebar">
        
         <div class="ddm-logo">
           <img src="${pageContext.request.contextPath}/images/로고.png" 
                alt="D.D.M 로고"
                onerror="this.style.display='none';">
         </div>
        <div class="ddm-brand" onclick="location.href='main.do'">D.D.M</div>
        
        <nav class="nav-scroll">
            <span class="nav-label">Profile Management</span>
            <%-- ✅ 수정: loadPage() 함수에 .do URL 전달 --%>
			<div onclick="loadPage('info', '<%=request.getContextPath()%>/SelectOne.do', this)" class="nav-item active">
                <i class="fa-solid fa-id-card"></i> 정보 조회
            </div>
 			<div onclick="loadPage('edit', '<%=request.getContextPath()%>/UpdateMember.do', this)" class="nav-item">
                <i class="fa-solid fa-user-gear"></i> 정보 수정
            </div>
			
			<%-- <div onclick="loadPage('out', '<%=request.getContextPath()%>/DeleteMember.do', this)" class="nav-item">
                <i class="fa-solid fa-user-xmark"></i> 회원 탈퇴
            </div>  --%>
            
            <div onclick="loadPage('out', '<%=request.getContextPath()%>/DeleteMember.do', this)" class="nav-item">
            <i class="fa-solid fa-user-xmark"></i> 회원 탈퇴
            </div>

            <span class="nav-label">Community Area</span>
			<div onclick="loadPage('qna', '<%=request.getContextPath()%>/mypage/qna/list.do', this)" class="nav-item">
                <i class="fa-solid fa-comments"></i> 나의 Q&A
            </div>
			<div onclick="loadPage('review', '<%=request.getContextPath()%>/review/mylistreview.do', this)" class="nav-item">
                <i class="fa-solid fa-star"></i> 나의 리뷰
            </div>

            <span class="nav-label">Service & Shop</span>
			<div onclick="loadPage('coupon', '<%=request.getContextPath()%>/couponham/list.do', this)" class="nav-item">
  			  <i class="fa-solid fa-ticket"></i> 쿠폰함

            </div>
			<div onclick="loadPage('resv', '<%=request.getContextPath()%>/myReservation.do', this)" class="nav-item">
  				<i class="fa-solid fa-calendar-check"></i> 예약/알림
			</div>
			
			<%-- ⭐ 찜 목록 메뉴 추가 --%>
			<div onclick="loadPage('like', '<%=request.getContextPath()%>/DipsList.do', this)" class="nav-item">
			    <i class="fa-solid fa-bookmark"></i> 찜 목록
			</div>
        </nav>
        
        <button class="btn-logout" onclick="location.href='logout.do'">
            <i class="fa-solid fa-power-off"></i> <span>Log out</span>
        </button>
    </aside>

    <main class="ddm-container">
        <header class="ddm-header">
            <div>
                <span id="page-sub" class="text-orange-500 text-[10px] font-black tracking-[3px] uppercase">My Settings</span>
                <h2 id="page-title" class="header-title-main">회원정보 조회</h2>
            </div>
            
            <div class="flex items-center gap-4 bg-orange-50 p-2 pr-6 rounded-2xl border border-orange-100">
                <div class="w-11 h-11 bg-orange-500 rounded-xl flex items-center justify-center text-white text-xl font-black shadow-lg">
                    ${loginUser.name.substring(0,1)}
                </div>
                <div>
                    <p class="text-[10px] text-orange-400 font-black leading-none uppercase mb-1">마이페이지</p>
                    <p class="text-slate-800 font-black text-sm italic">어서오세요. ${loginUser.name}님!</p>
                </div>
            </div>
        </header>

        <%-- ✅ 초기 로딩 시 정보조회 페이지 표시 --%>
        <div id="main-view" class="ddm-content-area">
             <jsp:include page="/TEST/views/user/memberProfile.jsp" /> 
        </div>
    </main>
</div>

<script>
  const ctx = '<%=request.getContextPath()%>';

  function loadPage(type, url, el) {
      const view = document.getElementById('main-view');
      const titleArea = document.getElementById('page-title');
      const subArea = document.getElementById('page-sub');

      if (el) {
          document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
          el.classList.add('active');
      }

      const meta = {
          'info': ['MY SETTINGS', '회원정보 조회'],
          'edit': ['MY SETTINGS', '정보 수정'],
          'out': ['MY SETTINGS', '회원 탈퇴'],
          'qna': ['COMMUNITY', '나의 Q&A'],
          'review': ['COMMUNITY', '나의 리뷰'],
          'coupon': ['SHOPPING', '나의 쿠폰함'],
          'resv': ['SERVICE', '예약 및 알림'],
          'like': ['SERVICE', '찜 목록']
      };

      if (meta[type]) {
          subArea.innerText = meta[type][0];
          titleArea.innerText = meta[type][1];
      }

      view.classList.add('loading-overlay');

      fetch(url)
      .then(response => {
          console.log('[FETCH]', response.status, url);
          if (!response.ok) {
              if (response.status === 401) {
                  alert('로그인이 필요합니다.\n요청 URL = ' + url);
                  location.href = ctx + '/login.do';
                  throw new Error('Unauthorized');
              }
              throw new Error('페이지를 불러올 수 없습니다.');
          }
          return response.text();
      })
      .then(html => {
          view.innerHTML = html;
          view.classList.remove('loading-overlay');

          const scripts = view.querySelectorAll("script");
          scripts.forEach(oldScript => {
              const newScript = document.createElement("script");
              Array.from(oldScript.attributes).forEach(attr => newScript.setAttribute(attr.name, attr.value));
              newScript.appendChild(document.createTextNode(oldScript.innerHTML));
              oldScript.parentNode.replaceChild(newScript, oldScript);
          });
      })
      .catch(error => {
          if (error.message !== 'Unauthorized') {
              view.innerHTML = `
                  <div class="flex flex-col items-center justify-center h-full text-red-400">
                      <i class="fa-solid fa-circle-exclamation text-6xl mb-4"></i>
                      <p class="text-xl font-black italic">ERROR: ${error.message}</p>
                  </div>`;
              view.classList.remove('loading-overlay');
          }
      });
  }

  // ✅ DOMContentLoaded는 "1번만"
  document.addEventListener('DOMContentLoaded', function () {
      const params = new URLSearchParams(location.search);
      const tab = params.get('tab'); // ex) "resv"

      // ✅ tab=resv 기억하고 있으면 -> info 자동로드 금지
      if (tab === 'resv') {
          // 현재 네 메뉴는 data-menu가 없으니, onclick 패턴으로 찾는게 안정적
          const el = document.querySelector(".nav-item[onclick*=\"loadPage('resv'\"]");
          loadPage('resv', ctx + '/myReservation.do', el);
          return; // ✅ 중요: 여기서 끝내야 info로 안 감
      }

      // 기본은 info
      const firstMenu = document.querySelector(".nav-item[onclick*=\"loadPage('info'\"]")
                      || document.querySelector('.nav-item.active');
      loadPage('info', ctx + '/SelectOne.do', firstMenu);
  });
</script>



</body>
</html>