package kr.or.ddit.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.user.service.IMyMemberService;
import kr.or.ddit.user.service.MyMemberServiceImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

import java.io.IOException;

/**
 * Servlet implementation class SelectOne
 */
@WebServlet("/SelectOne.do")
public class SelectOne extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public SelectOne() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        // 1. 세션 가져오기 (false: 세션이 없으면 새로 생성하지 않고 null 반환)
        HttpSession session = request.getSession(false);
        
        // 2. 로그인 여부 체크 ("loginUser" 객체가 있는지 확인)
        if (session == null || session.getAttribute("loginUser") == null) {
            // 미인증 사용자 처리 (401 에러 또는 로그인 페이지 리다이렉트)
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            // response.sendRedirect(request.getContextPath() + "/login.jsp"); // 필요 시 주석 해제
            return;
        }

        // 3. 세션에서 UserVO 객체를 꺼내와서 데이터 추출
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();

        // 4. 서비스 인스턴스 가져오기
        IMyMemberService service = MyMemberServiceImpl.getInstance();
        
        // 5. DB에서 상세 정보 조회 (추출한 userId 사용)
        // USER 테이블 조회 (기본 정보)
        UserVO userVO = service.SelectUser(userId);
        
        // MEMBER 테이블 조회 (추가 상세 정보)
        MemberVO memberVO = service.SelectMember(userId);
        
        // 6. 예외 처리: 정보가 없을 경우
        if (userVO == null || memberVO == null) {
            request.setAttribute("errorMsg", "회원 정보를 불러오는 데 실패했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

     // 7. JSP에 전달할 데이터 저장
        request.setAttribute("userVO", userVO);
        request.setAttribute("memberVO", memberVO);

        // DB에서 실제 개수 조회해오기 (서비스에 메서드가 있다고 가정)
     // SelectOne.java의 7번 단계 수정
        int couponCount = service.getCouponCount(userId);
        int reviewCount = service.getReviewCount(userId);

        request.setAttribute("couponCount", couponCount);
        request.setAttribute("reviewCount", reviewCount);
        
        // 8. 뷰(JSP)로 이동
        request.getRequestDispatcher("/TEST/views/user/memberProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}