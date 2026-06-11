package kr.or.ddit.review.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.ReviewDetailVO;

/**
 * [AJAX 요청용] 미작성 리뷰 목록의 "내용물"만 리턴하는 서블릿
 */
@WebServlet("/review/unwrittenContent.do") // URL을 기능에 맞게 살짝 수정
public class UnwrittenReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IReviewService service;
    
    @Override
    public void init() throws ServletException {
        service = ReviewServiceImpl.getInstance();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        // AJAX 요청이므로 로그인이 안 되어 있다면 단순 에러 메시지나 빈 내용을 보냅니다.
        if (uvo == null) {
            response.getWriter().print("<p style='text-align:center; padding:20px;'>로그인이 필요합니다.</p>");
            return;
        }
        
        String userId = uvo.getUserId();
        
        // 1. 데이터 조회
        List<ReviewDetailVO> unwrittenList = service.getUnwrittenReviews(userId);
        
        // 2. 결과 전달
        request.setAttribute("unwrittenList", unwrittenList);
        
        // [중요] 전체 틀이 아닌, 반복문만 있는 JSP 조각으로 보냅니다.
        request.getRequestDispatcher("/TEST/views/review/unwrittenContent.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}