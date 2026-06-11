package kr.or.ddit.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admin.service.IRouletteService;
import kr.or.ddit.admin.service.RouletteServiceImpl;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class StoreRoulette
 */
@WebServlet("/StoreRoulette.do")
public class StoreRoulette extends HttpServlet {
   private static final long serialVersionUID = 1L;
     
   private IRouletteService service;
   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreRoulette() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * 서블릿 초기화 - 싱글톤 service 인스턴스 가져오기
     */
    @Override
    public void init() throws ServletException {
       service = RouletteServiceImpl.getInstance();
    }
    
   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
      //세션에서 로그인 사용자 정보 가져오기
      HttpSession session = request.getSession();
      UserVO uvo = (UserVO) session.getAttribute("loginUser");
      
   /*   //로그인 체크
      if (uvo == null) {
         response.sendRedirect(request.getContextPath() + "/login.do");
         return;
      }             */
      
      //사용자 정보 추출
      String userId = null;
      String userRole = null;
      if(uvo != null) {
         userId = uvo.getUserId();
         userRole = uvo.getDivision();
      }
      
      //DB에서 모든 가게목록 조회
      List<StoreVO> storeList = service.getstoreRoulette();
      
      
      //request에 데이터 저장
      request.setAttribute("storeList", storeList);
      
      //사용자 정보도 JSP로 전달
      request.setAttribute("userId", userId);
      request.setAttribute("userRole", userRole);
      
      //JSP로 포워딩
      request.getRequestDispatcher("/TEST/views/admin/StoreRoulette.jsp").forward(request, response);
         
   
   }
   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}
