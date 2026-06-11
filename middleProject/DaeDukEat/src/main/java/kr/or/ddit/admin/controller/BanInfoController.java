package kr.or.ddit.admin.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/banInfo.do")
public class BanInfoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IAdminService service = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        // 관리자면 굳이 볼 필요 없으니 홈/관리로 보내도 됨
        if ("관리자".equals(loginUser.getDivision())) {
            response.sendRedirect(request.getContextPath() + "/admin/main.do");
            return;
        }

        AdminUserBanVO banInfo = service.selectBanInfo(loginUser.getUserId());
        request.setAttribute("banInfo", banInfo);

        // ✅ “전체 페이지 JSP”로 두는 게 안전(필터 리다이렉트 목적)
        request.getRequestDispatcher("/TEST/views/common/ban_info.jsp").forward(request, response);
    }
}
