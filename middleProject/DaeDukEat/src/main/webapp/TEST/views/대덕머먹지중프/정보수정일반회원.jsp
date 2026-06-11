<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="max-w-md mx-auto animate-slideUp">
    <div id="edit-auth-section" class="text-center py-10">
        <div class="w-20 h-20 bg-orange-100 text-orange-500 rounded-full flex items-center justify-center text-3xl mx-auto mb-6">
            <i class="fa-solid fa-shield-halved"></i>
        </div>
        <h3 class="text-2xl font-black text-slate-800 mb-2">본인 확인</h3>
        <p class="text-slate-400 text-sm mb-8 font-medium">안전한 정보 수정을 위해 비밀번호를 입력해주세요.</p>
        
        <input type="hidden" id="auth-mem-id" value="${userVO.mem_id}">
        
        <input type="password" id="confirm-pw" class="w-full p-5 border-2 border-slate-100 rounded-2xl focus:border-orange-500 outline-none text-center text-xl transition-all" placeholder="현재 비밀번호 입력">
        
        <button onclick="verifyPassword()" class="w-full mt-6 bg-slate-900 text-white py-5 rounded-2xl font-black hover:bg-orange-600 transition-all shadow-lg">인증 및 수정하기</button>
    </div>

    <form id="edit-form-section" class="hidden space-y-6" action="updateMember.do" method="post" onsubmit="return validateForm()">
        <div class="flex items-center gap-4 mb-10">
            <div class="w-1 bg-orange-500 h-8 rounded-full"></div>
            <h3 class="text-2xl font-black text-slate-800">프로필 수정</h3>
        </div>
        
        <input type="hidden" name="mem_id" value="${userVO.mem_id}">
        
        <div>
            <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">이름 (Full Name)</label>
            <input type="text" name="mem_name" value="${userVO.mem_name}" class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500/20">
        </div>

        <div>
            <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">이메일 주소 (Email Address)</label>
            <input type="email" id="mem_mail" name="mem_mail" value="${userVO.mem_mail}" class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500/20" placeholder="example@ddm.com">
        </div>
        
        <div>
            <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">연락처 (Phone Number)</label>
            <input type="text" name="mem_hp" value="${userVO.mem_hp}" class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500/20">
        </div>

        <div>
            <label class="text-[10px] font-black text-slate-400 ml-2 mb-2 block uppercase tracking-tighter">새 비밀번호 (New Password)</label>
            <input type="password" name="mem_pass" placeholder="변경할 비밀번호 입력 (미입력 시 기존 비밀번호 유지)" class="w-full p-4 bg-slate-50 border-none rounded-2xl font-bold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500/20">
        </div>
        
        <div class="flex gap-4 pt-6">
            <button type="button" onclick="loadPage('info', 'memberProfile.jsp')" class="flex-1 py-4 bg-slate-100 text-slate-400 rounded-2xl font-bold hover:bg-slate-200 transition-all">취소</button>
            <button type="submit" class="flex-[2] py-4 bg-orange-500 text-white rounded-2xl font-black shadow-lg shadow-orange-200 hover:bg-orange-600 transition-all">수정 내용 저장</button>
        </div>
    </form>
</div>

<script>
    /**
     * 비밀번호 검증 (Ajax 호출)
     */
    function verifyPassword() {
        const memId = document.getElementById('auth-mem-id').value;
        const memPass = document.getElementById('confirm-pw').value;

        if(!memPass) {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        // 서버에 비밀번호 일치 여부 확인 요청
        fetch('checkPassword.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `mem_id=\${memId}&mem_pass=\${memPass}`
        })
        .then(response => response.json())
        .then(data => {
            if(data.result === "success") {
                // 인증 성공 시 수정 폼 노출
                document.getElementById('edit-auth-section').classList.add('hidden');
                document.getElementById('edit-form-section').classList.remove('hidden');
            } else {
                alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
                document.getElementById('confirm-pw').value = "";
                document.getElementById('confirm-pw').focus();
            }
        })
        .catch(err => {
            console.error("인증 처리 중 오류 발생:", err);
            alert("인증 서버와 통신 중 오류가 발생했습니다.");
        });
    }

    /**
     * 폼 유효성 검사
     */
    function validateForm() {
        const email = document.getElementById('mem_mail').value;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        if (email && !emailRegex.test(email)) {
            alert("유효한 이메일 형식을 입력해주세요.");
            return false;
        }
        
        if(!confirm("입력하신 정보로 수정하시겠습니까?")) {
            return false;
        }
        
        return true;
    }
</script>