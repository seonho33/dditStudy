package kr.or.ddit.reservation.service;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.reservation.vo.PaymentVO;

public class PaymentReservationServiceImpl {

    private static PaymentReservationServiceImpl instance = new PaymentReservationServiceImpl();

    private PaymentReservationServiceImpl() {}

    public static PaymentReservationServiceImpl getInstance() {
        return instance;
    }

    /**
     * 예약 + 결제 정보 저장 (트랜잭션)
     * @return reservId (성공), null (동일 시간 예약 중복으로 실패)
     */
    public Long createReservationWithPayment(ReservationVO reservation, PaymentVO payment) throws Exception {
        SqlSession session = null;

        try {
            session = MyBatisUtil.getSqlSession();

            // 1) 예약 저장
            int result = session.insert(
                "kr.or.ddit.reservation.dao.IReservationDAO.insertReservation",
                reservation
            );

            if (result <= 0) {
                throw new Exception("예약 정보 저장 실패");
            }

            // 2) 결제에 reservId 세팅
            payment.setReservId(reservation.getReservId());

            // 3) 결제 저장
            result = session.insert(
                "kr.or.ddit.reservation.dao.IPaymentDAO.insertPayment",
                payment
            );

            if (result <= 0) {
                throw new Exception("결제 정보 저장 실패");
            }

            session.commit();
            return reservation.getReservId();

        } catch (Exception e) {

            // ✅ 핵심: 같은 시간 슬롯(대기/승인) 중복이면 "에러로 터뜨리지 말고" 실패로 처리
            String msg = String.valueOf(e.getMessage());
            if (msg.contains("ORA-00001") && msg.contains("IDX_RESERV_UNIQUE")) {
                if (session != null) session.rollback();
                return null; // 컨트롤러에서 "이미 예약된 시간" 안내
            }

            if (session != null) session.rollback();
            throw e;

        } finally {
            if (session != null) session.close();
        }
    }
}
