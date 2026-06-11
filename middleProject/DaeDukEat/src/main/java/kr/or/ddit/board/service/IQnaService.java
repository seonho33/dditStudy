package kr.or.ddit.board.service;

import java.util.List;
import kr.or.ddit.board.vo.QnaVO;

/**
 * QNA Service 인터페이스
 * 
 * @author Legacy Architect
 * @since 2025-01-27
 * 
 * <pre>
 * [주의사항]
 * - 반환타입이 boolean (int가 아님)
 * - getInstance() 사용 (getService가 아님)
 * </pre>
 */
public interface IQnaService {
    
    /**
     * 새 질문 등록
     * @param qna - 질문 VO
     * @return 성공 true, 실패 false
     */
    boolean insertQna(QnaVO qna);
    
    /**
     * 전체 질문 목록 조회
     * @return List<QnaVO>
     */
    List<QnaVO> getAllQnas();
    
    /**
     * 질문 상세 조회
     * @param qnaId - 질문 ID
     * @return QnaVO
     */
    QnaVO getQnaDetail(Long qnaId);
    
    /**
     * 질문 수정
     * @param qna - 수정할 VO
     * @return 성공 true, 실패 false
     */
    boolean updateQna(QnaVO qna);
    
    /**
     * 관리자 답변 등록
     * @param qna - 답변 VO
     * @return 성공 true, 실패 false
     */
    boolean insertAnswer(QnaVO qna);
    
    /**
     * 질문 삭제
     * @param qnaId - 질문 ID
     * @return 성공 true, 실패 false
     */
    boolean deleteQna(Long qnaId);
    
    /**
     * 페이징 조회
     * @param page - 페이지 번호
     * @param pageSize - 페이지 크기
     * @return List<QnaVO>
     */
    List<QnaVO> getQnasWithPaging(int page, int pageSize);
    
    /**
     * 전체 페이지 수
     * @param pageSize - 페이지 크기
     * @return 페이지 수
     */
    int getTotalPages(int pageSize);
    
    /**
     * 본인 작성 질문 목록 조회
     * @param userId - 사용자 ID
     * @return List<QnaVO>
     */
    List<QnaVO> getMyQnas(String userId);
    
    /**
     * 제목 검색
     * @param keyword - 검색어
     * @return List<QnaVO>
     */
    List<QnaVO> searchByTitle(String keyword);
    
    /**
     * 상태별 조회
     * @param statusYn - 상태 (접수, 완료)
     * @return List<QnaVO>
     */
    List<QnaVO> getQnasByStatus(String statusYn);
}