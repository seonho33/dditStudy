package kr.or.ddit.review.service;

import java.util.List;
import kr.or.ddit.review.dao.ICEOReviewDAO;
import kr.or.ddit.review.dao.CEOReviewDAOImpl;
import kr.or.ddit.review.vo.CEOReviewDetailVO;
import kr.or.ddit.review.vo.CeoReviewVO;

/**
 * 리뷰 서비스 구현체
 * @pattern Singleton
 */
public class CEOReviewServiceImpl implements ICEOReviewService {
    
    private ICEOReviewDAO dao;
    private static CEOReviewServiceImpl instance = new CEOReviewServiceImpl();
    
    private CEOReviewServiceImpl() {
        dao = CEOReviewDAOImpl.getInstance();
    }
    
    public static CEOReviewServiceImpl getInstance() {
        return instance;
    }
    
    @Override
    public List<CEOReviewDetailVO> getReviewsByStore(String storeId) throws Exception {
        return dao.selectReviewsByStore(storeId);
    }
    
    @Override
    public boolean saveCeoReply(CeoReviewVO ceoReview) throws Exception {
        // 답글 존재 여부 확인 후 INSERT/UPDATE 분기
        int existCount = dao.checkCeoReplyExists(ceoReview.getReservId());
        
        int result = 0;
        if (existCount > 0) {
            // 기존 답글 수정
            result = dao.updateCeoReply(ceoReview);
        } else {
            // 신규 답글 등록
            result = dao.insertCeoReply(ceoReview);
        }
        
        return result > 0;
    }
}