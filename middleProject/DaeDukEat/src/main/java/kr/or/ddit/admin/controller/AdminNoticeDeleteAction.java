package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.user.vo.UserVO; // ✅ 너 프로젝트 경로에 맞게 수정

@WebServlet("/DeleteNotice.do")
public class AdminNoticeDeleteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IAdminService service = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DeleteNotice] doGet 진입");

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String noStr = request.getParameter("no"); // ✅ JS에서 ?no= 로 보냄
        if (noStr == null || noStr.trim().isEmpty()) {
            writeJson(response, false, "공지번호(no)가 없습니다.");
            return;
        }

        int noticeNo;
        try {
            noticeNo = Integer.parseInt(noStr.trim());
        } catch (NumberFormatException e) {
            writeJson(response, false, "공지번호(no)가 올바르지 않습니다.");
            return;
        }

        // (선택) 관리자만 삭제 허용
        // 테스트 중이면 주석 처리 가능
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object obj = session.getAttribute("loginUser");
            if (obj instanceof UserVO) {
                UserVO loginUser = (UserVO) obj;
                String division = loginUser.getDivision();
                if (division != null && !division.equals("관리자")) {
                    writeJson(response, false, "관리자만 삭제할 수 있습니다.");
                    return;
                }
            }
        }

        Map<String, Object> param = new HashMap<>();
        param.put("noticeNo", noticeNo);

        try {
            int cnt = service.deleteNotice(param); // ✅ 서비스/DAO/mapper 만들어야 함
            if (cnt > 0) writeJson(response, true, "삭제 완료!");
            else writeJson(response, false, "삭제 실패(대상 없음)");
        } catch (Exception e) {
            e.printStackTrace();
            writeJson(response, false, "DB 오류");
        }
    }

    // =========================
    // 유틸
    // =========================
    private void writeJson(HttpServletResponse response, boolean success, String message) throws IOException {
        String json = "{\"success\":" + success + ",\"message\":\"" + escapeJson(message) + "\"}";
        response.getWriter().write(json);
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
