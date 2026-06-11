package kr.or.ddit.store.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.UserReviewVO;

/**
 * 사용자 리뷰 DAO 구현체
 * 
 * [설계 패턴]
 * - Singleton Pattern (Thread-Safe)
 * - MyBatisUtil을 통한 SqlSession 관리
 */
public class UserReviewDAOImpl implements IUserReviewDAO {
    
    /* ====================================
       Singleton 인스턴스
       ==================================== */
    private static UserReviewDAOImpl instance = new UserReviewDAOImpl();
    
    private UserReviewDAOImpl() {
        // Private 생성자
    }
    
    public static UserReviewDAOImpl getInstance() {
        return instance;
    }
    
    
    /* ====================================
       조회 메서드 (SELECT)
       ==================================== */
    
    @Override
    public List<UserReviewVO> selectReviewableReservations(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<UserReviewVO> list = null;
        
        try {
            // [Mapper 호출]
            // - namespace: userReview
            // - id: selectReviewableReservations
            list = session.selectList("userReview.selectReviewableReservations", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<UserReviewVO> selectMyReviews(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<UserReviewVO> list = null;
        
        try {
            list = session.selectList("userReview.selectMyReviews", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public UserReviewVO selectReviewById(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        UserReviewVO review = null;
        
        try {
            review = session.selectOne("userReview.selectReviewById", reservId);
        } finally {
            if(session != null) session.close();
        }
        
        return review;
    }
    
    @Override
    public List<UserReviewVO> selectReviewsByStore(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<UserReviewVO> list = null;
        
        try {
            list = session.selectList("userReview.selectReviewsByStore", storeId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public int checkReviewExists(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            count = session.selectOne("userReview.checkReviewExists", reservId);
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    
    /* ====================================
       변경 메서드 (INSERT/UPDATE/DELETE)
       ==================================== */
    
    @Override
    public int insertReview(UserReviewVO review) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // [INSERT 실행]
            result = session.insert("userReview.insertReview", review);
            
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int updateReview(UserReviewVO review) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("userReview.updateReview", review);
            
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deleteReview(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // [논리 삭제]
            // - DELETE 대신 UPDATE로 STATUS='삭제' 처리
            result = session.update("userReview.deleteReview", reservId);
            
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
}