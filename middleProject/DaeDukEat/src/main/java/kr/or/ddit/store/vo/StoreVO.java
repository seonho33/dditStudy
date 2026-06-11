package kr.or.ddit.store.vo;

import java.util.Date;

public class StoreVO {
	private String storeId;        // STORE_ID   -  가게 아이디
    private String storeName;      // STORE_NAME  -가게 이름
    private String storeAddr;      // STORE_ADDR  -가게 주소
    private String storeAddr2;     // STORE_ADDR2  - 가게 상세주소
    private String storePhone;     // STORE_PHONE - 가게 전화번호
    private String category;       // CATEGORY  -카테고리
    private String storeContent;   // STORE_CONTENT  - 가게 내용
    private String operationHours; // OPERATION_HOURS  - 운영시간
    private Date createDate;       // CREATE_DATE  - 생성 일자
    private int rating;            // RATING  - 평점 
    private int dibsCount;         // DIBS_COUNT  - 찜 수
    private int reviewCount;       // REVIEW_COUNT - 리뷰 수
    private String status;         // STATUS - 상태
    private String bizNo;          // BIZ_NO - 사업자 등록 번호
    private String ownerEmail;     // OWNER_EMAIL - 대표자 이메일
    private int deposit;           // DEPOSIT - 가게 예약금
    private String userId;         // USER_ID - 이용자 아이디
    private String storePicture; 	/* 가게 사진 */ 
    private int likesCount; /* 좋아요수 */     
  
    
    private String review;          // 리뷰 내용
	private int distance;   // 거리 ✅ 화면 출력용

	
	public StoreVO() {}
	
		public StoreVO(String storeId, String storeName, String storeAddr, String storeAddr2,
	               	   String storePhone, String category, String storeContent, String operationHours,
	                   Date createDate, int rating, int dibsCount, int reviewCount,
	                   String status, String bizNo, String ownerEmail, int deposit, String userId) {
	    super();
	    this.storeId = storeId;
	    this.storeName = storeName;
	    this.storeAddr = storeAddr;
	    this.storeAddr2 = storeAddr2;
	    this.storePhone = storePhone;
	    this.category = category;
	    this.storeContent = storeContent;
	    this.operationHours = operationHours;
	    this.createDate = createDate;
	    this.rating = rating;
	    this.dibsCount = dibsCount;
	    this.reviewCount = reviewCount;
	    this.status = status;
	    this.bizNo = bizNo;
	    this.ownerEmail = ownerEmail;
	    this.deposit = deposit;
	    this.userId = userId;
	}
	
	

	
	@Override
		public String toString() {
			return "StoreVO [storeId=" + storeId + ", storeName=" + storeName + ", storeAddr=" + storeAddr
					+ ", storeAddr2=" + storeAddr2 + ", storePhone=" + storePhone + ", category=" + category
					+ ", storeContent=" + storeContent + ", operationHours=" + operationHours + ", createDate="
					+ createDate + ", rating=" + rating + ", dibsCount=" + dibsCount + ", reviewCount=" + reviewCount
					+ ", status=" + status + ", bizNo=" + bizNo + ", ownerEmail=" + ownerEmail + ", deposit=" + deposit
					+ ", userId=" + userId + ", storePicture=" + storePicture + "]";
		}

	public String getStorePicture() {
		return storePicture;
	}

	public void setStorePicture(String storePicture) {
		this.storePicture = storePicture;
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
	public String getStoreAddr2() {
		return storeAddr2;
	}
	public void setStoreAddr2(String storeAddr2) {
		this.storeAddr2 = storeAddr2;
	}
	public String getStorePhone() {
		return storePhone;
	}
	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getStoreContent() {
		return storeContent;
	}
	public void setStoreContent(String storeContent) {
		this.storeContent = storeContent;
	}
	public String getOperationHours() {
		return operationHours;
	}
	public void setOperationHours(String operationHours) {
		this.operationHours = operationHours;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getDibsCount() {
		return dibsCount;
	}
	public void setDibsCount(int dibsCount) {
		this.dibsCount = dibsCount;
	}
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBizNo() {
		return bizNo;
	}
	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}
	public String getOwnerEmail() {
		return ownerEmail;
	}
	public void setOwnerEmail(String ownerEmail) {
		this.ownerEmail = ownerEmail;
	}
	public int getDeposit() {
		return deposit;
	}
	public void setDeposit(int deposit) {
		this.deposit = deposit;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
    public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}
    
    public int getLikesCount() {
		return likesCount;
	}

	public void setLikesCount(int likesCount) {
		this.likesCount = likesCount;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

    
}
