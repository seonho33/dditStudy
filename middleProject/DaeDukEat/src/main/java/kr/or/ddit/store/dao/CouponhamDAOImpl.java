package kr.or.ddit.store.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.CouponhamVO;

/**
 * 쿠폰함 DAO 구현체
 * 
 * [설계 패턴]
 * - Singleton Pattern (Thread-Safe)
 * - MyBatisUtil을 통한 SqlSession 관리
 * 
 * [트랜잭션 규칙]
 * - SELECT: Auto-commit (트랜잭션 불필요)
 * - INSERT/UPDATE/DELETE: 명시적 commit/rollback
 * 
 * [에러 처리]
 * - 모든 메서드에서 Exception throw
 * - Service 레이어에서 예외 처리 및 로깅
 */
public class CouponhamDAOImpl implements ICouponhamDAO {
    
    /* ====================================
       Singleton 인스턴스
       ==================================== */
    private static CouponhamDAOImpl instance = new CouponhamDAOImpl();
    
    private CouponhamDAOImpl() {
        // Private 생성자로 외부 인스턴스 생성 차단
    }
    
    public static CouponhamDAOImpl getInstance() {
        return instance;
    }
    
    
    /* ====================================
       조회 메서드 (SELECT)
       ==================================== */
    
    @Override
    public List<CouponhamVO> selectAvailableCoupons(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<CouponhamVO> list = null;
        
        try {
            // [Mapper 호출]
            // - namespace: couponham
            // - id: selectAvailableCoupons
            // - 파라미터: userId (String)
            list = session.selectList("couponham.selectAvailableCoupons", userId);
        } finally {
            // SELECT는 트랜잭션 불필요하므로 바로 close
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public List<CouponhamVO> selectAllCouponsByUser(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<CouponhamVO> list = null;
        
        try {
            list = session.selectList("couponham.selectAllCouponsByUser", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public CouponhamVO selectCouponById(Long couponBoxId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        CouponhamVO coupon = null;
        
        try {
            coupon = session.selectOne("couponham.selectCouponById", couponBoxId);
        } finally {
            if(session != null) session.close();
        }
        
        return coupon;
    }
    
    @Override
    public int getCouponCount(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            count = session.selectOne("couponham.getCouponCount", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    @Override
    public int checkCouponIssued(String userId, Long couponId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            // [Map 파라미터 사용]
            // - MyBatis는 다중 파라미터 시 Map 또는 VO 객체 사용
            Map<String, Object> params = new HashMap<>();
            params.put("userId", userId);
            params.put("couponId", couponId);
            
            count = session.selectOne("couponham.checkCouponIssued", params);
        } finally {
            if(session != null) session.close();
        }
        
        return count;
    }
    
    
    /* ====================================
       변경 메서드 (INSERT/UPDATE/DELETE)
       ==================================== */
    @Override
    public int useCoupon(Map<String, Object> paramMap) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // [중요] 파라미터로 couponBoxId 대신, 3개의 값이 담긴 paramMap을 통째로 넘깁니다!
            result = session.update("couponham.useCoupon", paramMap);
            
            // 성공 시 commit
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            // 실패 시 rollback
            if(session != null) session.rollback();
            throw e;  // 상위 레이어로 예외 전파 (Service에서 에러 메시지 처리 가능)
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deleteCoupon(Long couponBoxId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.delete("couponham.deleteCoupon", couponBoxId);
            
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int insertCoupon(CouponhamVO couponham) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // [INSERT 실행]
            // - selectKey로 시퀀스 자동 설정 (COUPONHAM_SEQ.NEXTVAL)
            // - couponham.couponBoxId에 자동 할당됨
            result = session.insert("couponham.insertCoupon", couponham);
            
            if(result > 0) {
                session.commit();
            }
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
}