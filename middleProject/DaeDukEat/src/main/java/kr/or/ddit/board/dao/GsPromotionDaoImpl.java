package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.GsPromotionVO;
import kr.or.ddit.common.util.MyBatisUtil;

public class GsPromotionDaoImpl implements IGsPromotionDao {

	private static IGsPromotionDao dao;
	
	public static IGsPromotionDao getDao() {
		if(dao == null) dao = new GsPromotionDaoImpl();
		return dao;
	}
	
	
	private GsPromotionDaoImpl () {}
	
	@Override
	public int gsInsert(GsPromotionVO vo) {
		System.out.println("인설트접근");
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int count = 0;
		try {
			count = sql.insert("GsPromotion.insertPromotion", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		return count;				
	}

	
	
	@Override
	public int gsUpdate(GsPromotionVO vo) {
	
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int count = 0;
		try {
			count = sql.update("GsPromotion.updatePromotionStatus", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			sql.commit();
			sql.close();
		}
		return count;				
	}

	@Override
	public int gsDelete(GsPromotionVO vo) {

		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int count = 0;
		try {
			count = sql.delete("GsPromotion.deletePromotion", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
			
		}
		return count;				
	}
	
	
	@Override
	public List<GsPromotionVO> selectGsPromotionList() {
		SqlSession sql = MyBatisUtil.getSqlSession();
		List<GsPromotionVO> list = null;
		
		try {
			// namespace.id 형식으로 호출
			list = sql.selectList("GsPromotion.selectAllPromotions");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// select는 commit이 필요 없지만 close는 반드시 해야 함
			sql.close();
		}
		return list;
	}

	@Override
	public GsPromotionVO selectGsPromotion(Long gsId) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		GsPromotionVO vo = null;
		
		try {
			// 파라미터 gsId를 넘겨서 단일 객체 조회
			vo = sql.selectOne("GsPromotion.selectPromotionById", gsId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.close();
		}
		return vo;
	}
	
}