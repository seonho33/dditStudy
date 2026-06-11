package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.admin.service.BotServiceImpl;
import kr.or.ddit.admin.service.IBotService;
import kr.or.ddit.admin.vo.BotVO;

@WebServlet("/admin/bot.do")
public class AdminBotPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IBotService service = BotServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) 목록 조회 (관리자용: Y/N 전부 보고 싶으면 전체 조회 메서드 사용)
        List<BotVO> botList = service.selectBotList();

        // 2) request에 담기
        request.setAttribute("botList", botList);

        // 3) 조각 JSP로 forward
        request.getRequestDispatcher("/TEST/views/admin/admin_bot_category.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
