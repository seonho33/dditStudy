package kr.or.ddit.store.detail.service;

import java.text.SimpleDateFormat;
import java.util.*;

import kr.or.ddit.store.detail.dao.IStoreDetailDAO;
import kr.or.ddit.store.detail.dao.StoreDetailDAOImpl;
import kr.or.ddit.store.detail.vo.StoreDetailVO;

/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * Store Detail Service 구현체
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */
public class StoreDetailServiceImpl implements IStoreDetailService {
    
    private static StoreDetailServiceImpl instance = new StoreDetailServiceImpl();
    private StoreDetailServiceImpl() {}
    public static StoreDetailServiceImpl getInstance() { return instance; }
    
    private IStoreDetailDAO dao = StoreDetailDAOImpl.getInstance();
    
    @Override
    public StoreDetailVO getStoreWithAllData(String storeId, String userId) throws Exception {
        
        // ━━━━━━━ 1. 가게 기본 정보 ━━━━━━━
        StoreDetailVO store = dao.selectStoreById(storeId);
        
        if (store == null) {
            throw new Exception("존재하지 않거나 승인되지 않은 가게입니다.");
        }
        
        // ━━━━━━━ 2. 연관 데이터 조회 ━━━━━━━
		/* store.setStorePictures(dao.selectStorePictures(storeId)); */
        store.setMenuList(dao.selectMenuList(storeId));
        store.setReviewList(dao.selectReviewsWithCeoReply(storeId));
        store.setStoreHolidays(dao.selectStoreHolidays(storeId));
        
        // ━━━━━━━ 3. 사용자별 좋아요/찜 상태 ━━━━━━━
        if (userId != null && !userId.trim().isEmpty()) {
            int likeCount = dao.checkUserLike(userId, storeId);
            int bookmarkCount = dao.checkUserBookmark(userId, storeId);
            
            store.setLiked(likeCount > 0);
            store.setBookmarked(bookmarkCount > 0);
        } else {
            store.setLiked(false);
            store.setBookmarked(false);
        }
        
        return store;
    }
    
    @Override
    public List<String> getAvailableTimes(String storeId, String date) throws Exception {
        /**
         * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         * 예약 가능 시간 계산
         * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         * 1. 영업시간 파싱 (예: "11:00~22:00")
         * 2. 30분 단위 슬롯 생성
         * 3. 기존 예약 제외
         * 4. 당일 예약 시 과거 시간 제외
         * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         */
        
        List<String> availableTimes = new ArrayList<>();
        
        // ━━━━━━━ Step 1: 영업시간 조회 ━━━━━━━
        StoreDetailVO store = dao.selectStoreById(storeId);
        String operationHours = store.getOperationHours();
        
        if (operationHours == null || !operationHours.contains("~")) {
            return availableTimes;
        }
        
        String[] hours = operationHours.split("~");
        String startTime = hours[0].trim();
        String endTime = hours[1].trim();
        
        // ━━━━━━━ Step 2: 30분 단위 시간대 생성 ━━━━━━━
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        Calendar cal = Calendar.getInstance();
        
        try {
            cal.setTime(sdf.parse(startTime));
            Date endDate = sdf.parse(endTime);
            
            while (cal.getTime().before(endDate)) {
                String timeSlot = sdf.format(cal.getTime());
                availableTimes.add(timeSlot);
                cal.add(Calendar.MINUTE, 30);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return availableTimes;
        }
        
        // ━━━━━━━ Step 3: 기존 예약 시간 제외 ━━━━━━━
        List<String> bookedTimes = dao.getBookedTimes(storeId, date);
        availableTimes.removeAll(bookedTimes);
        
        // ━━━━━━━ Step 4: 당일 예약 시 과거 시간 제외 ━━━━━━━
        SimpleDateFormat dateSdf = new SimpleDateFormat("yyyy-MM-dd");
        String today = dateSdf.format(new Date());
        
        if (date.equals(today)) {
            Calendar now = Calendar.getInstance();
            now.add(Calendar.HOUR, 1); // 1시간 후부터 예약 가능
            String nowTime = sdf.format(now.getTime());
            
            availableTimes.removeIf(time -> time.compareTo(nowTime) < 0);
        }
        
        return availableTimes;
    }
    
    @Override
    public Map<String, Object> toggleAction(String userId, String storeId, 
                                           String type, String action) throws Exception {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if ("like".equals(type)) {
                if ("add".equals(action)) {
                    dao.insertUserLike(userId, storeId);
                    dao.updateUserLikeCount(storeId, 1);
                    result.put("message", "좋아요를 추가했습니다.");
                } else {
                    dao.deleteUserLike(userId, storeId);
                    dao.updateUserLikeCount(storeId, -1);
                    result.put("message", "좋아요를 취소했습니다.");
                }
            } else if ("bookmark".equals(type)) {
                if ("add".equals(action)) {
                    dao.insertDids(userId, storeId);
                    dao.updateDibsCount(storeId, 1);
                    result.put("message", "찜 목록에 추가했습니다.");
                } else {
                    dao.deleteDids(userId, storeId);
                    dao.updateDibsCount(storeId, -1);
                    result.put("message", "찜 목록에서 제거했습니다.");
                }
            }
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        
        return result;
    }
    
    
	
	
}