package kr.or.ddit.hotel.service;

import java.util.List;

import kr.or.ddit.hotel.dao.HotelDaoImplForMyBatis;
import kr.or.ddit.hotel.dao.IHotelDao;
import kr.or.ddit.hotel.vo.HotelVO;

public class HotelServiceImpl implements IHotelService {

	private static IHotelService hotelService = new HotelServiceImpl();
	private IHotelDao hotelDao;
	private HotelServiceImpl() {
		hotelDao = HotelDaoImplForMyBatis.getInstance();
	}
	
	public static IHotelService getInstance() {
		return hotelService;
	}
	
	@Override
	public int registerHotel(HotelVO hv) {
		return hotelDao.checkIn(hv);
	}

	@Override
	public int removeHotel(String hotelId) {
		return hotelDao.checkOut(hotelId);
	}

	@Override
	public boolean checkHotle(String hotelId) {
		return hotelDao.checkHotel(hotelId);
	}

	@Override
	public List<HotelVO> searchHotel(HotelVO hv) {
		return hotelDao.searchHotel(hv);
	}

	@Override
	public List<HotelVO> displayAllHotel() {
		return hotelDao.getAllHotel();
	}

	
	@Override
	public boolean cheakTable() {
		return hotelDao.checkTable();
	}

	@Override
	public void createTable(boolean isExist) {
		hotelDao.createTable(isExist);
	}
}
