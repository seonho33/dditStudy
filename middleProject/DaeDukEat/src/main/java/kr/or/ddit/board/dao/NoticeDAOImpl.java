package kr.or.ddit.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.board.vo.NoticeVO;

/**
 * 공지사항 DAO 구현체
 * - MyBatis SqlSession을 통해 DB 작업 수행
 */
public class NoticeDAOImpl implements INoticeDAO {
    
    // Singleton Pattern
    private static NoticeDAOImpl instance = new NoticeDAOImpl();
    private NoticeDAOImpl() {}
    public static NoticeDAOImpl getInstance() {
        return instance;
    }
    
    
    @Override
    public int insertNotice(NoticeVO notice) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("notice.insertNotice", notice);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    
    @Override
    public List<NoticeVO> selectAllNotices() throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> list = null;
        
        try {
            list = session.selectList("notice.selectAllNotices");
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    
    @Override
    public NoticeVO selectNoticeByNo(Long noticeNo) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        NoticeVO notice = null;
        
        try {
            notice = session.selectOne("notice.selectNoticeByNo", noticeNo);
        } finally {
            if(session != null) session.close();
        }
        
        return notice;
    }
    
    
    @Override
    public int updateNotice(NoticeVO notice) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("notice.updateNotice", notice);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    
    @Override
    public int deleteNotice(Long noticeNo) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.delete("notice.deleteNotice", noticeNo);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    
    @Override
    public int updateHitCount(Long noticeNo) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("notice.updateHitCount", noticeNo);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    
    @Override
    public List<NoticeVO> selectTopNotices() throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> list = null;
        
        try {
            list = session.selectList("notice.selectTopNotices");
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    
    @Override
    public int getTotalCount() throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            count = session.selectOne("notice.getTotalCount");
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    
    @Override
    public List<NoticeVO> selectNoticesWithPaging(int offset, int limit) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> list = null;
        
        try {
            Map<String, Integer> params = new HashMap<>();
            params.put("offset", offset);
            params.put("limit", limit);
            
            list = session.selectList("notice.selectNoticesWithPaging", params);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    
    @Override
    public List<NoticeVO> searchByTitle(String keyword) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> list = null;
        
        try {
            list = session.selectList("notice.searchByTitle", keyword);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
}