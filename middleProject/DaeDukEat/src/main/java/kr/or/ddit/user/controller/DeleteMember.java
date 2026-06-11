package kr.or.ddit.user.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.user.service.DeleteMemberServiceImpl;
import kr.or.ddit.user.service.IDeleteMemberService;

@WebServlet("/DeleteMember.do")
public class DeleteMember extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IDeleteMemberService deleteService = DeleteMemberServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== DeleteMember.do GET 호출됨 ==========");

        HttpSession session = request.getSession(false);

        UserVO uvo = null;
        if (session != null) {
            uvo = (UserVO) session.getAttribute("loginUser");
        }

        if (uvo == null) {
            System.out.println("로그인 정보 없음 - 401 반환");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized - Please login first");
            return;
        }

        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();

        System.out.println("로그인 사용자: " + userId + ", 권한: " + userRole);

        request.setAttribute("userVO", uvo);

        request.getRequestDispatcher("/TEST/views/user/deleteMember.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== DeleteMember.do POST 호출됨 ==========");

        HttpSession session = request.getSession(false);

        UserVO uvo = null;
        if (session != null) {
            uvo = (UserVO) session.getAttribute("loginUser");
        }

        if (uvo == null) {
            System.out.println("로그인 정보 없음 - 401 반환");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String userId = uvo.getUserId();
        
        System.out.println("회원 탈퇴 처리 시작: " + userId);

        boolean result = deleteService.withdraw(userId);//USE_YN='N'
        
        System.out.println("회원 탈퇴 처리->result : " + result);
        
        
        if (result) {
            System.out.println("회원 탈퇴 성공 - 메인으로 이동");
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/main.do");
        } else {
            System.out.println("회원 탈퇴 실패 - 에러 메시지 표시");
            request.setAttribute("msg", "회원 탈퇴에 실패했습니다.");
            request.setAttribute("userVO", uvo);

            request.getRequestDispatcher("/TEST/views/user/deleteMember.jsp").forward(request, response);
        }
    }
}