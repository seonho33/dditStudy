package kr.or.ddit.user.vo;

public class UserVO {
	private String userId; /* 이용자아이디 */
	private String password; /* 비밀번호 */
	private String name; /* 이름 */
	private String division; /* 회원분류 */
	private String blockYn; /* 블랙상태 */
	private String useYn; /* 활동여부 */
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", password=" + password + ", name=" + name + ", division=" + division
				+ ", blockYn=" + blockYn + ", useYn=" + useYn + "]";
	}
	
	
	
}