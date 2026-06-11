package kr.or.ddit.reservation.service;

import kr.or.ddit.reservation.dao.IPaymentDAO;
import kr.or.ddit.reservation.dao.PaymentDAOImpl;
import kr.or.ddit.reservation.vo.PaymentVO;

/**
 * [PAYMENT Service 구현체]
 * 
 * @author Senior Architect
 * @pattern Singleton (Service는 유지)
 */
public class PaymentServiceImpl implements IPaymentService {
    
    // ✅ 수정: getInstance() → new 생성자
    private IPaymentDAO dao = new PaymentDAOImpl();
    
    // ========================================
    // Singleton Pattern (Service는 유지)
    // ========================================
    private static PaymentServiceImpl instance = new PaymentServiceImpl();
    private PaymentServiceImpl() {}
    public static PaymentServiceImpl getInstance() {
        return instance;
    }
    
    @Override
    public int registerPayment(PaymentVO payment) throws Exception {
        return dao.insertPayment(payment);
    }
    
    @Override
    public PaymentVO getPaymentByReservId(Long reservId) throws Exception {
        return dao.selectPaymentByReservId(reservId);
    }
}
