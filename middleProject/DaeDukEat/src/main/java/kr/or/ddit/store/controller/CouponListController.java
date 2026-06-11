package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.service.CouponServiceImpl;
import kr.or.ddit.store.service.ICouponService;
import kr.or.ddit.store.vo.CouponVO;
import kr.or.ddit.store.vo.StoreVO;

@WebServlet("/couponList.do")
public class CouponListController extends HttpServlet {
    private ICouponService service = CouponServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        StoreVO svo = (StoreVO)session.getAttribute("loginStore");
        
        // 1. 세션 체크: 비동기 요청일 경우 리다이렉트 대신 에러코드를 보냄 (대시보드 튕김 방지)
        if(svo == null) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            } else {
                response.sendRedirect(request.getContextPath() + "/login.do");
            }
            return;
        }
        
        String storeId = svo.getStoreId();
        
        try {
            // 2. 데이터 조회
            List<CouponVO> couponList = service.getCouponList(storeId);
            request.setAttribute("couponList", couponList);
            
            // 3. [핵심] 대시보드용 응답 처리
            // 이 컨트롤러가 호출되면 "쿠폰관리.jsp"의 순수 HTML 내용만 리턴합니다.
            request.getRequestDispatcher("/TEST/views/store/쿠폰관리.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}