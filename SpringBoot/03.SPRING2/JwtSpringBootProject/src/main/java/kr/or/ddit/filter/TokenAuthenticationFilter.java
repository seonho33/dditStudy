package kr.or.ddit.filter;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.util.TokenProvider;
import lombok.extern.slf4j.Slf4j;

// TokenAuthenticationFilter는 OncePerRequestFilter를 상속받아 작성합니다.
// OncePerRequestFilter는 하나의 요청당 단일 실행을 보장하는 것을 목표로 하는 필터 기본 클래스입니다.
@Slf4j
public class TokenAuthenticationFilter extends OncePerRequestFilter{

	// 토큰 검증 시 사용할 토큰 Key와 식별자
	private final static String HEADER_AUTHORIZATION = "Authorization";
	private final static String TOKEN_PREFIX = "Bearer ";

	// 전반적인 토큰 생성, 토큰 검증 등 기능을 담당하는 객체
	private TokenProvider tokenProvider;
	
	public TokenAuthenticationFilter(TokenProvider tokenProvider) {
		this.tokenProvider = tokenProvider;
	}
	
	// 요청 하나당 실행 될 메서드 재정의
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		log.info("# TokenAuthenticationFilter.doFilterInternal -> msg : Filter execution...!");
		
		// 요청 헤더의 'Authorization' 키의 값 조회
		// {"Authorization" : "Bearer jwt token"}에서 'Bearer ' 식별자를 제외하고 token 추출
		String authorizationHeader = request.getHeader(HEADER_AUTHORIZATION);
		// 가져온 값에서 접두사 제거('Bearer ' 제거)
		String token = getAccessToken(authorizationHeader);
		
		// 가져온 토큰이 유효한지 확인하고, 유효한 때는 인증 정보 설정
		if(token != null && tokenProvider.validToken(token)) {
			// 토큰 검증 완료 후 인증 객체 생성
			// token을 전달하면, 토큰 내 저장된 사용자 아이디를 통해서 loadUserByUsername 메소드를 통해
			// 조회된 회원정보(BlogMemberVO)를 얻을 수 있습니다.
			// 조회된 회원정보를 이용하여 UsernamePasswordAuthenticationToken 객체를 이용해 Authentication
			// 객체를 반환받습니다.
			Authentication authentication = tokenProvider.getAuthentication(token);
			
			// 인증 객체 설정
			SecurityContextHolder.getContext().setAuthentication(authentication);
		}
		filterChain.doFilter(request, response);
	}


	private String getAccessToken(String authorizationHeader) {

		if(authorizationHeader !=null && authorizationHeader.startsWith(TOKEN_PREFIX)) {
			return authorizationHeader.substring(TOKEN_PREFIX.length());
		}
		
		return null;
	}

	
	
}
