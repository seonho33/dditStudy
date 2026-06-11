package kr.or.ddit.common.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 로그인 체크 필터 (Jakarta Servlet 버전)
 * - 마이페이지, 예약 관련 URL 접근 시 세션 검증
 * - 비로그인 시 로그인 페이지로 리다이렉트
 */
public class LoginCheckFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 초기화 작업 (필요 시)
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // 세션에서 로그인 정보 확인
        HttpSession session = httpRequest.getSession(false);
        String userId = (session != null) ? (String) session.getAttribute("userId") : null;
        
        // 로그인 여부 체크
        if(userId == null || userId.isEmpty()) {
            // 비로그인 시 로그인 페이지로 리다이렉트
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;  // 필터 체인 중단
        }
        
        // 로그인된 경우 다음 필터 또는 서블릿으로 전달
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // 필터 종료 시 정리 작업 (필요 시)
    }
}