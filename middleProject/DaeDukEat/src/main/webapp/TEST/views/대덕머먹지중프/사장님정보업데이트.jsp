<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="animate-fadeIn max-w-2xl mx-auto">
    <div class="text-center mb-12">
        <p class="text-sky-500 font-black text-xs uppercase tracking-widest mb-2">Security & Profile</p>
        <h3 class="text-3xl font-black text-slate-800">내 정보 관리</h3>
        <p class="text-slate-400 text-sm font-bold mt-2">안전한 정보 수정을 위해 본인 확인이 필요합니다.</p>
    </div>

    <div id="pw-check-step" class="bg-white border-2 border-slate-100 rounded-[40px] p-12 shadow-sm transition-all">
        <div class="flex flex-col items-center">
            <div class="w-20 h-20 bg-slate-50 text-slate-300 rounded-full flex items-center justify-center text-3xl mb-8">
                <i class="fa-solid fa-lock"></i>
            </div>
            <div class="w-full space-y-6">
                <div>
                    <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Current Password</label>
                    <input type="password" id="confirm-pw" placeholder="현재 비밀번호를 입력하세요" 
                           class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700">
                </div>
                <button onclick="verifyPassword()" class="w-full py-5 bg-slate-900 text-white rounded-[25px] font-black text-sm shadow-xl hover:bg-sky-500 transition-all active:scale-95">
                    본인 확인하기
                </button>
            </div>
        </div>
    </div>

    <div id="profile-edit-step" class="hidden bg-white border-2 border-slate-100 rounded-[40px] p-12 shadow-sm transition-all">
        <form action="updateProfile.do" method="POST" onsubmit="return validateProfileForm()" class="space-y-8">
            <div>
                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Owner ID</label>
                <input type="text" value="owner_admin_01" readonly 
                       class="w-full bg-slate-100 border-none rounded-2xl px-6 py-4 font-black text-slate-400 cursor-not-allowed">
            </div>

            <div>
                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Owner Name</label>
                <input type="text" name="ownerName" id="edit-name" value="박사장님" 
                       class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700">
            </div>

            <div>
                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">Email Address</label>
                <input type="email" name="ownerEmail" id="edit-email" value="owner@ddm.com" 
                       class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700">
            </div>

            <div>
                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-3 ml-1">New Password</label>
                <input type="password" name="ownerPw" id="edit-pw" placeholder="변경할 비밀번호를 입력 (미입력 시 기존 유지)" 
                       class="w-full bg-slate-50 border-2 border-transparent rounded-2xl px-6 py-4 font-bold outline-none focus:border-sky-500/30 focus:bg-white transition-all text-slate-700">
            </div>

            <div class="flex gap-4 pt-4">
                <button type="button" onclick="location.reload()" class="flex-1 py-5 bg-slate-100 text-slate-400 rounded-[25px] font-black text-sm hover:bg-slate-200 transition-all">
                    취소
                </button>
                <button type="submit" class="flex-2 px-12 py-5 bg-sky-500 text-white rounded-[25px] font-black text-sm shadow-lg shadow-sky-100 hover:bg-sky-600 transition-all active:scale-95">
                    정보 수정 완료
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    /**
     * 본인 확인 (임시 로직)
     */
    function verifyPassword() {
        const pw = document.getElementById('confirm-pw').value;
        
        if(!pw) {
            alert("비밀번호를 입력해주세요.");
            return;
        }

        // 실제로는 Ajax로 DB 비밀번호와 대조해야 합니다.
        // 여기서는 임시로 '1234'일 때 통과되도록 설정했습니다.
        if(pw === "1234") {
            document.getElementById('pw-check-step').classList.add('hidden');
            document.getElementById('profile-edit-step').classList.remove('hidden');
        } else {
            alert("비밀번호가 일치하지 않습니다. (테스트 비번: 1234)");
        }
    }

    /**
     * 폼 유효성 검사
     */
    function validateProfileForm() {
        const name = document.getElementById('edit-name').value;
        const email = document.getElementById('edit-email').value;

        if(!name || !email) {
            alert("이름과 이메일은 필수 입력 항목입니다.");
            return false;
        }
        
        if(confirm("수정된 정보를 저장하시겠습니까?")) {
            return true;
        }
        return false;
    }
</script>