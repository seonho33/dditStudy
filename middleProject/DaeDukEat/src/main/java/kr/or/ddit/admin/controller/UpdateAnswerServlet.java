package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;

@WebServlet("/UpdateAnswer.do")
public class UpdateAnswerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String noStr = request.getParameter("no");
        String content = request.getParameter("content");

        if (noStr == null || noStr.isBlank() || content == null || content.isBlank()) {
            writeJson(response, false, "답변 내용이 비어있습니다.");
            return;
        }

        final Long qnaId;
        try {
            qnaId = Long.parseLong(noStr.trim());
        } catch (NumberFormatException e) {
            writeJson(response, false, "QnA 번호 형식이 올바르지 않습니다.");
            return;
        }

        try {
            IAdminService service = AdminServiceImpl.getInstance();

            Map<String, Object> param = new HashMap<>();
            param.put("qnaId", qnaId);
            param.put("answerContent", content.trim());

            int cnt = service.updateQnaAnswer(param);

            if (cnt > 0) {
                writeJson(response, true, "답변이 저장되었습니다.");
            } else {
                writeJson(response, false, "저장할 QnA를 찾지 못했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            writeJson(response, false, "서버 오류로 답변 저장에 실패했습니다.");
        }
    }

    private void writeJson(HttpServletResponse response, boolean success, String message) throws IOException {
        PrintWriter out = response.getWriter();
        String safeMsg = message == null ? "" : message.replace("\\", "\\\\").replace("\"", "\\\"");
        out.print("{\"success\":" + success + ",\"message\":\"" + safeMsg + "\"}");
        out.flush();
    }
}
