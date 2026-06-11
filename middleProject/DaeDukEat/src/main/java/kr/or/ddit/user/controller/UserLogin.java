
package kr.or.ddit.user.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.UserServiceImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

/*
	유저정보 섹션넣는거에 loginMember와 loginStore 섹션 추가했습니다
	
*/

/**
 * Servlet implementation class UserLogin
 */
@WebServlet("/login.do")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * 로그인
     */
    public UserLogin() {
        super();
    }
    

    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/TEST/views/user/login.jsp");
		
		//request.getRequestDispatcher("/TEST/views/user/login.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 1. 한글 인코딩
        request.setCharacterEncoding("UTF-8");
        
        // 2. 로그인 폼 데이터 받기
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String type = request.getParameter("type").trim();     // 로그인 타입 (user 또는 seller)
  
        
        // ✅ 디버깅: 입력값 확인
//        System.out.println("=== 로그인 시도 ===");
//        System.out.println("ID: " + id);
//        System.out.println("PW: " + pw);
//        System.out.println("TYPE: " + type);
        
        
        // 3. VO에 담기
        UserVO vo = new UserVO();
        vo.setUserId(id);
        vo.setPassword(pw);

        // 4. DB에서 사용자 정보 조회
        IUserService service = UserServiceImpl.getService();
        UserVO loginUser = service.loginUser(vo);
        System.out.println("vo ===" +vo);
        
        
     // ==============================
     // 로그인 실패 / 탈퇴회원 체크
     // ==============================

     if (loginUser == null) {
         // ❌ 아이디 또는 비밀번호 틀림 → 화면 메시지
         request.setAttribute("error", "아이디 또는 비밀번호가 틀렸습니다.");
         request.getRequestDispatcher("/TEST/views/user/login.jsp").forward(request, response);
         return;
     }

     // ❌ 탈퇴 회원 체크
     if ("N".equals(loginUser.getUseYn())) {
         // → alert 전용 메시지
         request.setAttribute("alertError", "탈퇴한 회원입니다. 로그인이 불가합니다.");
         request.getRequestDispatcher("/TEST/views/user/login.jsp").forward(request, response);
         return;
     }
  
        
        // 6. 회원 구분(DIVISION) 확인
        String division = loginUser.getDivision().trim();  // DB에서 가져온 회원 구분
        
        
        // 7. 로그인 타입과 회원 구분이 일치하는지 검사
        boolean isValid = false;
        
	     // ✅ 관리자면 무조건 허용
	        if ("관리자".equals(division)) {
	            isValid = true;
	
	        } else if ("user".equals(type)) {
	            // 일반회원 로그인
	            if ("일반회원".equals(division)) {
	                isValid = true;
	            }
	
	        } else if ("seller".equals(type)) {
	            // 판매자 로그인
	            if ("점주".equals(division)) {
	                isValid = true;
	            }
	        }
        
        System.out.println("type === " +type);
        
        
        
        // 8. 검증 결과에 따른 처리
        if (isValid) {
            HttpSession session = request.getSession();

            // ✅ 공통 사용자 정보
            session.setAttribute("loginUser", loginUser);

            // ✅ 일반회원
            if ("일반회원".equals(division)) {

                MemberVO loginMember = service.selectMemberByUserId(loginUser.getUserId());
                session.setAttribute("loginMember", loginMember);

                // 혹시 남아있을 수 있는 점주 정보 제거
                session.removeAttribute("loginStore");

                System.out.println("loginMember ===== " + loginMember);

            // ✅ 점주
            } else if ("점주".equals(division)) {

                StoreVO loginStore = service.getStoreByUserId(loginUser.getUserId());
                session.setAttribute("loginStore", loginStore);

                // 일반회원 정보 제거
                session.removeAttribute("loginMember");

                System.out.println("loginStore ===== " + loginStore);

            // ✅ 관리자
            } else if ("관리자".equals(division)) {

                session.removeAttribute("loginStore");
                session.removeAttribute("loginMember");
                session.setAttribute("loginAdmin", loginUser);
            }

            response.sendRedirect(request.getContextPath() + "/main.do");
        } else {
            // ❌ 회원 구분이 맞지 않는 경우
            String errorMsg = "";
            if ("user".equals(type)) {
                errorMsg = "일반회원 계정이 아닙니다. 판매자 로그인을 이용해주세요.";
            } else {
                errorMsg = "판매자 계정이 아닙니다. 일반회원 로그인을 이용해주세요.";
            }
        
//            request.getSession().setAttribute("error", errorMsg);
//            response.sendRedirect(request.getContextPath() + "/TEST/views/user/login.jsp");
            
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("/TEST/views/user/login.jsp").forward(request, response);
        }
        


    }

}
