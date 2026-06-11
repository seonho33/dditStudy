package kr.or.ddit.hotel.dao;

import java.util.List;

import kr.or.ddit.hotel.vo.HotelVO;

/**
 * HotelService에서 요청을 받고 SQL문이 작성된 mapper와 연결해 sql문을 수행하는 DAO interface
 */
public interface IHotelDao {

	/**
	 * 객실등록을 위한 메서드
	 * @param hv 체크인 정보를 담은 HotelVO객체
	 * @return 체크인 성공하면 1, 실패하면 0반환
	 */
	public int checkIn(HotelVO hv);
	
	
	/**
	 * 객실정보를 삭제하기 위한 메서드
	 * @param hotelId = 삭제할 hotelId
	 * @return 삭제성공시 1, 실패하면 0 반환
	 */
	public int checkOut(String hotelId);
	
	
	/**
	 * 객실정보의 존재여부를 확인하는 메서드
	 * @param hotelId 체크를 위한 hotelId DB에서 기본키
	 * @return 회원정보가 존재하면 true, 없다면 false 반환함
	 */
	public boolean checkHotel(String hotelId);
	
	
	/**
	 * 검색조건에 해당하는 객실정보를 검색하기 위한 메서드
	 * @param hv 검색조건을 담은 Hotel 객체
	 * @return 검색된 객실정보를 담은 List 객체
	 */
	public List<HotelVO> searchHotel(HotelVO hv);
	
	/**
	 *  DB에 존재하는 모든 회원정보를 확인하기 위한 메서드
	 * @return 모든 회원정보를 담은 List 객체 반환됨...
	 */
	public List<HotelVO> getAllHotel();
	
	/**
	 * 테이블의 존재여부를 확인하는 메서드
	 * @return 존재하지 않는다면 false 존재하면 true 반환...
	 */
	public boolean checkTable();
	
	/**
	 * 테이블이 있는지 확인하고 없다면 생성하는 메서드
	 */
	public void createTable(boolean isExist);
}
