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
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 공지사항 수정 Controller
 */
@WebServlet("/notice/update.do")
public class NoticeUpdateController extends HttpServlet {
    
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
        
        // 기존 데이터 조회
        NoticeVO notice = service.getNoticeDetail(noticeNo);
        
        if(notice == null) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }
        
        // 수정 폼으로 이동 (notice 객체 전달)
        req.setAttribute("notice", notice);
        System.out.println("접근함");
        req.getRequestDispatcher("/TEST/views/board/noticeUpdateForm.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 세션 체크
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO)session.getAttribute("loginUser");
        if(uvo == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        String userId = uvo.getUserId();
        
     
        
        // 파라미터 수집
        String noticeNoParam = req.getParameter("noticeNo");
        String noticeTitle = req.getParameter("noticeTitle");
        String noticeContent = req.getParameter("noticeContent");
        String topYn = req.getParameter("topYn");
        
        // 유효성 검사
        if(noticeNoParam == null || noticeTitle == null || noticeContent == null) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }
        
        // VO 생성
        NoticeVO notice = new NoticeVO();
        notice.setNoticeNo(Long.parseLong(noticeNoParam));
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setTopYn(topYn != null ? topYn : "N");
        
        // 수정
        boolean result = service.updateNotice(notice);
        
        if(result) {
            // 성공 시 상세 페이지로 이동
            resp.sendRedirect(req.getContextPath() + "/notice/detail.do?noticeNo=" + notice.getNoticeNo());
        } else {
            // 실패 시 에러 메시지
            req.setAttribute("errorMsg", "공지사항 수정에 실패했습니다.");
            req.setAttribute("notice", notice);
            req.getRequestDispatcher("/TEST/views/board/noticeUpdateForm.jsp").forward(req, resp);
        }
    }
}