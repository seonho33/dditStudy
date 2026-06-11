package kr.or.ddit.member.vo;

import java.time.LocalDate;

/**
 * <p>
 * 		**회원정보를 담기위한 VO 클래스** 
 * 		DB테이블의 '컬럼명'을 참고하여 '멤버변수명'을 만들어 준다.
 * </p>
 */


public class MemberVO {
	private String memId;		//회원ID
	private String memName;		//회원이름
	private String memTel;		//회원전화번호
	private String memAddr;		//회원주소
	
	private LocalDate regDt;	//등록일
	
	

	public MemberVO(String memId, String memName, String memTel, String memAddr) {
		super();
		this.memId = memId;
		this.memName = memName;
		this.memTel = memTel;
		this.memAddr = memAddr;
	}
	
	public MemberVO() {
		
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemTel() {
		return memTel;
	}

	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}

	public String getMemAddr() {
		return memAddr;
	}

	public void setMemAddr(String memAddr) {
		this.memAddr = memAddr;
	}

	public LocalDate getRegDt() {
		return regDt;
	}

	public void setRegDt(LocalDate regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memName=" + memName + ", memTel=" + memTel + ", memAddr=" + memAddr
				+ ", regDt=" + regDt + "]";
	}
	
	
	
}