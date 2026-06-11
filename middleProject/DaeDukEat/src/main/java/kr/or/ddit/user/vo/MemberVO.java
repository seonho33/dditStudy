package kr.or.ddit.user.vo;

import java.time.LocalDate;

/**
 * 
 */
public class MemberVO {

	private String profileImg; /* 프로필사진 */
	private String userId; /* 이용자 아이디 */
	private LocalDate userBir; /* 이용자들 생년월일 */
	private String userMail; /* 이용자들 이메일(비밀번호,ID찾기에 필요) */
	private int userNo; /* 대덕사용자인지 확인용 기수번호 */
	
	
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public LocalDate getUserBir() {
		return userBir;
	}
	public void setUserBir(LocalDate userBir) {
		this.userBir = userBir;
	}
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	@Override
	public String toString() {
		return "MemberVO [profileImg=" + profileImg + ", userId=" + userId + ", userBir=" + userBir + ", userMail="
				+ userMail + ", userNo=" + userNo + "]";
	}
	
}
