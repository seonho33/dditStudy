package kr.or.ddit.admin.dao;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreVO;

public class RouletteDaoImpl implements IRouletteDao {

	private static IRouletteDao roulette = new RouletteDaoImpl();
	
	private RouletteDaoImpl() {	
	}
	
	public static IRouletteDao getInstance() {
		return roulette;
	}
	
	@Override
	public List<StoreVO> getstoreRoulette() {
		SqlSession session = MyBatisUtil.getSqlSession();
		List<StoreVO> storeList = null;
		
		try {
			storeList = session.selectList("storeRoulette.getstoreRoulette");
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}	
		return storeList;
	}

	@Override
	public List<StoreVO> getstoreCategory(String category) {
		SqlSession session = MyBatisUtil.getSqlSession();
		List<StoreVO> storeList = null;
		 
		try {
			storeList = session.selectList("storeRoulette.getstoreCategory", category);
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return storeList;
	}

	@Override
	public List<StoreVO> getstoreRating(int rating) {
		SqlSession session = MyBatisUtil.getSqlSession();
		List<StoreVO> storeList = null;
		
		try {
			storeList = session.selectList("storeRoulette.getstoreRating", rating);
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		} 
		return storeList;		
	}
}