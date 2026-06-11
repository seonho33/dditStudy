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
import kr.or.ddit.store.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 회원 정보 조회 AJAX 컨트롤러
 * - URL: /member/info.do
 * - 로그인한 회원의 상세 정보 조회
 */
@WebServlet("/member/info.do")
public class MemberInfoController extends HttpServlet {
    
    private IMemberService service = MemberServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession();
    	UserVO uvo = (UserVO)session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        
        // 세션 체크
        if(userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("로그인이 필요합니다.");
            return;
        }
        
        try {
            // 회원 정보 조회
            MemberVO member = service.getMemberInfo(userId);
            
            // JSP로 데이터 전달
            request.setAttribute("member", member);
            
            // JSP 조각(Fragment)만 반환
            request.getRequestDispatcher("/WEB-INF/views/member/memberProfile.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("정보 조회 중 오류가 발생했습니다.");
        }
    }
}