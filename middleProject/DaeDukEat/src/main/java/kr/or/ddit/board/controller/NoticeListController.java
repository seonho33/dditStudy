package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeVO;


/**
 * 공지사항 목록 조회 Controller
 */

@WebServlet("/notice/list.do")
public class NoticeListController extends HttpServlet {
    
    private INoticeService service = NoticeServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 페이징 파라미터
        String pageParam = req.getParameter("page");
        int currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int pageSize = 10; // 페이지당 게시글 수
        
        // 검색 파라미터
        String keyword = req.getParameter("keyword");
        
        List<NoticeVO> noticeList = null;
        int totalPages = 0;
        
        // 검색어가 있으면 검색, 없으면 전체 조회
        if(keyword != null && !keyword.trim().isEmpty()) {
            noticeList = service.searchByTitle(keyword);
            // 검색 결과는 페이징 안함 (필요시 별도 구현)
            totalPages = 1;
        } else {
            noticeList = service.getNoticesWithPaging(currentPage, pageSize);
            totalPages = service.getTotalPages(pageSize);
        }
        
        // JSP로 전달
        req.setAttribute("noticeList", noticeList);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        
        req.getRequestDispatcher("/TEST/views/board/noticeList.jsp").forward(req, resp);
    }
}