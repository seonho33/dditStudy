package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import kr.or.ddit.store.service.IUserService;
import kr.or.ddit.store.service.UserServiceImpl;
import kr.or.ddit.store.dao.UserDaoImpl;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/checkPassword.do")
public class CheckPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        IUserService userService = new UserServiceImpl(new UserDaoImpl());

        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().print("{\"result\":\"unauthorized\",\"message\":\"로그인이 필요합니다.\"}");
            return;
        }

        String userId = loginUser.getUserId();
        String password = request.getParameter("password"); 

        boolean isValid = userService.checkPassword(userId, password);

        if (isValid) {
            response.getWriter().print("{\"result\":\"success\"}");
        } else {
            response.getWriter().print("{\"result\":\"fail\",\"message\":\"비밀번호가 일치하지 않습니다.\"}");
        }
    }
}
