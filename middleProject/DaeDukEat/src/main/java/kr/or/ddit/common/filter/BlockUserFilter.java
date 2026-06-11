package kr.or.ddit.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.user.vo.UserVO;
// 필요하면 서비스로 DB 재확인/자동해제용
// import kr.or.ddit.admin.service.IAdminService;
// import kr.or.ddit.admin.service.AdminServiceImpl;

/**
 * ✅ 정지(제재) 회원 전역 차단 필터
 * - 관리자(division=관리자)는 통과
 * - 정지회원은 /banInfo.do, /logout.do 등 일부만 허용
 * - fetch/AJAX 요청은 403 JSON, 일반 요청은 redirect
 */
@WebFilter("/*")
public class BlockUserFilter implements Filter {

    // ⭐ 여기서 "정지여도 허용할 URL"만 화이트리스트로 관리
    private static final String[] ALLOW_PATH_PREFIX = {
        "/login.do",
        "/logout.do",
        "/banInfo.do",         // 정지 안내 페이지(너가 만들면 됨)
        "/AdminBan.do"         // (선택) 관리자 기능 호출은 보통 관리자만 접근하니 사실 필요없음
    };

    // 정적 리소스는 필터 제외 (css/js/img 등)
    private static final String[] STATIC_PREFIX = {
        "/css/", "/js/", "/images/", "/TEST/css/", "/TEST/js/", "/TEST/images/", "/favicon"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String ctx  = request.getContextPath();
        String uri  = request.getRequestURI();
        String path = uri.substring(ctx.length()); // /DaeDukEat 제거 후 경로만

        // 1) 정적 리소스는 패스
        if (isStatic(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 2) 세션 로그인 유저 확인
        HttpSession session = request.getSession(false);
        UserVO loginUser = null;
        if (session != null) {
            Object obj = session.getAttribute("loginUser");
            if (obj instanceof UserVO) loginUser = (UserVO) obj;
        }

        // 로그인 안 했으면 그냥 통과(각 서블릿에서 로그인 체크 하거나 별도 AuthFilter가 있을 수 있음)
        if (loginUser == null) {
            chain.doFilter(req, res);
            return;
        }

        // 3) 관리자는 무조건 통과
        String division = safeTrim(loginUser.getDivision());
        if ("관리자".equals(division)) {
            chain.doFilter(req, res);
            return;
        }

        // 4) 정지 여부 확인
        String blockYn = safeTrim(loginUser.getBlockYn()); // UserVO에 blockYn 있어야 함
        boolean isBlocked = "Y".equalsIgnoreCase(blockYn);

        // (선택) 기간제 자동 해제까지 하고 싶으면 여기서 DB 확인해서 end_date 지났으면 풀어줌
        // isBlocked = refreshBlockStatusIfNeeded(loginUser, session);

        if (!isBlocked) {
            chain.doFilter(req, res);
            return;
        }

        // 5) 정지된 유저인데 허용 URL이면 통과
        if (isAllowed(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 6) 차단 응답: fetch면 JSON, 일반이면 redirect
        if (isAjax(request)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json; charset=UTF-8");

            PrintWriter out = response.getWriter();
            out.write("{\"success\":false,\"code\":\"BANNED\",\"message\":\"현재 계정이 제재 상태입니다.\"}");
            out.flush();
            return;
        } else {
            // 정지 안내 페이지로
            response.sendRedirect(ctx + "/banInfo.do");
            return;
        }
    }

    @Override
    public void destroy() {}

    private boolean isAllowed(String path) {
        for (int i = 0; i < ALLOW_PATH_PREFIX.length; i++) {
            if (path.startsWith(ALLOW_PATH_PREFIX[i])) return true;
        }
        return false;
    }

    private boolean isStatic(String path) {
        for (int i = 0; i < STATIC_PREFIX.length; i++) {
            if (path.startsWith(STATIC_PREFIX[i])) return true;
        }
        // 확장자로도 한 번 더 방어
        return path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".jpg")
                || path.endsWith(".jpeg") || path.endsWith(".gif") || path.endsWith(".svg") || path.endsWith(".woff")
                || path.endsWith(".woff2") || path.endsWith(".ttf") || path.endsWith(".ico");
    }

    private boolean isAjax(HttpServletRequest request) {
        String xrw = request.getHeader("X-Requested-With");
        String accept = request.getHeader("Accept");
        // fetch는 X-Requested-With가 없는 경우가 많아서 Accept도 같이 봄
        if ("XMLHttpRequest".equalsIgnoreCase(xrw)) return true;
        if (accept != null && accept.toLowerCase().contains("application/json")) return true;
        return false;
    }

    private String safeTrim(String s) {
        return (s == null) ? "" : s.trim();
    }

    // (선택) 자동 해제 로직: end_date < 오늘이면 users.block_yn='N' 업데이트 + 세션도 반영
    // private boolean refreshBlockStatusIfNeeded(UserVO loginUser, HttpSession session) {
    //     try {
    //         IAdminService svc = AdminServiceImpl.getInstance();
    //         // svc가 userId로 최신 block 상태 + endDate 조회해서
    //         // endDate < today 이면 해제 처리하고, loginUser.setBlockYn("N") 해서 세션 갱신
    //     } catch (Exception e) {}
    //     return "Y".equalsIgnoreCase(safeTrim(loginUser.getBlockYn()));
    // }
}
