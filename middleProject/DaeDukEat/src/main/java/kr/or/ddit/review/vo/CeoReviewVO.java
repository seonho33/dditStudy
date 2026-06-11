package kr.or.ddit.review.vo;

import java.io.Serializable;

/**
 * 사장님 답글 VO
 * @table CEO_REVIEW
 */
public class CeoReviewVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long reservId;      // 예약ID (PK, FK to USER_REVIEW)
    private String review;      // 답글내용
    private String createDate;  // 작성일
    private String updateDate;  // 수정일
    
    // Getters & Setters
    public Long getReservId() { return reservId; }
    public void setReservId(Long reservId) { this.reservId = reservId; }
    
    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }
    
    public String getCreateDate() { return createDate; }
    public void setCreateDate(String createDate) { this.createDate = createDate; }
    
    public String getUpdateDate() { return updateDate; }
    public void setUpdateDate(String updateDate) { this.updateDate = updateDate; }
    
    @Override
    public String toString() {
        return "CeoReviewVO [reservId=" + reservId + ", review=" + review + 
               ", createDate=" + createDate + "]";
    }
}