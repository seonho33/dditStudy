package kr.or.ddit.member.vo;

public class UserVO {
	private String userid; /* 이용자아이디 */
	private String password; /* 비밀번호 */
	private String name; /* 이름 */
	private String division; /* 회원분류 */
	private String blockyn; /* 블랙상태 */
	private String useyn; /* 활동여부 */
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	public String getBlockyn() {
		return blockyn;
	}
	public void setBlockyn(String blockyn) {
		this.blockyn = blockyn;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}
}
