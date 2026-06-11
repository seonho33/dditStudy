package kr.or.ddit.reservation.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.reservation.service.PaymentReservationServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.reservation.vo.PaymentVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.store.dao.IStoreDao;
import kr.or.ddit.store.dao.StoreDaoImpl;

@WebServlet("/reserveComplete.do")
public class ReserveComplete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            UserVO loginUser = (UserVO) session.getAttribute("loginUser");

            if (loginUser == null) {
                response.sendRedirect(request.getContextPath() + "/login.do");
                return;
            }

            String shopId = request.getParameter("shopId");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String count = request.getParameter("count");
            String impUid = request.getParameter("imp_uid");

            System.out.println("=== 예약 완료 파라미터 ===");
            System.out.println("shopId: " + shopId);
            System.out.println("date: " + date);
            System.out.println("time: " + time);
            System.out.println("count: " + count);
            System.out.println("impUid: " + impUid);

            if (shopId == null || date == null || time == null || count == null || impUid == null) {
                request.setAttribute("error", "필수 정보가 누락되었습니다.");
                request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
                return;
            }

            // Store 조회
            IStoreDao storeDao = StoreDaoImpl.getInstance();
            StoreVO store = storeDao.selectStoreById(shopId);

            if (store == null) {
                request.setAttribute("error", "존재하지 않는 가게입니다.");
                request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
                return;
            }

            // 예약 VO 세팅
            ReservationVO reservation = new ReservationVO();
            reservation.setStoreId(shopId);
            reservation.setUserId(loginUser.getUserId());
            reservation.setReservTime(date + " " + time);

            int guestCount = 2;
            if (count != null) {
                if (count.contains("단체")) {
                    guestCount = 10;
                } else {
                    String numStr = count.replaceAll("[^0-9]", "");
                    if (!numStr.isEmpty()) {
                        guestCount = Integer.parseInt(numStr);
                    }
                }
            }
            reservation.setGuestCount(guestCount);

            // 예약금/결제금액
            reservation.setAmount(store.getDeposit());

            // 결제 VO 세팅
            PaymentVO payment = new PaymentVO();
            payment.setPayMethod("카드");
            payment.setPayStatus("완료");
            payment.setImpUid(impUid);

            // ✅ 트랜잭션 처리 (예약+결제)
            Long reservId = PaymentReservationServiceImpl.getInstance()
                    .createReservationWithPayment(reservation, payment);

            // ✅ 핵심 추가: 슬롯 중복이면 null
            if (reservId == null) {
                // 이미 같은 시간에 예약이 존재
                request.setAttribute("error", "이미 예약이 존재하는 시간입니다. 다른 시간을 선택해주세요.");
                request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
                return;
            }

            System.out.println("✅ 예약 완료! reservId: " + reservId);

            request.setAttribute("reservation", reservation);
            request.setAttribute("store", store);
            request.setAttribute("reservId", reservId);

            request.getRequestDispatcher("/TEST/views/reservation/reserveSuccess.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "예약 처리 중 오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
