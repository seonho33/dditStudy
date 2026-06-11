package kr.or.ddit.admin.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.dao.BotDaoImpl;
import kr.or.ddit.admin.dao.IBotDao;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.common.util.MyBatisUtil;

public class BotServiceImpl implements IBotService {
	
	private static IBotService service;
    private IBotDao dao;

    private BotServiceImpl() {
        dao = BotDaoImpl.getInstance();
    }

    public static IBotService getInstance() {
        if (service == null) service = new BotServiceImpl();
        return service;
    }	

    
    
    
    @Override
    public List<BotVO> selectBotList() {
        return dao.selectBotList();
    }

	@Override
	public BotVO getBotByKeyword(String keyword) {
		return dao.selectBotByKeyword(keyword);
	}

	@Override
	public int insertBot(BotVO vo) {
	    return dao.insertBot(vo);
	}

	@Override
	public int deleteBot(int botId) {
	    return dao.deleteBot(botId);
	}
	
	@Override
	public int updateBot(BotVO vo) {
	    return dao.updateBot(vo);
	}
	
	@Override
	public String toggleActive(int botId) {
	    try (SqlSession session = MyBatisUtil.getSqlSession()) {
	        IBotDao dao = session.getMapper(IBotDao.class);

	        String now = dao.selectActiveYnById(botId);
	        if (now == null) return null; // 없는 botId

	        String next = "Y".equalsIgnoreCase(now) ? "N" : "Y";

	        java.util.Map<String, Object> p = new java.util.HashMap<>();
	        p.put("botId", botId);
	        p.put("activeYn", next);

	        int cnt = dao.updateActiveYn(p);
	        if (cnt > 0) {
	            session.commit();
	            return next;
	        }
	        session.rollback();
	        return null;
	    }
	}

	@Override
	public BotVO findBestMatch(String userInput) {
	    if (userInput == null) userInput = "";
	    String input = normalize(userInput);
	    if (input.isEmpty()) return null;

	    List<BotVO> list = dao.selectActiveBots();
	    if (list == null || list.isEmpty()) return null;

	    BotVO best = null;
	    int bestLen = -1;

	    for (BotVO b : list) {
	        String raw = b.getQuestionKeyword();
	        if (raw == null) continue;

	        // ✅ "햄버거, 치킨" -> ["햄버거","치킨"]
	        String[] parts = raw.split("[,|/\\s]+");

	        for (String p : parts) {
	            String k = normalize(p);
	            if (k.isEmpty()) continue;

	            // ✅ "치킨집" contains "치킨" => true
	            if (input.contains(k)) {
	                if (k.length() > bestLen) {
	                    bestLen = k.length();
	                    best = b;
	                }
	            }
	        }
	    }

	    // 포함 매칭 성공하면 바로 반환
	    if (best != null) return best;

	    // ✅ 포함 매칭이 없으면: 토큰 단위로 유사도 비교
	    int bestScore = Integer.MIN_VALUE;
	    for (BotVO b : list) {
	        String raw = b.getQuestionKeyword();
	        if (raw == null) continue;

	        String[] parts = raw.split("[,|/\\s]+");

	        for (String p : parts) {
	            String k = normalize(p);
	            if (k.isEmpty()) continue;

	            int score = similarityScore(input, k);
	            if (score > bestScore) {
	                bestScore = score;
	                best = b;
	            }
	        }
	    }

	    if (bestScore < 30) return null;
	    return best;
	}

	private String normalize(String s) {
	    if (s == null) return "";
	    s = s.trim().toLowerCase();
	    return s.replaceAll("[^가-힣0-9a-z]", "");
	}


	/**
	 * 유사도 점수: (100 - 편집거리비율*100) + 키워드 길이 가중치
	 */
	private int similarityScore(String input, String keyword) {
	    int dist = levenshtein(input, keyword);
	    int max = Math.max(input.length(), keyword.length());
	    if (max == 0) return 0;

	    int base = 100 - (dist * 100 / max);  // 0~100
	    return base + Math.min(keyword.length(), 10); // 길이 가중치
	}

	private int levenshtein(String a, String b) {
	    int n = a.length(), m = b.length();
	    int[][] dp = new int[n + 1][m + 1];

	    for (int i = 0; i <= n; i++) dp[i][0] = i;
	    for (int j = 0; j <= m; j++) dp[0][j] = j;

	    for (int i = 1; i <= n; i++) {
	        char ca = a.charAt(i - 1);
	        for (int j = 1; j <= m; j++) {
	            char cb = b.charAt(j - 1);
	            int cost = (ca == cb) ? 0 : 1;

	            dp[i][j] = Math.min(
	                Math.min(dp[i - 1][j] + 1, dp[i][j - 1] + 1),
	                dp[i - 1][j - 1] + cost
	            );
	        }
	    }
	    return dp[n][m];
	}

	@Override
	public List<Map<String, Object>> searchTop3(String categoryName, String keyword) {
	    if (keyword == null || keyword.trim().isEmpty()) return Collections.emptyList();

	    // 1) 카테고리 기반(한식/중식 등) 추천
	    List<Map<String, Object>> result = Collections.emptyList();

	    if (categoryName != null) {
	        if ("식당검색".equals(categoryName)) {
	            result = dao.searchStoreTop3(keyword);
	        } else if ("메뉴검색".equals(categoryName)) {
	            result = dao.searchMenuTop3(keyword);
	        } else {
	            // ✅ categoryName이 한식/중식 같은 “음식 카테고리”인 경우
	            result = dao.searchStoreByCategoryTop3(categoryName); // (네가 이미 만들었던 카테고리 top3)
	        }
	    }

	    // 2) ✅ 결과가 없으면 메뉴명으로 가게 찾기 (김밥 같은 케이스)
	    if (result == null || result.isEmpty()) {
	        result = dao.searchStoreTop3ByMenuName(keyword);
	    }

	    return (result == null) ? Collections.emptyList() : result;
	}
	
	@Override
	public List<Map<String, Object>> searchTop3Mixed(String categoryName, String menuKeyword) {
	    // 1) 카테고리로 가게 TOP3
	    List<Map<String, Object>> byCategory = dao.searchStoreByCategoryTop3(categoryName);

	    // 2) 메뉴키워드로 가게 TOP3 (메뉴 조인 기반, store 중복 제거된 쿼리)
	    List<Map<String, Object>> byMenu = dao.searchStoreByMenuKeywordTop3(menuKeyword);

	    // 3) 합치기(중복 storeId 제거) + likes_count 내림차순 + 3개
	    java.util.LinkedHashMap<String, Map<String, Object>> merged = new java.util.LinkedHashMap<>();

	    java.util.List<Map<String, Object>> all = new java.util.ArrayList<>();
	    if (byCategory != null) all.addAll(byCategory);
	    if (byMenu != null) all.addAll(byMenu);

	    for (Map<String, Object> row : all) {
	        String storeId = str(row.get("STOREID")); // ✅ 너 콘솔 키가 STOREID였지
	        if (storeId.isEmpty()) continue;
	        if (!merged.containsKey(storeId)) merged.put(storeId, row);
	    }

	    java.util.List<Map<String, Object>> result = new java.util.ArrayList<>(merged.values());
	    result.sort((a, b) -> Integer.compare(intv(b.get("LIKESCOUNT")), intv(a.get("LIKESCOUNT"))));

	    return result.size() > 3 ? result.subList(0, 3) : result;
	}

	private String str(Object o){ return (o==null) ? "" : String.valueOf(o).trim(); }
	private int intv(Object o){
	    try { return Integer.parseInt(String.valueOf(o)); } catch(Exception e){ return 0; }
	}



}
