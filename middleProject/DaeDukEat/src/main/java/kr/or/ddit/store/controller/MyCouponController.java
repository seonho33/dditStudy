package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.dao.ICouponhamDAO;
import kr.or.ddit.store.dao.CouponhamDAOImpl;
import kr.or.ddit.store.vo.CouponhamVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 나의 쿠폰함 조회 AJAX 컨트롤러
 * - URL: /member/coupon.do
 * - 로그인한 회원이 보유한 쿠폰 목록 조회
 */
@WebServlet("/member/coupon.do")
public class MyCouponController extends HttpServlet {
    
    // ⚠️ CouponhamDAO 생성 필요
    
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
            // TODO: CouponhamDAO.selectMyCoupons(userId) 구현
            // List<CouponhamVO> myCouponList = couponhamDao.selectMyCoupons(userId);
            // request.setAttribute("myCouponList", myCouponList);
            
            request.getRequestDispatcher("/TEST/views/store/couponList.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}