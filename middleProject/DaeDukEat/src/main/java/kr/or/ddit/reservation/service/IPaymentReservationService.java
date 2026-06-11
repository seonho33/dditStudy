package kr.or.ddit.reservation.service;

import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.reservation.vo.PaymentVO;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 결제 연동 예약 Service Interface
 */
public interface IPaymentReservationService {
    
    /**
     * 가게 정보 조회
     */
    StoreVO getStoreById(String storeId) throws Exception;
    
    /**
     * 예약 + 결제 정보 저장 (트랜잭션)
     */
    Long createReservationWithPayment(ReservationVO reservation, PaymentVO payment) throws Exception;
}