package kr.or.ddit.store.vo;

import java.util.Date;

/**
 * COUPON 테이블 매핑 VO
 * - MyBatis mapUnderscoreToCamelCase 설정으로 자동 변환
 * - DB: COUPON_ID → Java: couponId
 */
public class CouponVO {
    private Long couponId;          // 쿠폰아이디 (PK)
    private String couponName;      // 쿠폰이름
    private String couponContent;   // 쿠폰내용
    private Long deductedPrice;     // 할인금액
    private Long minPrice;          // 최소주문금액
    private Date createDate;        // 쿠폰생성일
    private Date expiredDate;       // 쿠폰소멸일
    private Date updateDate;        // 쿠폰수정일
    private String status;          // 쿠폰상태 (Y/N)
    private Long couponQty;         // 쿠폰수량
    private String storeId;         // 가게아이디 (FK)
    
    // Getter & Setter
    public Long getCouponId() {
        return couponId;
    }
    
    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }
    
    public String getCouponName() {
        return couponName;
    }
    
    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }
    
    public String getCouponContent() {
        return couponContent;
    }
    
    public void setCouponContent(String couponContent) {
        this.couponContent = couponContent;
    }
    
    public Long getDeductedPrice() {
        return deductedPrice;
    }
    
    public void setDeductedPrice(Long deductedPrice) {
        this.deductedPrice = deductedPrice;
    }
    
    public Long getMinPrice() {
        return minPrice;
    }
    
    public void setMinPrice(Long minPrice) {
        this.minPrice = minPrice;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public Date getExpiredDate() {
        return expiredDate;
    }
    
    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Long getCouponQty() {
        return couponQty;
    }
    
    public void setCouponQty(Long couponQty) {
        this.couponQty = couponQty;
    }
    
    public String getStoreId() {
        return storeId;
    }
    
    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    @Override
    public String toString() {
        return "CouponVO{" +
                "couponId=" + couponId +
                ", couponName='" + couponName + '\'' +
                ", deductedPrice=" + deductedPrice +
                ", minPrice=" + minPrice +
                ", status='" + status + '\'' +
                ", storeId='" + storeId + '\'' +
                '}';
    }
}