package kr.or.ddit.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.UserServiceImpl;


import java.io.IOException;
import java.security.Provider.Service;

/**
 * Servlet implementation class select
 */
@WebServlet("/checkId.do")
public class checkId extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        IUserService service = new UserServiceImpl();
        boolean exists = service.checkUser(userId);

        // ⭐ session 사용
        var session = request.getSession();

        if (exists) {
          
            request.setAttribute("idcheck", false);
            request.setAttribute("idMsg", "사용 중인 아이디 입니다.");

            //session에서 제거
            session.removeAttribute("checkedId");

        } else {
            
            request.setAttribute("idcheck", true);
            request.setAttribute("idMsg", "사용 가능한 아이디 입니다.");

            //session에 저장
            session.setAttribute("checkedId", userId);
        }

        request.getRequestDispatcher("/TEST/views/user/join.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
