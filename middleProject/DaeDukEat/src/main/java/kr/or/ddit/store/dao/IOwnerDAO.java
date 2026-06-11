package kr.or.ddit.store.dao;

import java.util.List;

import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.store.vo.OwnerStatsVO;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * 사장님 전용 DAO Interface
 * - MyBatis Mapper와 1:1 매핑
 * - namespace: kr.or.ddit.owner.dao.IOwnerDAO
 * 
 * @author Senior Architect
 * @version 1.0
 */
public interface IOwnerDAO {
    
    /**
     * 사장님 대시보드 통계 조회
     * @param userId 사장님 ID (세션)
     * @return OwnerStatsVO 통계 데이터
     * @throws Exception DB 조회 실패
     */
    OwnerStatsVO selectOwnerStats(String userId) throws Exception;
    
    /**
     * 사장님 프로필 정보 조회
     * @param userId 사장님 ID
     * @return OwnerProfileVO 프로필 정보
     * @throws Exception DB 조회 실패
     */
    OwnerProfileVO selectOwnerProfile(String userId) throws Exception;
    
    /**
     * 가게 정보 수정
     * @param profile 수정할 프로필 정보
     * @return 수정된 행 수
     * @throws Exception DB 업데이트 실패
     */
    int updateStoreInfo(OwnerProfileVO profile) throws Exception;
    
    OwnerStatsVO selectOwnerStatsByStoreId(String storeId) throws Exception;
    
    List<ReservationVO> selectTodayReservListByStoreId(String storeId);


}