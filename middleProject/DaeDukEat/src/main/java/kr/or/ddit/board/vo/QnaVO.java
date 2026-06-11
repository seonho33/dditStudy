package kr.or.ddit.board.vo;

import java.util.Date;

/**
 * QNA 테이블 매핑 VO
 * 
 * [테이블 구조]
 * - PK: qna_id (NUMBER)
 * - FK: user_id → USERS(user_id)
 * 
 * [주요 기능]
 * - Q&A 질문 등록/수정/삭제
 * - 관리자 답변 등록
 * - 비밀글 설정
 * - 상태 관리 (접수/완료)
 */
public class QnaVO {
    
    private Long qnaId;              // 질문 아이디 (PK)
    private String qnaTitle;         // 질문 제목 (최대 300자)
    private String qnaContent;       // 질문 내용 (최대 500자)
    private String answerContent;    // 관리자 답변 (최대 1000자)
    private String statusYn;         // 상태 (접수, 완료)
    private String secretYn;         // 비밀글 여부 (Y, N)
    private Date createDate;         // 등록일자
    private Date answerDate;         // 답변일자
    private String userId;           // 작성자 아이디 (FK)
    
    // 기본 생성자
    public QnaVO() {}
    
    // Getters & Setters
    public Long getQnaId() {
        return qnaId;
    }
    
    public void setQnaId(Long qnaId) {
        this.qnaId = qnaId;
    }
    
    public String getQnaTitle() {
        return qnaTitle;
    }
    
    public void setQnaTitle(String qnaTitle) {
        this.qnaTitle = qnaTitle;
    }
    
    public String getQnaContent() {
        return qnaContent;
    }
    
    public void setQnaContent(String qnaContent) {
        this.qnaContent = qnaContent;
    }
    
    public String getAnswerContent() {
        return answerContent;
    }
    
    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }
    
    public String getStatusYn() {
        return statusYn;
    }
    
    public void setStatusYn(String statusYn) {
        this.statusYn = statusYn;
    }
    
    public String getSecretYn() {
        return secretYn;
    }
    
    public void setSecretYn(String secretYn) {
        this.secretYn = secretYn;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public Date getAnswerDate() {
        return answerDate;
    }
    
    public void setAnswerDate(Date answerDate) {
        this.answerDate = answerDate;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    /**
     * 답변 완료 여부
     */
    public boolean isAnswered() {
        return this.answerContent != null && !this.answerContent.isEmpty();
    }
    
    /**
     * 비밀글 여부
     */
    public boolean isSecret() {
        return "Y".equalsIgnoreCase(this.secretYn);
    }

	@Override
	public String toString() {
		return "QnaVO [qnaId=" + qnaId + ", qnaTitle=" + qnaTitle + ", qnaContent=" + qnaContent + ", answerContent="
				+ answerContent + ", statusYn=" + statusYn + ", secretYn=" + secretYn + ", createDate=" + createDate
				+ ", answerDate=" + answerDate + ", userId=" + userId + "]";
	}
    
    
}