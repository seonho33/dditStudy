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
 * [AJAX 전용] 내가 작성한 리뷰 목록의 내용물만 반환
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-30
 * @url /review/myReviewContent.do
 */
@WebServlet("/review/myReviewContent.do")
public class MyReviewContentServlet extends HttpServlet {
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
        
        if (uvo == null) {
            response.getWriter().print("<p style='text-align:center; padding:20px;'>로그인이 필요합니다.</p>");
            return;
        }
        
        String userId = uvo.getUserId();
        
        // 데이터 조회
        List<ReviewDetailVO> myReviewList = service.getMyReviews(userId);
        
        // 결과 전달
        request.setAttribute("myReviewList", myReviewList);
        
        // JSP 조각으로 포워드
        request.getRequestDispatcher("/TEST/views/review/myReviewContent.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}