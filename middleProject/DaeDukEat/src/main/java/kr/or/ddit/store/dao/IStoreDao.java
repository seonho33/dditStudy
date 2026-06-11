package kr.or.ddit.store.dao;

import java.util.List;

import kr.or.ddit.store.vo.StoreGameVO;
import kr.or.ddit.store.vo.StoreVO;

public interface IStoreDao {

    // 기존 메서드들...
    public int insertStore(StoreVO store);
    public StoreVO selectStoreById(String storeId);
    public int withdrawStoreByUserId(String userId);
    public StoreVO selectStoreByUserId(String userId);

    // ✅ 신규 추가: 가게 정보 수정
    public int updateStore(StoreVO store);
    
    // ✅ 신규 추가: 가게 이미지 관리
    public int deleteStorePicture(String storeId);
    public int insertStorePicture(String storeId, String picturePath);
    public String selectStorePicture(String storeId);
   
    List<StoreGameVO> selectActiveStoresForGame() throws Exception;
}