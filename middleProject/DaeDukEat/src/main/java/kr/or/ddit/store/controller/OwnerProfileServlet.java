package kr.or.ddit.store.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.service.IOwnerService;
import kr.or.ddit.store.service.OwnerServiceImpl;
import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.user.vo.UserVO; // UserVO 패키지 경로를 프로젝트에 맞춰 확인하세요.

/**
 * 사장님 프로필 조회/수정 컨트롤러
 */
@WebServlet("/owner/profile.do")
public class OwnerProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IOwnerService service = OwnerServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // ========== 1. 세션 검증 (수정된 부분) ==========
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");

        // 로그인 여부 확인
        if(uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        String userId = uvo.getUserId();
        
        try {
            // ========== 2. 데이터 조회 및 포워딩 ==========
            OwnerProfileVO profile = service.getOwnerProfile(userId);
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("/owner/profile.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "프로필 조회 실패");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // ========== 1. 세션 검증 (수정된 부분) ==========
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");

        if(uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        String userId = uvo.getUserId();
        
        // ========== 2. 파라미터 수집 ==========
        OwnerProfileVO profile = new OwnerProfileVO();
        profile.setUserId(userId);
        profile.setStoreId(request.getParameter("storeId"));
        profile.setStoreName(request.getParameter("storeName"));
        profile.setStoreAddr(request.getParameter("storeAddr"));
        profile.setStoreAddr2(request.getParameter("storeAddr2"));
        profile.setStorePhone(request.getParameter("storePhone"));
        profile.setStoreContent(request.getParameter("storeContent"));
        profile.setOperationHours(request.getParameter("operationHours"));
        
        String depositStr = request.getParameter("deposit");
        if(depositStr != null && !depositStr.isEmpty()) {
            try {
                profile.setDeposit(Integer.parseInt(depositStr));
            } catch (NumberFormatException e) {
                profile.setDeposit(0); // 파싱 에러 시 기본값 처리
            }
        }
        
        try {
            // ========== 3. 데이터 업데이트 ==========
            boolean success = service.updateStoreInfo(profile);
            
            if(success) {
                // 수정 성공 시 대시보드로 이동
                response.sendRedirect(request.getContextPath() + "/owner/dashboard.do");
            } else {
                request.setAttribute("errorMsg", "정보 수정 실패");
                doGet(request, response);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "정보 수정 중 오류 발생");
            doGet(request, response);
        }
    }
}