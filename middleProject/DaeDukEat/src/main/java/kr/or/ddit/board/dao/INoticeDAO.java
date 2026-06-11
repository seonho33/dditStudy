package kr.or.ddit.board.dao;

import java.util.List;
import kr.or.ddit.board.vo.NoticeVO;

/**
 * 공지사항 DAO 인터페이스
 */
public interface INoticeDAO {
    
    /**
     * 공지사항 등록
     */
    public int insertNotice(NoticeVO notice) throws Exception;
    
    /**
     * 전체 공지사항 조회
     */
    public List<NoticeVO> selectAllNotices() throws Exception;
    
    /**
     * 공지사항 상세 조회
     */
    public NoticeVO selectNoticeByNo(Long noticeNo) throws Exception;
    
    /**
     * 공지사항 수정
     */
    public int updateNotice(NoticeVO notice) throws Exception;
    
    /**
     * 공지사항 삭제
     */
    public int deleteNotice(Long noticeNo) throws Exception;
    
    /**
     * 조회수 증가
     */
    public int updateHitCount(Long noticeNo) throws Exception;
    
    /**
     * 상단 고정 게시글만 조회
     */
    public List<NoticeVO> selectTopNotices() throws Exception;
    
    /**
     * 전체 개수
     */
    public int getTotalCount() throws Exception;
    
    /**
     * 페이징 조회
     */
    public List<NoticeVO> selectNoticesWithPaging(int offset, int limit) throws Exception;
    
    /**
     * 제목 검색
     */
    public List<NoticeVO> searchByTitle(String keyword) throws Exception;
}