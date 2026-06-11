<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M 가게 등록</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* [디자인 보존] 사용자님이 주신 토스 화이트 스타일 100% */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); width: 100%; max-width: 900px; overflow: hidden; }
        .header { background: white; padding: 40px; text-align: center; border-bottom: 1px solid #f0f0f0; }
        .logo-icon { width: 70px; height: 70px; background: #3182f6; border-radius: 16px; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; }
        .logo-icon i { font-size: 35px; color: white; }
        .header h1 { font-size: 26px; color: #191f28; margin-bottom: 8px; font-weight: 700; }
        .header p { color: #8b95a1; font-size: 14px; }
        .progress-container { background: white; padding: 30px 40px; border-bottom: 1px solid #f0f0f0; }
        .progress-steps { display: flex; justify-content: space-between; align-items: center; position: relative; max-width: 600px; margin: 0 auto; }
        .progress-line { position: absolute; top: 20px; left: 0; right: 0; height: 2px; background: #e5e8eb; z-index: 1; }
        .progress-line-active { position: absolute; top: 0; left: 0; height: 100%; background: #3182f6; transition: width 0.3s ease; z-index: 2; }
        .step { position: relative; z-index: 3; text-align: center; flex: 1; }
        .step-circle { width: 40px; height: 40px; border-radius: 50%; background: white; border: 2px solid #e5e8eb; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px; font-weight: 700; color: #8b95a1; transition: all 0.3s; font-size: 14px; }
        .step.active .step-circle { background: #3182f6; border-color: #3182f6; color: white; }
        .step.completed .step-circle { background: #3182f6; border-color: #3182f6; color: white; }
        .step-label { font-size: 13px; color: #8b95a1; font-weight: 500; }
        .step.active .step-label { color: #3182f6; font-weight: 600; }
        .content { padding: 40px; }
        .step-content { display: none; }
        .step-content.active { display: block; animation: fadeIn 0.4s; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .form-row { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #191f28; font-size: 14px; }
        .required { color: #f04452; margin-left: 3px; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 12px 16px; border: 1px solid #d7dbdf; border-radius: 8px; font-size: 14px; color: #191f28; transition: all 0.2s; }
        .form-group input:focus { outline: none; border-color: #3182f6; box-shadow: 0 0 0 3px rgba(49, 130, 246, 0.1); }
        .button-group { display: flex; gap: 12px; margin-top: 40px; padding-top: 30px; border-top: 1px solid #f0f0f0; }
        .btn { flex: 1; padding: 14px; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-primary { background: #3182f6; color: white; }
        .btn-secondary { background: #f2f4f6; color: #191f28; }
        .image-upload { border: 2px dashed #d7dbdf; border-radius: 12px; padding: 40px; text-align: center; cursor: pointer; background: #f9fafb; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo-icon"><i class="fas fa-store"></i></div>
            <h1>사장님, 환영합니다!</h1>
            <p>D.D.M에서 멋진 가게를 등록해 보세요</p>
        </div>

        <div class="progress-container">
            <div class="progress-steps">
                <div class="progress-line"><div class="progress-line-active" id="progressBar"></div></div>
                <div class="step active" data-step="1"><div class="step-circle">1</div><div class="step-label">이용자 정보</div></div>
                <div class="step" data-step="2"><div class="step-circle">2</div><div class="step-label">가게 정보</div></div>
                <div class="step" data-step="3"><div class="step-circle">3</div><div class="step-label">운영 정보</div></div>
                <div class="step" data-step="4"><div class="step-circle">4</div><div class="step-label">완료</div></div>
            </div>
        </div>

        <div class="content">
            <form id="storeForm">
                <div class="step-content active" data-step="1">
                    <h2 style="font-size: 22px; font-weight: 700; margin-bottom: 20px; color: #191f28;">계정 정보 입력</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label>이용자 아이디 <span class="required">*</span></label>
                            <input type="text" name="mem_id" placeholder="사용할 아이디">
                        </div>
                        <div class="form-group">
                            <label>이용자 비밀번호 <span class="required">*</span></label>
                            <input type="password" name="mem_pass" placeholder="비밀번호 입력">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>이용자 이름 <span class="required">*</span></label>
                            <input type="text" name="mem_name" placeholder="대표자 성함">
                        </div>
                        <div class="form-group">
                            <label>대표자 이메일 <span class="required">*</span></label>
                            <input type="email" name="mem_mail" placeholder="email@example.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>사업자 등록번호 <span class="required">*</span></label>
                        <input type="text" name="store_bis_no" placeholder="000-00-00000">
                    </div>
                </div>

                <div class="step-content" data-step="2">
                    <h2 style="font-size: 22px; font-weight: 700; margin-bottom: 20px; color: #191f28;">가게 상세 정보</h2>
                    <div class="form-group">
                        <label>가게 이름 <span class="required">*</span></label>
                        <input type="text" name="store_name" placeholder="가게 명칭">
                    </div>
                    <div class="form-group">
                        <label>가게 주소 <span class="required">*</span></label>
                        <input type="text" name="store_addr1" placeholder="주소 검색 버튼을 눌러주세요" readonly style="margin-bottom:10px;">
                        <input type="text" name="store_addr2" placeholder="상세 주소를 입력하세요">
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>가게 전화번호 <span class="required">*</span></label>
                            <input type="tel" name="store_tel" placeholder="02-1234-5678">
                        </div>
                        <div class="form-group">
                            <label>카테고리 <span class="required">*</span></label>
                            <select name="store_category">
                                <option>한식</option><option>중식</option><option>일식</option><option>양식</option><option>카페</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>가게 예약금 <span class="required">*</span></label>
                        <input type="number" name="store_deposit" placeholder="1인 기준 예약 금액(원)">
                    </div>
                    <div class="form-group">
                        <label>가게 내용 <span class="required">*</span></label>
                        <textarea name="store_cont" placeholder="가게의 특징을 설명해주세요"></textarea>
                    </div>
                </div>

                <div class="step-content" data-step="3">
                    <h2 style="font-size: 22px; font-weight: 700; margin-bottom: 20px; color: #191f28;">운영 정보</h2>
                    <div class="form-group">
                        <label>운영 시간 <span class="required">*</span></label>
                        <div class="form-row">
                            <input type="time" name="store_open" value="09:00">
                            <input type="time" name="store_close" value="21:00">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>가게 사진 <span class="required">*</span></label>
                        <div class="image-upload" onclick="document.getElementById('fileInput').click()">
                            <i class="fas fa-camera" style="font-size: 30px; color: #3182f6; margin-bottom: 10px;"></i>
                            <p>클릭하여 사진 추가</p>
                            <input type="file" id="fileInput" name="store_img" multiple style="display:none">
                        </div>
                    </div>
                </div>

                <div class="step-content" data-step="4">
                    <div style="text-align: center; padding: 40px 0;">
                        <div style="width: 80px; height: 80px; background: #3182f6; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px;">
                            <i class="fas fa-check" style="color: white; font-size: 40px;"></i>
                        </div>
                        <h2 style="font-size: 26px; font-weight: 700;">모든 준비가 끝났습니다!</h2>
                        <p style="color: #8b95a1; margin-top: 12px;">입력하신 정보로 등록을 완료하시겠습니까?</p>
                    </div>
                </div>

                <div class="button-group" id="buttonGroup">
                    <button type="button" class="btn btn-secondary" id="prevBtn" style="display:none">이전</button>
                    <button type="button" class="btn btn-primary" id="nextBtn">다음</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let currentStep = 1;
        const totalSteps = 4;

        function updateUI() {
            const bar = document.getElementById('progressBar');
            const steps = document.querySelectorAll('.step');
            const contents = document.querySelectorAll('.step-content');
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');
            const btnGroup = document.getElementById('buttonGroup');

            bar.style.width = ((currentStep - 1) / (totalSteps - 1) * 100) + '%';
            steps.forEach((s, i) => {
                if(i+1 < currentStep) s.classList.add('completed');
                else if(i+1 === currentStep) s.classList.add('active');
                else s.classList.remove('active', 'completed');
            });
            contents.forEach((c, i) => c.classList.toggle('active', i+1 === currentStep));

            prevBtn.style.display = currentStep > 1 ? 'block' : 'none';
            if(currentStep === totalSteps) btnGroup.style.display = 'none';
            else nextBtn.textContent = currentStep === 3 ? '등록 요청' : '다음';
        }

        document.getElementById('nextBtn').addEventListener('click', () => { if(currentStep < totalSteps) { currentStep++; updateUI(); }});
        document.getElementById('prevBtn').addEventListener('click', () => { if(currentStep > 1) { currentStep--; updateUI(); }});
    </script>
</body>
</html>