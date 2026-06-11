package kr.or.ddit.reservation.controller;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;


@WebServlet("/reservation/list.do")
public class ReservationListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");

        if (svo == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        boolean isFetch = "fetch".equalsIgnoreCase(request.getHeader("X-Requested-With"));

        
        try {
            IReservationService service = ReservationServiceImpl.getInstance();

            String storeId = svo.getStoreId();
            List<ReservationVO> reserveList = service.getReservationsByStore(storeId);

            // ⚠️ 상태값 통일: 너는 승인대기 쓰고 있으니 여기서도 승인대기 추천
            int waitingCount = service.countReservationsByStatus(storeId, "대기");

            request.setAttribute("reserveList", reserveList);
            request.setAttribute("waitingCount", waitingCount);

            // ✅ fetch면 조각 JSP로(대시보드 owner-content에 들어갈 내용)
            // ✅ fetch가 아니면 풀페이지로(원하면 같은 JSP 써도 됨)
            if (isFetch) {
                request.getRequestDispatcher("/TEST/views/store/reservationManagement.jsp")
                       .forward(request, response);
            } else {
                request.getRequestDispatcher("/TEST/views/store/reservationManagement.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "예약 목록 조회 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
}
