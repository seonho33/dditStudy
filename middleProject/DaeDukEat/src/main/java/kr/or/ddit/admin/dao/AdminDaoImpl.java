package kr.or.ddit.admin.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.admin.vo.OwnerApplyVO;
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.BlackListVO;

public class AdminDaoImpl implements IAdminDao{

	private	AdminDaoImpl() {};
	private	static IAdminDao AdminDao = new AdminDaoImpl();
	public	static IAdminDao getInstance() {
		return AdminDao;
	}
	
	
	@Override
	public List<AdminUserBanVO> AdminBanlList(SqlSession sql) {
		List<AdminUserBanVO> userList = new ArrayList<AdminUserBanVO>();
		
			userList=sql.selectList("admin.adminBanlList");

			return userList;
	}


	@Override
	public int insertBanUser(SqlSession session, BlackListVO blvo) {
		
		int	result = session.insert("admin.insertBlacklist",blvo);
			
		return result;
	}


	@Override
	public int updateBan(SqlSession session, Map<String, Object> bmap) {
		
		int result = session.update("admin.updateUserBlockYn",bmap);
		
		return result;
	}


	@Override
	public List<OwnerApplyVO> ownerApplyList(SqlSession session) {

	    return session.selectList("admin.ownerApplyList");
	}


	@Override
	public int updateStoreStatus(SqlSession session, Map<String, Object> map) {
	    return session.update("admin.updateStoreStatus", map);
	}


	@Override
	public List<NoticeVO> getNoticeList() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
        return session.selectList("admin.getNoticeList");
	}
}


	@Override
	public List<QnaVO> getUnansweredQnaList() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectList("admin.getUnansweredQnaList");
        }
	}


    @Override
    public int insertNotice(Map<String, Object> param) {
        SqlSession session = null;
        try {
            session = MyBatisUtil.getSqlSession();
            int cnt = session.insert("admin.insertNotice", param);
            session.commit();
            return cnt;
        } catch (Exception e) {
            if (session != null) session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
    }
    
    @Override
    public int deleteNotice(Map<String, Object> param) {
        SqlSession session = null;
        try {
            session = MyBatisUtil.getSqlSession();
            int cnt = session.delete("admin.deleteNotice", param); // ✅ mapper 맞춰 수정
            session.commit();
            return cnt;
        } catch (Exception e) {
            if (session != null) session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
    }
    
    @Override
    public int updateNotice(NoticeVO vo) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.update("admin.updateNotice", vo);
            if (cnt > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e; // 서비스에서 잡게 던짐
        } finally {
            session.close();
        }

        return cnt;
    }
    
    @Override
    public int updateQnaAnswer(Map<String, Object> param) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.update("admin.updateQnaAnswer", param);
            if (cnt > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
        return cnt;
    }
    
	@Override
	public List<BotVO> selectBotList() {
		try (SqlSession session = MyBatisUtil.getSqlSession()) {
			return session.selectList("bot.selectBotList");
		}
	}
	
	@Override
	public AdminUserBanVO selectBanInfo(String userId) {
	    SqlSession session = MyBatisUtil.getSqlSession();
	    try {
	        return session.selectOne("admin.selectBanInfo", userId);
	    } finally {
	        session.close();
	    }
	}

    
}
