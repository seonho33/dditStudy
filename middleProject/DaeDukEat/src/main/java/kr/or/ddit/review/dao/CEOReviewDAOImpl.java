package kr.or.ddit.review.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.review.vo.CEOReviewDetailVO;
import kr.or.ddit.review.vo.CeoReviewVO;

/**
 * 리뷰 DAO 구현체
 * @pattern Singleton
 */
public class CEOReviewDAOImpl implements ICEOReviewDAO {
    
    private static CEOReviewDAOImpl instance = new CEOReviewDAOImpl();
    private CEOReviewDAOImpl() {}
    
    public static CEOReviewDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public List<CEOReviewDetailVO> selectReviewsByStore(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<CEOReviewDetailVO> list = null;
        
        try {
            list = session.selectList("kr.or.ddit.review.dao.ICEOReviewDAO.selectReviewsByStore", storeId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public int checkCeoReplyExists(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            count = session.selectOne("kr.or.ddit.review.dao.ICEOReviewDAO.checkCeoReplyExists", reservId);
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    @Override
    public int insertCeoReply(CeoReviewVO ceoReview) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("kr.or.ddit.review.dao.ICEOReviewDAO.insertCeoReply", ceoReview);
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
    public int updateCeoReply(CeoReviewVO ceoReview) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("kr.or.ddit.review.dao.ICEOReviewDAO.updateCeoReply", ceoReview);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
}