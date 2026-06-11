let currentStep = 1;
const totalSteps = 4;
let idAvailable = false;

/* ================= UI 업데이트 ================= */
function updateUI() {
    const bar = document.getElementById('progressBar');
    const steps = document.querySelectorAll('.step');
    const contents = document.querySelectorAll('.step-content');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');
    const btnGroup = document.getElementById('buttonGroup');

    if (!prevBtn || !nextBtn || !submitBtn || !btnGroup) {
        console.error('버튼 요소를 찾을 수 없습니다');
        return;
    }

    // 진행바
    bar.style.width = ((currentStep - 1) / (totalSteps - 1)) * 100 + '%';

    // 스텝
    steps.forEach((s, i) => {
        s.classList.remove('active', 'completed');
        if (i + 1 < currentStep) s.classList.add('completed');
        else if (i + 1 === currentStep) s.classList.add('active');
    });

    // 콘텐츠
    contents.forEach((c, i) => {
        c.classList.toggle('active', i + 1 === currentStep);
    });

    // 🔥 버튼 초기화
    btnGroup.style.display = 'flex';
    prevBtn.style.display = 'none';
    nextBtn.style.display = 'none';
    submitBtn.style.display = 'none';

    // 🔥 단계별 버튼
    switch (currentStep) {
        case 1:
            nextBtn.style.display = 'flex';
            break;
        case 2:
            prevBtn.style.display = 'flex';
            nextBtn.style.display = 'flex';
            break;
        case 3:
            prevBtn.style.display = 'flex';
            submitBtn.style.display = 'flex';
            break;
        case 4:
            btnGroup.style.display = 'none';
            break;
    }
}




/* ================= 사업자 번호 포맷 ================= */
function formatBizNo() {
    const bizNoInput = document.getElementById('bizNo');
    if (!bizNoInput) return;

    bizNoInput.addEventListener('input', function () {
        let value = this.value.replace(/\D/g, '').slice(0, 10);

        if (value.length > 5) {
            value = value.replace(/^(\d{3})(\d{2})(\d+)/, '$1-$2-$3');
        } else if (value.length > 3) {
            value = value.replace(/^(\d{3})(\d+)/, '$1-$2');
        }

        this.value = value;
    });
}

/* ================= 아이디 중복 체크 ================= */
function initIdCheck() {
    const checkBtn = document.getElementById('checkIdBtn');
    if (!checkBtn) return;
    
    checkBtn.addEventListener('click', () => {
        const userId = document.getElementById('userId').value.trim();  // 👈 변경
        const result = document.getElementById('idCheckResult');
        
        if (!userId) {
            alert('아이디를 입력해주세요.');
            return;
        }
        
        fetch('checkId.jsp?user_id=' + encodeURIComponent(userId))  // 👈 변경
            .then(res => res.text())
            .then(data => {
                if (data.trim() === 'available') {
                    result.className = 'success-msg';
                    result.textContent = '✓ 사용 가능한 아이디입니다.';
                    idAvailable = true;
                } else {
                    result.className = 'error-msg';
                    result.textContent = '✗ 이미 사용 중인 아이디입니다.';
                    idAvailable = false;
                }
            })
            .catch(() => alert('아이디 확인 중 오류가 발생했습니다.'));
    });
}

/* ================= 주소 검색 ================= */
function initAddressSearch() {
    const btn = document.getElementById('addrSearchBtn');
    if (!btn) return;

    btn.addEventListener('click', () => {
        new daum.Postcode({
            oncomplete: function (data) {
                document.getElementById('storeAddr1').value =
                    data.roadAddress || data.jibunAddress;
                document.getElementById('storeAddr2').focus();
            }
        }).open();
    });
}



/* ================= 사진 미리보기 (최대 4개, 이전 사진 유지) ================= */
function initImagePreview() {
    const fileInput = document.getElementById('fileInput');
    const previewContainer = document.getElementById('previewContainer');

    // 현재 업로드된 파일을 저장할 배열
    let uploadedFiles = [];

    fileInput.addEventListener('change', () => {
        const newFiles = Array.from(fileInput.files);

        // 최대 4개까지만 허용
        if (uploadedFiles.length + newFiles.length > 4) {
            alert('사진은 최대 4개까지 업로드할 수 있습니다.');
            return;
        }

        // 새로 선택된 파일을 배열에 추가
        uploadedFiles = uploadedFiles.concat(newFiles);

        // 미리보기 초기화
        previewContainer.innerHTML = '';

        uploadedFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = (e) => {
                const img = document.createElement('img');
                img.src = e.target.result;
                previewContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
        });

        // fileInput 초기화 (같은 파일 재선택 시 이벤트 발생하도록)
        fileInput.value = '';
    });
}

/* ================= 운영시간 분 선택 후 자동 닫기 ================= */

function initTimeSelectClose() {
    const selects = document.querySelectorAll('#store_open_minute, #store_close_minute');

    selects.forEach(select => {
        select.addEventListener('change', () => {
            select.blur(); // 선택 후 바로 닫기
        });
    });
}



/* ================= 버튼 ================= */
function initStepButtons() {
    const form = document.getElementById('storeForm');

    document.getElementById('nextBtn').addEventListener('click', () => {
        if (currentStep < totalSteps) {
            currentStep++;
            updateUI();
        }
    });

    document.getElementById('prevBtn').addEventListener('click', () => {
        if (currentStep > 1) {
            currentStep--;
            updateUI();
        }
    });
	
	document.getElementById('submitBtn').addEventListener('click', () => {
	    currentStep = 4;
	    updateUI();
	});
}

/* ================= 초기화 ================= */
document.addEventListener('DOMContentLoaded', () => {
    formatBizNo();
    initIdCheck();
    initAddressSearch();
    initStepButtons();   
    initImagePreview();
	initTimeSelectClose();
    updateUI();
});
