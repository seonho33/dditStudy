package kr.or.ddit.admin.vo;

import java.sql.Timestamp;

public class GsVO {

    // 아이템분류(갓세일, 마감할인, 핫아이템)
    private String productDivision;   // PRODUCT_DIVISION

    // GS 아이디 (PK / 시퀀스)
    private int gsId;                 // GS_ID

    // 상품명
    private String productName;       // PRODUCT_NAME

    // 정가
    private int originalPrice;        // ORIGINAL_PRICE

    // 할인판매가
    private int discountPrice;        // DISCOUNT_PRICE

    // 할인율(계산값 저장) -> 퍼센트 정수(예: 25 = 25%)
    private int discountRate;         // DISCOUNT_RATE

    // 상품 이미지 경로/파일명(UUID 저장 권장)
    private String productImageUrl;   // PRODUCT_IMAGE_URL

    // 상태(진행중 Y, 마감 N)
    private String statusYn;          // STATUS_YN

    // 등록일자
    private Timestamp createDate;     // CREATE_DATE

    // 이용자아이디(등록한 관리자/점주 등)
    private String userId;            // USER_ID

 // private Timestamp endTime;
    private String endTime;

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    
    // 기본 생성자
    public GsVO() {}

    // 전체 생성자(원하면 사용)
    public GsVO(String productDivision, int gsId, String productName,
                int originalPrice, int discountPrice, int discountRate,
                String productImageUrl, String endTime,
                String statusYn, Timestamp createDate, String userId) {

        this.productDivision = productDivision;
        this.gsId = gsId;
        this.productName = productName;
        this.originalPrice = originalPrice;
        this.discountPrice = discountPrice;
        this.discountRate = discountRate;
        this.productImageUrl = productImageUrl;
        this.endTime = endTime;
        this.statusYn = statusYn;
        this.createDate = createDate;
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "GsVO [productDivision=" + productDivision
                + ", gsId=" + gsId
                + ", productName=" + productName
                + ", originalPrice=" + originalPrice
                + ", discountPrice=" + discountPrice
                + ", discountRate=" + discountRate
                + ", productImageUrl=" + productImageUrl
                + ", endTime=" + endTime
                + ", statusYn=" + statusYn
                + ", createDate=" + createDate
                + ", userId=" + userId + "]";
    }

	public String getProductDivision() {
		return productDivision;
	}

	public void setProductDivision(String productDivision) {
		this.productDivision = productDivision;
	}

	public int getGsId() {
		return gsId;
	}

	public void setGsId(int gsId) {
		this.gsId = gsId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(int originalPrice) {
		this.originalPrice = originalPrice;
	}

	public int getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(int discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
	}

	public String getProductImageUrl() {
		return productImageUrl;
	}

	public void setProductImageUrl(String productImageUrl) {
		this.productImageUrl = productImageUrl;
	}
	public String getStatusYn() {
		return statusYn;
	}

	public void setStatusYn(String statusYn) {
		this.statusYn = statusYn;
	}

	public Timestamp getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
    
}
