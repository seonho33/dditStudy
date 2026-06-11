package kr.or.ddit.store.vo;

import java.util.Date;

/**
 * 쿠폰함 VO (COUPONHAM 테이블 매핑)
 * 
 * [테이블 구조]
 * - COUPON_BOX_ID : PK (쿠폰함 ID)
 * - USE_YN        : 사용 여부 ('Y'=사용완료, 'N'=미사용)
 * - ISSUED_DATE   : 발급일자
 * - USED_DATE     : 사용일자 (NULL 허용)
 * - COUPON_ID     : FK (쿠폰 ID)
 * - USER_ID       : FK (회원 ID)
 * 
 * [MyBatis 설정]
 * - mapUnderscoreToCamelCase=true 설정으로 자동 매핑
 * - COUPON_BOX_ID → couponBoxId
 */
public class CouponhamVO {
    
    /* ====================================
       기본 필드 (COUPONHAM 테이블)
       ==================================== */
    private Long couponBoxId;       // 쿠폰함 ID (PK)
    private String useYn;           // 사용 여부 ('Y', 'N')
    private Date issuedDate;        // 발급일자
    private Date usedDate;          // 사용일자 (nullable)
    private Long couponId;          // 쿠폰 ID (FK)
    private String userId;          // 회원 ID (FK)
    
    /* ====================================
       조인 필드 (COUPON 테이블 정보)
       ==================================== */
    private String couponName;      // 쿠폰 이름
    private String couponContent;   // 쿠폰 설명
    private Integer deductedPrice;  // 할인 금액 (정액) 또는 할인율 (%)
    private Integer minPrice;       // 최소 주문 금액
    private Date expiredDate;       // 쿠폰 만료일
    private String couponStatus;    // 쿠폰 상태 ('Y', 'N')
    
    /* ====================================
       조인 필드 (STORE 테이블 정보)
       ==================================== */
    private String storeId;         // 가게 ID
    private String storeName;       // 가게 이름
    
    /* ====================================
       계산 필드 (View/Query에서 생성)
       ==================================== */
    private Integer discountRate;   // 할인율 (%, 정액 할인일 경우 NULL)
    private String availability;    // 사용 가능 상태 (AVAILABLE, USED, EXPIRED, DISABLED)
    
    
    /* ====================================
       Getters & Setters
       ==================================== */
    public Long getCouponBoxId() {
        return couponBoxId;
    }

    public void setCouponBoxId(Long couponBoxId) {
        this.couponBoxId = couponBoxId;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public Date getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(Date issuedDate) {
        this.issuedDate = issuedDate;
    }

    public Date getUsedDate() {
        return usedDate;
    }

    public void setUsedDate(Date usedDate) {
        this.usedDate = usedDate;
    }

    public Long getCouponId() {
        return couponId;
    }

    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public Integer getDeductedPrice() {
        return deductedPrice;
    }

    public void setDeductedPrice(Integer deductedPrice) {
        this.deductedPrice = deductedPrice;
    }

    public Integer getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Integer minPrice) {
        this.minPrice = minPrice;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getCouponStatus() {
        return couponStatus;
    }

    public void setCouponStatus(String couponStatus) {
        this.couponStatus = couponStatus;
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

    public Integer getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(Integer discountRate) {
        this.discountRate = discountRate;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    
    /* ====================================
       비즈니스 로직 메서드
       ==================================== */
    
    /**
     * 쿠폰 사용 가능 여부 체크
     * @return true=사용가능, false=사용불가
     */
    public boolean isAvailable() {
        return "AVAILABLE".equals(this.availability);
    }
    
    /**
     * 할인 타입 판별
     * @return "PERCENT" (할인율) 또는 "FIXED" (정액 할인)
     */
    public String getDiscountType() {
        if(this.discountRate != null && this.discountRate > 0) {
            return "PERCENT";
        }
        return "FIXED";
    }
    
    /**
     * 표시용 할인 정보 (예: "15%" 또는 "5,000원")
     * @return 포맷팅된 할인 정보
     */
    public String getFormattedDiscount() {
        if("PERCENT".equals(getDiscountType())) {
            return this.discountRate + "%";
        } else {
            return String.format("%,d원", this.deductedPrice);
        }
    }
    
    @Override
    public String toString() {
        return "CouponhamVO [couponBoxId=" + couponBoxId + ", couponName=" + couponName 
                + ", useYn=" + useYn + ", availability=" + availability + "]";
    }
}