package kr.or.ddit.hotel.service;

import java.util.List;

import kr.or.ddit.hotel.vo.HotelVO;

public interface IHotelService {
	
	/**
	 * 객실정보를 등록하기위한 메서드
	 * @param hv 객실정보를 담은 HotelVO
	 * @return 등록성공하면 1, 실패하면 0반환됨
	 */
	public int registerHotel(HotelVO hv);	
	
	/**
	 * 객실정보를 삭제하기 위한 메서드
	 * @param hotelId 삭제할 객실정보
	 * @return 삭제성공하면 1, 실패하면 0반환
	 */
	public int removeHotel(String hotelId);
	
	
	/**
	 * 객실정보 존재여부를 확인하는 메서드
	 * @param hotelId 존재여부 체크를 위한 객실정보
	 * @return 객실정보가 존재하면 true, 존재하지 않으면 false 반환
	 */
	public boolean checkHotle(String hotelId);
	
	/**
	 * 검색조건에 해당하는 객실정보를 검색하기위한 메서드
	 * @param hv 검색조건을 담은 Hotel 객체
	 * @return 검색된 객실정보를 담은 List 객체를 반환
	 */
	public List<HotelVO> searchHotel(HotelVO hv);
	
	/**
	 * 모든 객실정보를 확인하기 위한 메서드
	 * @return 모든 객실정보를 담은 List 객체를 반환함
	 */
	public List<HotelVO> displayAllHotel();
	
	/**
	 * 테이블의 존재여부를 확인하는 메서드
	 * @return 테이블이 존재하면 1을 반환 없다면 0을 반환함...
	 */
	public boolean cheakTable();
	
	/**
	 * 테이블을 생성하는 메서드
	 */
	public void createTable(boolean isExist);
}