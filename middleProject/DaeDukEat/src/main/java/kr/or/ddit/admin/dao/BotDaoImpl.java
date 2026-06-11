package kr.or.ddit.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.common.util.MyBatisUtil;

public class BotDaoImpl implements IBotDao {
	
	private static IBotDao dao;

    private BotDaoImpl() {}

    public static IBotDao getInstance() {
        if (dao == null) dao = new BotDaoImpl();
        return dao;
    }	

    @Override
    public List<BotVO> selectBotList() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            IBotDao mapper = session.getMapper(IBotDao.class);
            return mapper.selectBotList();
        }
    }

	@Override
	public BotVO selectBotByKeyword(String keyword) {
		SqlSession session = MyBatisUtil.getSqlSession();
        BotVO vo = session.selectOne(
            "kr.or.ddit.admin.dao.IBotDao.selectBotByKeyword",
            keyword
        );
        session.close();
        return vo;
    }
	
	@Override
	public int insertBot(BotVO vo) {
	    try (SqlSession session = MyBatisUtil.getSqlSession()) {
	        int cnt = session.insert("kr.or.ddit.admin.dao.IBotDao.insertBot", vo);
	        session.commit();
	        return cnt;
	    }
	}
	
	@Override
	public int deleteBot(int botId) {
	    try (SqlSession session = MyBatisUtil.getSqlSession()) {
	        int cnt = session.delete(
	            "kr.or.ddit.admin.dao.IBotDao.deleteBot", botId
	        );
	        session.commit();
	        return cnt;
	    }
	}
	
	@Override
	public int updateBot(BotVO vo) {
	    try (SqlSession session = MyBatisUtil.getSqlSession()) {
	        int cnt = session.update("kr.or.ddit.admin.dao.IBotDao.updateBot", vo);
	        session.commit();
	        return cnt;
	    }
	}
	
    private static final String NS = "kr.or.ddit.admin.dao.IBotDao.";

	
    @Override
    public String selectActiveYnById(int botId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne(NS + "selectActiveYnById", botId);
        } finally {
            session.close();
        }
    }

    @Override
    public int updateActiveYn(Map<String, Object> param) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.update(NS + "updateActiveYn", param);
            if (cnt > 0) session.commit();
            else session.rollback();
            return cnt;
        } finally {
            session.close();
        }
    }
	
    @Override
    public List<BotVO> selectActiveBots() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.selectActiveBots");
        }
    }

    @Override
    public List<Map<String, Object>> searchStoreTop3(String keyword) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.searchStoreTop3", keyword);
        }
    }

    @Override
    public List<Map<String, Object>> searchMenuTop3(String keyword) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.searchMenuTop3", keyword);
        }
    }

    @Override
    public List<Map<String, Object>> searchStoreByCategoryTop3(String categoryName) {
        try (org.apache.ibatis.session.SqlSession session = kr.or.ddit.common.util.MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.searchStoreByCategoryTop3", categoryName);
        }
    }

    @Override
    public List<Map<String, Object>> searchStoreByMenuKeywordTop3(String keyword) {
        try (org.apache.ibatis.session.SqlSession session = kr.or.ddit.common.util.MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.searchStoreByMenuKeywordTop3", keyword);
        }
    }
    @Override
    public List<Map<String, Object>> searchMenuByNameTop3(String keyword) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList(NS + "searchMenuByNameTop3", keyword);
        }
    }
    
    @Override
    public List<Map<String, Object>> searchStoreTop3ByMenuName(String keyword) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("kr.or.ddit.admin.dao.IBotDao.searchStoreTop3ByMenuName", keyword);
        }
    }

}
