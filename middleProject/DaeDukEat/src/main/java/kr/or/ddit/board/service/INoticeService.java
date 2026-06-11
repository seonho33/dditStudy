package kr.or.ddit.board.service;

import java.util.List;
import kr.or.ddit.board.vo.NoticeVO;

/**
 * 공지사항 Service 인터페이스
 */
public interface INoticeService {
    
    /**
     * 공지사항 등록
     */
    public boolean insertNotice(NoticeVO notice);
    
    /**
     * 전체 공지사항 조회
     */
    public List<NoticeVO> getAllNotices();
    
    /**
     * 공지사항 상세 조회 (조회수 자동 증가)
     */
    public NoticeVO getNoticeDetail(Long noticeNo);
    
    /**
     * 공지사항 수정
     */
    public boolean updateNotice(NoticeVO notice);
    
    /**
     * 공지사항 삭제
     */
    public boolean deleteNotice(Long noticeNo);
    
    /**
     * 상단 고정 게시글만 조회
     */
    public List<NoticeVO> getTopNotices();
    
    /**
     * 페이징 처리
     */
    public List<NoticeVO> getNoticesWithPaging(int page, int pageSize);
    
    /**
     * 전체 페이지 수
     */
    public int getTotalPages(int pageSize);
    
    /**
     * 제목 검색
     */
    public List<NoticeVO> searchByTitle(String keyword);
    
    
}