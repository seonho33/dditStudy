package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.store.service.CouponServiceImpl;
import kr.or.ddit.store.service.ICouponService;

/**
 * 쿠폰 삭제 컨트롤러
 * - URL: /deleteCoupon.do?idx=1
 * - 논리 삭제 (STATUS='N')
 */
@WebServlet("/deleteCoupon.do")
public class DeleteCouponController extends HttpServlet {
    
    private ICouponService service = CouponServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. JSP에서 'couponId'라는 이름으로 보냈으므로 똑같이 맞춤
        String idParam = request.getParameter("couponId");
        
        // 디버깅용 로그 (서버 콘솔에서 확인 가능)
        System.out.println("삭제 요청 쿠폰 ID: " + idParam);

        // AJAX 응답을 위한 설정
        response.setContentType("text/plain; charset=UTF-8");
        
        if(idParam == null || idParam.trim().isEmpty()) {
            response.getWriter().write("fail: missing id");
            return;
        }
        
        try {
            Long couponId = Long.parseLong(idParam);
            
            // 2. 서비스 호출 (논리 삭제 STATUS='N' 처리)
            boolean isDeleted = service.removeCoupon(couponId);
            
            if(isDeleted) {
                // 🔥 AJAX 요청이므로 리다이렉트가 아니라 "success" 문자열만 보냄
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("error: invalid format");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error: server exception");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST로 요청이 와도 doGet에서 처리하도록 연결
        doGet(request, response);
    }
}