package kr.or.ddit.board.service;

import java.util.List;
import kr.or.ddit.board.dao.IQnaDAO;
import kr.or.ddit.board.dao.QnaDAOImpl;
import kr.or.ddit.board.vo.QnaVO;

/**
 * QNA Service 구현체
 */
public class QnaServiceImpl implements IQnaService {
    
    private static QnaServiceImpl instance = new QnaServiceImpl();
    private QnaServiceImpl() {}
    public static QnaServiceImpl getInstance() {
        return instance;
    }
    
    private IQnaDAO dao = QnaDAOImpl.getInstance();
    
    @Override
    public boolean insertQna(QnaVO qna) {
        boolean result = false;
        try {
            // 기본값 설정
            if(qna.getSecretYn() == null || qna.getSecretYn().isEmpty()) {
                qna.setSecretYn("N");
            }
            if(qna.getStatusYn() == null || qna.getStatusYn().isEmpty()) {
                qna.setStatusYn("접수");
            }
            
            int cnt = dao.insertQna(qna);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public List<QnaVO> getAllQnas() {
        List<QnaVO> list = null;
        try {
            list = dao.selectAllQnas();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public QnaVO getQnaDetail(Long qnaId) {
        QnaVO qna = null;
        try {
            qna = dao.selectQnaById(qnaId);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return qna;
    }
    
    @Override
    public boolean updateQna(QnaVO qna) {
        boolean result = false;
        try {
            int cnt = dao.updateQna(qna);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public boolean insertAnswer(QnaVO qna) {
        boolean result = false;
        try {
            int cnt = dao.insertAnswer(qna);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public boolean deleteQna(Long qnaId) {
        boolean result = false;
        try {
            int cnt = dao.deleteQna(qnaId);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public List<QnaVO> getQnasWithPaging(int page, int pageSize) {
        List<QnaVO> list = null;
        try {
            int offset = (page - 1) * pageSize;
            list = dao.selectQnasWithPaging(offset, pageSize);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public int getTotalPages(int pageSize) {
        int totalPages = 0;
        try {
            int totalCount = dao.getTotalCount();
            totalPages = (int) Math.ceil((double) totalCount / pageSize);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return totalPages;
    }
    
    @Override
    public List<QnaVO> getMyQnas(String userId) {
        List<QnaVO> list = null;
        try {
            list = dao.selectMyQnas(userId);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public List<QnaVO> searchByTitle(String keyword) {
        List<QnaVO> list = null;
        try {
            list = dao.searchByTitle(keyword);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    @Override
    public List<QnaVO> getQnasByStatus(String statusYn) {
        List<QnaVO> list = null;
        try {
            list = dao.selectByStatus(statusYn);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}