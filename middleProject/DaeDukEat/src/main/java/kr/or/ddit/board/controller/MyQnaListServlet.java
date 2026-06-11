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
 * 마이페이지 QNA 목록 조회
 * 
 * @author Legacy Architect
 * @since 2025-01-27
 * 
 * <pre>
 * [URL] /mypage/qna/list.do
 * [Method] GET
 * [Response] JSP Forward
 * </pre>
 */
@WebServlet("/mypage/qna/list.do")
public class MyQnaListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 세션 검증
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        
        // 2. Service 호출 (본인 글만)
        IQnaService service = QnaServiceImpl.getInstance();  // ✅ getInstance 사용
        List<QnaVO> qnaList = service.getMyQnas(userId);      // ✅ getMyQnas 사용
        
        // 3. JSP로 데이터 전달
        request.setAttribute("qnaList", qnaList);
        
        // 4. Forward
        request.getRequestDispatcher("/TEST/views/board/myQnaList.jsp")
               .forward(request, response);
    }
}