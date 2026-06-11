package kr.or.ddit.admin.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.admin.service.BotServiceImpl;
import kr.or.ddit.admin.service.IBotService;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/admin/bot-toggle.do")
public class AdminBotToggleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IBotService service = BotServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // 로그인/권한 체크
        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"로그인이 필요합니다.\"}");
            return;
        }
        if (!"관리자".equals(loginUser.getDivision())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"success\":false,\"message\":\"관리자만 가능합니다.\"}");
            return;
        }

        // 파라미터
        String botIdStr = request.getParameter("botId");
        int botId;
        try {
            botId = Integer.parseInt(botIdStr);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"botId가 올바르지 않습니다.\"}");
            return;
        }

        String next = service.toggleActive(botId);
        if (next == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"success\":false,\"message\":\"대상이 없거나 토글 실패\"}");
            return;
        }

        // next 값을 응답으로 같이 줘서 프론트가 즉시 뱃지 바꾸기 좋게
        response.getWriter().write("{\"success\":true,\"activeYn\":\"" + next + "\"}");
    }
}
