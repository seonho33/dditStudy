package kr.or.ddit.review.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 리뷰 상세 정보 VO (조인 쿼리 결과 매핑)
 * RESERVATION + USER_REVIEW + STORE 조인 데이터 담당
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-23
 */
public class ReviewDetailVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // === RESERVATION 테이블 컬럼 ===
    /** 예약 ID */
    private Long reservId;
    
    /** 예약 시간 */
    private String reservTime;
    
    /** 예약 인원 수 */
    private Integer guestCount;
    
    /** 예약 상태 */
    private String reservStatus;
    
    /** 예약 생성 일자 */
    private Date createDate;
    
    // === STORE 테이블 컬럼 ===
    /** 가게 ID */
    private String storeId;
    
    /** 가게 이름 */
    private String storeName;
    
    /** 가게 주소 */
    private String storeAddr;
    
    /** 가게 전화번호 */
    private String storePhone;
    
    // === USER_REVIEW 테이블 컬럼 ===
    /** 리뷰 내용 */
    private String review;
    
    /** 리뷰 사진 */
    private String reviewPicture;
    
    /** 평점 */
    private Integer rating;
    
    /** 리뷰 상태 */
    private String reviewStatus;
    
    /** 리뷰 작성 여부 (미작성 리뷰 구분용) */
    private Boolean hasReview;
    
    // === Constructor ===
    public ReviewDetailVO() {}
    
    // === Getters & Setters ===
    public Long getReservId() {
        return reservId;
    }
    
    public void setReservId(Long reservId) {
        this.reservId = reservId;
    }
    
    public String getReservTime() {
        return reservTime;
    }
    
    public void setReservTime(String reservTime) {
        this.reservTime = reservTime;
    }
    
    public Integer getGuestCount() {
        return guestCount;
    }
    
    public void setGuestCount(Integer guestCount) {
        this.guestCount = guestCount;
    }
    
    public String getReservStatus() {
        return reservStatus;
    }
    
    public void setReservStatus(String reservStatus) {
        this.reservStatus = reservStatus;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public String getStoreId() {
        return storeId;
    }
    
    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }
    
    public String getStoreName() {
        return storeName;
    }
    
    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }
    
    public String getStoreAddr() {
        return storeAddr;
    }
    
    public void setStoreAddr(String storeAddr) {
        this.storeAddr = storeAddr;
    }
    
    public String getStorePhone() {
        return storePhone;
    }
    
    public void setStorePhone(String storePhone) {
        this.storePhone = storePhone;
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
    
    public Integer getRating() {
        return rating;
    }
    
    public void setRating(Integer rating) {
        this.rating = rating;
    }
    
    public String getReviewStatus() {
        return reviewStatus;
    }
    
    public void setReviewStatus(String reviewStatus) {
        this.reviewStatus = reviewStatus;
    }
    
    public Boolean getHasReview() {
        return hasReview;
    }
    
    public void setHasReview(Boolean hasReview) {
        this.hasReview = hasReview;
    }
    
    @Override
    public String toString() {
        return "ReviewDetailVO [reservId=" + reservId + ", storeName=" + storeName 
                + ", rating=" + rating + ", hasReview=" + hasReview + "]";
    }
}