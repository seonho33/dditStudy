package kr.or.ddit.user.vo;

import java.time.LocalDate;

public class BlackListVO {

	private int blacklistId; /* 블랙리스트아이디 */
	private String blockReason; /* 차단사유 */
	private LocalDate blockDate; /* 차단일자 */
	private LocalDate blockEndDate; /* 차단만료일자 */
	private String userId; /* 회원아이디 */
	public int getBlacklistId() {
		return blacklistId;
	}
	public void setBlacklistId(int blacklistId) {
		this.blacklistId = blacklistId;
	}
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
	@Override
	public String toString() {
		return "BlackListVO [blacklistId=" + blacklistId + ", blockReason=" + blockReason + ", blockDate=" + blockDate
				+ ", blockEndDate=" + blockEndDate + ", userId=" + userId + "]";
	}
}
