package kr.or.ddit.board.service;

import java.util.List;
import kr.or.ddit.board.dao.INoticeDAO;
import kr.or.ddit.board.dao.NoticeDAOImpl;
import kr.or.ddit.board.vo.NoticeVO;

/**
 * 공지사항 Service 구현체
 * - 비즈니스 로직 처리
 * - 트랜잭션 관리는 DAO에서 처리
 */
public class NoticeServiceImpl implements INoticeService {
    
    // Singleton Pattern
    private static NoticeServiceImpl instance = new NoticeServiceImpl();
    private NoticeServiceImpl() {}
    public static NoticeServiceImpl getInstance() {
        return instance;
    }
    
    // DAO 인스턴스
    private INoticeDAO dao = NoticeDAOImpl.getInstance();
    
    
    @Override
    public boolean insertNotice(NoticeVO notice) {
        boolean result = false;
        
        try {
            // 기본값 설정
            if(notice.getTopYn() == null || notice.getTopYn().isEmpty()) {
                notice.setTopYn("N");
            }
            
            int cnt = dao.insertNotice(notice);
            result = (cnt > 0);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    
    @Override
    public List<NoticeVO> getAllNotices() {
        List<NoticeVO> list = null;
        
        try {
            list = dao.selectAllNotices();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    @Override
    public NoticeVO getNoticeDetail(Long noticeNo) {
        NoticeVO notice = null;
        
        try {
            // 1. 조회수 증가
            dao.updateHitCount(noticeNo);
            
            // 2. 상세 정보 조회
            notice = dao.selectNoticeByNo(noticeNo);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return notice;
    }
    
    
    @Override
    public boolean updateNotice(NoticeVO notice) {
        boolean result = false;
        
        try {
            int cnt = dao.updateNotice(notice);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    
    @Override
    public boolean deleteNotice(Long noticeNo) {
        boolean result = false;
        
        try {
            int cnt = dao.deleteNotice(noticeNo);
            result = (cnt > 0);
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    
    @Override
    public List<NoticeVO> getTopNotices() {
        List<NoticeVO> list = null;
        
        try {
            list = dao.selectTopNotices();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    @Override
    public List<NoticeVO> getNoticesWithPaging(int page, int pageSize) {
        List<NoticeVO> list = null;
        
        try {
            // 페이지 번호를 offset으로 변환 (1페이지 = offset 0)
            int offset = (page - 1) * pageSize;
            
            list = dao.selectNoticesWithPaging(offset, pageSize);
            
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
            
            // 전체 페이지 수 계산 (올림 처리)
            totalPages = (int) Math.ceil((double) totalCount / pageSize);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return totalPages;
    }
    
    
    @Override
    public List<NoticeVO> searchByTitle(String keyword) {
        List<NoticeVO> list = null;
        
        try {
            list = dao.searchByTitle(keyword);
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
}
