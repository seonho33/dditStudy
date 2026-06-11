<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 관리</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Outfit', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }
        
        .review-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        /* ===== 탭 디자인 ===== */
        .tab-container {
            display: flex;
            border-bottom: 3px solid #e9ecef;
            margin-bottom: 30px;
            background: white;
            border-radius: 10px 10px 0 0;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .tab-button {
            flex: 1;
            padding: 18px 24px;
            border: none;
            background: white;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            color: #6c757d;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .tab-button:hover {
            background: #f8f9fa;
            color: #495057;
        }
        
        .tab-button.active {
            color: #FF6B35;
            background: linear-gradient(to bottom, #fff 0%, #fff5f2 100%);
        }
        
        .tab-button.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #FF6B35 0%, #FF8C42 100%);
        }
        
        /* ===== 리뷰 카드 디자인 ===== */
        .review-card {
            background: white;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .review-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .store-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .store-name {
            font-size: 20px;
            font-weight: 700;
            color: #212529;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .store-name::before {
            content: '🍽️';
            font-size: 24px;
        }
        
        .reserv-date {
            color: #6c757d;
            font-size: 14px;
            font-weight: 500;
            background: #f8f9fa;
            padding: 6px 12px;
            border-radius: 6px;
        }
        
        .reservation-detail {
            color: #495057;
            font-size: 15px;
            margin-bottom: 16px;
            display: flex;
            gap: 16px;
        }
        
        .reservation-detail span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .review-text {
            margin: 16px 0;
            line-height: 1.7;
            color: #212529;
            font-size: 15px;
            background: #f8f9fa;
            padding: 16px;
            border-radius: 8px;
            border-left: 4px solid #FF6B35;
        }
        
        .review-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 16px;
        }
        
        /* ===== 버튼 디자인 ===== */
        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8C42 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }
        
        .btn-primary:active {
            transform: translateY(0);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        /* ===== 모달 디자인 ===== */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* ✨ [추가] 페이드아웃 애니메이션 ✨ */
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        /* ✨ [추가 끝] ✨ */
        
        @keyframes slideUp {
            from {
                transform: translate(-50%, -45%);
                opacity: 0;
            }
            to {
                transform: translate(-50%, -50%);
                opacity: 1;
            }
        }
        
        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.4s ease;
        }
        
        .modal-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .modal-header h3 {
            font-size: 24px;
            color: #212529;
            margin: 0;
        }
        
        .modal-header::before {
            content: '✍️';
            font-size: 32px;
        }
        
        /* ===== 별점 디자인 ===== */
        .rating-section {
            margin: 24px 0;
            text-align: center;
        }
        
        .rating-label {
            font-size: 16px;
            color: #495057;
            margin-bottom: 12px;
            font-weight: 600;
        }
        
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 8px;
            margin: 16px 0;
        }
        
        .rating-input input {
            display: none;
        }
        
        .rating-input label {
            font-size: 40px;
            color: #dee2e6;
            cursor: pointer;
            transition: all 0.2s ease;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }
        
        .rating-input label:hover,
        .rating-input label:hover ~ label {
            color: #FFD700;
            transform: scale(1.1);
        }
        
        .rating-input input:checked ~ label {
            color: #FFD700;
        }
        
        .rating-input input:checked + label {
            animation: starPulse 0.3s ease;
        }
        
        @keyframes starPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }
        
        /* ===== 텍스트 영역 ===== */
        textarea {
            width: 100%;
            padding: 16px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 15px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s ease;
        }
        
        textarea:focus {
            outline: none;
            border-color: #FF6B35;
            box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.1);
        }
        
        /* ===== 별점 표시 ===== */
        .rating-stars {
            color: #FFD700;
            font-size: 1.3rem;
            margin: 8px 0;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }
        
        /* ===== 빈 상태 ===== */
        .empty-message {
            text-align: center;
            padding: 80px 20px;
            color: #6c757d;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .empty-message::before {
            content: '📝';
            font-size: 64px;
            display: block;
            margin-bottom: 16px;
        }
        
        .empty-message p:first-of-type {
            font-size: 18px;
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }
        
        /* ✨✨✨ [수정 시작] 기존 알림/확인 모달을 프리미엄 스타일로 변경 ✨✨✨ */
        /* 기존 confirm-modal 스타일 삭제하고 프리미엄 스타일 적용 */
        
        /* ✨ [수정] 프리미엄 알림 모달 오버레이 - 중앙 정렬 수정 ✨ */
        .alert-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(8px);
            display: none; /* 초기 상태는 숨김 */
            align-items: center; /* 수직 중앙 정렬 */
            justify-content: center; /* 수평 중앙 정렬 */
            z-index: 20000;
            padding: 20px;
            font-family: 'Outfit', 'Pretendard', sans-serif;
        }
        
        .alert-modal-overlay.active {
            display: flex !important; /* flex로 변경하여 중앙 정렬 활성화 */
            animation: fadeIn 0.3s ease-out;
        }
        
        /* ✨ [추가] 닫힘 애니메이션 ✨ */
        .alert-modal-overlay.closing {
            animation: fadeOut 0.3s ease-out;
        }
        /* ✨ [추가 끝] ✨ */
        /* ✨ [수정 끝] ✨ */
        
        /* ✨ [수정] 프리미엄 알림 모달 콘텐츠 - 중앙 정렬 개선 ✨ */
        .alert-modal-content {
            background: white;
            border-radius: 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 30px 90px rgba(0,0,0,0.4);
            animation: modalZoomIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            position: relative; /* absolute 제거 */
            overflow: hidden;
            margin: auto; /* 자동 마진으로 중앙 정렬 */
        }
        
        @keyframes modalZoomIn {
            from {
                opacity: 0;
                transform: scale(0.8) translateY(50px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }
        
        /* ✨ [추가] 모달 줌아웃 애니메이션 ✨ */
        @keyframes modalZoomOut {
            from {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
            to {
                opacity: 0;
                transform: scale(0.8) translateY(50px);
            }
        }
        
        .alert-modal-overlay.closing .alert-modal-content {
            animation: modalZoomOut 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        /* ✨ [추가 끝] ✨ */
        /* ✨ [수정 끝] ✨ */
        
        .alert-modal-body {
            padding: 60px 40px 40px 40px;
            text-align: center;
        }
        
        .alert-modal-icon {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px auto;
            font-size: 48px;
            position: relative;
        }
        
        .alert-modal-icon.info {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #1e40af;
        }
        
        .alert-modal-icon.success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
        }
        
        .alert-modal-icon.error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
        }
        
        .alert-modal-icon.warning {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
        }
        
        .alert-modal-icon::before {
            content: '';
            position: absolute;
            width: 120%;
            height: 120%;
            border-radius: 50%;
            opacity: 0.2;
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.2; }
            50% { transform: scale(1.1); opacity: 0.1; }
        }
        
        .alert-modal-icon.info::before {
            background: #3b82f6;
        }
        
        .alert-modal-icon.success::before {
            background: #10b981;
        }
        
        .alert-modal-icon.error::before {
            background: #ef4444;
        }
        
        .alert-modal-icon.warning::before {
            background: #f59e0b;
        }
        
        .alert-modal-title {
            font-size: 28px;
            font-weight: 900;
            color: #1e293b;
            margin: 0 0 15px 0;
            line-height: 1.3;
        }
        
        .alert-modal-message {
            font-size: 16px;
            color: #64748b;
            line-height: 1.7;
            margin: 0 0 30px 0;
            font-weight: 500;
            white-space: pre-line;
        }
        
        .alert-modal-buttons {
            display: flex;
            gap: 12px;
        }
        
        .alert-modal-btn {
            flex: 1;
            padding: 16px 24px;
            border-radius: 16px;
            font-weight: 800;
            font-size: 15px;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .alert-modal-btn-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
        }
        
        .alert-modal-btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(59, 130, 246, 0.4);
        }
        
        .alert-modal-btn-secondary {
            background: #f1f5f9;
            color: #64748b;
        }
        
        .alert-modal-btn-secondary:hover {
            background: #e2e8f0;
            color: #475569;
            transform: translateY(-2px);
        }
        
        .alert-modal-btn-success {
            background: linear-gradient(135deg, #10b981 0%, #34d399 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
        }
        
        .alert-modal-btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(16, 185, 129, 0.4);
        }
        
        .alert-modal-btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #f87171 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(239, 68, 68, 0.3);
        }
        
        .alert-modal-btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(239, 68, 68, 0.4);
        }
        /* ✨✨✨ [수정 끝] ✨✨✨ */
        
        /* ===== 로딩 애니메이션 ===== */
        .loading {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
        
        .loading::after {
            content: '...';
            animation: dots 1.5s infinite;
        }
        
        @keyframes dots {
            0%, 20% { content: '.'; }
            40% { content: '..'; }
            60%, 100% { content: '...'; }
        }
        
        /* ✨ [추가] 반응형 디자인 ✨ */
        @media (max-width: 768px) {
            .alert-modal-body {
                padding: 40px 20px 30px 20px;
            }
            
            .alert-modal-icon {
                width: 80px;
                height: 80px;
                font-size: 36px;
            }
            
            .alert-modal-title {
                font-size: 24px;
            }
            
            .alert-modal-buttons {
                flex-direction: column;
            }
        }
        /* ✨ [추가 끝] ✨ */
    </style>
</head>
<body>
    <div class="review-container">
        <div class="tab-container">
            <button id="tabUnwritten" class="tab-button active" onclick="loadTab('unwrittenContent')">
                작성 가능한 리뷰
            </button>
            <button id="tabMylist" class="tab-button" onclick="loadTab('myReviewContent')">
                내가 작성한 리뷰
            </button>
        </div>
        
        <div id="listContainer">
            </div>
    </div>
    
    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalStoreName"></h3>
            </div>
            <form id="reviewForm">
                <input type="hidden" name="reservId" id="modalReservId">
                
                <div class="rating-section">
                    <div class="rating-label">이 가게는 어떠셨나요?</div>
                    <div class="rating-input">
                        <input type="radio" name="rating" value="5" id="star5" required>
                        <label for="star5">★</label>
                        <input type="radio" name="rating" value="4" id="star4">
                        <label for="star4">★</label>
                        <input type="radio" name="rating" value="3" id="star3">
                        <label for="star3">★</label>
                        <input type="radio" name="rating" value="2" id="star2">
                        <label for="star2">★</label>
                        <input type="radio" name="rating" value="1" id="star1">
                        <label for="star1">★</label>
                    </div>
                </div>
                
                <textarea name="review" rows="5" placeholder="솔직한 리뷰를 남겨주세요 😊" required></textarea>
                
                <div class="review-actions" style="justify-content: center; margin-top: 24px;">
                    <button type="button" class="btn btn-primary" onclick="submitReview()">
                        ✓ 리뷰 등록
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="closeReviewModal()">
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- ✨✨✨ [수정] 삭제 확인 모달을 프리미엄 스타일로 변경 ✨✨✨ -->
    <div id="deleteConfirmModal" class="alert-modal-overlay">
        <div class="alert-modal-content">
            <div class="alert-modal-body">
                <div class="alert-modal-icon warning">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <h3 class="alert-modal-title">리뷰 삭제</h3>
                <div class="alert-modal-message">
                    정말로 이 리뷰를 삭제하시겠습니까?
삭제된 리뷰는 복구할 수 없습니다.
                </div>
                <div class="alert-modal-buttons">
                    <button class="alert-modal-btn alert-modal-btn-danger" onclick="confirmDelete()">
                        삭제
                    </button>
                    <button class="alert-modal-btn alert-modal-btn-secondary" onclick="closeDeleteModal()">
                        취소
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- ✨✨✨ [수정 끝] ✨✨✨ -->

    <!-- ✨✨✨ [수정] 알림 모달을 프리미엄 스타일로 변경 ✨✨✨ -->
    <div id="alertModal" class="alert-modal-overlay">
        <div class="alert-modal-content">
            <div class="alert-modal-body">
                <div id="alert-icon" class="alert-modal-icon">
                    <i id="alert-icon-element"></i>
                </div>
                <h3 id="alertTitle" class="alert-modal-title">알림</h3>
                <div id="alertMessage" class="alert-modal-message"></div>
                <div class="alert-modal-buttons">
                    <button id="alert-confirm-btn" class="alert-modal-btn alert-modal-btn-primary" onclick="closeAlertModal()">확인</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ✨✨✨ [수정 끝] ✨✨✨ -->

<script>
    // ✅ 네임스페이스 객체로 관리
    window.ReviewApp = window.ReviewApp || {
        deleteTargetId: null,
        alertCallback: null
    };

    /* ✨✨✨ [수정] 커스텀 알림 함수를 프리미엄 스타일로 변경 ✨✨✨ */
    // type: 'info', 'success', 'error', 'warning'
    // title: 모달 제목
    // message: 모달 메시지
    // callback: 확인 버튼 클릭 시 실행할 콜백 함수
    window.showAlert = function(title, message, callback = null) {
        var modal = document.getElementById('alertModal');
        var icon = document.getElementById('alert-icon');
        var iconElement = document.getElementById('alert-icon-element');
        var titleElement = document.getElementById('alertTitle');
        var messageElement = document.getElementById('alertMessage');
        var confirmBtn = document.getElementById('alert-confirm-btn');
        
        // 제목에 따라 아이콘 타입 자동 설정
        var type = 'info';
        if (title === '알림' || title === '완료') {
            type = 'success';
            iconElement.className = 'fa-solid fa-check';
        } else if (title === '오류' || title === '실패') {
            type = 'error';
            iconElement.className = 'fa-solid fa-xmark';
        } else if (title === '경고') {
            type = 'warning';
            iconElement.className = 'fa-solid fa-triangle-exclamation';
        } else {
            type = 'info';
            iconElement.className = 'fa-solid fa-circle-info';
        }
        
        // 아이콘 클래스 설정
        icon.className = 'alert-modal-icon ' + type;
        
        // 제목과 메시지 설정
        titleElement.textContent = title;
        messageElement.textContent = message;
        
        // 콜백 저장
        window.ReviewApp.alertCallback = callback;
        
        // 모달 표시 (기존 style.display 방식 유지)
        modal.style.display = 'block';
        // 애니메이션을 위해 active 클래스 추가
        setTimeout(function() {
            modal.classList.add('active');
        }, 10);
    };

    /* ✨ [수정] closeAlertModal - 부드러운 닫힘 애니메이션 적용 ✨ */
    window.closeAlertModal = function() {
        var modal = document.getElementById('alertModal');
        
        // active 클래스 제거하고 closing 클래스 추가
        modal.classList.remove('active');
        modal.classList.add('closing');
        
        // 애니메이션이 끝난 후 display none 및 closing 클래스 제거
        setTimeout(function() {
            modal.style.display = 'none';
            modal.classList.remove('closing');
        }, 300);
        
        if (window.ReviewApp.alertCallback) {
            window.ReviewApp.alertCallback();
            window.ReviewApp.alertCallback = null;
        }
    };
    /* ✨✨✨ [수정 끝] ✨✨✨ */
    
    // 1. 탭 내용 로드 함수
    window.loadTab = function(action) {
        document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
        if(action === 'unwrittenContent') document.getElementById('tabUnwritten').classList.add('active');
        else document.getElementById('tabMylist').classList.add('active');

        const timestamp = new Date().getTime();
        fetch('${pageContext.request.contextPath}/review/' + action + '.do?t=' + timestamp)
            .then(res => res.text())
            .then(html => {
                document.getElementById('listContainer').innerHTML = html;
            })
            .catch(err => {
                console.error('Error loading tab:', err);
                document.getElementById('listContainer').innerHTML = 
                    '<div class="empty-message"><p>목록을 불러오는 중 오류가 발생했습니다.</p></div>';
            });
    };

    // 2. 리뷰 등록 함수
    window.submitReview = function() {
        const form = document.getElementById('reviewForm');
        const rating = form.querySelector('input[name="rating"]:checked');
        const review = form.querySelector('textarea[name="review"]').value.trim();
        
        if (!rating) {
            window.showAlert('알림', '별점을 선택해주세요.');
            return;
        }
        
        if (!review) {
            window.showAlert('알림', '리뷰 내용을 입력해주세요.');
            return;
        }
        
        const formData = new URLSearchParams(new FormData(form));

        fetch('${pageContext.request.contextPath}/review/writereview.do', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            window.showAlert('알림', data.message, function() {
                if(data.success) {
                    window.closeReviewModal();
                    window.loadTab('myReviewContent');
                }
            });
        })
        .catch(err => {
            console.error('Error submitting review:', err);
            window.showAlert('오류', '리뷰 등록 중 오류가 발생했습니다.');
        });
    };

    // 3. 리뷰 삭제 함수
    window.deleteReview = function(reservId) {
        window.ReviewApp.deleteTargetId = reservId;
        /* ✨ [수정] 프리미엄 스타일 모달 표시 방식으로 변경 ✨ */
        var modal = document.getElementById('deleteConfirmModal');
        modal.style.display = 'block';
        setTimeout(function() {
            modal.classList.add('active');
        }, 10);
        /* ✨ [수정 끝] ✨ */
    };
    
    // 4. 삭제 확인
    window.confirmDelete = function() {
        if(!window.ReviewApp.deleteTargetId) return;
        
        fetch('${pageContext.request.contextPath}/review/deletereview.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'reservId=' + window.ReviewApp.deleteTargetId
        })
        .then(res => res.json())
        .then(data => {
            window.showAlert('알림', data.message, function() {
                if(data.success) {
                    window.closeDeleteModal();
                    window.loadTab('myReviewContent');
                }
            });
        })
        .catch(err => {
            console.error('Error:', err);
            window.showAlert('오류', '리뷰 삭제 중 오류가 발생했습니다.');
        });
    };
    
    // 5. 삭제 모달 닫기
    /* ✨ [수정] closeDeleteModal - 부드러운 닫힘 애니메이션 적용 ✨ */
    window.closeDeleteModal = function() {
        var modal = document.getElementById('deleteConfirmModal');
        
        // active 클래스 제거하고 closing 클래스 추가
        modal.classList.remove('active');
        modal.classList.add('closing');
        
        // 애니메이션이 끝난 후 display none 및 closing 클래스 제거
        setTimeout(function() {
            modal.style.display = 'none';
            modal.classList.remove('closing');
        }, 300);
        
        window.ReviewApp.deleteTargetId = null;
    };
    /* ✨ [수정 끝] ✨ */

    // 6. 모달 열기/닫기
    window.openReviewModal = function(id, name) {
        document.getElementById('modalReservId').value = id;
        document.getElementById('modalStoreName').innerText = name;
        document.getElementById('reviewModal').style.display = 'block';
    };

    window.closeReviewModal = function() {
        document.getElementById('reviewModal').style.display = 'none';
        document.getElementById('reviewForm').reset();
    };
    
    // 7. 모달 외부 클릭 닫기
    if (window.ReviewApp.modalClickHandler) {
        window.removeEventListener('click', window.ReviewApp.modalClickHandler);
    }
    
    window.ReviewApp.modalClickHandler = function(event) {
        const reviewModal = document.getElementById('reviewModal');
        const deleteModal = document.getElementById('deleteConfirmModal');
        const alertModal = document.getElementById('alertModal');
        
        if (event.target == reviewModal) window.closeReviewModal();
        /* ✨ [수정] 프리미엄 모달은 오버레이 클릭 시 닫기 ✨ */
        if (event.target == deleteModal) window.closeDeleteModal();
        if (event.target == alertModal) window.closeAlertModal();
        /* ✨ [수정 끝] ✨ */
    };
    
    window.addEventListener('click', window.ReviewApp.modalClickHandler);

    // ✅ 8. 확실한 DOM 체크 및 초기화
    (function initReviewTab() {
        let attempts = 0;
        const maxAttempts = 20;
        
        function tryInit() {
            attempts++;
            const tabContainer = document.getElementById('tabUnwritten');
            const listContainer = document.getElementById('listContainer');
            
            if (tabContainer && listContainer) {
                window.loadTab('unwrittenContent');
                return;
            }
            if (attempts >= maxAttempts) return;
            setTimeout(tryInit, 100);
        }
        tryInit();
    })();
