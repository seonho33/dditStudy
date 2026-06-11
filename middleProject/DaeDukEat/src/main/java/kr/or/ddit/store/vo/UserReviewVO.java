package kr.or.ddit.store.vo;

import java.util.Date;

/**
 * 사용자 리뷰 VO (USER_REVIEW 테이블 매핑)
 * 
 * [테이블 구조]
 * - RESERV_ID       : PK/FK (예약 ID)
 * - REVIEW          : 리뷰 내용
 * - REVIEW_PICTURE  : 리뷰 사진 경로
 * - CREATE_DATE     : 작성일
 * - UPDATE_DATE     : 수정일
 * - RATING          : 평점 (1-5)
 * - STATUS          : 상태 (정상, 삭제)
 * 
 * [조인 필드]
 * - RESERVATION 테이블 정보
 * - STORE 테이블 정보
 * - CEO_REVIEW 테이블 정보
 */
public class UserReviewVO {
    
    /* ====================================
       기본 필드 (USER_REVIEW 테이블)
       ==================================== */
    private Long reservId;          // 예약 ID (PK/FK)
    private String review;          // 리뷰 내용
    private String reviewPicture;   // 리뷰 사진 경로
    private Date createDate;        // 작성일
    private Date updateDate;        // 수정일
    private Integer rating;         // 평점 (1-5)
    private String status;          // 상태 (정상, 삭제)
    
    /* ====================================
       조인 필드 (RESERVATION 테이블)
       ==================================== */
    private String userId;          // 사용자 ID
    private String storeId;         // 가게 ID
    private String reservTime;      // 예약 시간
    private Integer guestCount;     // 예약 인원
    private String reservStatus;    // 예약 상태
    private Date reservDate;        // 예약 생성일
    
    /* ====================================
       조인 필드 (STORE 테이블)
       ==================================== */
    private String storeName;       // 가게 이름
    private String storeAddr;       // 가게 주소
    private String category;        // 카테고리
    
    /* ====================================
       조인 필드 (CEO_REVIEW 테이블)
       ==================================== */
    private String hasCeoReply;     // 사장님 답글 여부 (Y/N)
    private String ceoReview;       // 사장님 답글 내용
    
    /* ====================================
       계산 필드
       ==================================== */
    private String reviewable;      // 리뷰 작성 가능 여부 (Y/N)
    
    
    /* ====================================
       Getters & Setters
       ==================================== */
    
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
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

    public Date getReservDate() {
        return reservDate;
    }

    public void setReservDate(Date reservDate) {
        this.reservDate = reservDate;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getHasCeoReply() {
        return hasCeoReply;
    }

    public void setHasCeoReply(String hasCeoReply) {
        this.hasCeoReply = hasCeoReply;
    }

    public String getCeoReview() {
        return ceoReview;
    }

    public void setCeoReview(String ceoReview) {
        this.ceoReview = ceoReview;
    }

    public String getReviewable() {
        return reviewable;
    }

    public void setReviewable(String reviewable) {
        this.reviewable = reviewable;
    }

    
    /* ====================================
       비즈니스 로직 메서드
       ==================================== */
    
    /**
     * 리뷰 작성 가능 여부 체크
     */
    public boolean isReviewable() {
        return "Y".equals(this.reviewable);
    }
    
    /**
     * 별점 문자열 생성 (★★★★★)
     */
    public String getStarString() {
        if(rating == null || rating < 1 || rating > 5) {
            return "";
        }
        
        StringBuilder stars = new StringBuilder();
        for(int i = 0; i < rating; i++) {
            stars.append("★ ");
        }
        return stars.toString().trim();
    }
    
    /**
     * 사장님 답글 존재 여부
     */
    public boolean hasCeoReply() {
        return "Y".equals(this.hasCeoReply);
    }
    
    @Override
    public String toString() {
        return "UserReviewVO [reservId=" + reservId + ", storeName=" + storeName 
                + ", rating=" + rating + ", status=" + status + "]";
    }
}