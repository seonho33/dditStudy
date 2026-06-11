package kr.or.ddit.store.vo;

import java.io.Serializable;

/**
 * 사장님 대시보드 통계 데이터 전송 객체
 * - V_OWNER_STATS 뷰와 매핑
 * - MyBatis mapUnderscoreToCamelCase 활용
 * 
 * @author Senior Architect
 * @version 1.0
 */
public class OwnerStatsVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String userId;              // 사장님 ID
    private String storeId;             // 가게 ID
    private String storeName;           // 가게명
    private Double rating;              // 평균 평점
    private Integer dibsCount;          // 찜 수
    private Integer reviewCount;        // 총 리뷰 수
    private Integer todayReservCount;   // 오늘 예약 건수
    private Integer pendingReservCount; // 대기중 예약 건수
    
    // ========== Constructors ==========
    public OwnerStatsVO() {}
    
    // ========== Getters & Setters ==========
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getStoreId() { return storeId; }
    public void setStoreId(String storeId) { this.storeId = storeId; }
    
    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }
    
    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }
    
    public Integer getDibsCount() { return dibsCount; }
    public void setDibsCount(Integer dibsCount) { this.dibsCount = dibsCount; }
    
    public Integer getReviewCount() { return reviewCount; }
    public void setReviewCount(Integer reviewCount) { this.reviewCount = reviewCount; }
    
    public Integer getTodayReservCount() { return todayReservCount; }
    public void setTodayReservCount(Integer todayReservCount) { this.todayReservCount = todayReservCount; }
    
    public Integer getPendingReservCount() { return pendingReservCount; }
    public void setPendingReservCount(Integer pendingReservCount) { this.pendingReservCount = pendingReservCount; }
    
    @Override
    public String toString() {
        return "OwnerStatsVO{" +
                "userId='" + userId + '\'' +
                ", storeId='" + storeId + '\'' +
                ", storeName='" + storeName + '\'' +
                ", rating=" + rating +
                ", dibsCount=" + dibsCount +
                ", reviewCount=" + reviewCount +
                ", todayReservCount=" + todayReservCount +
                ", pendingReservCount=" + pendingReservCount +
                '}';
    }
}