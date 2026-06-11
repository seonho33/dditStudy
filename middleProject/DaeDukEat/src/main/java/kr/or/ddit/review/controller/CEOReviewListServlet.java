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
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.review.service.ICEOReviewService;
import kr.or.ddit.review.service.CEOReviewServiceImpl;
import kr.or.ddit.review.vo.CEOReviewDetailVO;

/**
 * 리뷰 목록 조회 서블릿
 * @url /owner/reviewList.do
 * @role 점주 전용 (세션 검증 필수)
 */
@WebServlet("/owner/reviewList.do")
public class CEOReviewListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
    	
        // 1. 세션에서 로그인 정보 추출
        HttpSession session = req.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        StoreVO loginStore = (StoreVO) session.getAttribute("loginStore");
        
        if (loginUser == null || loginStore == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        System.out.println(loginUser.getDivision());
        System.out.println("loginStore ===== " + loginStore);

        System.out.println("접근함");
        // 3. 점주 권한 확인
        String division = loginUser.getDivision().trim();
        if (!"점주".equals(division) && !"관리자".equals(division)) {
            req.setAttribute("error", "접근 권한이 없습니다.");
            req.getRequestDispatcher("/TEST/views/user/login.jsp").forward(req, resp);
            return;
        }
        
        // 4. 서비스 호출하여 리뷰 목록 조회
        String storeId = loginStore.getStoreId();
        ICEOReviewService service = CEOReviewServiceImpl.getInstance();
        
        try {
            List<CEOReviewDetailVO> reviewList = service.getReviewsByStore(storeId);
            req.setAttribute("reviewList", reviewList);
            
            // 5. JSP로 포워딩
            req.getRequestDispatcher("/TEST/views/review/CEOreviewList.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "리뷰 목록 조회 중 오류가 발생했습니다.");
            req.getRequestDispatcher("/TEST/views/review/CEOreviewList.jsp").forward(req, resp);
        }
    }
}