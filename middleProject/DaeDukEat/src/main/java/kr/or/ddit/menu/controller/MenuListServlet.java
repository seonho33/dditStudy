package kr.or.ddit.menu.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.menu.service.IMenuService;
import kr.or.ddit.menu.service.MenuServiceImpl;
import kr.or.ddit.menu.vo.MenuVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.store.vo.StoreVO; // StoreVO 패키지 경로를 확인하세요.

/**
 * <pre>
 * 메뉴 목록 조회 컨트롤러
 * * 연결 구조:
 * 1. 세션에서 'loginUser'를 꺼내 유저 ID와 권한(division) 확인
 * 2. 세션에서 'loginStore'를 꺼내 실제 조회용 storeId 확보
 * 3. DB 조회 후 /TEST/views/store/menuList.jsp로 포워딩
 * </pre>
 */
@WebServlet("/menu/list.do")
public class MenuListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IMenuService menuService;
    
    @Override
    public void init() throws ServletException {
        // 서비스 레이어 인스턴스 확보
        this.menuService = MenuServiceImpl.getInstance();
        System.out.println("[SYSTEM] MenuListServlet 인스턴스 초기화 완료");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // ------------------------------------------------------------
        // 1. 세션 데이터 추출 및 유효성 검사
        // ------------------------------------------------------------
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");
        
        // AJAX 요청 여부 파악 (대시보드 fetch 대응)
        String isAjax = req.getHeader("X-Requested-With");

        // [검증] 로그인 유무 확인
        if (uvo == null) {
            if ("fetch".equals(isAjax)) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().print("SESSION_EXPIRED");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.do");
            }
            return;
        }

        // [정보 추출] 요청하신 userId 및 division 확보
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        System.out.println("[DEBUG] 접속 시도 유저: " + userId + " (권한: " + userRole + ")");

        // [검증] 가게 정보 존재 확인
        if (svo == null) {
            System.err.println("[ERROR] 세션에 loginStore 정보가 없습니다.");
            req.setAttribute("errorMsg", "등록된 가게 정보가 없습니다. 가게를 먼저 등록해 주세요.");
            // 에러 시 보여줄 페이지 (경로 확인 필요)
            req.getRequestDispatcher("/TEST/views/store/error/noStore.jsp").forward(req, resp);
            return;
        }
        
        // [정보 추출] 실제 메뉴 조회에 필요한 storeId
        String storeId = svo.getStoreId();
        System.out.println("[DEBUG] 조회 대상 StoreID: " + storeId);

        // ------------------------------------------------------------
        // 2. 비즈니스 로직 수행 (메뉴 목록 조회)
        // ------------------------------------------------------------
        try {
            // Service를 통해 DB 데이터 반환
            List<MenuVO> menuList = menuService.getMenusByStoreId(storeId);
            
            // 결과 데이터를 Request Scope에 저장
            req.setAttribute("menuList", menuList);
            req.setAttribute("storeId", storeId);
            req.setAttribute("userRole", userRole); // 필요 시 권한에 따른 UI 분기용

            // ------------------------------------------------------------
            // 3. 뷰 연결 (Forward)
            // ------------------------------------------------------------
            String viewPath = "/TEST/views/store/menuList.jsp";
            
            // [마스터 디버깅] 404 방지를 위해 실제 경로를 로그로 출력
            String realPath = getServletContext().getRealPath(viewPath);
            System.out.println("----------------------------------------------");
            System.out.println("[PATH CHECK] 포워딩 주소: " + viewPath);
            if (realPath != null && new java.io.File(realPath).exists()) {
                System.out.println("[RESULT] SUCCESS: JSP 파일이 존재합니다.");
            } else {
                System.err.println("[RESULT] FAIL: 해당 경로에 JSP 파일이 없습니다!");
                System.err.println("[PHYSICAL PATH] " + realPath);
            }
            System.out.println("----------------------------------------------");

            req.getRequestDispatcher(viewPath).forward(req, resp);

        } catch (Exception e) {
            System.err.println("[EXCEPTION] 메뉴 조회 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            
            if ("fetch".equals(isAjax)) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            } else {
                resp.sendRedirect(req.getContextPath() + "/error.do");
            }
        }
    }
}