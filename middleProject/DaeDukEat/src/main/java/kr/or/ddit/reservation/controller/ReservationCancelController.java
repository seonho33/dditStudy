package kr.or.ddit.reservation.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/reservation/cancel.do")
public class ReservationCancelController extends HttpServlet {

    private final IReservationService service = ReservationServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession(false);
        UserVO uvo = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
        if (uvo == null) {
            response.setStatus(401);
            response.getWriter().print("{\"success\":false,\"message\":\"로그인이 필요합니다.\"}");
            return;
        }

        long reservId = Long.parseLong(request.getParameter("reservId"));

        boolean ok = service.cancelReservationAndPayment(reservId, uvo.getUserId());
        if (ok) response.getWriter().print("{\"success\":true}");
        else    response.getWriter().print("{\"success\":false,\"message\":\"취소 불가 상태이거나 권한이 없습니다.\"}");
    }

}
