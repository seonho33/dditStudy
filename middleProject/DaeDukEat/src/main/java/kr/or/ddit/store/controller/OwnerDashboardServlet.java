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
import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.store.vo.OwnerStatsVO;
import kr.or.ddit.store.vo.ReservationVO; // ✅ 너희 경로 맞춰
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/owner/dashboard.do")
public class OwnerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private IOwnerService service = OwnerServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("### OwnerDashboardServlet HIT ###");

        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");

        if (uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        String userRole = uvo.getDivision();
        if (!"점주".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "사장님 권한이 없습니다.");
            return;
        }

        StoreVO loginStore = (StoreVO) session.getAttribute("loginStore");
        String storeId = (loginStore != null ? loginStore.getStoreId() : null);

        if (storeId == null || storeId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "세션에 매장 정보(loginStore)가 없습니다.");
            return;
        }

        String userId = uvo.getUserId();

        try {
            OwnerStatsVO stats = service.getOwnerStatsByStoreId(storeId);
            OwnerProfileVO profile = service.getOwnerProfile(userId);

         // ✅ 오늘 예약 리스트
            List<ReservationVO> todayReservList = service.getTodayReservationsByStoreId(storeId);

            // ✅ 오늘 "승인대기"만 필터 (VO 필드명은 너희꺼에 맞춰 수정)
            List<ReservationVO> todayPendingList = todayReservList.stream()
            	    .filter(r -> r.getReservStatus() != null && "대기".equals(r.getReservStatus()))
            	    .collect(Collectors.toList());
            
         // ✅ dashboard 맵에 추가
            Map<String, Object> dashboard = new HashMap<>();
            dashboard.put("todayReservList", todayReservList);
            dashboard.put("todayPendingList", todayPendingList);

            // ✅ JSP에서 바로 쓰기 쉽게도 올려주기(추천)
            request.setAttribute("todayReservList", todayReservList);
            request.setAttribute("todayPendingList", todayPendingList);

            // 기존 setAttribute 유지
            request.setAttribute("stats", stats);
            request.setAttribute("profile", profile);
            request.setAttribute("dashboard", dashboard);
            request.setAttribute("userRole", userRole);

            request.getRequestDispatcher("/TEST/views/store/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "대시보드 로드 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
