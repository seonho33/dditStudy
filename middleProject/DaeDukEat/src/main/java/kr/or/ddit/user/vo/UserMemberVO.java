package kr.or.ddit.user.vo;

public class UserMemberVO {
	
	//선언
	private String userId; /* 이용자아이디 */
	private String name; /* 이름 */// USERS.name
	private String password; /* 비밀번호 */
	private String userMail; /* 이용자들 이메일(비밀번호,ID찾기에 필요) */// MEMBER.user_mail
	private int userNo; /* 대덕사용자인지 확인용 기수번호 */
	private String profileImg;  /* 프로필사진 */
	
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	//게터세터
    public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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

}
