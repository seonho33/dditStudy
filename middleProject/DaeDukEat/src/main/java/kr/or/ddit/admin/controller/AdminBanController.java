package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.admin.vo.BanRequestVO;
import kr.or.ddit.common.util.GsonUtil;
import kr.or.ddit.common.util.ObjJson;

@WebServlet("/AdminBan.do")
public class AdminBanController extends HttpServlet {

    private final IAdminService service = AdminServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");

        try {
            BanRequestVO dto = ObjJson.fromJson(request, BanRequestVO.class);

            String action = dto.getAction();
            String userId = dto.getUserId();

            if (action == null || userId == null) {
                write(response, false, "action 또는 userId 누락");
                return;
            }

            boolean result = false;

            if ("BAN".equals(action)) {
                result = service.banUser(
                        userId,
                        dto.getReason(),
                        dto.getEndDate()
                );
            } 
            else if ("UNBAN".equals(action)) {
                result = service.unbanUser(userId);
            } 
            else {
                write(response, false, "잘못된 action 값");
                return;
            }

            write(response, result, result ? "처리 완료" : "처리 실패");

        } catch (Exception e) {
            e.printStackTrace();
            write(response, false, "서버 오류");
        }
    }

    private void write(HttpServletResponse response, boolean success, String msg)
            throws IOException {

        Map<String, Object> res = new HashMap<>();
        res.put("success", success);
        res.put("message", msg);

        response.getWriter().write(GsonUtil.gson.toJson(res));
    }
}
