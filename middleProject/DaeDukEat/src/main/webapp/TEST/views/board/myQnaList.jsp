

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap');
    
    /* 전역 변수 */
    :root {
        --primary: #ff6b00;
        --primary-dark: #e65c00;
        --primary-light: #ff8533;
        --secondary: #64748b;
        --success: #10b981;
        --danger: #ef4444;
        --pending: #f59e0b;
        --bg-gradient: linear-gradient(135deg, #fff5eb 0%, #ffe4cc 100%);
    }
    
    /* 컨테이너 */
    #qna-premium-container {
        font-family: 'Outfit', 'Pretendard', sans-serif;
        animation: fadeInUp 0.6s ease-out;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* 헤더 영역 */
    .qna-header {
        background: linear-gradient(135deg, #ff6b00 0%, #ff8533 100%);
        padding: 40px;
        border-radius: 30px;
        margin-bottom: 40px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(255, 107, 0, 0.2);
    }
    
    .qna-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 70%);
        border-radius: 50%;
        animation: float 6s ease-in-out infinite;
    }
    
    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-20px); }
    }
    
    .qna-header-content {
        position: relative;
        z-index: 1;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .qna-header h3 {
        font-size: 32px;
        font-weight: 900;
        color: white;
        margin: 0 0 10px 0;
        text-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .qna-header p {
        font-size: 16px;
        color: rgba(255,255,255,0.9);
        margin: 0;
        font-weight: 500;
    }
    
    .qna-count {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(10px);
        padding: 8px 20px;
        border-radius: 50px;
        color: white;
        font-weight: 700;
        font-size: 18px;
        border: 2px solid rgba(255,255,255,0.3);
    }
    
    /* 새 질문 작성 버튼 */
    .btn-write-premium {
        background: white;
        color: var(--primary);
        padding: 14px 32px;
        border-radius: 50px;
        font-weight: 800;
        font-size: 15px;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }
    
    .btn-write-premium::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 107, 0, 0.1);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }
    
    .btn-write-premium:hover::before {
        width: 300px;
        height: 300px;
    }
    
    .btn-write-premium:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(255, 107, 0, 0.3);
    }
    
    .btn-write-premium i {
        position: relative;
        z-index: 1;
    }
    
    /* QNA 카드 */
    .qna-card-premium {
        background: white;
        border-radius: 24px;
        padding: 32px;
        margin-bottom: 20px;
        position: relative;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        border: 2px solid transparent;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    }
    
    .qna-card-premium::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 6px;
        height: 100%;
        background: linear-gradient(180deg, var(--primary) 0%, var(--primary-light) 100%);
        transition: width 0.3s ease;
    }
    
    .qna-card-premium:hover::before {
        width: 12px;
    }
    
    .qna-card-premium:hover {
        transform: translateX(8px) translateY(-4px);
        box-shadow: 0 20px 60px rgba(255, 107, 0, 0.15);
        border-color: rgba(255, 107, 0, 0.2);
    }
    
    .qna-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 12px;
    }
    
    .qna-badges {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    /* 상태 배지 */
    .status-badge-premium {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 18px;
        border-radius: 50px;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .status-pending-premium {
        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
        color: #92400e;
    }
    
    .status-complete-premium {
        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
        color: #065f46;
    }
    
    .secret-badge-premium {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        color: #991b1b;
        padding: 6px 14px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 700;
        box-shadow: 0 4px 15px rgba(239, 68, 68, 0.15);
    }
    
    .qna-date {
        font-size: 13px;
        color: #94a3b8;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .qna-card-body h4 {
        font-size: 20px;
        font-weight: 800;
        color: #1e293b;
        margin: 0 0 12px 0;
        line-height: 1.4;
    }
    
    .qna-card-body p {
        font-size: 15px;
        color: #64748b;
        line-height: 1.7;
        margin: 0;
    }
    
    .qna-card-footer {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px solid #f1f5f9;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .answer-indicator {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border-radius: 50px;
        font-size: 13px;
        font-weight: 700;
        color: #065f46;
    }
    
    .answer-indicator i {
        animation: bounce 2s ease-in-out infinite;
    }
    
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-4px); }
    }
    
    /* Empty State */
    .empty-state-premium {
        text-align: center;
        padding: 100px 40px;
        background: white;
        border-radius: 30px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.06);
    }
    
    .empty-state-premium i {
        font-size: 100px;
        margin-bottom: 30px;
        background: linear-gradient(135deg, #ff6b00 0%, #ff8533 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        opacity: 0.4;
        animation: pulse 3s ease-in-out infinite;
    }
    
    @keyframes pulse {
        0%, 100% { opacity: 0.4; }
        50% { opacity: 0.6; }
    }
    
    .empty-state-premium h4 {
        font-size: 24px;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 12px;
    }
    
    .empty-state-premium p {
        font-size: 16px;
        color: #64748b;
        font-weight: 500;
    }
    
    /* 모달 */
    .modal-overlay-premium {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(8px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 10000;
        padding: 20px;
    }
    
    .modal-overlay-premium.active {
        display: flex;
        animation: fadeIn 0.3s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    .modal-content-premium {
        background: white;
        border-radius: 30px;
        width: 100%;
        max-width: 800px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 30px 90px rgba(0,0,0,0.4);
        animation: modalZoomIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
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
    
    .modal-header-premium {
        padding: 40px 40px 30px 40px;
        border-top: 2px solid #f1f5f9;
        position: relative;
    }
    
    .modal-title-section {
        margin-bottom: 20px;
    }
    
    .modal-title-premium {
        font-size: 28px;
        font-weight: 900;
        color: #1e293b;
        margin: 0;
        line-height: 1.3;
    }
    
    .modal-close-btn {
        position: absolute;
        top: 30px;
        right: 30px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #f1f5f9;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
        color: #64748b;
        font-size: 20px;
    }
    
    .modal-close-btn:hover {
        background: #fee2e2;
        color: #ef4444;
        transform: rotate(90deg);
    }
    
    .modal-body-premium {
        padding: 40px;
    }
    
    .content-section {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        padding: 30px;
        border-radius: 20px;
        margin-bottom: 30px;
        border: 2px solid #e2e8f0;
    }
    
    .content-label {
        font-size: 12px;
        font-weight: 800;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 12px;
        display: block;
    }
    
    .content-text {
        font-size: 16px;
        color: #334155;
        line-height: 1.8;
        white-space: pre-wrap;
        font-weight: 500;
    }
    
    .answer-section {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border: 2px solid #a7f3d0;
        padding: 30px;
        border-radius: 20px;
        margin-bottom: 30px;
    }
    
    .answer-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    
    .answer-title {
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 900;
        color: #065f46;
        font-size: 18px;
    }
    
    .answer-title i {
        font-size: 24px;
    }
    
    .answer-date {
        font-size: 13px;
        color: #059669;
        font-weight: 700;
    }
    
    /* 폼 스타일 */
    .form-group {
        margin-bottom: 24px;
    }
    
    .form-label {
        display: block;
        font-size: 14px;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 10px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .form-input,
    .form-textarea {
        width: 100%;
        padding: 16px 20px;
        border: 2px solid #e2e8f0;
        border-radius: 16px;
        font-size: 15px;
        font-weight: 500;
        color: #1e293b;
        transition: all 0.3s;
        font-family: 'Outfit', sans-serif;
        background: white;
    }
    
    .form-input:focus,
    .form-textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
        transform: translateY(-2px);
    }
    
    .form-textarea {
        resize: none;
        min-height: 200px;
    }
    
    .form-checkbox {
        display: flex;
        align-items: center;
        gap: 12px;
        cursor: pointer;
        padding: 16px 20px;
        background: #f8fafc;
        border-radius: 12px;
        transition: all 0.3s;
    }
    
    .form-checkbox:hover {
        background: #fff5eb;
    }
    
    .form-checkbox input[type="checkbox"] {
        width: 24px;
        height: 24px;
        cursor: pointer;
        accent-color: var(--primary);
    }
    
    .form-checkbox label {
        font-size: 15px;
        font-weight: 700;
        color: #475569;
        cursor: pointer;
    }
    
    /* 버튼 그룹 */
    .button-group {
        display: flex;
        gap: 12px;
        margin-top: 30px;
    }
    
    .btn-premium {
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
    
    .btn-premium-primary {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
    }
    
    .btn-premium-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(255, 107, 0, 0.4);
    }
    
    .btn-premium-secondary {
        background: #f1f5f9;
        color: #64748b;
    }
    
    .btn-premium-secondary:hover {
        background: #e2e8f0;
        color: #475569;
        transform: translateY(-2px);
    }
    
    .btn-premium-danger {
        background: linear-gradient(135deg, #ef4444 0%, #f87171 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(239, 68, 68, 0.3);
        flex: 0 0 auto;
    }
    
    .btn-premium-danger:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(239, 68, 68, 0.4);
    }
    
    /* ✨✨✨ [추가] 알림 모달 스타일 - 프리미엄 디자인 ✨✨✨ */
    .alert-modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(8px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 20000;
        padding: 20px;
        font-family: 'Outfit', 'Pretendard', sans-serif;
    }
    
    .alert-modal-overlay.active {
        display: flex;
        animation: fadeIn 0.3s ease-out;
    }
    
    .alert-modal-content {
        background: white;
        border-radius: 30px;
        width: 100%;
        max-width: 500px;
        box-shadow: 0 30px 90px rgba(0,0,0,0.4);
        animation: modalZoomIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
        overflow: hidden;
    }
    
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
    /* ✨✨✨ [추가 끝] ✨✨✨ */
    
    /* 스크롤바 스타일 */
    .modal-content-premium::-webkit-scrollbar {
        width: 8px;
    }
    
    .modal-content-premium::-webkit-scrollbar-track {
        background: #f1f5f9;
    }
    
    .modal-content-premium::-webkit-scrollbar-thumb {
        background: var(--primary);
        border-radius: 10px;
    }
    
    .modal-content-premium::-webkit-scrollbar-thumb:hover {
        background: var(--primary-dark);
    }
    
    /* 반응형 */
    @media (max-width: 768px) {
        .qna-header {
            padding: 30px 20px;
        }
        
        .qna-header h3 {
            font-size: 24px;
        }
        
        .qna-card-premium {
            padding: 24px;
        }
        
        .modal-content-premium {
            margin: 10px;
        }
        
        .modal-header-premium,
        .modal-body-premium {
            padding: 30px 20px;
        }
        
        .button-group {
            flex-direction: column;
        }
        
        /* ✨ [추가] 알림 모달 반응형 ✨ */
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
        /* ✨ [추가 끝] ✨ */
    }
    
    /* 텍스트 말줄임 */
    .line-clamp-1 {
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
</style>

<div id="qna-premium-container">
    <!-- 프리미엄 헤더 -->
    <div class="qna-header">
        <div class="qna-header-content">
            <div>
                <h3>✨ My Questions</h3>
                <p>나만의 질문 관리 공간</p>
            </div>
            <div style="display: flex; align-items: center; gap: 20px;">
                <span class="qna-count">
                    <i class="fa-solid fa-comment-dots"></i>
                    ${qnaList.size()}
                </span>
                <button id="btn-write" class="btn-write-premium">
                    <i class="fa-solid fa-pen-fancy"></i>
                    <span>새 질문 작성</span>
                </button>
            </div>
        </div>
    </div>

    <!-- QNA 목록 -->
    <c:choose>
        <c:when test="${empty qnaList}">
            <div class="empty-state-premium">
                <i class="fa-solid fa-inbox"></i>
                <h4>아직 작성한 질문이 없어요</h4>
                <p>궁금한 점이 있다면 언제든지 질문해보세요!</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="qna" items="${qnaList}">
                <div class="qna-card-premium" data-qna-id="${qna.qnaId}">
                    <div class="qna-card-header">
                        <div class="qna-badges">
                            <span class="status-badge-premium ${qna.statusYn == '완료' ? 'status-complete-premium' : 'status-pending-premium'}">
                                <i class="fa-solid ${qna.statusYn == '완료' ? 'fa-check-circle' : 'fa-clock'}"></i>
                                ${qna.statusYn}
                            </span>
                            
                            <c:if test="${qna.secretYn == 'Y'}">
                                <span class="secret-badge-premium">
                                    <i class="fa-solid fa-lock"></i>
                                    비밀글
                                </span>
                            </c:if>
                        </div>
                        
                        <span class="qna-date">
                            <i class="fa-regular fa-calendar"></i>
                            <fmt:formatDate value="${qna.createDate}" pattern="yyyy.MM.dd"/>
                        </span>
                    </div>
                    
                    <div class="qna-card-body">
                        <h4 class="line-clamp-1">${qna.qnaTitle}</h4>
                        <p class="line-clamp-2">${qna.qnaContent}</p>
                    </div>
                    
                    <c:if test="${not empty qna.answerContent}">
                        <div class="qna-card-footer">
                            <span class="answer-indicator">
                                <i class="fa-solid fa-reply"></i>
                                관리자 답변 완료
                            </span>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- 상세보기 모달 -->
<div id="detailModal" class="modal-overlay-premium">
    <div class="modal-content-premium">
        <div class="modal-header-premium">
            <div class="qna-badges" style="margin-bottom: 20px;">
                <span id="modal-status" class="status-badge-premium"></span>
                <span id="modal-secret" class="secret-badge-premium" style="display: none;">
                    <i class="fa-solid fa-lock"></i> 비밀글
                </span>
            </div>
            <h3 id="modal-title" class="modal-title-premium"></h3>
            <button id="btn-close-detail" class="modal-close-btn">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div id="view-mode" class="modal-body-premium">
            <div class="content-section">
                <span class="content-label">질문 내용</span>
                <p id="modal-content" class="content-text"></p>
            </div>
            
            <div id="answer-area" class="answer-section" style="display: none;">
                <div class="answer-header">
                    <div class="answer-title">
                        <i class="fa-solid fa-headset"></i>
                        <span>관리자 답변</span>
                    </div>
                    <span id="modal-answer-date" class="answer-date"></span>
                </div>
                <p id="modal-answer" class="content-text"></p>
            </div>

            <div class="button-group">
                <button id="btn-edit" class="btn-premium btn-premium-primary">
                    <i class="fa-solid fa-pen"></i>
                    수정하기
                </button>
                <button id="btn-delete" class="btn-premium btn-premium-danger">
                    <i class="fa-solid fa-trash"></i>
                    삭제
                </button>
                <button id="btn-close-detail2" class="btn-premium btn-premium-secondary">
                    <i class="fa-solid fa-xmark"></i>
                    닫기
                </button>
            </div>
        </div>

        <div id="edit-mode" class="modal-body-premium" style="display: none;">
            <form id="editForm">
                <input type="hidden" id="edit-qnaId" name="qnaId">
                
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" id="edit-title" name="qnaTitle" required class="form-input" placeholder="질문 제목을 입력하세요">
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea id="edit-content" name="qnaContent" required class="form-textarea" placeholder="질문 내용을 자세히 작성해주세요"></textarea>
                </div>
                
                <div class="form-group">
                    <div class="form-checkbox">
                        <input type="checkbox" id="edit-secret" name="secretYn" value="Y">
                        <label for="edit-secret">비밀글로 설정 (본인과 관리자만 열람 가능)</label>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-premium btn-premium-primary">
                        <i class="fa-solid fa-check"></i>
                        저장하기
                    </button>
                    <button type="button" id="btn-cancel-edit" class="btn-premium btn-premium-secondary">
                        <i class="fa-solid fa-rotate-left"></i>
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 작성 모달 -->
<div id="writeModal" class="modal-overlay-premium">
    <div class="modal-content-premium">
        <div class="modal-header-premium">
            <h3 class="modal-title-premium">✨ 새 질문 작성</h3>
            <button id="btn-close-write" class="modal-close-btn">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="modal-body-premium">
            <form id="writeForm">
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" name="qnaTitle" required class="form-input" placeholder="질문 제목을 입력하세요">
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea name="qnaContent" required class="form-textarea" placeholder="궁금한 내용을 자세히 작성해주세요"></textarea>
                </div>
                
                <div class="form-group">
                    <div class="form-checkbox">
                        <input type="checkbox" name="secretYn" value="Y" id="write-secret">
                        <label for="write-secret">비밀글로 설정 (본인과 관리자만 열람 가능)</label>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-premium btn-premium-primary">
                        <i class="fa-solid fa-paper-plane"></i>
                        질문 등록
                    </button>
                    <button type="button" id="btn-close-write2" class="btn-premium btn-premium-secondary">
                        <i class="fa-solid fa-xmark"></i>
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ✨✨✨ [추가] 알림 모달 HTML ✨✨✨ -->
<div id="alertModal" class="alert-modal-overlay">
    <div class="alert-modal-content">
        <div class="alert-modal-body">
            <div id="alert-icon" class="alert-modal-icon">
                <i id="alert-icon-element"></i>
            </div>
            <h3 id="alert-title" class="alert-modal-title"></h3>
            <p id="alert-message" class="alert-modal-message"></p>
            <div id="alert-buttons" class="alert-modal-buttons"></div>
        </div>
    </div>
</div>
<!-- ✨✨✨ [추가 끝] ✨✨✨ -->


<script>

 // ✅ 중복 실행 방지
if (!window.qnaScriptLoaded) {
    window.qnaScriptLoaded = true;
    
    (function() {
        'use strict';
        
        console.log('🚀 QNA Premium 스크립트 시작');
        
        var ctx = '<%=request.getContextPath()%>';
        var currentQnaId = null;
        
        /* ✨✨✨ [추가] 프리미엄 알림 모달 함수 ✨✨✨ */
        // type: 'info', 'success', 'error', 'warning'
        // title: 모달 제목
        // message: 모달 메시지
        // buttons: 버튼 배열 [{ text: '확인', className: 'alert-modal-btn-primary', onClick: function() {} }]
        function showPremiumAlert(type, title, message, buttons) {
            var modal = document.getElementById('alertModal');
            var icon = document.getElementById('alert-icon');
            var iconElement = document.getElementById('alert-icon-element');
            var titleElement = document.getElementById('alert-title');
            var messageElement = document.getElementById('alert-message');
            var buttonsContainer = document.getElementById('alert-buttons');
            
            // 아이콘 타입별 설정
            icon.className = 'alert-modal-icon ' + type;
            
            if (type === 'success') {
                iconElement.className = 'fa-solid fa-check';
            } else if (type === 'error') {
                iconElement.className = 'fa-solid fa-xmark';
            } else if (type === 'warning') {
                iconElement.className = 'fa-solid fa-triangle-exclamation';
            } else {
                iconElement.className = 'fa-solid fa-circle-info';
            }
            
            // 제목과 메시지 설정
            titleElement.textContent = title;
            messageElement.textContent = message;
            
            // 버튼 생성
            buttonsContainer.innerHTML = '';
            buttons.forEach(function(btn) {
                var button = document.createElement('button');
                button.className = 'alert-modal-btn ' + (btn.className || 'alert-modal-btn-primary');
                button.textContent = btn.text;
                button.onclick = function() {
                    modal.classList.remove('active');
                    if (btn.onClick) btn.onClick();
                };
                buttonsContainer.appendChild(button);
            });
            
            // 모달 표시
            modal.classList.add('active');
        }
        /* ✨✨✨ [추가 끝] ✨✨✨ */
        
        // 이벤트 위임
        document.addEventListener('click', function(e) {
            if (e.target && e.target.closest('#btn-write')) {
                var writeForm = document.getElementById('writeForm');
                if (writeForm) writeForm.reset();
                var writeModal = document.getElementById('writeModal');
                if (writeModal) writeModal.classList.add('active');
            }
            
            if (e.target && e.target.closest('.qna-card-premium')) {
                var card = e.target.closest('.qna-card-premium');
                var qnaId = card.getAttribute('data-qna-id');
                openDetailModal(qnaId);
            }
            
            if (e.target && (e.target.closest('#btn-close-detail') || e.target.closest('#btn-close-detail2'))) {
                closeDetailModal();
            }
            if (e.target && (e.target.closest('#btn-close-write') || e.target.closest('#btn-close-write2'))) {
                closeWriteModal();
            }
            
            if (e.target && e.target.closest('#btn-edit')) {
                enterEditMode();
            }
            if (e.target && e.target.closest('#btn-delete')) {
                deleteQna();
            }
            if (e.target && e.target.closest('#btn-cancel-edit')) {
                cancelEdit();
            }
            
            if (e.target && e.target.classList.contains('modal-overlay-premium')) {
                e.target.classList.remove('active');
            }
            
            /* ✨ [추가] 알림 모달 오버레이 클릭 시 닫기 ✨ */
            if (e.target && e.target.classList.contains('alert-modal-overlay')) {
                e.target.classList.remove('active');
            }
            /* ✨ [추가 끝] ✨ */
        });
        
        document.addEventListener('submit', function(e) {
            if (e.target && e.target.id === 'editForm') {
                e.preventDefault();
                submitEdit(e);
            }
            if (e.target && e.target.id === 'writeForm') {
                e.preventDefault();
                submitWrite(e);
            }
        });
        
        function openDetailModal(qnaId) {
            currentQnaId = qnaId;
            
            fetch(ctx + '/mypage/qna/detail.do?qnaId=' + qnaId)
                .then(function(res) {
                    if (!res.ok) throw new Error('조회 실패');
                    return res.json();
                })
                .then(function(data) {
                    if (data.error) {
                        /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                        showPremiumAlert('error', '오류', data.error, [
                            { text: '확인', className: 'alert-modal-btn-danger' }
                        ]);
                        /* ✨ [수정 끝] ✨ */
                        return;
                    }
                    
                    document.getElementById('modal-title').textContent = data.qnaTitle;
                    document.getElementById('modal-content').textContent = data.qnaContent;
                    
                    var statusBadge = document.getElementById('modal-status');
                    statusBadge.innerHTML = '<i class="fa-solid ' + (data.statusYn == '완료' ? 'fa-check-circle' : 'fa-clock') + '"><\/i> ' + data.statusYn;
                    statusBadge.className = 'status-badge-premium ' + (data.statusYn == '완료' ? 'status-complete-premium' : 'status-pending-premium');
                    
                    document.getElementById('modal-secret').style.display = data.secretYn == 'Y' ? 'inline-flex' : 'none';
                    
                    var answerArea = document.getElementById('answer-area');
                    if (data.answerContent) {
                        document.getElementById('modal-answer').textContent = data.answerContent;
                        if (data.answerDate) {
                            var answerDate = new Date(data.answerDate);
                            document.getElementById('modal-answer-date').textContent = 
                                answerDate.getFullYear() + '.' + 
                                String(answerDate.getMonth() + 1).padStart(2, '0') + '.' + 
                                String(answerDate.getDate()).padStart(2, '0');
                        }
                        answerArea.style.display = 'block';
                    } else {
                        answerArea.style.display = 'none';
                    }
                    
                    document.getElementById('edit-qnaId').value = data.qnaId;
                    document.getElementById('edit-title').value = data.qnaTitle;
                    document.getElementById('edit-content').value = data.qnaContent;
                    document.getElementById('edit-secret').checked = (data.secretYn == 'Y');
                    
                    document.getElementById('detailModal').classList.add('active');
                    document.getElementById('view-mode').style.display = 'block';
                    document.getElementById('edit-mode').style.display = 'none';
                })
                .catch(function(err) {
                    /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                    showPremiumAlert('error', '오류', '질문 정보를 불러오는데 실패했습니다.', [
                        { text: '확인', className: 'alert-modal-btn-danger' }
                    ]);
                    /* ✨ [수정 끝] ✨ */
                });
        }
        
        function closeDetailModal() {
            var modal = document.getElementById('detailModal');
            if (modal) modal.classList.remove('active');
            currentQnaId = null;
        }
        
        function closeWriteModal() {
            var modal = document.getElementById('writeModal');
            if (modal) modal.classList.remove('active');
        }
        
        function enterEditMode() {
            document.getElementById('view-mode').style.display = 'none';
            document.getElementById('edit-mode').style.display = 'block';
        }
        
        function cancelEdit() {
            document.getElementById('view-mode').style.display = 'block';
            document.getElementById('edit-mode').style.display = 'none';
        }
        
        function submitEdit(e) {
            var form = e.target;
            var params = new URLSearchParams();
            params.append('qnaId', form.qnaId.value);
            params.append('qnaTitle', form.qnaTitle.value);
            params.append('qnaContent', form.qnaContent.value);
            params.append('secretYn', form.secretYn.checked ? 'Y' : 'N');
            
            fetch(ctx + '/mypage/qna/update.do', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) throw new Error('수정 실패');
                return res.json();
            })
            .then(function(data) {
                if (data.success) {
                    /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                    showPremiumAlert('success', '완료', '✅ 질문이 수정되었습니다.', [
                        { 
                            text: '확인', 
                            className: 'alert-modal-btn-success',
                            onClick: function() {
                                closeDetailModal();
                                if (typeof loadPage === 'function') {
                                    loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                                } else {
                                    location.reload();
                                }
                            }
                        }
                    ]);
                    /* ✨ [수정 끝] ✨ */
                } else {
                    /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                    showPremiumAlert('error', '실패', '❌ ' + data.message, [
                        { text: '확인', className: 'alert-modal-btn-danger' }
                    ]);
                    /* ✨ [수정 끝] ✨ */
                }
            })
            .catch(function(err) {
                /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                showPremiumAlert('error', '오류', '수정 중 오류가 발생했습니다.', [
                    { text: '확인', className: 'alert-modal-btn-danger' }
                ]);
                /* ✨ [수정 끝] ✨ */
            });
        }
        
        function deleteQna() {
            /* ✨ [수정] confirm → 프리미엄 모달 ✨ */
            showPremiumAlert('warning', '확인', '🗑️ 정말 이 질문을 삭제하시겠습니까?\n삭제된 내용은 복구할 수 없습니다.', [
                { 
                    text: '삭제', 
                    className: 'alert-modal-btn-danger',
                    onClick: function() {
                        var params = new URLSearchParams();
                        params.append('qnaId', currentQnaId);
                        
                        fetch(ctx + '/mypage/qna/delete.do', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                            body: params.toString()
                        })
                        .then(function(res) {
                            if (!res.ok) throw new Error('삭제 실패');
                            return res.json();
                        })
                        .then(function(data) {
                            if (data.success) {
                                showPremiumAlert('success', '완료', '✅ 질문이 삭제되었습니다.', [
                                    { 
                                        text: '확인', 
                                        className: 'alert-modal-btn-success',
                                        onClick: function() {
                                            closeDetailModal();
                                            if (typeof loadPage === 'function') {
                                                loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                                            } else {
                                                location.reload();
                                            }
                                        }
                                    }
                                ]);
                            } else {
                                showPremiumAlert('error', '실패', '❌ ' + data.message, [
                                    { text: '확인', className: 'alert-modal-btn-danger' }
                                ]);
                            }
                        })
                        .catch(function(err) {
                            showPremiumAlert('error', '오류', '삭제 중 오류가 발생했습니다.', [
                                { text: '확인', className: 'alert-modal-btn-danger' }
                            ]);
                        });
                    }
                },
                { 
                    text: '취소', 
                    className: 'alert-modal-btn-secondary'
                }
            ]);
            /* ✨ [수정 끝] ✨ */
        }
        
        function submitWrite(e) {
            var form = e.target;
            var params = new URLSearchParams();
            params.append('qnaTitle', form.qnaTitle.value);
            params.append('qnaContent', form.qnaContent.value);
            params.append('secretYn', form.secretYn.checked ? 'Y' : 'N');
            
            fetch(ctx + '/mypage/qna/insert.do', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) throw new Error('등록 실패');
                return res.json();
            })
            .then(function(data) {
                if (data.success) {
                    /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                    showPremiumAlert('success', '완료', '✅ 질문이 등록되었습니다.', [
                        { 
                            text: '확인', 
                            className: 'alert-modal-btn-success',
                            onClick: function() {
                                closeWriteModal();
                                if (typeof loadPage === 'function') {
                                    loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                                } else {
                                    location.reload();
                                }
                            }
                        }
                    ]);
                    /* ✨ [수정 끝] ✨ */
                } else {
                    /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                    showPremiumAlert('error', '실패', '❌ ' + data.message, [
                        { text: '확인', className: 'alert-modal-btn-danger' }
                    ]);
                    /* ✨ [수정 끝] ✨ */
                }
            })
            .catch(function(err) {
                /* ✨ [수정] alert → 프리미엄 모달 ✨ */
                showPremiumAlert('error', '오류', '등록 중 오류가 발생했습니다.', [
                    { text: '확인', className: 'alert-modal-btn-danger' }
                ]);
                /* ✨ [수정 끝] ✨ */
            });
        }
        
        console.log('✅ QNA Premium 완료');
    })();
} 
</script>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap');
    
    /* 전역 변수 */
    :root {
        --primary: #ff6b00;
        --primary-dark: #e65c00;
        --primary-light: #ff8533;
        --secondary: #64748b;
        --success: #10b981;
        --danger: #ef4444;
        --pending: #f59e0b;
        --bg-gradient: linear-gradient(135deg, #fff5eb 0%, #ffe4cc 100%);
    }
    
    /* 컨테이너 */
    #qna-premium-container {
        font-family: 'Outfit', 'Pretendard', sans-serif;
        animation: fadeInUp 0.6s ease-out;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* 헤더 영역 */
    .qna-header {
        background: linear-gradient(135deg, #ff6b00 0%, #ff8533 100%);
        padding: 40px;
        border-radius: 30px;
        margin-bottom: 40px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(255, 107, 0, 0.2);
    }
    
    .qna-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 70%);
        border-radius: 50%;
        animation: float 6s ease-in-out infinite;
    }
    
    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-20px); }
    }
    
    .qna-header-content {
        position: relative;
        z-index: 1;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .qna-header h3 {
        font-size: 32px;
        font-weight: 900;
        color: white;
        margin: 0 0 10px 0;
        text-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .qna-header p {
        font-size: 16px;
        color: rgba(255,255,255,0.9);
        margin: 0;
        font-weight: 500;
    }
    
    .qna-count {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(10px);
        padding: 8px 20px;
        border-radius: 50px;
        color: white;
        font-weight: 700;
        font-size: 18px;
        border: 2px solid rgba(255,255,255,0.3);
    }
    
    /* 새 질문 작성 버튼 */
    .btn-write-premium {
        background: white;
        color: var(--primary);
        padding: 14px 32px;
        border-radius: 50px;
        font-weight: 800;
        font-size: 15px;
        border: none;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }
    
    .btn-write-premium::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 107, 0, 0.1);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }
    
    .btn-write-premium:hover::before {
        width: 300px;
        height: 300px;
    }
    
    .btn-write-premium:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(255, 107, 0, 0.3);
    }
    
    .btn-write-premium i {
        position: relative;
        z-index: 1;
    }
    
    /* QNA 카드 */
    .qna-card-premium {
        background: white;
        border-radius: 24px;
        padding: 32px;
        margin-bottom: 20px;
        position: relative;
        overflow: hidden;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        border: 2px solid transparent;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    }
    
    .qna-card-premium::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 6px;
        height: 100%;
        background: linear-gradient(180deg, var(--primary) 0%, var(--primary-light) 100%);
        transition: width 0.3s ease;
    }
    
    .qna-card-premium:hover::before {
        width: 12px;
    }
    
    .qna-card-premium:hover {
        transform: translateX(8px) translateY(-4px);
        box-shadow: 0 20px 60px rgba(255, 107, 0, 0.15);
        border-color: rgba(255, 107, 0, 0.2);
    }
    
    .qna-card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 12px;
    }
    
    .qna-badges {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    /* 상태 배지 */
    .status-badge-premium {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 18px;
        border-radius: 50px;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .status-pending-premium {
        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
        color: #92400e;
    }
    
    .status-complete-premium {
        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
        color: #065f46;
    }
    
    .secret-badge-premium {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        color: #991b1b;
        padding: 6px 14px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 700;
        box-shadow: 0 4px 15px rgba(239, 68, 68, 0.15);
    }
    
    .qna-date {
        font-size: 13px;
        color: #94a3b8;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    
    .qna-card-body h4 {
        font-size: 20px;
        font-weight: 800;
        color: #1e293b;
        margin: 0 0 12px 0;
        line-height: 1.4;
    }
    
    .qna-card-body p {
        font-size: 15px;
        color: #64748b;
        line-height: 1.7;
        margin: 0;
    }
    
    .qna-card-footer {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 2px solid #f1f5f9;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .answer-indicator {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border-radius: 50px;
        font-size: 13px;
        font-weight: 700;
        color: #065f46;
    }
    
    .answer-indicator i {
        animation: bounce 2s ease-in-out infinite;
    }
    
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-4px); }
    }
    
    /* Empty State */
    .empty-state-premium {
        text-align: center;
        padding: 100px 40px;
        background: white;
        border-radius: 30px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.06);
    }
    
    .empty-state-premium i {
        font-size: 100px;
        margin-bottom: 30px;
        background: linear-gradient(135deg, #ff6b00 0%, #ff8533 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        opacity: 0.4;
        animation: pulse 3s ease-in-out infinite;
    }
    
    @keyframes pulse {
        0%, 100% { opacity: 0.4; }
        50% { opacity: 0.6; }
    }
    
    .empty-state-premium h4 {
        font-size: 24px;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 12px;
    }
    
    .empty-state-premium p {
        font-size: 16px;
        color: #64748b;
        font-weight: 500;
    }
    
    /* 모달 */
    .modal-overlay-premium {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(8px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 10000;
        padding: 20px;
    }
    
    .modal-overlay-premium.active {
        display: flex;
        animation: fadeIn 0.3s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    .modal-content-premium {
        background: white;
        border-radius: 30px;
        width: 100%;
        max-width: 800px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 30px 90px rgba(0,0,0,0.4);
        animation: modalZoomIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
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
    
    .modal-header-premium {
        padding: 40px 40px 30px 40px;
        border-bottom: 2px solid #f1f5f9;
        position: relative;
    }
    
    .modal-title-section {
        margin-bottom: 20px;
    }
    
    .modal-title-premium {
        font-size: 28px;
        font-weight: 900;
        color: #1e293b;
        margin: 0;
        line-height: 1.3;
    }
    
    .modal-close-btn {
        position: absolute;
        top: 30px;
        right: 30px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #f1f5f9;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
        color: #64748b;
        font-size: 20px;
    }
    
    .modal-close-btn:hover {
        background: #fee2e2;
        color: #ef4444;
        transform: rotate(90deg);
    }
    
    .modal-body-premium {
        padding: 40px;
    }
    
    .content-section {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        padding: 30px;
        border-radius: 20px;
        margin-bottom: 30px;
        border: 2px solid #e2e8f0;
    }
    
    .content-label {
        font-size: 12px;
        font-weight: 800;
        color: var(--primary);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 12px;
        display: block;
    }
    
    .content-text {
        font-size: 16px;
        color: #334155;
        line-height: 1.8;
        white-space: pre-wrap;
        font-weight: 500;
    }
    
    .answer-section {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border: 2px solid #a7f3d0;
        padding: 30px;
        border-radius: 20px;
        margin-bottom: 30px;
    }
    
    .answer-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
    }
    
    .answer-title {
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 900;
        color: #065f46;
        font-size: 18px;
    }
    
    .answer-title i {
        font-size: 24px;
    }
    
    .answer-date {
        font-size: 13px;
        color: #059669;
        font-weight: 700;
    }
    
    /* 폼 스타일 */
    .form-group {
        margin-bottom: 24px;
    }
    
    .form-label {
        display: block;
        font-size: 14px;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 10px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .form-input,
    .form-textarea {
        width: 100%;
        padding: 16px 20px;
        border: 2px solid #e2e8f0;
        border-radius: 16px;
        font-size: 15px;
        font-weight: 500;
        color: #1e293b;
        transition: all 0.3s;
        font-family: 'Outfit', sans-serif;
        background: white;
    }
    
    .form-input:focus,
    .form-textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
        transform: translateY(-2px);
    }
    
    .form-textarea {
        resize: none;
        min-height: 200px;
    }
    
    .form-checkbox {
        display: flex;
        align-items: center;
        gap: 12px;
        cursor: pointer;
        padding: 16px 20px;
        background: #f8fafc;
        border-radius: 12px;
        transition: all 0.3s;
    }
    
    .form-checkbox:hover {
        background: #fff5eb;
    }
    
    .form-checkbox input[type="checkbox"] {
        width: 24px;
        height: 24px;
        cursor: pointer;
        accent-color: var(--primary);
    }
    
    .form-checkbox label {
        font-size: 15px;
        font-weight: 700;
        color: #475569;
        cursor: pointer;
    }
    
    /* 버튼 그룹 */
    .button-group {
        display: flex;
        gap: 12px;
        margin-top: 30px;
    }
    
    .btn-premium {
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
    
    .btn-premium-primary {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary-light) 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
    }
    
    .btn-premium-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(255, 107, 0, 0.4);
    }
    
    .btn-premium-secondary {
        background: #f1f5f9;
        color: #64748b;
    }
    
    .btn-premium-secondary:hover {
        background: #e2e8f0;
        color: #475569;
        transform: translateY(-2px);
    }
    
    .btn-premium-danger {
        background: linear-gradient(135deg, #ef4444 0%, #f87171 100%);
        color: white;
        box-shadow: 0 10px 30px rgba(239, 68, 68, 0.3);
        flex: 0 0 auto;
    }
    
    .btn-premium-danger:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 40px rgba(239, 68, 68, 0.4);
    }
    
    /* 스크롤바 스타일 */
    .modal-content-premium::-webkit-scrollbar {
        width: 8px;
    }
    
    .modal-content-premium::-webkit-scrollbar-track {
        background: #f1f5f9;
    }
    
    .modal-content-premium::-webkit-scrollbar-thumb {
        background: var(--primary);
        border-radius: 10px;
    }
    
    .modal-content-premium::-webkit-scrollbar-thumb:hover {
        background: var(--primary-dark);
    }
    
    /* 반응형 */
    @media (max-width: 768px) {
        .qna-header {
            padding: 30px 20px;
        }
        
        .qna-header h3 {
            font-size: 24px;
        }
        
        .qna-card-premium {
            padding: 24px;
        }
        
        .modal-content-premium {
            margin: 10px;
        }
        
        .modal-header-premium,
        .modal-body-premium {
            padding: 30px 20px;
        }
        
        .button-group {
            flex-direction: column;
        }
    }
    
    /* 텍스트 말줄임 */
    .line-clamp-1 {
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
</style>

<div id="qna-premium-container">
    <!-- 프리미엄 헤더 -->
    <div class="qna-header">
        <div class="qna-header-content">
            <div>
                <h3>✨ My Questions</h3>
                <p>나만의 질문 관리 공간</p>
            </div>
            <div style="display: flex; align-items: center; gap: 20px;">
                <span class="qna-count">
                    <i class="fa-solid fa-comment-dots"></i>
                    ${qnaList.size()}
                </span>
                <button id="btn-write" class="btn-write-premium">
                    <i class="fa-solid fa-pen-fancy"></i>
                    <span>새 질문 작성</span>
                </button>
            </div>
        </div>
    </div>

    <!-- QNA 목록 -->
    <c:choose>
        <c:when test="${empty qnaList}">
            <div class="empty-state-premium">
                <i class="fa-solid fa-inbox"></i>
                <h4>아직 작성한 질문이 없어요</h4>
                <p>궁금한 점이 있다면 언제든지 질문해보세요!</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="qna" items="${qnaList}">
                <div class="qna-card-premium" data-qna-id="${qna.qnaId}">
                    <div class="qna-card-header">
                        <div class="qna-badges">
                            <span class="status-badge-premium ${qna.statusYn == '완료' ? 'status-complete-premium' : 'status-pending-premium'}">
                                <i class="fa-solid ${qna.statusYn == '완료' ? 'fa-check-circle' : 'fa-clock'}"></i>
                                ${qna.statusYn}
                            </span>
                            
                            <c:if test="${qna.secretYn == 'Y'}">
                                <span class="secret-badge-premium">
                                    <i class="fa-solid fa-lock"></i>
                                    비밀글
                                </span>
                            </c:if>
                        </div>
                        
                        <span class="qna-date">
                            <i class="fa-regular fa-calendar"></i>
                            <fmt:formatDate value="${qna.createDate}" pattern="yyyy.MM.dd"/>
                        </span>
                    </div>
                    
                    <div class="qna-card-body">
                        <h4 class="line-clamp-1">${qna.qnaTitle}</h4>
                        <p class="line-clamp-2">${qna.qnaContent}</p>
                    </div>
                    
                    <c:if test="${not empty qna.answerContent}">
                        <div class="qna-card-footer">
                            <span class="answer-indicator">
                                <i class="fa-solid fa-reply"></i>
                                관리자 답변 완료
                            </span>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<!-- 상세보기 모달 -->
<div id="detailModal" class="modal-overlay-premium">
    <div class="modal-content-premium">
        <div class="modal-header-premium">
            <div class="qna-badges" style="margin-bottom: 20px;">
                <span id="modal-status" class="status-badge-premium"></span>
                <span id="modal-secret" class="secret-badge-premium" style="display: none;">
                    <i class="fa-solid fa-lock"></i> 비밀글
                </span>
            </div>
            <h3 id="modal-title" class="modal-title-premium"></h3>
            <button id="btn-close-detail" class="modal-close-btn">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div id="view-mode" class="modal-body-premium">
            <div class="content-section">
                <span class="content-label">질문 내용</span>
                <p id="modal-content" class="content-text"></p>
            </div>
            
            <div id="answer-area" class="answer-section" style="display: none;">
                <div class="answer-header">
                    <div class="answer-title">
                        <i class="fa-solid fa-headset"></i>
                        <span>관리자 답변</span>
                    </div>
                    <span id="modal-answer-date" class="answer-date"></span>
                </div>
                <p id="modal-answer" class="content-text"></p>
            </div>

            <div class="button-group">
                <button id="btn-edit" class="btn-premium btn-premium-primary">
                    <i class="fa-solid fa-pen"></i>
                    수정하기
                </button>
                <button id="btn-delete" class="btn-premium btn-premium-danger">
                    <i class="fa-solid fa-trash"></i>
                    삭제
                </button>
                <button id="btn-close-detail2" class="btn-premium btn-premium-secondary">
                    <i class="fa-solid fa-xmark"></i>
                    닫기
                </button>
            </div>
        </div>

        <div id="edit-mode" class="modal-body-premium" style="display: none;">
            <form id="editForm">
                <input type="hidden" id="edit-qnaId" name="qnaId">
                
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" id="edit-title" name="qnaTitle" required class="form-input" placeholder="질문 제목을 입력하세요">
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea id="edit-content" name="qnaContent" required class="form-textarea" placeholder="질문 내용을 자세히 작성해주세요"></textarea>
                </div>
                
                <div class="form-group">
                    <div class="form-checkbox">
                        <input type="checkbox" id="edit-secret" name="secretYn" value="Y">
                        <label for="edit-secret">비밀글로 설정 (본인과 관리자만 열람 가능)</label>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-premium btn-premium-primary">
                        <i class="fa-solid fa-check"></i>
                        저장하기
                    </button>
                    <button type="button" id="btn-cancel-edit" class="btn-premium btn-premium-secondary">
                        <i class="fa-solid fa-rotate-left"></i>
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 작성 모달 -->
<div id="writeModal" class="modal-overlay-premium">
    <div class="modal-content-premium">
        <div class="modal-header-premium">
            <h3 class="modal-title-premium">✨ 새 질문 작성</h3>
            <button id="btn-close-write" class="modal-close-btn">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="modal-body-premium">
            <form id="writeForm">
                <div class="form-group">
                    <label class="form-label">제목</label>
                    <input type="text" name="qnaTitle" required class="form-input" placeholder="질문 제목을 입력하세요">
                </div>
                
                <div class="form-group">
                    <label class="form-label">내용</label>
                    <textarea name="qnaContent" required class="form-textarea" placeholder="궁금한 내용을 자세히 작성해주세요"></textarea>
                </div>
                
                <div class="form-group">
                    <div class="form-checkbox">
                        <input type="checkbox" name="secretYn" value="Y" id="write-secret">
                        <label for="write-secret">비밀글로 설정 (본인과 관리자만 열람 가능)</label>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn-premium btn-premium-primary">
                        <i class="fa-solid fa-paper-plane"></i>
                        질문 등록
                    </button>
                    <button type="button" id="btn-close-write2" class="btn-premium btn-premium-secondary">
                        <i class="fa-solid fa-xmark"></i>
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<script>

// ✅ 중복 실행 방지
if (!window.qnaScriptLoaded) {
    window.qnaScriptLoaded = true;
    
    (function() {
        'use strict';
        
        console.log('🚀 QNA Premium 스크립트 시작');
        
        var ctx = '<%=request.getContextPath()%>';
        var currentQnaId = null;
        
        // 이벤트 위임
        document.addEventListener('click', function(e) {
            if (e.target && e.target.closest('#btn-write')) {
                var writeForm = document.getElementById('writeForm');
                if (writeForm) writeForm.reset();
                var writeModal = document.getElementById('writeModal');
                if (writeModal) writeModal.classList.add('active');
            }
            
            if (e.target && e.target.closest('.qna-card-premium')) {
                var card = e.target.closest('.qna-card-premium');
                var qnaId = card.getAttribute('data-qna-id');
                openDetailModal(qnaId);
            }
            
            if (e.target && (e.target.closest('#btn-close-detail') || e.target.closest('#btn-close-detail2'))) {
                closeDetailModal();
            }
            if (e.target && (e.target.closest('#btn-close-write') || e.target.closest('#btn-close-write2'))) {
                closeWriteModal();
            }
            
            if (e.target && e.target.closest('#btn-edit')) {
                enterEditMode();
            }
            if (e.target && e.target.closest('#btn-delete')) {
                deleteQna();
            }
            if (e.target && e.target.closest('#btn-cancel-edit')) {
                cancelEdit();
            }
            
            if (e.target && e.target.classList.contains('modal-overlay-premium')) {
                e.target.classList.remove('active');
            }
        });
        
        document.addEventListener('submit', function(e) {
            if (e.target && e.target.id === 'editForm') {
                e.preventDefault();
                submitEdit(e);
            }
            if (e.target && e.target.id === 'writeForm') {
                e.preventDefault();
                submitWrite(e);
            }
        });
        
        function openDetailModal(qnaId) {
            currentQnaId = qnaId;
            
            fetch(ctx + '/mypage/qna/detail.do?qnaId=' + qnaId)
                .then(function(res) {
                    if (!res.ok) throw new Error('조회 실패');
                    return res.json();
                })
                .then(function(data) {
                    if (data.error) {
                        alert(data.error);
                        return;
                    }
                    
                    document.getElementById('modal-title').textContent = data.qnaTitle;
                    document.getElementById('modal-content').textContent = data.qnaContent;
                    
                    var statusBadge = document.getElementById('modal-status');
                    statusBadge.innerHTML = '<i class="fa-solid ' + (data.statusYn == '완료' ? 'fa-check-circle' : 'fa-clock') + '"><\/i> ' + data.statusYn;
                    statusBadge.className = 'status-badge-premium ' + (data.statusYn == '완료' ? 'status-complete-premium' : 'status-pending-premium');
                    
                    document.getElementById('modal-secret').style.display = data.secretYn == 'Y' ? 'inline-flex' : 'none';
                    
                    var answerArea = document.getElementById('answer-area');
                    if (data.answerContent) {
                        document.getElementById('modal-answer').textContent = data.answerContent;
                        if (data.answerDate) {
                            var answerDate = new Date(data.answerDate);
                            document.getElementById('modal-answer-date').textContent = 
                                answerDate.getFullYear() + '.' + 
                                String(answerDate.getMonth() + 1).padStart(2, '0') + '.' + 
                                String(answerDate.getDate()).padStart(2, '0');
                        }
                        answerArea.style.display = 'block';
                    } else {
                        answerArea.style.display = 'none';
                    }
                    
                    document.getElementById('edit-qnaId').value = data.qnaId;
                    document.getElementById('edit-title').value = data.qnaTitle;
                    document.getElementById('edit-content').value = data.qnaContent;
                    document.getElementById('edit-secret').checked = (data.secretYn == 'Y');
                    
                    document.getElementById('detailModal').classList.add('active');
                    document.getElementById('view-mode').style.display = 'block';
                    document.getElementById('edit-mode').style.display = 'none';
                })
                .catch(function(err) {
                    alert('질문 정보를 불러오는데 실패했습니다.');
                });
        }
        
        function closeDetailModal() {
            var modal = document.getElementById('detailModal');
            if (modal) modal.classList.remove('active');
            currentQnaId = null;
        }
        
        function closeWriteModal() {
            var modal = document.getElementById('writeModal');
            if (modal) modal.classList.remove('active');
        }
        
        function enterEditMode() {
            document.getElementById('view-mode').style.display = 'none';
            document.getElementById('edit-mode').style.display = 'block';
        }
        
        function cancelEdit() {
            document.getElementById('view-mode').style.display = 'block';
            document.getElementById('edit-mode').style.display = 'none';
        }
        
        function submitEdit(e) {
            var form = e.target;
            var params = new URLSearchParams();
            params.append('qnaId', form.qnaId.value);
            params.append('qnaTitle', form.qnaTitle.value);
            params.append('qnaContent', form.qnaContent.value);
            params.append('secretYn', form.secretYn.checked ? 'Y' : 'N');
            
            fetch(ctx + '/mypage/qna/update.do', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) throw new Error('수정 실패');
                return res.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('✅ 질문이 수정되었습니다.');
                    closeDetailModal();
                    if (typeof loadPage === 'function') {
                        loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                    } else {
                        location.reload();
                    }
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(function(err) {
                alert('수정 중 오류가 발생했습니다.');
            });
        }
        
        function deleteQna() {
            if (!confirm('🗑️ 정말 이 질문을 삭제하시겠습니까?\n삭제된 내용은 복구할 수 없습니다.')) {
                return;
            }
            
            var params = new URLSearchParams();
            params.append('qnaId', currentQnaId);
            
            fetch(ctx + '/mypage/qna/delete.do', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) throw new Error('삭제 실패');
                return res.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('✅ 질문이 삭제되었습니다.');
                    closeDetailModal();
                    if (typeof loadPage === 'function') {
                        loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                    } else {
                        location.reload();
                    }
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(function(err) {
                alert('삭제 중 오류가 발생했습니다.');
            });
        }
        
        function submitWrite(e) {
            var form = e.target;
            var params = new URLSearchParams();
            params.append('qnaTitle', form.qnaTitle.value);
            params.append('qnaContent', form.qnaContent.value);
            params.append('secretYn', form.secretYn.checked ? 'Y' : 'N');
            
            fetch(ctx + '/mypage/qna/insert.do', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                body: params.toString()
            })
            .then(function(res) {
                if (!res.ok) throw new Error('등록 실패');
                return res.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('✅ 질문이 등록되었습니다.');
                    closeWriteModal();
                    if (typeof loadPage === 'function') {
                        loadPage('qna', ctx + '/mypage/qna/list.do', document.querySelector('.nav-item.active'));
                    } else {
                        location.reload();
                    }
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(function(err) {
                alert('등록 중 오류가 발생했습니다.');
            });
        }
        
        console.log('✅ QNA Premium 완료');
    })();
} 
</script> --%>