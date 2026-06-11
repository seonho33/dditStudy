package kr.or.ddit.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import kr.or.ddit.admin.service.BotServiceImpl;
import kr.or.ddit.admin.service.IBotService;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/admin/bot-delete.do")
public class AdminBotDeleteController extends HttpServlet {

    private IBotService service = BotServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"로그인 필요\"}");
            return;
        }

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null || !"관리자".equals(loginUser.getDivision())) {
            response.getWriter().write("{\"success\":false,\"message\":\"권한 없음\"}");
            return;
        }

        int botId;
        try {
            botId = Integer.parseInt(request.getParameter("botId"));
        } catch (Exception e) {
            response.getWriter().write("{\"success\":false,\"message\":\"botId 오류\"}");
            return;
        }

        int cnt = service.deleteBot(botId);
        if (cnt > 0) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"삭제 실패\"}");
        }
    }
}
