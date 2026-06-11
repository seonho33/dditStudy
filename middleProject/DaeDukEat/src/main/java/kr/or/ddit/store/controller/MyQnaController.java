package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.dao.IQnaDAO;
import kr.or.ddit.board.dao.QnaDAOImpl;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 나의 QNA 조회 AJAX 컨트롤러
 * - URL: /member/qna.do
 * - 로그인한 회원이 작성한 QNA 목록 조회
 */
@WebServlet("/member/qna.do")
public class MyQnaController extends HttpServlet {
    
    private IQnaDAO qnaDao = QnaDAOImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        
        if(userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        try {
            // 내가 작성한 QNA 목록 조회 (기존 QnaDAO 재사용)
            List<QnaVO> myQnaList = qnaDao.selectMyQnas(userId);
            
            request.setAttribute("myQnaList", myQnaList);
            
            request.getRequestDispatcher("/WEB-INF/views/member/QNA일반회원.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}