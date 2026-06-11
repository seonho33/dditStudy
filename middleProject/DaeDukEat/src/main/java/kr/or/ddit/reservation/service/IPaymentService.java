package kr.or.ddit.reservation.service;

import kr.or.ddit.reservation.vo.PaymentVO;

/**
 * [PAYMENT Service Interface]
 * 
 * @author Senior Architect
 */
public interface IPaymentService {
    
    /**
     * [CREATE] 결제 정보 등록
     * 
     * @param payment - 결제 정보 VO
     * @return int - 성공 여부 (1 = 성공)
     */
    int registerPayment(PaymentVO payment) throws Exception;
    
    /**
     * [READ] 예약 ID로 결제 정보 조회
     * 
     * @param reservId - 예약 ID
     * @return PaymentVO
     */
    PaymentVO getPaymentByReservId(Long reservId) throws Exception;
}