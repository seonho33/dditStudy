package kr.or.ddit.common.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

/**
 * 인코딩 필터 (Jakarta Servlet 버전)
 * - 모든 요청/응답을 UTF-8로 통일
 * - web.xml에서 모든 URL 패턴(/*)에 적용
 */
public class EncodingFilter implements Filter {
    
    private String encoding = "UTF-8";
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // web.xml에서 전달된 encoding 파라미터 읽기
        String encodingParam = filterConfig.getInitParameter("encoding");
        if(encodingParam != null && !encodingParam.isEmpty()) {
            this.encoding = encodingParam;
        }
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // 요청/응답 인코딩 설정
        request.setCharacterEncoding(encoding);
        response.setCharacterEncoding(encoding);
        response.setContentType("text/html; charset=" + encoding);
        
        // 다음 필터 또는 서블릿으로 전달
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // 필터 종료 시 정리 작업 (필요 시)
    }
}