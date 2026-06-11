package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeVO;

/**
 * 공지사항 상세 조회 Controller
 * - 조회수 자동 증가
 */
@WebServlet("/notice/detail.do")
public class NoticeDetailController extends HttpServlet {
    
    private INoticeService service = NoticeServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String noticeNoParam = req.getParameter("noticeNo");
        
        if(noticeNoParam == null || noticeNoParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }
        
        Long noticeNo = Long.parseLong(noticeNoParam);
        
        // 상세 조회 (조회수 자동 증가)
        NoticeVO notice = service.getNoticeDetail(noticeNo);
        
        if(notice == null) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }
        
        // JSP로 전달
        req.setAttribute("notice", notice);
        
        req.getRequestDispatcher("/TEST/views/board/noticeDetail.jsp").forward(req, resp);
    }
}