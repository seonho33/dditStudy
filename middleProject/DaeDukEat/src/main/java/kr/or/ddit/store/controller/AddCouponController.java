package kr.or.ddit.store.controller;

import java.io.IOException;
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

@WebServlet("/addCoupon.do")
public class AddCouponController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ICouponService service = CouponServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession();
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");

        if (svo == null) {
            response.getWriter().write("LOGOUT");
            return;
        }

        try {
            // ===== 1) 파라미터 수집 =====
            String couponName = request.getParameter("couponName");
            String couponContent = request.getParameter("couponContent");

            String dPrice = request.getParameter("deductedPrice");
            String mPrice = request.getParameter("minPrice");
            String qty    = request.getParameter("couponQty");
            String expStr = request.getParameter("expiredDate");

            // ✅ 새로 추가: 리뷰 조건
            String reviewNStr = request.getParameter("reviewN");

            // ===== 2) 유효성(최소) =====
            if (couponName == null || couponName.trim().isEmpty()) {
                response.getWriter().write("INVALID");
                return;
            }
            if (reviewNStr == null || reviewNStr.trim().isEmpty()) {
                response.getWriter().write("INVALID_REVIEWN");
                return;
            }

            long deductedPrice = Long.parseLong(dPrice != null ? dPrice : "0");
            long minPrice      = Long.parseLong(mPrice != null ? mPrice : "0");
            long couponQty     = Long.parseLong(qty != null && !qty.isEmpty() ? qty : "999");
            int reviewN        = Integer.parseInt(reviewNStr);

            if (reviewN < 1) {
                response.getWriter().write("INVALID_REVIEWN");
                return;
            }

            // ===== 3) VO 세팅 =====
            CouponVO coupon = new CouponVO();
            coupon.setStoreId(svo.getStoreId());
            coupon.setCouponName(couponName);
            coupon.setCouponContent(couponContent);
            coupon.setDeductedPrice(deductedPrice);
            coupon.setMinPrice(minPrice);
            coupon.setCouponQty(couponQty);

            if (expStr != null && !expStr.isEmpty()) {
                coupon.setExpiredDate(java.sql.Date.valueOf(expStr));
            }

            // ===== 4) DB 저장 (COUPON + COUPON_RULE) =====
            // ⚠️ 핵심: 쿠폰 insert 후 couponId가 필요하므로,
            // service.registerCouponWithRule(coupon, reviewN) 형태로 트랜잭션 처리 권장
            boolean ok = service.registerCouponWithRule(coupon, reviewN);

            
            response.getWriter().write(ok ? "SUCCESS" : "FAIL");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().write("INVALID_NUMBER");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }
}
