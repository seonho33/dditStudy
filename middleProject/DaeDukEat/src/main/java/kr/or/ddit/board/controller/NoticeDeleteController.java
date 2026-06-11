package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.user.vo.UserVO;

/**
 * 공지사항 삭제 Controller
 */
@WebServlet("/notice/delete.do")
public class NoticeDeleteController extends HttpServlet {
    
    private INoticeService service = NoticeServiceImpl.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 세션 체크
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO)session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        
        if(userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        // 파라미터 수집
        String noticeNoParam = req.getParameter("noticeNo");
        
        if(noticeNoParam == null || noticeNoParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }
        
        Long noticeNo = Long.parseLong(noticeNoParam);
        
        // 삭제
        boolean result = service.deleteNotice(noticeNo);
        
        if(result) {
            // 성공 시 목록으로 이동
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
        } else {
            // 실패 시 상세 페이지로 돌아가기
            resp.sendRedirect(req.getContextPath() + "/notice/detail.do?noticeNo=" + noticeNo);
        }
    }
}
