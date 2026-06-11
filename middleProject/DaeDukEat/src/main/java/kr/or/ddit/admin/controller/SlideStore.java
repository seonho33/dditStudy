package kr.or.ddit.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.ISlideStoreService;
import kr.or.ddit.admin.service.SlideStoreServiceImpl;
import kr.or.ddit.store.vo.StoreVO;

import java.io.IOException;
import java.util.List;

@WebServlet("/SlideStore.do")
public class SlideStore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ISlideStoreService slideService = SlideStoreServiceImpl.getInstance();
			
    public SlideStore() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	System.out.println("=====main.do 호출됨 =====");
		
		// ✅ 슬라이드 데이터 조회
		List<StoreVO> slideList = slideService.StoreSlide();
		
		System.out.println("📦 메인 Controller 슬라이드 데이터: " + 
				(slideList != null ? slideList.size() + "개" : "null"));
		
		request.setAttribute("slideList", slideList);
		
	
		
		System.out.println("main.jsp로 forward\n");
		
		request.getRequestDispatcher("/TEST/views/user/main.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

}