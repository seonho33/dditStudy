package kr.or.ddit.review.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.vo.UserVO; // UserVO 패키지 경로를 확인하세요
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.ReviewDetailVO;

/**
 * 내가 작성한 리뷰 목록 조회 서블릿
 * * @author Legacy Architecture Team
 * @since 2025-01-23
 * @url /review/mylistreview.do
 */
@WebServlet("/review/mylistreview.do")
public class MyReviewListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /** Service Layer Dependency */
    private IReviewService service;
    
    @Override
    public void init() throws ServletException {
        service = ReviewServiceImpl.getInstance();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // --- 세션 수정 부분 시작 ---
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        // 로그인 체크 (UserVO 객체 존재 여부 확인)
        if (uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        // 유저 정보 추출
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        // --- 세션 수정 부분 끝 ---
        
        // 작성한 리뷰 목록 조회 (추출한 userId 사용)
        List<ReviewDetailVO> myReviewList = service.getMyReviews(userId);
        
        // JSP 전달
        request.setAttribute("myReviewList", myReviewList);
        request.setAttribute("userRole", userRole); // 필요 시 JSP에서 권한에 따른 분기 처리를 위해 추가
        request.setAttribute("currentTab", "mylist");
        
        request.getRequestDispatcher("/TEST/views/review/reviewTab.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}