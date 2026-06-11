<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 회원가입</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        
        body { font-family: 'Noto Sans KR', sans-serif; background-color: #fafafa; margin: 0; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }
        
        .input-base {
            width: 100%; background-color: #f9fafb; border: 2px solid #f3f4f6;
            border-radius: 9999px; padding: 0.8rem 1.5rem; font-weight: 700;
            transition: all 0.3s ease; outline: none;
        }
        .input-base:focus {
            border-color: #f97316; background-color: #fff;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }
        .max-container { max-width: 700px; margin: 0 auto; padding: 40px 20px; }
    </style>
</head>
<body>

    <header class="bg-white border-b py-5 shadow-sm mb-8">
        <div class="max-w-[1200px] mx-auto px-5">
            <a href="index.do" class="text-4xl b-grade-font text-orange-500">D.D.M</a>
        </div>
    </header>

    <main class="max-container">
        <div class="bg-white rounded-[50px] shadow-2xl p-12 border-2 border-gray-100">
            <h2 class="text-5xl b-grade-font text-orange-500 mb-10 tracking-tighter text-center">
                회원가입
            </h2>

            <%-- [규율 2: 백엔드 로직 추론]
                 Action: join.do (MemberController)
                 MyBatis ID: insertMember
            --%>
            <form id="joinForm" action="<%=request.getContextPath()%>/InsertMember.do" method="post" class="space-y-7">
                
                <div class="space-y-2">
                    <label class="block text-sm font-black text-gray-500 ml-5">아이디</label>
                    <div class="flex gap-3">
                        <input type="text" name="memId" id="userId" class="input-base" placeholder="아이디를 입력해 주세요" required>
                        <button type="button" class="min-w-[110px] bg-orange-500 text-white rounded-full font-bold hover:bg-orange-600 active:scale-95 transition-all shadow-md">
                            중복확인
                        </button>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div class="space-y-2">
                        <label class="block text-sm font-black text-gray-500 ml-5">비밀번호</label>
                        <input type="password" name="memPw" id="userPw" class="input-base" placeholder="비밀번호 입력" required>
                    </div>
                    <div class="space-y-2">
                        <label class="block text-sm font-black text-gray-500 ml-5">비밀번호 확인</label>
                        <input type="password" id="userPwConfirm" class="input-base" placeholder="비밀번호 재입력" required>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <div class="space-y-2">
                        <label class="block text-sm font-black text-gray-500 ml-5">이름</label>
                        <input type="text" name="memName" class="input-base" placeholder="실명 입력" required>
                    </div>
                    <div class="space-y-2">
                        <label class="block text-sm font-black text-gray-500 ml-5">생년월일</label>
                        <input type="date" name="memBirth" class="input-base text-gray-400" required>
                    </div>
                </div>

                <div class="space-y-2">
                    <label class="block text-sm font-black text-gray-500 ml-5">이메일</label>
                    <div class="flex items-center gap-2 flex-wrap md:flex-nowrap">
                        <input type="text" id="emailPart1" class="input-base !w-full md:!w-1/3" placeholder="이메일 아이디" required>
                        <span class="font-bold text-gray-400">@</span>
                        <div class="relative w-full md:w-2/3">
                            <select id="emailSelect" class="input-base appearance-none cursor-pointer pr-10">
                                <option value="naver.com">naver.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="direct">직접입력</option>
                            </select>
                            <i class="fa-solid fa-chevron-down absolute right-5 top-4 text-gray-400 pointer-events-none"></i>
                        </div>
                    </div>
                    <input type="text" id="directEmail" class="input-base mt-2 hidden" placeholder="도메인을 입력해 주세요">
                    <input type="hidden" name="memEmail" id="fullEmail">
                </div>

                <div class="space-y-2">
                    <label class="block text-sm font-black text-gray-500 ml-5">기수 번호</label>
                    <input type="number" name="memGusu" class="input-base" min="0" value="0" required>
                </div>

                <div class="flex gap-4 pt-8">
                    <button type="submit" class="flex-[2] py-4 rounded-full text-xl b-grade-font text-white bg-orange-500 shadow-xl hover:bg-orange-600 hover:scale-[1.02] active:scale-95 transition-all border-b-4 border-orange-700">
                        회원가입 완료
                    </button>
                    <button type="button" onclick="history.back()" class="flex-1 py-4 rounded-full text-xl b-grade-font text-gray-400 bg-gray-100 hover:bg-gray-200 transition-all text-center">
                        취소
                    </button>
                </div>
            </form>
        </div>
    </main>

    <script>
        // 이메일 선택 제어
        const emailSelect = document.getElementById('emailSelect');
        const directEmail = document.getElementById('directEmail');
        emailSelect.addEventListener('change', (e) => {
            if (e.target.value === 'direct') {
                directEmail.classList.remove('hidden');
                directEmail.required = true;
            } else {
                directEmail.classList.add('hidden');
                directEmail.required = false;
            }
        });

        // 제출 전 데이터 처리
        document.getElementById('joinForm').onsubmit = function(e) {
            const pw = document.getElementById('userPw').value;
            const pwConfirm = document.getElementById('userPwConfirm').value;

            if (pw !== pwConfirm) {
                alert("비밀번호가 서로 다릅니다.");
                return false;
            }

            // 이메일 합치기
            const email1 = document.getElementById('emailPart1').value;
            const email2 = emailSelect.value === 'direct' ? directEmail.value : emailSelect.value;
            document.getElementById('fullEmail').value = email1 + "@" + email2;
            
            return true;
        };
    </script>
</body>
</html>