package kr.or.ddit.store.detail.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import kr.or.ddit.store.detail.service.IStoreDetailService;
import kr.or.ddit.store.detail.service.StoreDetailServiceImpl;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 예약 가능 시간 조회 (AJAX)
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */
@WebServlet("/getAvailableTimes.do")
public class AvailableTimeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IStoreDetailService service = StoreDetailServiceImpl.getInstance();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String storeId = request.getParameter("storeId");
        String date = request.getParameter("date");
        
        try {
            List<String> times = service.getAvailableTimes(storeId, date);
            out.print(gson.toJson(times));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        }
        
        out.flush();
    }
}