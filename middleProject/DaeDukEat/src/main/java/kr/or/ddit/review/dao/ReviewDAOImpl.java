package kr.or.ddit.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.review.vo.ReviewDetailVO;
import kr.or.ddit.review.vo.UserReviewVO;


/**
 * 리뷰 DAO 구현체 (Singleton Pattern)
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-23
 */
public class ReviewDAOImpl implements IReviewDAO {

    /** Singleton Instance (Thread-Safe) */
    private static ReviewDAOImpl instance = new ReviewDAOImpl();
    private static final String NS = "kr.or.ddit.review.dao.IReviewDAO.";
    
    /** Private Constructor (외부 생성 차단) */
    private ReviewDAOImpl() {}
    
    /**
     * Singleton 인스턴스 반환
     * @return ReviewDAOImpl 유일 인스턴스
     */
    public static ReviewDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public int insertReview(UserReviewVO review) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // 1. 리뷰 등록
            result = session.insert("kr.or.ddit.review.dao.IReviewDAO.insertReview", review);
            
            if (result > 0) {
                // 2. 가게 평점 재계산 (동일 트랜잭션)
                ReviewDetailVO detail = session.selectOne(
                    "kr.or.ddit.review.dao.IReviewDAO.selectReviewDetail", 
                    review.getReservId()
                );
                
                if (detail != null && detail.getStoreId() != null) {
                    session.update(
                        "kr.or.ddit.review.dao.IReviewDAO.updateStoreRating", 
                        detail.getStoreId()
                    );
                }
                
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public List<ReviewDetailVO> selectUnwrittenReviews(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReviewDetailVO> list = null;
        
        try {
            list = session.selectList(
                "kr.or.ddit.review.dao.IReviewDAO.selectUnwrittenReviews", 
                userId
            );
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<ReviewDetailVO> selectMyReviews(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReviewDetailVO> list = null;
        
        try {
            list = session.selectList(
                "kr.or.ddit.review.dao.IReviewDAO.selectMyReviews", 
                userId
            );
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public ReviewDetailVO selectReviewDetail(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        ReviewDetailVO detail = null;
        
        try {
            detail = session.selectOne(
                "kr.or.ddit.review.dao.IReviewDAO.selectReviewDetail", 
                reservId
            );
        } finally {
            if (session != null) session.close();
        }
        
        return detail;
    }
    
    @Override
    public int deleteReview(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update(
                "kr.or.ddit.review.dao.IReviewDAO.deleteReview", 
                reservId
            );
            
            if (result > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int updateStoreRating(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update(
                "kr.or.ddit.review.dao.IReviewDAO.updateStoreRating", 
                storeId
            );
            
            if (result > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int countUserReviewsSinceCouponCreate(Map<String, Object> param) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.review.dao.IReviewDAO.countUserReviewsSinceCouponCreate", param);
        } finally {
            if(session != null) session.close();
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map<String, String> selectUserAndStoreByReservId(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            // mapper resultType="map" 이므로 Map으로 받음
            return (Map<String, String>) session.selectOne(NS + "selectUserAndStoreByReservId", reservId);
        } finally {
            if (session != null) session.close();
        }
    }

}