package kr.or.ddit.vo;

import lombok.Data;

@Data // Getter, Setter, toString 등을 자동으로 만들어주는 마법의 어노테이션
public class StudentVO {
	// 주의 : 여기 적힌 변수명이 이따가 만들 JSP 의 name 속성과 완벽히 똑같아야 합니다!
	private String 	stuName;	//학생이름
	private int 	stuAge;		//학생나이
	private String 	stuMajor;	//전공
	
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public int getStuAge() {
		return stuAge;
	}
	public void setStuAge(int stuAge) {
		this.stuAge = stuAge;
	}
	public String getStuMajor() {
		return stuMajor;
	}
	public void setStuMajor(String stuMajor) {
		this.stuMajor = stuMajor;
	}
}
