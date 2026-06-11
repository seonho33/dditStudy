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
        .content { padding: 40px 80px; }
        .step-content { display: none; }
        .step-content.active { display: block; animation: fadeIn 0.4s; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .form-row { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; margin-bottom: 20px; }
        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #191f28; font-size: 14px; }
        .required { color: #f04452; margin-left: 3px; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 12px 16px; border: 1px solid #d7dbdf; border-radius: 8px; font-size: 14px; color: #191f28; transition: all 0.2s; }
        .form-group input:focus { outline: none; border-color: #3182f6; box-shadow: 0 0 0 3px rgba(49, 130, 246, 0.1); }
        .button-group { display: flex; gap: 12px; margin-top: 40px; padding-top: 30px; border-top: 1px solid #f0f0f0; }
        .btn { padding: 14px 16px; border: none; border-radius: 8px;  display: flex; justify-content: center; align-items: center;
        font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s;  text-align: center; }
        .btn-primary { background: #3182f6; color: white; flex: 1; }
        .btn-secondary { background: #f2f4f6; color: #191f28; }
    	.btn:active { transform: scale(0.98); }
        .btn-small { padding: 8px 12px; font-size: 13px; margin-top: 5px; display: inline-block; }
        .image-upload { border: 2px dashed #d7dbdf; border-radius: 12px; padding: 40px; text-align: center; cursor: pointer; background: #f9fafb; }
        .address-group { display: flex; gap: 12px; align-items: center; }
		.address-group input { flex: 1; height: 44px; padding: 0 12px; font-size: 14px; border-radius: 8px; box-sizing: border-box; border: 1px solid #d7dbdf; }
		.address-group button { height: 44px; padding: 0 16px; display: flex; align-items: center; justify-content: center; font-size: 14px; border-radius: 8px; box-sizing: border-box; cursor: pointer; line-height: 44px; margin: 0; border: none; background-color: #f2f4f6; font-family: inherit; }
		.step4-btn { width: 100%; max-width: 400px; margin: 0 auto; }
		#storeAddr2 { margin-top: 12px; padding: 0 12px; height: 44px; border-radius: 8px; border: 1px solid #d7dbdf; font-size: 14px; box-sizing: border-box; width: 100%; }
		#previewContainer img { max-width: 100%; max-height: 200px; border-radius: 8px; margin-top: 10px; object-fit: contain; display: block; }
		#buttonGroup {display: flex !important;}
        .error-msg { color: #f04452; font-size: 13px; margin-top: 5px; }
        .success-msg { color: #05a154; font-size: 13px; margin-top: 5px; }
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
		    <form id="storeForm" method="post" action="${pageContext.request.contextPath}/registerStore.do" enctype="multipart/form-data">
		        
		        <div class="step-content active" data-step="1">
		            <h2 style="font-size: 22px; font-weight: 700; margin-bottom: 20px; color: #191f28;">계정 정보 입력</h2>
		            <div class="form-row">
		                <div class="form-group">
		                    <label>이용자 아이디 <span class="required">*</span></label>
		                    <input type="text" name="user_id" placeholder="사용할 아이디" id="userId" required>
		                    <button type="button" id="checkIdBtn" class="btn btn-secondary btn-small">중복 확인</button>
		                    <span id="idCheckResult"></span>
		                </div>
		                <div class="form-group">
		                    <label>이용자 비밀번호 <span class="required">*</span></label>
		                    <input type="password" name="mem_pass" placeholder="비밀번호 입력" required>
		                </div>
		            </div>
		            <div class="form-row">
		                <div class="form-group">
		                    <label>이용자 이름 <span class="required">*</span></label>
		                    <input type="text" name="mem_name" placeholder="대표자 성함" required>
		                </div>
		                <div class="form-group">
		                    <label>대표자 이메일 <span class="required">*</span></label>
		                    <input type="email" name="mem_mail" placeholder="email@example.com" required>
		                </div>
		            </div>
		            <div class="form-group">
		                <label>사업자 등록번호 <span class="required">*</span></label>
		                <input type="text" name="store_bis_no" id="bizNo" placeholder="000-00-00000" maxlength="12" required>
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
                        <div class="address-group">
                            <input type="text" name="store_addr1" id="storeAddr1" placeholder="주소 검색" readonly class="address-input">
                            <button type="button" id="addrSearchBtn" class="btn btn-secondary btn-small">검색</button>
                        </div>
                        <input type="text" name="store_addr2" id="storeAddr2" placeholder="상세 주소를 입력하세요">
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>가게 전화번호 <span class="required">*</span></label>
                            <input type="tel" name="store_tel" placeholder="02-1234-5678">
                        </div>
                        <div class="form-group">
                            <label>카테고리 <span class="required">*</span></label>
                            <select name="store_category">
                                <option>한식</option><option>중식</option><option>일식</option><option>양식</option><option>카페</option><option>기타</option>
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
						    <input type="file" id="fileInput" name="store_img" multiple style="display:none" accept="image/*">
						    <div id="previewContainer"></div> 
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
                    <div style="text-align:center;">
				        <button type="submit" class="btn btn-primary step4-btn">
				            가입 승인 요청
				        </button>
				    </div>
                </div>
				
                <div class="button-group" id="buttonGroup" style="display:flex;">
				    <button type="button" class="btn btn-secondary" id="prevBtn">이전</button>
				    <button type="button" class="btn btn-primary" id="nextBtn">다음</button>
				    <button type="button" class="btn btn-primary" id="submitBtn">등록 완료</button>
				</div>
			
            </form>
        </div>
    </div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
	<script src="${pageContext.request.contextPath}/TEST/js/store/register.js"></script>
	<!-- <script src="${pageContext.request.contextPath}/TEST/js/store/register.js"></script> -->
    
</body>
</html>