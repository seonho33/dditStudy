package kr.or.ddit.reservation.dao;

import kr.or.ddit.reservation.vo.PaymentVO;

/**
 * 결제 관리 DAO Interface
 * 
 * @author Senior Architect
 * @since 2025-01-26
 * @description 아임포트 결제 정보를 DB에 저장/조회하는 인터페이스.
 *              - namespace: kr.or.ddit.reservation.dao.IPaymentDAO
 */
public interface IPaymentDAO {
    
    /**
     * 결제 정보 INSERT
     * 
     * @param vo 결제 VO (payNo는 시퀀스로 자동 생성)
     * @return 삽입된 행 수 (1 = 성공, 0 = 실패)
     * @throws Exception DB 연결 또는 쿼리 오류
     */
    int insertPayment(PaymentVO vo) throws Exception;
    
    /**
     * 예약 ID로 결제 정보 조회
     * 
     * @param reservId 예약 ID
     * @return PaymentVO 객체 (없으면 null)
     * @throws Exception DB 연결 또는 쿼리 오류
     */
    PaymentVO selectPaymentByReservId(Long reservId) throws Exception;
}