package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.service.GsServiceImpl;
import kr.or.ddit.admin.service.IGSService;
import kr.or.ddit.admin.vo.GsVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/admin/gs25.do")
public class AdminGs25PageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IGSService service = GsServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ✅ 여기서부터 loginAdmin 기준
        UserVO admin = (session == null) ? null : (UserVO) session.getAttribute("loginUser");

        // 로그인/권한 없으면: alert + 로그인 페이지로 이동
        if (admin == null) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write(
                "<script>alert('로그인이 필요한 페이지입니다.');" +
                "location.href='" + request.getContextPath() + "/TEST/views/user/login.jsp';</script>"
            );
            return;
        }

        // ✅ userId 꺼내쓰기 (등록자/검증 등에 활용)
        String adminId = admin.getUserId();
        request.setAttribute("adminId", adminId); // JSP에서 필요하면 사용

        // 1) 목록 조회

        List<GsVO> gsList = service.selectAll(); // 아래에서 DAO/mapper 연결하면 됨

        request.setAttribute("gsList", gsList);

        // 2) 조각 JSP forward
        request.getRequestDispatcher("/TEST/views/admin/admin_gs25_product.jsp")
               .forward(request, response);
    }
}
