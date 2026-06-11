package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.board.vo.NoticeVO;   // ✅ 여기 패키지 수정!

@WebServlet("/UpdateNotice.do")
public class UpdateNoticeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String noticeNoStr = request.getParameter("noticeNo");
        String title       = request.getParameter("noticeTitle");
        String content     = request.getParameter("noticeContent");

        if (noticeNoStr == null || noticeNoStr.isBlank() ||
            title == null || title.isBlank() ||
            content == null || content.isBlank()) {
            writeJson(response, false, "필수값이 누락되었습니다.");
            return;
        }

        final Long noticeNo;
        try {
            noticeNo = Long.parseLong(noticeNoStr.trim());
        } catch (NumberFormatException e) {
            writeJson(response, false, "공지 번호 형식이 올바르지 않습니다.");
            return;
        }

        try {
            IAdminService service = AdminServiceImpl.getInstance();

            NoticeVO vo = new NoticeVO();
            vo.setNoticeNo(noticeNo);          // ✅ Long
            vo.setNoticeTitle(title.trim());
            vo.setNoticeContent(content.trim());

            int cnt = service.updateNotice(vo);  // 너희 서비스 메서드 그대로 사용

            if (cnt > 0) {
                writeJson(response, true, "공지 수정이 완료되었습니다.");
            } else {
                writeJson(response, false, "수정할 공지를 찾지 못했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            writeJson(response, false, "서버 오류로 수정에 실패했습니다.");
        }
    }

    private void writeJson(HttpServletResponse response, boolean success, String message) throws IOException {
        PrintWriter out = response.getWriter();
        String safeMsg = message == null ? "" : message.replace("\\", "\\\\").replace("\"", "\\\"");
        out.print("{\"success\":" + success + ",\"message\":\"" + safeMsg + "\"}");
        out.flush();
    }
    
    
}
