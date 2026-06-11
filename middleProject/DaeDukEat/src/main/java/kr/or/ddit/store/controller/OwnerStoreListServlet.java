package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.service.IOwnerService;
import kr.or.ddit.store.service.OwnerServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/store/list.do")
public class OwnerStoreListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOwnerService service = OwnerServiceImpl.getInstance(); // ✅ 대시보드랑 동일 서비스 사용

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
        StoreVO loginStore = (session == null) ? null : (StoreVO) session.getAttribute("loginStore");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        if (!"점주".equals(loginUser.getDivision())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "사장님 권한이 없습니다.");
            return;
        }

        if (loginStore == null) {
            request.setAttribute("storeList", java.util.List.of());
            request.setAttribute("errorMsg", "등록된 가게 정보가 없습니다. (loginStore 세션이 null)");

            // ✅ JSP에서 dashboard를 참조하니, null 방지용으로라도 넣어두면 안전
            request.setAttribute("dashboard", Map.of("todayPendingList", java.util.List.of()));

        } else {
            request.setAttribute("storeList", java.util.List.of(loginStore));

            // =========================================
            // ✅ 여기 위치에 붙이면 됨 (핵심!)
            // =========================================
            String storeId = loginStore.getStoreId();

            List<ReservationVO> todayReservList = service.getTodayReservationsByStoreId(storeId);

            List<ReservationVO> todayPendingList = todayReservList.stream()
                    .filter(r -> r.getReservStatus() != null && "대기".equals(r.getReservStatus()))
                    .collect(Collectors.toList());

            Map<String, Object> dashboard = new HashMap<>();
            dashboard.put("todayReservList", todayReservList);
            dashboard.put("todayPendingList", todayPendingList);

            request.setAttribute("dashboard", dashboard);
            request.setAttribute("todayPendingList", todayPendingList); // (있어도 되고 없어도 됨)
        }

        // ✅ Ajax 판별은 XMLHttpRequest로 통일 (loadOwnerPage도 같이 바꿔야 함)
        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));

        if (isAjax) {
            request.getRequestDispatcher("/TEST/views/store/myStoreList.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/owner/dashboard.do");
        }
    }
}
