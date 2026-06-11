package kr.or.ddit.store.vo;

public class UserLikesDidsVO {
	
	private String userId;
	private String storeId;
	
	private int likesCount; //좋아요수???
	

	//게터세터
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
	public int getLikesCount() {
		return likesCount;
	}
	public void setLikesCount(int likesCount) {
		this.likesCount = likesCount;
	}
	

}
