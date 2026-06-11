package kr.or.ddit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.security.autoconfigure.web.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.filter.TokenAuthenticationFilter;
import kr.or.ddit.util.TokenProvider;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	
	// 전반적인 토큰 생성, 토큰 검증 등 기능을 담당하는 객체로 TokenAuthenticationFilter 에 빈으로
	// 등록 후 사용 할 수 있도록 선언
	@Autowired
	private TokenProvider tokenProvider;
	
	// permitAll로 설정할 URL 목록들 설정
	private static final String[] PASS_URL = {
			"/",					// ROOT
			"/error",				// 스프링이 제공하는 에러 URL 경로
			"/upload/**",			// 파일 업로드 경로
			"/blog/**",				// 블로그 페이지
			"/api/blog/idCheck",	// 회원가입: 아이디 중복체크
			"/api/blog/signup",		// 회원가입
			"/api/blog/signin",		// 회원가입
			"/api/blog/display",	// 회원가입
			"/api/blog/download"	// 회원가입
	};
	
	// 스프링 시큐리티 기능 비활성화
	// SpringSecurityFilterChain 을 우회하기 위한 설정으로 보통 정적 리소스(css,js,이미지 등)를 시큐리티와
	// 관련된 필터를 타지 않고 서블릿 컨테이너로 요청이 전달될 수 있도록 하기 위한 설정입니다.
	// 그렇다는건, SecurityFilterChain 보다도 가장 먼저 동작하는 부분입니다.
	// 정적 리소스 자원이 ignoring 되지 않는다면 서블릿 컨테이너로 가기도 전에 401 또는 403 에러가 발생해
	// 브라우저에서 css, js 등과 같은 정적 리소스가 실행되지 않고, 기본적인 UI, 스크립트 이벤트가 동작하지 않을 수 있습니다.
	@Bean
	public WebSecurityCustomizer configure() {
		return (web) -> web.ignoring()
						.requestMatchers(PathRequest.toStaticResources().atCommonLocations())
						.requestMatchers("/resources/**");
		
		// 해당 Bean 안에서도 정적 리소스 말고도 시큐리티를 우회하여 페이지를 실행할 여러 요청 경로를 설정할 수 있음
		// 그렇지만 보통 정적 리소스만 한정지어 필터 체인을 우회할 수 있도록 설정합니다.
		// 그 외 요청에 대해서는 아래 필터체인을 통해 모든 요청을 허용할 수 있는 permitAll() 을 설정하여 우회할 수 있도록 합니다.
		
	}
	
	// 특정 HTTP 요청에 대한 웹 기반 보안 구성
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) {
		http.csrf((csrf)->csrf.disable());
		
		// 폼 기반 로그인 비활성화
		http.formLogin((login)->login.disable());
		// HTTP 기본 인증 비활성화
		http.httpBasic((basic)->basic.disable());
		// 스프링 시큐리티는 기본적으로 X-Frame-Options Click jacking 공격을 막기위한 설정이 default로 됨.
		// 그래서 동일 도메인 내에서의 요청이라면 접근이 가능하도록 설정한다.
		http.headers((config)->config.frameOptions((fOpt)->fOpt.sameOrigin()));
		
		// 세션관리 정책 설정
		// 세션 인증을 사용하지 않고, JWT를 사용하여 인증(JWT 토큰 활용하기 때문에 세션 불필요)
		// - ALWAYS(default) : HttpSession 을 항상 생성하고 사용한다.
		// - NEVER : HttpSession 을 생성하지 않으나, 이미 존재하는 HttpSession 에 대해서는 사용한다.
		// - STATELESS : HttpSession 을 생성하지 않고, SecurityContext를 획득하는데 사용하지 않는다.
		http.sessionManagement((management)->management.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		
		http.authorizeHttpRequests((authorize) -> authorize.dispatcherTypeMatchers(DispatcherType.FORWARD,DispatcherType.ASYNC)
										.permitAll()	// forward는 모두 접근 가능
										.requestMatchers(PASS_URL).permitAll()
										.anyRequest().authenticated()
										);
		http.addFilterBefore(new TokenAuthenticationFilter(tokenProvider), UsernamePasswordAuthenticationFilter.class);
		
		return http.build();
	}
	
	// 비밀번호 암호화를 위한 PasswordEncoder 재정의
	// 암호화 알고리즘 방식으로 BCrypt 를 활용한다.
	@Bean
	protected PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
}