</script>
</body>
</html>




<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 관리</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }
        
        .review-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        /* ===== 탭 디자인 ===== */
        .tab-container {
            display: flex;
            border-bottom: 3px solid #e9ecef;
            margin-bottom: 30px;
            background: white;
            border-radius: 10px 10px 0 0;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .tab-button {
            flex: 1;
            padding: 18px 24px;
            border: none;
            background: white;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            color: #6c757d;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .tab-button:hover {
            background: #f8f9fa;
            color: #495057;
        }
        
        .tab-button.active {
            color: #FF6B35;
            background: linear-gradient(to bottom, #fff 0%, #fff5f2 100%);
        }
        
        .tab-button.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #FF6B35 0%, #FF8C42 100%);
        }
        
        /* ===== 리뷰 카드 디자인 ===== */
        .review-card {
            background: white;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .review-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .store-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .store-name {
            font-size: 20px;
            font-weight: 700;
            color: #212529;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .store-name::before {
            content: '🍽️';
            font-size: 24px;
        }
        
        .reserv-date {
            color: #6c757d;
            font-size: 14px;
            font-weight: 500;
            background: #f8f9fa;
            padding: 6px 12px;
            border-radius: 6px;
        }
        
        .reservation-detail {
            color: #495057;
            font-size: 15px;
            margin-bottom: 16px;
            display: flex;
            gap: 16px;
        }
        
        .reservation-detail span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .review-text {
            margin: 16px 0;
            line-height: 1.7;
            color: #212529;
            font-size: 15px;
            background: #f8f9fa;
            padding: 16px;
            border-radius: 8px;
            border-left: 4px solid #FF6B35;
        }
        
        .review-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 16px;
        }
        
        /* ===== 버튼 디자인 ===== */
        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8C42 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }
        
        .btn-primary:active {
            transform: translateY(0);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        /* ===== 모달 디자인 ===== */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from {
                transform: translate(-50%, -45%);
                opacity: 0;
            }
            to {
                transform: translate(-50%, -50%);
                opacity: 1;
            }
        }
        
        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.4s ease;
        }
        
        .modal-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .modal-header h3 {
            font-size: 24px;
            color: #212529;
            margin: 0;
        }
        
        .modal-header::before {
            content: '✍️';
            font-size: 32px;
        }
        
        /* ===== 별점 디자인 ===== */
        .rating-section {
            margin: 24px 0;
            text-align: center;
        }
        
        .rating-label {
            font-size: 16px;
            color: #495057;
            margin-bottom: 12px;
            font-weight: 600;
        }
        
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
            gap: 8px;
            margin: 16px 0;
        }
        
        .rating-input input {
            display: none;
        }
        
        .rating-input label {
            font-size: 40px;
            color: #dee2e6;
            cursor: pointer;
            transition: all 0.2s ease;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }
        
        .rating-input label:hover,
        .rating-input label:hover ~ label {
            color: #FFD700;
            transform: scale(1.1);
        }
        
        .rating-input input:checked ~ label {
            color: #FFD700;
        }
        
        .rating-input input:checked + label {
            animation: starPulse 0.3s ease;
        }
        
        @keyframes starPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }
        
        /* ===== 텍스트 영역 ===== */
        textarea {
            width: 100%;
            padding: 16px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 15px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s ease;
        }
        
        textarea:focus {
            outline: none;
            border-color: #FF6B35;
            box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.1);
        }
        
        /* ===== 별점 표시 ===== */
        .rating-stars {
            color: #FFD700;
            font-size: 1.3rem;
            margin: 8px 0;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }
        
        /* ===== 빈 상태 ===== */
        .empty-message {
            text-align: center;
            padding: 80px 20px;
            color: #6c757d;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .empty-message::before {
            content: '📝';
            font-size: 64px;
            display: block;
            margin-bottom: 16px;
        }
        
        .empty-message p:first-of-type {
            font-size: 18px;
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }
        
        /* ===== 알림/확인 모달 디자인 ===== */
        .confirm-modal .modal-content {
            max-width: 400px;
            text-align: center;
        }
        
        .confirm-modal .modal-header {
            justify-content: center;
        }
        
        .confirm-modal .modal-header::before {
            content: '⚠️';
        }

        #alertModal .modal-header::before {
            content: '🔔';
        }
        
        .confirm-message {
            font-size: 16px;
            color: #495057;
            margin: 24px 0;
            line-height: 1.6;
        }
        
        .confirm-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        
        /* ===== 로딩 애니메이션 ===== */
        .loading {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
        
        .loading::after {
            content: '...';
            animation: dots 1.5s infinite;
        }
        
        @keyframes dots {
            0%, 20% { content: '.'; }
            40% { content: '..'; }
            60%, 100% { content: '...'; }
        }
    </style>
</head>
<body>
    <div class="review-container">
        <div class="tab-container">
            <button id="tabUnwritten" class="tab-button active" onclick="loadTab('unwrittenContent')">
                작성 가능한 리뷰
            </button>
            <button id="tabMylist" class="tab-button" onclick="loadTab('myReviewContent')">
                내가 작성한 리뷰
            </button>
        </div>
        
        <div id="listContainer">
            </div>
    </div>
    
    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalStoreName"></h3>
            </div>
            <form id="reviewForm">
                <input type="hidden" name="reservId" id="modalReservId">
                
                <div class="rating-section">
                    <div class="rating-label">이 가게는 어떠셨나요?</div>
                    <div class="rating-input">
                        <input type="radio" name="rating" value="5" id="star5" required>
                        <label for="star5">★</label>
                        <input type="radio" name="rating" value="4" id="star4">
                        <label for="star4">★</label>
                        <input type="radio" name="rating" value="3" id="star3">
                        <label for="star3">★</label>
                        <input type="radio" name="rating" value="2" id="star2">
                        <label for="star2">★</label>
                        <input type="radio" name="rating" value="1" id="star1">
                        <label for="star1">★</label>
                    </div>
                </div>
                
                <textarea name="review" rows="5" placeholder="솔직한 리뷰를 남겨주세요 😊" required></textarea>
                
                <div class="review-actions" style="justify-content: center; margin-top: 24px;">
                    <button type="button" class="btn btn-primary" onclick="submitReview()">
                        ✓ 리뷰 등록
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="closeReviewModal()">
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <div id="deleteConfirmModal" class="modal confirm-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>리뷰 삭제</h3>
            </div>
            <div class="confirm-message">
                정말로 이 리뷰를 삭제하시겠습니까?<br>
                <strong>삭제된 리뷰는 복구할 수 없습니다.</strong>
            </div>
            <div class="confirm-actions">
                <button class="btn btn-danger" onclick="confirmDelete()">
                    🗑️ 삭제
                </button>
                <button class="btn btn-secondary" onclick="closeDeleteModal()">
                    취소
                </button>
            </div>
        </div>
    </div>

    <div id="alertModal" class="modal confirm-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="alertTitle">알림</h3>
            </div>
            <div id="alertMessage" class="confirm-message"></div>
            <div class="confirm-actions">
                <button class="btn btn-primary" onclick="closeAlertModal()">확인</button>
            </div>
        </div>
    </div>

<script>
    // ✅ 네임스페이스 객체로 관리
    window.ReviewApp = window.ReviewApp || {
        deleteTargetId: null,
        alertCallback: null
    };

    // 커스텀 알림 함수
    window.showAlert = function(title, message, callback = null) {
        document.getElementById('alertTitle').innerText = title;
        document.getElementById('alertMessage').innerText = message;
        window.ReviewApp.alertCallback = callback;
        document.getElementById('alertModal').style.display = 'block';
    };

    window.closeAlertModal = function() {
        document.getElementById('alertModal').style.display = 'none';
        if (window.ReviewApp.alertCallback) {
            window.ReviewApp.alertCallback();
            window.ReviewApp.alertCallback = null;
        }
    };
    
    // 1. 탭 내용 로드 함수
    window.loadTab = function(action) {
        document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
        if(action === 'unwrittenContent') document.getElementById('tabUnwritten').classList.add('active');
        else document.getElementById('tabMylist').classList.add('active');

        const timestamp = new Date().getTime();
        fetch('${pageContext.request.contextPath}/review/' + action + '.do?t=' + timestamp)
            .then(res => res.text())
            .then(html => {
                document.getElementById('listContainer').innerHTML = html;
            })
            .catch(err => {
                console.error('Error loading tab:', err);
                document.getElementById('listContainer').innerHTML = 
                    '<div class="empty-message"><p>목록을 불러오는 중 오류가 발생했습니다.</p></div>';
            });
    };

    // 2. 리뷰 등록 함수
    window.submitReview = function() {
        const form = document.getElementById('reviewForm');
        const rating = form.querySelector('input[name="rating"]:checked');
        const review = form.querySelector('textarea[name="review"]').value.trim();
        
        if (!rating) {
            window.showAlert('알림', '별점을 선택해주세요.');
            return;
        }
        
        if (!review) {
            window.showAlert('알림', '리뷰 내용을 입력해주세요.');
            return;
        }
        
        const formData = new URLSearchParams(new FormData(form));

        fetch('${pageContext.request.contextPath}/review/writereview.do', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            window.showAlert('알림', data.message, function() {
                if(data.success) {
                    window.closeReviewModal();
                    window.loadTab('myReviewContent');
                }
            });
        })
        .catch(err => {
            console.error('Error submitting review:', err);
            window.showAlert('오류', '리뷰 등록 중 오류가 발생했습니다.');
        });
    };

    // 3. 리뷰 삭제 함수
    window.deleteReview = function(reservId) {
        window.ReviewApp.deleteTargetId = reservId;
        document.getElementById('deleteConfirmModal').style.display = 'block';
    };
    
    // 4. 삭제 확인
    window.confirmDelete = function() {
        if(!window.ReviewApp.deleteTargetId) return;
        
        fetch('${pageContext.request.contextPath}/review/deletereview.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'reservId=' + window.ReviewApp.deleteTargetId
        })
        .then(res => res.json())
        .then(data => {
            window.showAlert('알림', data.message, function() {
                if(data.success) {
                    window.closeDeleteModal();
                    window.loadTab('myReviewContent');
                }
            });
        })
        .catch(err => {
            console.error('Error:', err);
            window.showAlert('오류', '리뷰 삭제 중 오류가 발생했습니다.');
        });
    };
    
    // 5. 삭제 모달 닫기
    window.closeDeleteModal = function() {
        document.getElementById('deleteConfirmModal').style.display = 'none';
        window.ReviewApp.deleteTargetId = null;
    };

    // 6. 모달 열기/닫기
    window.openReviewModal = function(id, name) {
        document.getElementById('modalReservId').value = id;
        document.getElementById('modalStoreName').innerText = name;
        document.getElementById('reviewModal').style.display = 'block';
    };

    window.closeReviewModal = function() {
        document.getElementById('reviewModal').style.display = 'none';
        document.getElementById('reviewForm').reset();
    };
    
    // 7. 모달 외부 클릭 닫기
    if (window.ReviewApp.modalClickHandler) {
        window.removeEventListener('click', window.ReviewApp.modalClickHandler);
    }
    
    window.ReviewApp.modalClickHandler = function(event) {
        const reviewModal = document.getElementById('reviewModal');
        const deleteModal = document.getElementById('deleteConfirmModal');
        const alertModal = document.getElementById('alertModal');
        
        if (event.target == reviewModal) window.closeReviewModal();
        if (event.target == deleteModal) window.closeDeleteModal();
        if (event.target == alertModal) window.closeAlertModal();
    };
    
    window.addEventListener('click', window.ReviewApp.modalClickHandler);

    // ✅ 8. 확실한 DOM 체크 및 초기화
    (function initReviewTab() {
        let attempts = 0;
        const maxAttempts = 20;
        
        function tryInit() {
            attempts++;
            const tabContainer = document.getElementById('tabUnwritten');
            const listContainer = document.getElementById('listContainer');
            
            if (tabContainer && listContainer) {
                window.loadTab('unwrittenContent');
                return;
            }
            if (attempts >= maxAttempts) return;
            setTimeout(tryInit, 100);
        }
        tryInit();
    })();
</script>
</body>
</html> --%>