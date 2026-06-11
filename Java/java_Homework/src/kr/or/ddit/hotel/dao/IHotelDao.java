package kr.or.ddit.hotel.dao;

import java.util.List;

import kr.or.ddit.hotel.Hotel;
import kr.or.ddit.hotel.vo.PeopleVO;

public interface IHotelDao {

	/**
	 * 호텔 체크인 메서드
	 * @param h 체크인 정보를 담음 hotel h객체
	 * @return
	 */
	int chackIn(PeopleVO p);
	
	int chackOut(PeopleVO p);
	
	List<Hotel> displayAll();
	
	/**
	 * 체크인 정보 존재여부를 확인하기 위한 메서드
	 * @param key 존재여부 체크를 위한 회원 ID
	 * @return 회원정보가 존재하면 true, 존재하지 않으며 false 반환
	 */
	boolean checkHotel(Integer key);
}
