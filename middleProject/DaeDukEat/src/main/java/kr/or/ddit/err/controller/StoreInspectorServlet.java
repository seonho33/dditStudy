package kr.or.ddit.err.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.err.service.DeadukGameServiceImpl;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 맛집통행증검문소 게임 컨트롤러
 */
@WebServlet("/inspector/*")
public class StoreInspectorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DeadukGameServiceImpl storeService;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        storeService = DeadukGameServiceImpl.getInstance();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/game")) {
            // 게임 페이지 포워딩
        	request.getRequestDispatcher("/TEST/views/error/game.jsp")
            .forward(request, response);
        	return;
                
        } else if (pathInfo.equals("/random")) {
            // 랜덤 식당 데이터 JSON 응답
            getRandomStore(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.equals("/judge")) {
            // 판정 결과 저장
            saveJudgement(request, response);
        }
    }
    
    /**
     * 랜덤 식당 데이터 반환
     */
    private void getRandomStore(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json; charset=UTF-8");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");

        PrintWriter out = response.getWriter();

        try {
            StoreVO store = storeService.getRandomStore();

            if (store == null) {
                out.print(gson.toJson(createErrorResponse("등록된 식당이 없습니다.")));
                return;
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("data", convertToGameData(store));

            out.print(gson.toJson(responseData));
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(createErrorResponse("서버 오류가 발생했습니다.")));
            out.flush();
        }
    }


    /**
     * 판정 결과 저장
     */
    private void saveJudgement(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> requestData = gson.fromJson(sb.toString(), Map.class);

            String storeId = (String) requestData.get("storeId");
            String decision = (String) requestData.get("decision");

            Object isCorrectObj = requestData.get("isCorrect");
            boolean isCorrect = false;
            if (isCorrectObj instanceof Boolean) {
                isCorrect = (Boolean) isCorrectObj;
            } else if (isCorrectObj != null) {
                isCorrect = Boolean.parseBoolean(String.valueOf(isCorrectObj));
            }

            // TODO: 판정 이력 저장 로직 가능
            // inspectorService.saveJudgement(storeId, decision, isCorrect);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("message", "판정이 기록되었습니다.");

            out.print(gson.toJson(responseData));
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(createErrorResponse("판정 기록 중 오류가 발생했습니다.")));
            out.flush();
        }
    }

    
    private Map<String, Object> convertToGameData(StoreVO store) {
        Map<String, Object> gameData = new HashMap<>();

        double rating5 = normalizeToFiveScale(store.getRating());  // rating이 double이라고 가정

        String mainMenu = storeService.getMainMenuName(store.getStoreId());
        if (mainMenu == null || mainMenu.isBlank()) mainMenu = "대표메뉴";

        gameData.put("storeId", store.getStoreId());
        gameData.put("name", store.getStoreName());
        gameData.put("menu", mainMenu);
        gameData.put("rating", String.format("%.1f", rating5));
        gameData.put("owner", extractOwnerName(store.getUserId()));
        gameData.put("picture", buildImagePath(store.getStorePicture()));
        gameData.put("grade", calculateGradeFromFiveScale(rating5));
        gameData.put("isGood", rating5 >= 3.5);

        return gameData;
    }

    /**
     * DB rating 스케일 보정
     * - DB가 0~1이면: 0.5 -> 5.0
     * - DB가 0~5이면: 그대로
     * - DB가 0~50(=x10)이면: /10
     */
    private double normalizeToFiveScale(double raw) {
        if (Double.isNaN(raw) || raw < 0) return 0.0;

        double v;
        if (raw > 0 && raw <= 1) {
            v = raw * 10;      // 0.5 -> 5.0
        } else if (raw > 1 && raw <= 5) {
            v = raw;           // 이미 5점 스케일
        } else if (raw > 5) {
            v = raw / 10.0;    // 10배 스케일
        } else {
            v = 0.0;
        }

        // ✅ 0~5로 강제
        if (v > 5) v = 5;
        return v;
    }

    private String calculateGradeFromFiveScale(double rating5) {
        if (rating5 >= 4.5) return "A";
        if (rating5 >= 3.5) return "B";
        if (rating5 >= 2.5) return "C";
        return "D";
    }


    
    /**
     * 이미지 경로 생성
     * DB: "store1.jpg" → 반환: "/images/upload/store/store1.jpg"
     */
    private String buildImagePath(String fileName) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return null;
        }
        // 이미 전체 경로가 저장되어 있는 경우 처리
        if (fileName.startsWith("/") || fileName.startsWith("http")) {
            return fileName;
        }
        // 파일명만 있는 경우 전체 경로 생성
        return "/images/upload/store/" + fileName;
    }
    
    /**
     * 사용자 ID에서 이름 추출
     */
    private String extractOwnerName(String userId) {
        if (userId == null || userId.isEmpty()) {
            return "미상";
        }
        return userId;
    }
    
    /**
     * 에러 응답 생성
     */
    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", message);
        return response;
    }
}
