package kr.or.ddit.admin.dao;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.vo.GsVO;
import kr.or.ddit.common.util.MyBatisUtil;

public class GsDaoImpl implements IGsDao {
	
	private static IGsDao dao;

    private GsDaoImpl() {}

    public static IGsDao getInstance() {
        if (dao == null) dao = new GsDaoImpl();
        return dao;
    }
    
    @Override
    public List<GsVO> selectAll() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectList("gs.selectAll");
        } finally {
            session.close();
        }
    }
    
    @Override
    public int updateExpiredPromotion() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            int cnt = session.update("gs.updateExpiredPromotion");
            session.commit();
            return cnt;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }


    @Override
    public int insertGsProduct(GsVO vo) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.insert("gs.insertGsProduct", vo);
            session.commit();
            return cnt;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    @Override
    public int deleteGsProduct(int gsId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.delete("gs.deleteGsProduct", gsId);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return cnt;
    }
    
    @Override
    public GsVO selectLatestGodSale() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("gs.selectLatestGodSale");
        }
    }

    @Override
    public GsVO selectLatestEndSale() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("gs.selectLatestEndSale");
        }
    }

    @Override
    public GsVO selectLatestHotItem() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("gs.selectLatestHotItem");
        }
    }
    
    @Override
    public GsVO selectLatestByDivision(String division) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("division", division);
            return session.selectOne("gs.selectLatestByDivision", param);
        }
    }
}
