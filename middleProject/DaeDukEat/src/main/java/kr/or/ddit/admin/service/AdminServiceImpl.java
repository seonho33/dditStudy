package kr.or.ddit.admin.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.dao.AdminDaoImpl;
import kr.or.ddit.admin.dao.IAdminDao;
import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.admin.vo.OwnerApplyVO;
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.BlackListVO;

public class AdminServiceImpl implements IAdminService {
	private IAdminDao adminDao;
	
	private	AdminServiceImpl() {
		adminDao=AdminDaoImpl.getInstance();
	}
	
	private	static	IAdminService adminService = new AdminServiceImpl();	
	
	public	static	IAdminService getInstance(){
		return adminService;
	}
	
	
	
	@Override
	public List<AdminUserBanVO> AdminBanlList() {
		
		
		SqlSession session = MyBatisUtil.getSqlSession();
		try {
			return adminDao.AdminBanlList(session);
		}finally {
			session.close();
		}
	}
	@Override
    public boolean banUser(String userId, String reason, LocalDate endDate) {
        SqlSession session = MyBatisUtil.getSqlSession();

        try {
            BlackListVO blvo = new BlackListVO();
            blvo.setUserId(userId);
            blvo.setBlockReason(reason);
            blvo.setBlockEndDate(endDate);

            int ins = adminDao.insertBanUser(session, blvo);

            Map<String, Object> bmap = new HashMap<>();
            bmap.put("userId", userId);
            bmap.put("blockYn", "Y");

            int upd = adminDao.updateBan(session, bmap);

            if (ins > 0 && upd > 0) {
                session.commit();
                return true;
            } else {
                session.rollback();
                return false;
            }
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean unbanUser(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();

        try {
            Map<String, Object> bmap = new HashMap<>();
            bmap.put("userId", userId);
            bmap.put("blockYn", "N");

            int upd = adminDao.updateBan(session, bmap);

            if (upd > 0) {
                session.commit();
                return true;
            } else {
                session.rollback();
                return false;
            }

        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }



	@Override
	public List<OwnerApplyVO> ownerApplyList() {
		SqlSession session = MyBatisUtil.getSqlSession();
				
		try {
			
		return adminDao.ownerApplyList(session);
			
		}finally {
			session.close();
		}
	}
	
	@Override
	public boolean updateOwnerStatus(Map<String, Object> map) {
	    SqlSession session = MyBatisUtil.getSqlSession();
	    try {
	        int upd = adminDao.updateStoreStatus(session, map);
	        if (upd > 0) {
	            session.commit();
	            return true;
	        }
	        session.rollback();
	        return false;
	    } catch (Exception e) {
	        session.rollback();
	        e.printStackTrace();
	        return false;
	    } finally {
	        session.close();
	    }
	}


	@Override
	public List<NoticeVO> getNoticeList() {
        return adminDao.getNoticeList();
	}



	@Override
	public List<QnaVO> getUnansweredQnaList() {
		return adminDao.getUnansweredQnaList();
	}

    @Override
    public int insertNotice(Map<String, Object> param) {
        return adminDao.insertNotice(param);
    }
    

    @Override
    public int deleteNotice(Map<String, Object> param) {
        return adminDao.deleteNotice(param);
    }
    

    @Override
    public int updateNotice(NoticeVO vo) {
        return adminDao.updateNotice(vo);
    }
    
    @Override
    public int updateQnaAnswer(Map<String, Object> param) {
        return adminDao.updateQnaAnswer(param);
    }
    
	@Override
	public List<BotVO> selectBotList() {
		return adminDao.selectBotList();
	}
	
	@Override
	public AdminUserBanVO selectBanInfo(String userId) {
	    return adminDao.selectBanInfo(userId);
	}

}
