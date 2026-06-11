package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.service.IUserService;
import kr.or.ddit.store.service.UserServiceImpl;
import kr.or.ddit.store.dao.UserDaoImpl;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.StoreServiceImpl;

/**
 * Store 패키지 전용 로그인 서블릿
 * - 점주(사장님) 로그인 전용
 */
@WebServlet("/Storelogin.do")
public class StoreLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public StoreLoginServlet() {
        super();
    }

    /**
     * GET: 로그인 페이지로 이동
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 🔥 로그인 페이지 경로 (본인의 경로에 맞게 수정)
        response.sendRedirect(request.getContextPath() + "/owner/login.jsp");
    }

    /**
     * POST: 로그인 처리
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 한글 인코딩
        request.setCharacterEncoding("UTF-8");
        
        // 2. 로그인 폼 데이터 받기
        String userId = request.getParameter("userId");      // 🔥 점주 아이디
        String password = request.getParameter("password");  // 🔥 비밀번호
        
        // 🔥 디버깅용 (나중에 삭제 가능)
        System.out.println("=== 점주 로그인 시도 ===");
        System.out.println("userId: " + userId);
        System.out.println("password: " + password);
        
        // 3. Service 생성
        IUserService userService = new UserServiceImpl(new UserDaoImpl());
        
        // 4. DB에서 사용자 정보 조회 (userId와 password로 검증)
        // 🔥 방법1: checkPassword 사용 (비밀번호 검증)
        boolean isValidPassword = userService.checkPassword(userId, password);
        
        if (!isValidPassword) {
            // ❌ 아이디나 비밀번호가 틀린 경우
            request.setAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/owner/login.jsp").forward(request, response);
            return;
        }
        
        // 5. 사용자 정보 조회
        UserVO loginUser = userService.getUserById(userId);
        
        if (loginUser == null) {
            request.setAttribute("error", "사용자 정보를 찾을 수 없습니다.");
            request.getRequestDispatcher("/owner/login.jsp").forward(request, response);
            return;
        }
        
        // 6. 회원 구분(DIVISION) 확인 - 점주만 허용
        String division = loginUser.getDivision();
        if (division != null) {
            division = division.trim();
        }
        
        // 🔥 점주 또는 관리자만 로그인 허용
        if (!"점주".equals(division) && !"관리자".equals(division)) {
            request.setAttribute("error", "점주 계정만 접근할 수 있습니다.");
            request.getRequestDispatcher("/owner/login.jsp").forward(request, response);
            return;
        }
        
        // 7. ✅ 로그인 성공 → 세션에 사용자 정보 저장
        HttpSession session = request.getSession();
        
        // 🔥 세션에 여러 형태로 저장 (다른 서블릿과 JSP에서 사용)
        session.setAttribute("loginUser", loginUser);              // 객체 전체 저장
        session.setAttribute("userId", loginUser.getUserId());     // userId 따로 저장
        session.setAttribute("userName", loginUser.getName());     // userName 따로 저장
        session.setAttribute("division", loginUser.getDivision()); // division 따로 저장
        
        // 8. 점주의 가게 정보 조회 및 세션 저장
        IStoreService storeService = new StoreServiceImpl();
        
        // 🔥 userId로 가게 정보 조회 (StoreService에 메서드 필요)
        StoreVO loginStore = storeService.selectStoreByUserId(userId);
        
        if (loginStore != null) {
            session.setAttribute("loginStore", loginStore);                // 가게 객체 전체
            session.setAttribute("storeId", loginStore.getStoreId());      // storeId 따로
            session.setAttribute("storeName", loginStore.getStoreName());  // storeName 따로
            
            // 🔥 디버깅용
            System.out.println("가게 정보 세션 저장: " + loginStore.getStoreName());
        } else {
            System.out.println("⚠️ 경고: 가게 정보가 없습니다. (userId: " + userId + ")");
        }
        
        // 9. 로그인 성공 후 대시보드로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/owner/dashboard.do");
    }
}