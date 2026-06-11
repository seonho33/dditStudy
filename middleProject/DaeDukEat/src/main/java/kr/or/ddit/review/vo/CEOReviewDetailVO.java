package kr.or.ddit.review.vo;

import java.io.Serializable;

/**
 * 리뷰 상세 정보 (고객 리뷰 + 사장 답글 + 예약자 정보)
 * @purpose MyBatis JOIN 결과 매핑용
 */
public class CEOReviewDetailVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // USER_REVIEW
    private Long reservId;
    private String userReview;
    private String reviewPicture;
    private String userReviewDate;
    private int rating;
    private String status;
    
    // RESERVATION (고객 정보)
    private String userId;          // 고객ID
    private String userName;        // 고객명 (MEMBER 테이블 조인 시)
    private String reservTime;      // 예약일시
    
    // CEO_REVIEW
    private String ceoReview;       // 사장 답글
    private String ceoReviewDate;   // 답글 작성일
    
    // UI용 추가 필드
    private boolean hasReply;       // 답글 존재 여부
    
    // Getters & Setters
    public Long getReservId() { return reservId; }
    public void setReservId(Long reservId) { this.reservId = reservId; }
    
    public String getUserReview() { return userReview; }
    public void setUserReview(String userReview) { this.userReview = userReview; }
    
    public String getReviewPicture() { return reviewPicture; }
    public void setReviewPicture(String reviewPicture) { this.reviewPicture = reviewPicture; }
    
    public String getUserReviewDate() { return userReviewDate; }
    public void setUserReviewDate(String userReviewDate) { this.userReviewDate = userReviewDate; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getReservTime() { return reservTime; }
    public void setReservTime(String reservTime) { this.reservTime = reservTime; }
    
    public String getCeoReview() { return ceoReview; }
    public void setCeoReview(String ceoReview) { 
        this.ceoReview = ceoReview;
        this.hasReply = (ceoReview != null && !ceoReview.trim().isEmpty());
    }
    
    public String getCeoReviewDate() { return ceoReviewDate; }
    public void setCeoReviewDate(String ceoReviewDate) { this.ceoReviewDate = ceoReviewDate; }
    
    public boolean isHasReply() { return hasReply; }
    public void setHasReply(boolean hasReply) { this.hasReply = hasReply; }
    
    @Override
    public String toString() {
        return "ReviewDetailVO [reservId=" + reservId + ", userName=" + userName + 
               ", rating=" + rating + ", hasReply=" + hasReply + "]";
    }
}