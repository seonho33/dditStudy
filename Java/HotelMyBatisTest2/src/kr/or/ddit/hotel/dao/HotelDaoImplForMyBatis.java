package kr.or.ddit.hotel.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.hotel.vo.HotelVO;
import kr.or.ddit.util.MyBatisUtil;

public class HotelDaoImplForMyBatis implements IHotelDao {

	private static HotelDaoImplForMyBatis hotelDao = new HotelDaoImplForMyBatis();
	
	private HotelDaoImplForMyBatis() {
	}
	
	public static IHotelDao getInstance() {
		return hotelDao;
	}
		
	@Override
	public int checkIn(HotelVO hv) {
		SqlSession session = MyBatisUtil.getSqlSession();
		int cnt = 0;
		try {
			cnt = session.insert("hotel.checkIn",hv);
			
			if(cnt>0) {
				session.commit();
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public int checkOut(String hotelId) {
		SqlSession session = MyBatisUtil.getSqlSession();
		int cnt = 0;

		try {
			cnt = session.delete("hotel.checkOut", hotelId);
			
			if(cnt>0) {
				session.commit();
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public boolean checkHotel(String hotelId) {
		boolean isExist = false;
		SqlSession session = MyBatisUtil.getSqlSession();
		try {
			int cnt = session.selectOne("hotel.checkHotel", hotelId);
			
			if(cnt>0) {
				isExist = true;
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return isExist;
	}


	@Override
	public List<HotelVO> searchHotel(HotelVO hv) {
		List<HotelVO> hotelList = new ArrayList<HotelVO>();
		SqlSession session = MyBatisUtil.getSqlSession();
		
		try {
			hotelList = session.selectList("hotel.searchHotel", hv);
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return hotelList;
	}

	@Override
	public List<HotelVO> getAllHotel() {
		
		List<HotelVO> hotelList = new ArrayList<HotelVO>();
		SqlSession session = MyBatisUtil.getSqlSession();
		try {
			hotelList = session.selectList("hotel.getAllHotel");
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return hotelList;
	}

	
	
	@Override
	public boolean checkTable() {
		boolean isExist = false;
		SqlSession session = MyBatisUtil.getSqlSession();
		try {
			int i=session.selectOne("hotel.checkTable");
			
			if(i>0) {
				isExist = true;
			}
		} catch (PersistenceException e) {
			return isExist;
		}finally {
			session.close();
		}
		return isExist;
	}

	@Override
	public void createTable(boolean isExist) {
		SqlSession session = MyBatisUtil.getSqlSession();
		try {
			if(!isExist) {
			session.update("hotel.createTable");
			session.commit();
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
	}
}
