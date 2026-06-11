package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.StoreServiceImpl;
import kr.or.ddit.store.vo.StoreGameVO;

/**
 * 랜덤 가게 선택 게임 컨트롤러
 * ✅ 수정: JSON 생성 시 null 안전성 보장
 */
@WebServlet("/randomStore.do")
public class RandomStoreController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IStoreService storeService;
    
    @Override
    public void init() throws ServletException {
        this.storeService = StoreServiceImpl.getInstance();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            // 1. 활성 가게 목록 조회
            List<StoreGameVO> stores = storeService.getActiveStoresForGame();
            
            // 2. ✅ 안전한 JSON 변환 (null이나 빈 리스트도 "[]"로 변환)
            Gson gson = new Gson();
            String storesJson = (stores != null && !stores.isEmpty()) 
                              ? gson.toJson(stores) 
                              : "[]";  // ← 핵심: 빈 배열 보장
            
            // 3. ✅ 디버깅 로그 (개발 환경에서만 활성화 권장)
            System.out.println("=== Random Store Controller ===");
            System.out.println("Store Count: " + (stores != null ? stores.size() : 0));
            System.out.println("JSON Length: " + storesJson.length());
            System.out.println("JSON Preview: " + storesJson.substring(0, Math.min(100, storesJson.length())));
            
            // 4. Request Scope에 데이터 저장
            request.setAttribute("storesJson", storesJson);
            request.setAttribute("storeCount", stores != null ? stores.size() : 0);
            
            // 5. JSP로 Forward
            request.getRequestDispatcher("/TEST/views/store/randomStore.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            
            // ✅ 에러 발생 시에도 빈 JSON 전달하여 JS 오류 방지
            request.setAttribute("storesJson", "[]");
            request.setAttribute("storeCount", 0);
            request.setAttribute("errorMsg", "가게 데이터를 불러오는데 실패했습니다: " + e.getMessage());
            
            request.getRequestDispatcher("/TEST/views/store/randomStore.jsp")
                   .forward(request, response);
        }
    }
}