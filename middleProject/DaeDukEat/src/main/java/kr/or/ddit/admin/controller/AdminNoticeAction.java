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

@WebServlet("/AdminNoticeAction.do")
public class AdminNoticeAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IAdminService service = AdminServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[AdminNoticeAction] doPost 진입");

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // 1) 파라미터 받기
        String title = request.getParameter("noticeTitle");
        String content = request.getParameter("noticeContent");

        if (isBlank(title) || isBlank(content)) {
            writeJson(response, false, "제목/내용을 입력해주세요.");
            return;
        }

        // 2) userId 결정 (세션 없으면 user999)
        String userId = "user999";

        HttpSession session = request.getSession(false);
        if (session != null) {
            Object obj = session.getAttribute("loginUser");
            if (obj instanceof UserVO) {
                UserVO loginUser = (UserVO) obj;

                // (선택) 관리자만 등록 허용
                // - 테스트 중이면 주석처리해도 됨
                String division = loginUser.getDivision();
                if (division != null && !division.equals("관리자")) {
                    writeJson(response, false, "관리자만 공지 등록이 가능합니다.");
                    return;
                }

                if (!isBlank(loginUser.getUserId())) {
                    userId = loginUser.getUserId();
                }
            }
        }

        // 3) 서비스로 넘길 param(Map)
        Map<String, Object> param = new HashMap<>();
        param.put("noticeTitle", title.trim());
        param.put("noticeContent", content.trim());
        param.put("userId", userId);

        // 4) insert 실행
        try {
            int cnt = service.insertNotice(param);
            if (cnt > 0) {
                writeJson(response, true, "등록 완료!");
            } else {
                writeJson(response, false, "등록 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            writeJson(response, false, "DB 오류");
        }
    }

    // =========================
    // 유틸
    // =========================
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

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
