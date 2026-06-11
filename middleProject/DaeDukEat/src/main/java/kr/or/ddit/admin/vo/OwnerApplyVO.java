package kr.or.ddit.admin.vo;

import java.time.LocalDate;

public class OwnerApplyVO {
    private String userId;
    private String name;        // 사장님 이름 (users.name)
    private String storeName;   // 가게명 (store.store_name)
    private LocalDate createDate; // 신청일 (store.create_date)
    private String status;      // 승인대기/승인/거절
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public LocalDate getCreateDate() {
		return createDate;
	}
	public void setCreateDate(LocalDate createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
    
}