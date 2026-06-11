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

@WebServlet("/admin/bot-insert.do")
public class AdminBotInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IBotService service = BotServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // 1) 세션 체크 (userId 확보)
        HttpSession session = request.getSession(false);
        UserVO loginAdmin = (session == null) ? null : (UserVO) session.getAttribute("loginAdmin");

        if (loginAdmin == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\":false,\"message\":\"로그인이 필요합니다.\"}");
            return;
        }

        // 2) 파라미터 받기
        String categoryName = safeTrim(request.getParameter("categoryName"));
        String questionKeyword = safeTrim(request.getParameter("questionKeyword"));
        String answerContent = safeTrim(request.getParameter("answerContent"));

        // 3) 검증 (최소)
        if (categoryName.isEmpty() || answerContent.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"카테고리/대사는 필수입니다.\"}");
            return;
        }

        // 4) VO 세팅
        BotVO vo = new BotVO();
        vo.setCategoryName(categoryName);
        vo.setQuestionKeyword(questionKeyword); // 빈 문자열도 허용(원하면 필수로 바꿔)
        vo.setAnswerContent(answerContent);
        vo.setUserId(loginAdmin.getUserId());   // ✅ 세션에서 userId

        // 5) INSERT
        
        if (!"관리자".equals(loginAdmin.getDivision())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"success\":false,\"message\":\"관리자만 가능합니다.\"}");
            return;
        }

        int cnt = service.insertBot(vo);

        if (cnt > 0) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\":false,\"message\":\"등록 실패\"}");
        }
    }

    private String safeTrim(String s) {
        return (s == null) ? "" : s.trim();
    }
}
