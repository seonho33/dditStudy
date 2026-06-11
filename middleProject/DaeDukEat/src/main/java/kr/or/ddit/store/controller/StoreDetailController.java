package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.StoreServiceImpl;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/store/detail.do")
public class StoreDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 세션 검증
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        
        // 2. 점주 권한 검증
        String division = loginUser.getDivision().trim();
        
        if(!"점주".equals(division) && !"관리자".equals(division)) {
            request.setAttribute("error", "점주만 접근 가능합니다.");
            request.getRequestDispatcher("/TEST/views/user/login.jsp").forward(request, response);
            return;
        }
        
        // 3. Service 객체 생성
        IStoreService service = new StoreServiceImpl();
        
        try {
            // 4. 가게 정보 조회
            StoreVO shopDTO = service.selectStoreByUserId(userId);
            
            if(shopDTO == null) {
                request.setAttribute("error", "등록된 가게 정보가 없습니다.");
                request.getRequestDispatcher("/TEST/views/store/registerStore.jsp").forward(request, response);
                return;
            }
            
            // 5. ✅ 이미지 경로 별도 조회 및 전달
            String imagePath = service.getStorePicture(shopDTO.getStoreId());
            
            // 6. Request에 저장
            request.setAttribute("shopDTO", shopDTO);        // 가게 정보
            request.setAttribute("imagePath", imagePath);    // 이미지 경로 (별도)
            
            // 7. ✅ 새로운 JSP로 이동
            request.getRequestDispatcher("/TEST/views/store/가게관리_update.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "가게 정보 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
}

