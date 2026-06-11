package kr.or.ddit.review.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 사용자 리뷰 VO (USER_REVIEW 테이블 매핑)
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-23
 * @see kr.or.ddit.review.dao.IReviewDAO
 */
public class UserReviewVO implements Serializable {
    private static final long serialVersionUID = 1L;
       
    /** 예약 ID (PK, FK → RESERVATION) */
    private Long reservId;
    
    /** 리뷰 내용 (최대 255자) */
    private String review;
    
    /** 리뷰 사진 경로 (최대 500자) */
    private String reviewPicture;
    
    /** 생성 일자 (DEFAULT: SYSDATE) */
    private Date createDate;
    
    /** 수정 일자 (NULL 허용) */
    private Date updateDate;
    
    /** 평점 (0~5, DEFAULT: 0) */
    private Integer rating;
    
    /** 리뷰 상태 (DEFAULT: '정상') */
    private String status;
    
    // === Constructor ===
    public UserReviewVO() {}
    
    // === Getters & Setters ===
    public Long getReservId() {
        return reservId;
    }
    
    public void setReservId(Long reservId) {
        this.reservId = reservId;
    }
    
    public String getReview() {
        return review;
    }
    
    public void setReview(String review) {
        this.review = review;
    }
    
    public String getReviewPicture() {
        return reviewPicture;
    }
    
    public void setReviewPicture(String reviewPicture) {
        this.reviewPicture = reviewPicture;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    public Integer getRating() {
        return rating;
    }
    
    public void setRating(Integer rating) {
        this.rating = rating;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "UserReviewVO [reservId=" + reservId + ", rating=" + rating 
                + ", review=" + review + ", status=" + status + "]";
    }

}