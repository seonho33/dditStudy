/*
 * package kr.or.ddit.store.controller;
 * 
 * import java.io.IOException;
 * 
 * import jakarta.servlet.ServletException; import
 * jakarta.servlet.annotation.WebServlet; import
 * jakarta.servlet.http.HttpServlet; import
 * jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * jakarta.servlet.http.HttpSession;
 * 
 *//**
	 * 일반회원 마이페이지 메인 컨트롤러 - URL: /mypage.do - 세션 검증 후 메인 페이지 표시
	 *//*
		 * @WebServlet("/mypage.do") public class MyPageMainController extends
		 * HttpServlet {
		 * 
		 * @Override protected void doGet(HttpServletRequest request,
		 * HttpServletResponse response) throws ServletException, IOException {
		 * 
		 * HttpSession session = request.getSession();
		 * 
		 * // ⚠️ 로그인 체크: 세션에 userId 확인 // 실제 로그인 구조에 따라 변수명 수정 필요 (예: loginUser,
		 * memberId 등) String userId = (String) session.getAttribute("userId");
		 * 
		 * if(userId == null) { // 로그인 안 된 경우 로그인 페이지로 리다이렉트
		 * response.sendRedirect(request.getContextPath() + "/login.do"); return; }
		 * 
		 * // 회원 구분 확인 (일반회원만 접근 가능) String division = (String)
		 * session.getAttribute("division"); if(!"일반회원".equals(division)) {
		 * response.sendRedirect(request.getContextPath() + "/main.do"); return; }
		 * 
		 * // 마이페이지 메인 JSP로 이동 request.getRequestDispatcher("/mypage_member.jsp")
		 * .forward(request, response); } }
		 */
package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.vo.UserVO;

/**
 * 일반회원 마이페이지 메인 컨트롤러
 * - URL: /mypage.do
 * - 세션 검증 후 메인 페이지 표시
 */
@WebServlet("/mypage.do")
public class MyPageMainController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        //위에꺼 세션 확인하구, 삭제 해도 됨미더~ 밑에껄로 마이페이지 이동 사용.
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
     // 🔴 로그인 안 된 상태면 로그인 페이지로
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }

        // ✅ 3. users 테이블의 division 컬럼 값
        String division = loginUser.getDivision();
        // 예: "일반회원", "점주"

        // ✅ 4. division 값에 따라 분기 처리
        if ("일반회원".equals(division)) {

            // 👉 일반 회원 마이페이지
            request.getRequestDispatcher(
                "/TEST/views/store/mypage_member.jsp"
            ).forward(request, response);

        }else if ("점주".equals(division)) {

            response.sendRedirect(request.getContextPath() + "/owner/dashboard.do");
            return;
        } else if ("관리자".equals(division)) {

            // 관리자 메인 이동
            response.sendRedirect(request.getContextPath() + "/TEST/views/admin/admin_main.jsp");
            return;

        }
        
        else {

            // 👉 예외 처리 (division 값이 이상한 경우)
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "접근 권한이 없습니다.");
        }
        
    }
}