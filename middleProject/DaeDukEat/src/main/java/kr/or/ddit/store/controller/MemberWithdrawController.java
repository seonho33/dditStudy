package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.service.IMemberService;
import kr.or.ddit.store.service.MemberServiceImpl;
import kr.or.ddit.user.vo.UserVO;

/**
 * 회원 탈퇴 AJAX 컨트롤러
 * - URL: /member/withdraw.do
 * - GET: 탈퇴 확인 화면
 * - POST: 탈퇴 처리
 */
@WebServlet("/member/withdraw.do")
public class MemberWithdrawController extends HttpServlet {
    
    private IMemberService service = MemberServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();        
        if(userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/member/회원탈퇴일반회원.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        
        if(userId == null) {
            response.getWriter().write("{\"result\":\"fail\",\"message\":\"로그인이 필요합니다.\"}");
            return;
        }
        
        try {
            // 비밀번호 확인
            String password = request.getParameter("password");
            
            // 탈퇴 처리 (USE_YN = 'N')
            boolean isWithdrawn = service.withdrawMember(userId, password);
            
            if(isWithdrawn) {
                // 세션 무효화
                session.invalidate();
                response.getWriter().write("{\"result\":\"success\",\"message\":\"탈퇴가 완료되었습니다.\"}");
            } else {
                response.getWriter().write("{\"result\":\"fail\",\"message\":\"비밀번호가 일치하지 않습니다.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"result\":\"error\",\"message\":\"처리 중 오류가 발생했습니다.\"}");
        }
    }
}