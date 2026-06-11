package kr.or.ddit.admin.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.admin.service.BotServiceImpl;
import kr.or.ddit.admin.service.IBotService;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/admin/bot-update.do")
public class AdminBotUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IBotService service = BotServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // 1) 관리자 권한 체크
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

        // 2) 파라미터
        int botId;
        try {
            botId = Integer.parseInt(request.getParameter("botId"));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"botId가 올바르지 않습니다.\"}");
            return;
        }

        String categoryName = safeTrim(request.getParameter("categoryName"));
        String questionKeyword = safeTrim(request.getParameter("questionKeyword"));
        String answerContent = safeTrim(request.getParameter("answerContent"));

        if (categoryName.isEmpty() || answerContent.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"카테고리/대사는 필수입니다.\"}");
            return;
        }

        // 3) 업데이트
        BotVO vo = new BotVO();
        vo.setBotId(botId);
        vo.setCategoryName(categoryName);
        vo.setQuestionKeyword(questionKeyword);
        vo.setAnswerContent(answerContent);

        int cnt = service.updateBot(vo);

        if (cnt > 0) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"수정 실패\"}");
        }
    }

    private String safeTrim(String s) {
        return (s == null) ? "" : s.trim();
    }
}
