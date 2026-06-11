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
 * 회원 정보 수정 AJAX 컨트롤러
 * - URL: /member/edit.do
 * - GET: 수정 폼 화면
 * - POST: 수정 처리
 */
@WebServlet("/member/edit.do")
public class MemberEditController extends HttpServlet {
    
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
        
        try {
            // 수정 폼에 기존 데이터 표시
            MemberVO member = service.getMemberInfo(userId);
            request.setAttribute("member", member);
            
            request.getRequestDispatcher("/WEB-INF/views/member/updateMember.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
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
            // 수정할 정보 수집
            String name = request.getParameter("name");
            String userMail = request.getParameter("userMail");
            String userBir = request.getParameter("userBir");
            
            MemberVO member = new MemberVO();
            member.setUserId(userId);
            member.setName(name);
            member.setUserMail(userMail);
            // userBir 파싱 필요 시 SimpleDateFormat 사용
            
            // 수정 처리
            boolean isUpdated = service.updateMemberInfo(member);
            
            if(isUpdated) {
                response.getWriter().write("{\"result\":\"success\",\"message\":\"정보가 수정되었습니다.\"}");
            } else {
                response.getWriter().write("{\"result\":\"fail\",\"message\":\"수정에 실패했습니다.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"result\":\"error\",\"message\":\"처리 중 오류가 발생했습니다.\"}");
        }
    }
}