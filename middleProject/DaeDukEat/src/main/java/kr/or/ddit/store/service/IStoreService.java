package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.vo.StoreGameVO;
import kr.or.ddit.store.vo.StoreVO;

public interface IStoreService {

    // 기존 메서드들...
    public int insertStore(StoreVO store);
    public StoreVO selectStoreById(String storeId);
    public int withdrawStoreByUserId(String userId);
    public StoreVO selectStoreByUserId(String userId);

    // ✅ 신규 추가: 가게 정보 수정
    public int updateStore(StoreVO store);
    
    // ✅ 신규 추가: 이미지 경로 조회
    public String getStorePicture(String storeId);
    
    // ✅ 신규 추가: 이미지 업로드 및 DB 저장
    public int saveStorePicture(String storeId, String picturePath);
    
    List<StoreGameVO> getActiveStoresForGame() throws Exception;
}