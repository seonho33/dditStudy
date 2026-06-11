package kr.or.ddit.reservation.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.StoreVO;

@WebServlet("/reservation/getWaitingCount.do")
public class ReservationWaitingCountController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String json;
        
        if (svo == null) {
            json = "{\"success\": false, \"message\": \"로그인이 필요합니다.\"}";
        } else {
            try {
                IReservationService service = ReservationServiceImpl.getInstance();
                int count = service.countReservationsByStatus(svo.getStoreId(), "대기");
                
                json = String.format("{\"success\": true, \"count\": %d}", count);
                
            } catch (Exception e) {
                e.printStackTrace();
                json = "{\"success\": false, \"message\": \"조회 중 오류가 발생했습니다.\"}";
            }
        }
        
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}