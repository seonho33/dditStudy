package kr.or.ddit.storelist.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.store.vo.UserLikesDidsVO;
import kr.or.ddit.storelist.service.StoreSearchService;
import kr.or.ddit.storelist.service.UserLikesDidsService;
import kr.or.ddit.storelist.service.UserLikesDidsServiceImpl;
import kr.or.ddit.user.vo.MemberVO;

@WebServlet("/userLikeDids.do")
public class UserLikesDids extends HttpServlet {

    private UserLikesDidsService service = new UserLikesDidsServiceImpl();
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

//        String type = req.getParameter("type"); // like / dibs
//        String storeId = req.getParameter("storeId");
//        String userId = ((MemberVO)req.getSession().getAttribute("loginUser")).getUserId();
//
//        UserLikesDidsVO vo = new UserLikesDidsVO();
//        vo.setUserId(userId);
//        vo.setStoreId(storeId);
//
//        int cnt = 0;
//
//        if ("like".equals(type)) {
//        	cnt = service.like(vo);
//        } else if ("dibs".equals(type)) {
//        	cnt = service.dibs(vo);
//        }
//
//        resp.setContentType("application/json");
//        resp.getWriter().write("{\"cnt\":" + cnt + "}");
    	
    	// ========================================
        // 1️⃣ 파라미터 및 세션 정보 가져오기
        // ========================================
        String type = req.getParameter("type");       // "like" 또는 "dibs"
        String storeId = req.getParameter("storeId"); // 가게 ID
        
        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession();
        MemberVO loginUser = (MemberVO) session.getAttribute("loginMember");
        
        // ========================================
        // 2️⃣ 로그인 체크
        // ========================================
        if (loginUser == null) {
            // 로그인하지 않은 경우 에러 응답
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"result\": 0, \"message\": \"로그인이 필요합니다.\"}");
            return;
        }
        
        String userId = loginUser.getUserId();
        
        // ========================================
        // 3️⃣ VO 객체 생성 및 데이터 세팅
        // ========================================
        UserLikesDidsVO vo = new UserLikesDidsVO();
        vo.setUserId(userId);
        vo.setStoreId(storeId);
        
        int result = 0;
        
        // ========================================
        // 4️⃣ type에 따라 좋아요 or 찜 처리
        // ✅ 핵심: Service의 like/dibs 메서드가
        //    INSERT/DELETE + LIKES_COUNT/DIBS_COUNT 업데이트를 모두 처리
        // ========================================
        try {
            if ("like".equals(type)) {
                // 좋아요 토글 (INSERT or DELETE)
                // + STORE.LIKES_COUNT 자동 업데이트
                result = service.like(vo);
                
            } else if ("dibs".equals(type)) {
                // 찜 토글 (INSERT or DELETE)
                // + STORE.DIBS_COUNT 자동 업데이트
                result = service.dibs(vo);
                
            } else {
                // type이 잘못된 경우
                resp.setContentType("application/json; charset=UTF-8");
                resp.getWriter().write("{\"result\": 0, \"message\": \"잘못된 요청입니다.\"}");
                return;
            }
            
            // ========================================
            // 5️⃣ 성공 응답 반환
            // ✅ JavaScript에서 data.result로 받을 수 있도록 수정
            // ========================================
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"result\": " + result + ", \"message\": \"성공\"}");
            
        } catch (Exception e) {
            // ========================================
            // 6️⃣ 에러 처리
            // ========================================
            e.printStackTrace();
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"result\": 0, \"message\": \"처리 중 오류가 발생했습니다.\"}");
        }
    	
    }
}
