package kr.or.ddit.admin.vo;

import java.time.LocalDate;

public class AdminUserBanVO {
	//User쪽 정보
	private String userId; /* 이용자아이디 */
	private String name; /* 이름 */
	private String division; /* 회원분류 */
	private String blockYn; /* 블랙상태 */

	//store쪽 정보
	private String storeName; /* 가게이름 */
	private LocalDate createDate; /* 가게등록일자 */
	private String status; /* 상태 */
	
	//블랙리스트쪽 정보
	private String blockReason; /* 차단사유 */
	private LocalDate blockDate; /* 차단일자 */
	private LocalDate blockEndDate; /* 차단만료일자 */

	
	
	public String getBlockReason() {
		return blockReason;
	}
	public void setBlockReason(String blockReason) {
		this.blockReason = blockReason;
	}
	public LocalDate getBlockDate() {
		return blockDate;
	}
	public void setBlockDate(LocalDate blockDate) {
		this.blockDate = blockDate;
	}
	public LocalDate getBlockEndDate() {
		return blockEndDate;
	}
	public void setBlockEndDate(LocalDate blockEndDate) {
		this.blockEndDate = blockEndDate;
	}
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
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getBlockYn() {
		return blockYn;
	}
	public void setBlockYn(String blockYn) {
		this.blockYn = blockYn;
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
	@Override
	public String toString() {
		return "AdminUserBanVO [userId=" + userId + ", name=" + name + ", division=" + division + ", blockYn=" + blockYn
				+ ", storeName=" + storeName + ", createDate=" + createDate + ", status=" + status + ", blockReason="
				+ blockReason + ", blockDate=" + blockDate + ", blockEndDate=" + blockEndDate + "]";
	}

	

}
