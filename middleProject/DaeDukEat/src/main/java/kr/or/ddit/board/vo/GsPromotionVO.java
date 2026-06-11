package kr.or.ddit.board.vo;

import java.sql.Timestamp;

/**
 * GS_PROMOTION 테이블 매핑 DTO
 * 
 * [주요 변경 사항]
 * - JSP form 필드와 DB 컬럼 간 Camel Case 자동 매핑
 * - discount_rate는 Service Layer에서 계산하여 설정
 * - 파일 업로드를 위한 MultipartFile 필드 추가 고려 가능
 */
public class GsPromotionVO {
    
    // PK
    private long gsId;
    
    // 상품 기본 정보
    private String productName;        // JSP: prod_name
    private long originalPrice;        // JSP: prod_price
    private long discountPrice;        // JSP: prod_discount
    private long discountRate;         // 자동 계산 필드 (Service에서 설정)
    
    // 이미지 및 시간 정보
    private String productImageUrl;    // JSP: prod_img → 서버 저장 경로로 변환 필요
    private Timestamp endTime;         // JSP: prod_deadline (마감할인 전용)
    
    // 상태 및 메타 정보
    private String statusYn;           // 기본값: 'Y'
    private Timestamp createDate;      // DB DEFAULT: SYSTIMESTAMP
    private String userId;             // FK → 세션에서 주입 필요
    
    // ✅ JSP의 prod_category는 별도 처리 (현재 DB 스키마에 없음)
    // 향후 확장 시 카테고리 테이블 분리 권장
    
    // Getters and Setters
    public long getGsId() { return gsId; }
    public void setGsId(long gsId) { this.gsId = gsId; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public long getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(long originalPrice) { this.originalPrice = originalPrice; }
    
    public long getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(long discountPrice) { this.discountPrice = discountPrice; }
    
    public long getDiscountRate() { return discountRate; }
    public void setDiscountRate(long discountRate) { this.discountRate = discountRate; }
    
    public String getProductImageUrl() { return productImageUrl; }
    public void setProductImageUrl(String productImageUrl) { this.productImageUrl = productImageUrl; }
    
    public Timestamp getEndTime() { return endTime; }
    public void setEndTime(Timestamp endTime) { this.endTime = endTime; }
    
    public String getStatusYn() { return statusYn; }
    public void setStatusYn(String statusYn) { this.statusYn = statusYn; }
    
    public Timestamp getCreateDate() { return createDate; }
    public void setCreateDate(Timestamp createDate) { this.createDate = createDate; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
}