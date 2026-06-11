package kr.or.ddit.reservation.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/reservePay.do")
public class ReservePay extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IReservationService service = ReservationServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. 세션 확인
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if(uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        // 2. 파라미터 확인
        String shopId = request.getParameter("shopId");
        if(shopId == null) shopId = request.getParameter("storeId");
        
        if(shopId == null || shopId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/main.do");
            return;
        }
        
        try {
            // 3. 가게 정보 조회
            StoreVO shop = service.getStoreById(shopId);
            
            if(shop == null) {
                request.setAttribute("error", "존재하지 않는 가게입니다.");
                request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
                return;
            }
            
            // 4. JSP로 데이터 전달
            request.setAttribute("shop", shop);
            request.getRequestDispatcher("/TEST/views/reservation/payment.jsp")
                   .forward(request, response);
                   
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "가게 정보 조회 중 오류: " + e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
}

