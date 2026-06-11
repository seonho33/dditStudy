package kr.or.ddit.hotel.vo;

import java.time.LocalDate;

/**
 * 호텔 체크인 정보를 담기위한 VO클래스
 * DB테이블의 '컬럼명'을 참고하여 변수명을 만들어준다
 */
public class HotelVO {
	private String hotelId;		//체크인방번호(기본키)
	private String hotelName;	//체크인사람이름(value)
	private LocalDate regDt;	//체크인 등록일
	
	public HotelVO(String hotelId,String hotelName) {
		super();
		this.hotelId = hotelId;
		this.hotelName = hotelName;
	}
	
	public HotelVO() {
		
	}

	public String getHotelId() {
		return hotelId;
	}

	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public LocalDate getRegDt() {
		return regDt;
	}

	public void setRegDt(LocalDate regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "HotelVO [hotelId=" + hotelId + ", hotelName=" + hotelName + ", regDt=" + regDt + "]";
	}
}
