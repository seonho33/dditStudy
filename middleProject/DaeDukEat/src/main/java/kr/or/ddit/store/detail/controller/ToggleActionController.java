package kr.or.ddit.store.detail.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.google.gson.Gson;
import kr.or.ddit.store.detail.service.IStoreDetailService;
import kr.or.ddit.store.detail.service.StoreDetailServiceImpl;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/toggleAction.do")
public class ToggleActionController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IStoreDetailService service = StoreDetailServiceImpl.getInstance();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. 세션에서 로그인 정보 가져오기 (태호 님 스타일 적용)
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        // ━━━━━━━ 로그인 체크 ━━━━━━━
        if (uvo == null) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "로그인이 필요합니다.");
            out.print(gson.toJson(error));
            out.flush();
            return;
        }
        
        // 2. 로그인된 사용자 정보 추출
        String userId = uvo.getUserId();
        // String userRole = uvo.getDivision(); // 필요 시 활용
        
        // 3. 파라미터 받기
        String type = request.getParameter("type");     // 'like' 또는 'bookmark'
        String storeId = request.getParameter("storeId");
        String action = request.getParameter("action"); // 'insert' 또는 'delete'

        
        try {
            // 4. Service 호출
            Map<String, Object> result = service.toggleAction(userId, storeId, type, action);
            out.print(gson.toJson(result));
            
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "처리 중 서버 오류가 발생했습니다.");
            out.print(gson.toJson(error));
        }
        
        out.flush();
    }
}