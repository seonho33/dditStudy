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
 * 공지사항 등록 Controller
 */
@WebServlet("/notice/insert.do")
public class NoticeInsertController extends HttpServlet {
    
    private INoticeService service = NoticeServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 등록 폼으로 이동
        req.getRequestDispatcher("/TEST/views/board/noticeForm.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 세션에서 로그인한 관리자 ID 가져오기
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO)session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        
        // 로그인 체크
        if(userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        // 파라미터 수집
        String noticeTitle = req.getParameter("noticeTitle");
        String noticeContent = req.getParameter("noticeContent");
        String topYn = req.getParameter("topYn"); // "Y" or "N"
        
        // 유효성 검사
        if(noticeTitle == null || noticeTitle.trim().isEmpty() ||
           noticeContent == null || noticeContent.trim().isEmpty()) {
            
            req.setAttribute("errorMsg", "제목과 내용을 입력해주세요.");
            req.getRequestDispatcher("/TEST/views/board/noticeForm.jsp").forward(req, resp);
            return;
        }
        
        // VO 생성
        NoticeVO notice = new NoticeVO();
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setTopYn(topYn != null ? topYn : "N");
        notice.setUserId(userId);
        
        // 등록
        boolean result = service.insertNotice(notice);
        
        if(result) {
            // 성공 시 목록으로 이동
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
        } else {
            // 실패 시 에러 메시지와 함께 폼으로 이동
            req.setAttribute("errorMsg", "공지사항 등록에 실패했습니다.");
            req.getRequestDispatcher("/TEST/views/board/noticeForm.jsp").forward(req, resp);
        }
    }
}