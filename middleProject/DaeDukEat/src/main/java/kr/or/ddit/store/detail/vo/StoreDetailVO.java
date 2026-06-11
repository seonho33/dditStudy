package kr.or.ddit.store.detail.vo;

import java.util.Date;
import java.util.List;
import kr.or.ddit.menu.vo.MenuVO;  // ✅ 올바른 import

public class StoreDetailVO {
    
    // ━━━━━━━ STORE 테이블 기본 필드 ━━━━━━━
    private String storeId;
    private String storeName;
    private String storeAddr;
    private String storeAddr2;
    private String storePhone;
    private String category;
    private String storeContent;
    private String operationHours;
    private Date createDate;
    private int rating;
    private int dibsCount;
    private int reviewCount;
    private String status;
    private String bizNo;
    private String ownerEmail;
    private int deposit;
    private String userId;
    private String storePicture; 	/*  */
    
 
    // ━━━━━━━ 연관 데이터 컬렉션 ━━━━━━━
	/*
	 * private List<StorePictureVO> storePictures;
	 */  
    private List<MenuVO> menuList;  // ✅ kr.or.ddit.menu.vo.MenuVO
    private List<ReviewDetailVO> reviewList;
    private List<String> storeHolidays;
    
    // ━━━━━━━ 사용자 상태 ━━━━━━━
    private boolean isLiked;
    private boolean isBookmarked;
    
    // ━━━━━━━ Constructor ━━━━━━━
    public StoreDetailVO() {}
    
    // ━━━━━━━ Getter/Setter ━━━━━━━
    
    public String getStoreId() { return storeId; }
    public String getStorePicture() {
		return storePicture;
	}

	public void setStorePicture(String storePicture) {
		this.storePicture = storePicture;
	}

	public void setStoreId(String storeId) { this.storeId = storeId; }
    
    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }
    
    public String getStoreAddr() { return storeAddr; }
    public void setStoreAddr(String storeAddr) { this.storeAddr = storeAddr; }
    
    public String getStoreAddr2() { return storeAddr2; }
    public void setStoreAddr2(String storeAddr2) { this.storeAddr2 = storeAddr2; }
    
    public String getStorePhone() { return storePhone; }
    public void setStorePhone(String storePhone) { this.storePhone = storePhone; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getStoreContent() { return storeContent; }
    public void setStoreContent(String storeContent) { this.storeContent = storeContent; }
    
    public String getOperationHours() { return operationHours; }
    public void setOperationHours(String operationHours) { this.operationHours = operationHours; }
    
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public int getDibsCount() { return dibsCount; }
    public void setDibsCount(int dibsCount) { this.dibsCount = dibsCount; }
    
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getBizNo() { return bizNo; }
    public void setBizNo(String bizNo) { this.bizNo = bizNo; }
    
    public String getOwnerEmail() { return ownerEmail; }
    public void setOwnerEmail(String ownerEmail) { this.ownerEmail = ownerEmail; }
    
    public int getDeposit() { return deposit; }
    public void setDeposit(int deposit) { this.deposit = deposit; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
  
	/*
	 * public List<StorePictureVO> getStorePictures() { return storePictures; }
	 * public void setStorePictures(List<StorePictureVO> storePictures) {
	 * this.storePictures = storePictures; }
	 */
    
    public List<MenuVO> getMenuList() { return menuList; }
    public void setMenuList(List<MenuVO> menuList) { this.menuList = menuList; }
    
    public List<ReviewDetailVO> getReviewList() { return reviewList; }
    public void setReviewList(List<ReviewDetailVO> reviewList) { 
        this.reviewList = reviewList; 
    }
    
    public List<String> getStoreHolidays() { return storeHolidays; }
    public void setStoreHolidays(List<String> storeHolidays) { 
        this.storeHolidays = storeHolidays; 
    }
    
    public boolean isLiked() { return isLiked; }
    public void setLiked(boolean isLiked) { this.isLiked = isLiked; }
    
    public boolean isBookmarked() { return isBookmarked; }
    public void setBookmarked(boolean isBookmarked) { 
        this.isBookmarked = isBookmarked; 
    }
}