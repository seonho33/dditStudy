package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.store.vo.OwnerStatsVO;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * 사장님 Service Interface
 * - 비즈니스 로직 처리
 * - Transaction 경계 설정
 * 
 * @author Senior Architect
 * @version 1.0
 */
public interface IOwnerService {
    
    /**
     * 사장님 대시보드 통계 조회
     * @param userId 사장님 ID
     * @return OwnerStatsVO
     * @throws Exception
     */
    OwnerStatsVO getOwnerStats(String userId) throws Exception;
    
    /**
     * 사장님 프로필 조회
     * @param userId 사장님 ID
     * @return OwnerProfileVO
     * @throws Exception
     */
    OwnerProfileVO getOwnerProfile(String userId) throws Exception;
    
    /**
     * 가게 정보 수정
     * @param profile 수정할 정보
     * @return 성공 여부
     * @throws Exception
     */
    boolean updateStoreInfo(OwnerProfileVO profile) throws Exception;
    
    OwnerStatsVO getOwnerStatsByStoreId(String storeId) throws Exception;

    
    List<ReservationVO> getTodayReservationsByStoreId(String storeId);

}