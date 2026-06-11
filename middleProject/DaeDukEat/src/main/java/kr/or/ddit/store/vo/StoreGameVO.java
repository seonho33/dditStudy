package kr.or.ddit.store.vo;

/**
 * 랜덤 가게 선택용 경량 DTO
 * - JSON 직렬화를 위한 최소 필드 구성
 * - STORE + STORE_PICTURE LEFT JOIN 결과 매핑
 */
public class StoreGameVO {
    private String storeId;        /* 가게ID (PK) */
    private String storeName;      /* 가게명 (게임 표시용) */
    private String category;       /* 카테고리 (필터용) */
    private String storePicture;   /* 대표 이미지 경로 (NULL 허용) */
    private String storeAddr;      /* 가게 주소 */
    private int rating;            /* 평점 */
    
    // Constructor
    public StoreGameVO() {}
    
    // Getters & Setters
    public String getStoreId() { return storeId; }
    public void setStoreId(String storeId) { this.storeId = storeId; }
    
    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getStorePicture() { return storePicture; }
    public void setStorePicture(String storePicture) { this.storePicture = storePicture; }
    
    public String getStoreAddr() { return storeAddr; }
    public void setStoreAddr(String storeAddr) { this.storeAddr = storeAddr; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    @Override
    public String toString() {
        return "StoreGameVO{" +
                "storeId='" + storeId + '\'' +
                ", storeName='" + storeName + '\'' +
                ", category='" + category + '\'' +
                ", storePicture='" + storePicture + '\'' +
                ", rating=" + rating +
                '}';
    }
}