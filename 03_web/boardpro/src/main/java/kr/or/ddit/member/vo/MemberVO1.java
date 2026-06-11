package kr.or.ddit.member.vo;

import java.util.Date;

public class MemberVO1 {

	private String userid; /* 이용자 아이디 */
	private Date userbir; /* 이용자들 생년월일 */
	private String usermail; /* 이용자들 이메일(비밀번호,ID찾기에 필요) */
	private String userno; /* 대덕사용자인지 확인용 기수번호 */
	
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Date getUserbir() {
		return userbir;
	}
	public void setUserbir(Date userbir) {
		this.userbir = userbir;
	}
	public String getUsermail() {
		return usermail;
	}
	public void setUsermail(String usermail) {
		this.usermail = usermail;
	}
	public String getUserno() {
		return userno;
	}
	public void setUserno(String userno) {
		this.userno = userno;
	}
}
