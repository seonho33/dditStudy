package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * Q&A 목록 조회 Controller
 */
@WebServlet("/qna/list.do")
public class QnaListController extends HttpServlet {
    
    private IQnaService service = QnaServiceImpl.getInstance();
    
    
    
    
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
       
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
      /*
       * // ================= [테스트용 세션 주입 코드 시작] ================= // 세션에 값이 없을 때만 강제로
       * 값을 넣어줍니다. if (session.getAttribute("userId") == null) {
       * session.setAttribute("userId", "testUser"); // 테스트용 아이디
       * session.setAttribute("userRole", "USER"); // 테스트용 권한 //
       * session.setAttribute("userRole", "ADMIN"); // 관리자 테스트 시 이 줄을 활성화하세요. } //
       * ================= [테스트용 세션 주입 코드 끝] =================
       */
        

        
		/*
		 * String userRole = (String) session.getAttribute("userRole"); String userId =
		 * (String) session.getAttribute("userId");
		 */
        
        // 페이징 파라미터
        String pageParam = req.getParameter("page");
        int currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);
        int pageSize = 10;
        
        // 검색 및 필터 파라미터
        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status"); // 접수, 완료
        
        List<QnaVO> qnaList = null;
        int totalPages = 0;
        
        // 검색 또는 상태 필터
        if(keyword != null && !keyword.trim().isEmpty()) {
            qnaList = service.searchByTitle(keyword);
            totalPages = 1;
        } else if(status != null && !status.trim().isEmpty()) {
            qnaList = service.getQnasByStatus(status);
            totalPages = 1;
        } else {
            qnaList = service.getQnasWithPaging(currentPage, pageSize);
            totalPages = service.getTotalPages(pageSize);
        }
        
        // 비밀글 필터링 (본인 또는 관리자만 볼 수 있음)
        if(qnaList != null && !"관리자".equals(userRole)) {
            for(QnaVO qna : qnaList) {
                if("Y".equals(qna.getSecretYn()) && !qna.getUserId().equals(userId)) {
                    qna.setQnaTitle("🔒 비밀글입니다");
                    qna.setQnaContent("");
                }
            }
        }
        
        // JSP로 전달
        req.setAttribute("qnaList", qnaList);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
        
        req.getRequestDispatcher("/TEST/views/board/qnaList.jsp").forward(req, resp);
    }
}