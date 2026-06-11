package kr.or.ddit.store.controller;


import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.service.IUserService;
import kr.or.ddit.store.service.UserServiceImpl;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/updateProfile.do")
public class UpdateStoreProfileServlet extends HttpServlet {

  private IUserService userService = new UserServiceImpl();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    req.setCharacterEncoding("UTF-8");
    resp.setContentType("application/json; charset=UTF-8");

    HttpSession session = req.getSession(false);
    UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
    if (loginUser == null) {
      resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
      resp.getWriter().write("{\"ok\":false,\"message\":\"로그인이 필요합니다.\"}");
      return;
    }

    String userId = loginUser.getUserId();

    String userName  = req.getParameter("userName");
    String userEmail = req.getParameter("userEmail");
    String userPw    = req.getParameter("userPw");

    if (userName == null) userName = "";

    UserVO user = new UserVO();
    user.setUserId(userId);
    user.setName(userName);

    if (userPw != null && !userPw.isBlank()) {
      user.setPassword(userPw);
    }

    int result = userService.updateUser(user);

    if (result > 0) {
      UserVO updatedUser = userService.getUserById(userId);
      session.setAttribute("loginUser", updatedUser);

      resp.getWriter().write("{\"ok\":true,\"message\":\"정보가 수정되었습니다.\"}");
      return;
    }

    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    resp.getWriter().write("{\"ok\":false,\"message\":\"정보 수정에 실패했습니다.\"}");
  }
}
