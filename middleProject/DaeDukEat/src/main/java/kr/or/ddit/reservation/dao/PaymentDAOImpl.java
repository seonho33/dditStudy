package kr.or.ddit.reservation.dao;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.reservation.vo.PaymentVO;

/**
 * [PAYMENT DAO 구현체]
 * 
 * @author Senior Architect
 * @description 기존 프로젝트 구조에 맞춰 Singleton 제거
 */
public class PaymentDAOImpl implements IPaymentDAO {
    
    // ❌ Singleton 패턴 제거
    
    @Override
    public int insertPayment(PaymentVO payment) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int result = session.insert("kr.or.ddit.reservation.dao.IPaymentDAO.insertPayment", payment);
            session.commit();
            return result;
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    @Override
    public PaymentVO selectPaymentByReservId(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.reservation.dao.IPaymentDAO.selectPaymentByReservId", reservId);
        } finally {
            session.close();
        }
    }
}