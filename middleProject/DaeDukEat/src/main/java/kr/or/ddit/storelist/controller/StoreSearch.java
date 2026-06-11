package kr.or.ddit.storelist.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.storelist.service.StoreSearchService;
import kr.or.ddit.storelist.service.StoreSearchServiceImpl;



@WebServlet("/storeSearch.do")
public class StoreSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	req.setCharacterEncoding("UTF-8");
    	
        StoreSearchService service = StoreSearchServiceImpl.getInstance();      
        List<StoreVO> storeList = null;
    	
    	 // 1️ 파라미터 받기
        String tag = req.getParameter("tag");
        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");
        String sort = req.getParameter("sort");  // ✅ 정렬 기준 추가
        //String review = req.getParameter("review"); 
        
        // ✅ sort가 없으면 기본값 'dibs' (찜많은순)
        if (sort == null || sort.isEmpty()) {
            sort = "dibs";
        }
        
        // ✅ 디버깅용
        System.out.println("🔍 받은 tag: " + tag);
        System.out.println("🔍 받은 keyword: " + keyword);
        System.out.println("🔍 받은 category: " + category);
        System.out.println("🔍 받은 sort: " + sort); 
        
        // 2️ 키워드 → 태그 변환 로직
        if (tag == null && keyword != null) {
            if (keyword.contains("떡볶이") || keyword.contains("떡")) {
                tag = "떡볶이";
            } else if (keyword.contains("면") || keyword.contains("라면")) {
                tag = "면";
            } else if (keyword.contains("밥")) {
                tag = "밥";
            } else if (keyword.contains("해장")) {
                tag = "해장";
            }
        }

        
        // 3️ 우선순위: tag > keyword > category
        if (tag != null && !tag.isEmpty()) {
            // MD 추천 검색
            storeList = service.getStoreSearch(tag, null, sort);
        } else if (keyword != null && !keyword.isEmpty()) {
            // 키워드 검색
            storeList = service.getStoreSearch(null, keyword, sort);
        } else if (category != null && !category.isEmpty()) {
            // 카테고리 검색
            storeList = service.getStoreListByCategory(category, sort);
        } else {
            // 전체 조회
            storeList = service.getAllStoreList(sort);
        }
        
        // 4️ JSP로 전달
        req.setAttribute("storeList", storeList);
        req.setAttribute("tag", tag);
        req.setAttribute("keyword", keyword);
        req.setAttribute("category", category);
        req.setAttribute("sort", sort); 
        
//        // StoreSearch controller에서 storeList를 조회 후
//        for (UserReviewVO rs : reviewStore) {
//            String latestReview = service.reviewByStore(rs.getReview());
//            rs.setReview(latestReview);
//        }
        
        if (storeList != null) {
            for (StoreVO s : storeList) {
                System.out.println("STORE=" + s.getStoreName()
                    + " / id=" + s.getStoreId()
                    + " / picture=" + s.getStorePicture());
            }
        }

        
        req.getRequestDispatcher("/TEST/views/store/storeList.jsp")
           .forward(req, resp);
    
     
    }
    

}



