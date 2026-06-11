package kr.or.ddit.board.dao;

import java.util.List;
import kr.or.ddit.board.vo.QnaVO;

/**
 * QNA DAO 인터페이스
 */
public interface IQnaDAO {
    
    int insertQna(QnaVO qna) throws Exception;
    
    List<QnaVO> selectAllQnas() throws Exception;
    
    QnaVO selectQnaById(Long qnaId) throws Exception;
    
    int updateQna(QnaVO qna) throws Exception;
    
    int insertAnswer(QnaVO qna) throws Exception;
    
    int deleteQna(Long qnaId) throws Exception;
    
    int getTotalCount() throws Exception;
    
    List<QnaVO> selectQnasWithPaging(int offset, int limit) throws Exception;
    
    List<QnaVO> selectMyQnas(String userId) throws Exception;
    
    List<QnaVO> searchByTitle(String keyword) throws Exception;
    
    List<QnaVO> selectByStatus(String statusYn) throws Exception;
}