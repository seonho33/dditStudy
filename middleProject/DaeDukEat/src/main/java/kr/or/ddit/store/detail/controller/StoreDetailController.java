package kr.or.ddit.store.detail.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.detail.service.IStoreDetailService;
import kr.or.ddit.store.detail.service.StoreDetailServiceImpl;
import kr.or.ddit.store.detail.vo.StoreDetailVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/storeDetail.do")
public class StoreDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IStoreDetailService service = StoreDetailServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 파라미터 받기
        String storeId = request.getParameter("id");

        if (storeId == null || storeId.trim().isEmpty()) {
        	System.out.println("===============null넘어옴==================");
            response.sendRedirect(request.getContextPath() + "/main.do");
            return;
        }
        
        // 2. 세션에서 로그인 사용자 정보 가져오기 (태호 님 가이드 적용)
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        String userId = null;
        if (loginUser != null) {
            userId = loginUser.getUserId();
            // JSP에서 사용하기 위해 request에 담기
            request.setAttribute("userId", userId);
            request.setAttribute("userName", loginUser.getName());
            request.setAttribute("userRole", loginUser.getDivision()); // 역할 정보
        }
        
        try {
            // 3. Service 호출 (로그인 안했을 시 userId는 null로 전달됨)
            StoreDetailVO store = service.getStoreWithAllData(storeId, userId);
            
            // 4. JSP로 데이터 전달
            request.setAttribute("store", store);
            request.setAttribute("menuList", store.getMenuList());
            request.setAttribute("reviewList", store.getReviewList());
            request.setAttribute("storeHolidays", store.getStoreHolidays());
            request.setAttribute("isLiked", store.isLiked());
            request.setAttribute("isBookmarked", store.isBookmarked());
            
            request.getRequestDispatcher("/TEST/views/store/storeDetail.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("에러남");
            response.sendRedirect(request.getContextPath() + "/main.do");
        }
    }
}