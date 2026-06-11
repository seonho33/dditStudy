package kr.or.ddit.store.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.store.dao.CouponhamDAOImpl;
import kr.or.ddit.store.dao.ICouponhamDAO;
import kr.or.ddit.store.vo.CouponhamVO;

/**
 * 쿠폰함 Service 구현체
 * 
 * [설계 패턴]
 * - Singleton Pattern
 * - DAO Delegation Pattern
 * 
 * [비즈니스 로직 책임]
 * 1. 입력 데이터 검증
 * 2. 권한 확인 (본인 쿠폰인지)
 * 3. 상태 검증 (만료, 사용 여부)
 * 4. 예외 처리 및 로깅
 */
public class CouponhamServiceImpl implements ICouponhamService {
    
    /* ====================================
       Singleton & DAO 인스턴스
       ==================================== */
    private static CouponhamServiceImpl instance = new CouponhamServiceImpl();
    private ICouponhamDAO dao;
    
    private CouponhamServiceImpl() {
        // DAO 인스턴스 주입
        this.dao = CouponhamDAOImpl.getInstance();
    }
    
    public static CouponhamServiceImpl getInstance() {
        return instance;
    }
    
    
    /* ====================================
       조회 메서드
       ==================================== */
    
    @Override
    public List<CouponhamVO> getAvailableCoupons(String userId) throws Exception {
        // [입력 검증]
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        return dao.selectAvailableCoupons(userId);
    }
    
    @Override
    public List<CouponhamVO> getAllCouponsByUser(String userId) throws Exception {
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        return dao.selectAllCouponsByUser(userId);
    }
    
    @Override
    public CouponhamVO getCouponById(Long couponBoxId) throws Exception {
        if(couponBoxId == null || couponBoxId <= 0) {
            throw new IllegalArgumentException("쿠폰 ID가 유효하지 않습니다.");
        }
        
        return dao.selectCouponById(couponBoxId);
    }
    
    @Override
    public int getCouponCount(String userId) throws Exception {
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        return dao.getCouponCount(userId);
    }
    
    
    /* ====================================
       쿠폰 사용 (비즈니스 로직)
       ==================================== */
    
    @Override
 // [수정] 파라미터에 inputStoreId 추가
 public boolean useCoupon(Long couponBoxId, String userId, String inputStoreId) throws Exception {
     
     // [1] 입력 검증
     if(couponBoxId == null || couponBoxId <= 0) {
         throw new IllegalArgumentException("쿠폰 ID가 유효하지 않습니다.");
     }
     if(userId == null || userId.trim().isEmpty()) {
         throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
     }
     // [추가] 입력받은 가게 아이디 검증
     if(inputStoreId == null || inputStoreId.trim().isEmpty()) {
         throw new IllegalArgumentException("가게 아이디를 입력해야 합니다.");
     }
     
     // [2] 쿠폰 존재 여부 확인
     CouponhamVO coupon = dao.selectCouponById(couponBoxId);
     if(coupon == null) {
         throw new IllegalStateException("존재하지 않는 쿠폰입니다.");
     }
     
     // [3] 본인 쿠폰인지 확인 (기존 동일)
     if(!userId.equals(coupon.getUserId())) {
         throw new IllegalStateException("본인의 쿠폰만 사용할 수 있습니다.");
     }
     
     // [추가] 입력한 가게 ID와 쿠폰의 실제 가게 ID가 일치하는지 확인
     // VO에 getStoreId() 메서드가 있다고 가정합니다. (없으면 컬럼 추가 필요)
     if(!inputStoreId.equals(coupon.getStoreId())) {
         throw new IllegalStateException("해당 매장에서 사용할 수 없는 쿠폰입니다.");
     }
     
     // [4] 이미 사용된 쿠폰인지 확인 (기존 동일)
     if("Y".equals(coupon.getUseYn())) {
         throw new IllegalStateException("이미 사용된 쿠폰입니다.");
     }
     
     // [5] 쿠폰 만료 여부 확인 (기존 동일)
     Date now = new Date();
     if(coupon.getExpiredDate() != null && coupon.getExpiredDate().before(now)) {
         throw new IllegalStateException("만료된 쿠폰입니다.");
     }
     
     // [6] 쿠폰 상태 확인 (기존 동일)
     if("N".equals(coupon.getCouponStatus())) {
         throw new IllegalStateException("비활성화된 쿠폰입니다.");
     }
     
     // [7] 모든 검증 통과 → 사용 처리
  // ⚠️ 중요: 파라미터를 Map에 담아서 쿼리가 요구하는 3개의 값을 다 전달해야 함!
     Map<String, Object> paramMap = new HashMap<>();
     paramMap.put("couponBoxId", couponBoxId);
     paramMap.put("userId", userId);
     paramMap.put("inputStoreId", inputStoreId);

     // 이제 인터페이스를 고쳤기 때문에 여기서 에러가 안 납니다!
     int result = dao.useCoupon(paramMap); 
     return result > 0;
 }
    
    
    /* ====================================
       쿠폰 삭제 (비즈니스 로직)
       ==================================== */
    
    @Override
    public boolean deleteCoupon(Long couponBoxId, String userId) throws Exception {
        // [1] 입력 검증
        if(couponBoxId == null || couponBoxId <= 0) {
            throw new IllegalArgumentException("쿠폰 ID가 유효하지 않습니다.");
        }
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        // [2] 쿠폰 존재 여부 확인
        CouponhamVO coupon = dao.selectCouponById(couponBoxId);
        if(coupon == null) {
            throw new IllegalStateException("존재하지 않는 쿠폰입니다.");
        }
        
        // [3] 본인 쿠폰인지 확인
        if(!userId.equals(coupon.getUserId())) {
            throw new IllegalStateException("본인의 쿠폰만 삭제할 수 있습니다.");
        }
        
        // [5] 모든 검증 통과 → 삭제 처리
        int result = dao.deleteCoupon(couponBoxId);
        return result > 0;
    }
    
    
    /* ====================================
       쿠폰 발급 (비즈니스 로직)
       ==================================== */
    
    @Override
    public boolean issueCoupon(String userId, Long couponId) throws Exception {
        // [1] 입력 검증
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        if(couponId == null || couponId <= 0) {
            throw new IllegalArgumentException("쿠폰 ID가 유효하지 않습니다.");
        }
        
        // [2] 중복 발급 방지
        int issued = dao.checkCouponIssued(userId, couponId);
        if(issued > 0) {
            throw new IllegalStateException("이미 발급받은 쿠폰입니다.");
        }
        
        // [3] 쿠폰 발급
        CouponhamVO couponham = new CouponhamVO();
        couponham.setUserId(userId);
        couponham.setCouponId(couponId);
        couponham.setUseYn("N");  // 미사용 상태
        
        int result = dao.insertCoupon(couponham);
        return result > 0;
    }
}