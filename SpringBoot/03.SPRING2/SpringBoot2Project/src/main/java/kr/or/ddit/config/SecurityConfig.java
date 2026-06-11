package kr.or.ddit.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.security.autoconfigure.web.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.security.CustomAccessDeniedHandler;
import kr.or.ddit.security.CustomLoginFailureHandler;
import kr.or.ddit.security.CustomLoginSuccessHandler;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.testBoard.service.TestBoardServiceImpl;
import lombok.extern.slf4j.Slf4j;

// @Configuration 어노테이션은 스프링 설정 클래스, 해당 클래스를 싱글톤을 적용하여 하나의 인스턴스로 관리하면
// Bean 등록을 위해 설정합니다.
// @EnableWebSecurity 어노테이션은 스프링 시큐리티를 활성화 하고 보안 설정을 구성하는데 사용하며, 시큐리티 필터 체인을
// 생성하여 시큐리티 구성을 돕는다.
// @EnableMethodSecurity 어노테이션은 요청을 처리하기 위한 타겟(메소드)에 권한을 설정하기 위해 설정한다.
// (@PreAuthorize, @PostAuthorize 사용)

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    private final TestBoardServiceImpl testBoardServiceImpl;
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	// application.properties 에 설정한 dataSourceDI
	@Autowired
	private DataSource dataSource;

    SecurityConfig(TestBoardServiceImpl testBoardServiceImpl) {
        this.testBoardServiceImpl = testBoardServiceImpl;
    }
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) {
		
		// #CSRF 설정
		// CSRF 공격에 방어하기 위한 방안으로 csrf를 설정하는데, REST 에서는 csrf를 disable 합니다.
		// 스프링 시큐리티 document 에서는 non-browser clients 만을 위한 서비스라면 csrf를 disable 해도 좋다고
		// 설명합니다. 그렇기 때문에 rest api 를 이용한 서버라면 session 기반 인증과는 다르게 stateless 하기
		// 때문에 서버에 인증정보를 보관하지 않습니다. rest api 에서 client 는 권한이 필요한 요청을 보내기 위해선
		// 요청에 필요한 인증 정보를(OAuth2, jwt토큰 등)을 포함시켜야 합니다.
		// 따라서 서버에 인증정보를 저장하지 않기 때문에 굳이 불필요한 csrf 코드들을 작성할 필요가 없습니다.
		// 그런데 form 인증 방식의 시큐리티 설정은 csrf 토큰을 꼭 보내야만 서버는 해당 요청이 서버가 발급해준 csrf
		// token 인증을 인식해 발급한 사용자가 요청한 요청이구나를 인식하고 서버에서 요청을 받아들여줍니다.
		
		http.csrf((csrf)->csrf.disable()); //세션기반이지만 비활성화로 두고 할 수도있다
		
		http.authorizeHttpRequests(
				// 기존 방식(Security 5.X 이하) 에서는 포워딩 요청이라면 이미 인증된 사용자이므로 내부에서의 요청을
				// 안전하다고 보았습니다. 그런데 이후(Security 6.x 이상) 에서는 모든 DispatcherType 에 대해
				// 보안검사를 진행하도록 설정되어 있습니다. 그러므로, 내부에서 동작하는 포워딩 및 비동기 요청에 대해서
				// permitAll(전체허용) 을 설정합니다.
				(authorize)->authorize.dispatcherTypeMatchers(DispatcherType.FORWARD,DispatcherType.ASYNC).permitAll()
					// 서버쪽에서 정적 자원을 관리한다면 static 하위 정책 파일들을 permitAll로 풀 이유가 생기지만,
					// REST로 프론트와 백엔드가 분리되어 있는 상황이라면 아래 내용이 굳이 필요하지는 않습니다.
					// 정적 자원을 front 영역에서 관리하고 있기 때문에
					.requestMatchers(PathRequest.toStaticResources().atCommonLocations())
						.permitAll()
					.requestMatchers("/resources/**")
						.permitAll()
					// 시큐리티 일반게시판 목록, 공지사항 게시판 목록 모두 접근 가능
//					.requestMatchers("/security/board/list","/security/notice/list")
//						.permitAll()
					// 일반 게시판 등록은 회원과 관리자만 접근 가능
//					.requestMatchers("/security/board/register")
//						.hasAnyRole("MEMBER","ADMIN")
					// 공지사항 등록은 관리자만 접근 가능
//					.requestMatchers("/security/notice/register")
//						.hasRole("ADMIN")
					.requestMatchers("/")
						.permitAll()
					.requestMatchers("/jwt/**").permitAll()
						// 이외의 요청은 전부 검증
						//.anyRequest().authenticated()
					//다른요청은 모두 접근가능
					.anyRequest().permitAll()
				);
	
		// 로그인 인증방식 'BASIC'에 해당하는 기본 인증 방식으로 요청
//		http.httpBasic(Customizer.withDefaults());
		
		// 5. 접근 거부 처리
		// 해당 타겟에 접근 가능한 권한을 가진 사용자가 아닌 경우 접근 거부 처리(URI 형태로)
		/*
		 * http.exceptionHandling( (exception) ->
		 * exception.accessDeniedPage("/accessError") );
		 */
		
		// 6. 사용자 정의 접근 거부 처리자
		http.exceptionHandling(
				(exception)->exception.accessDeniedHandler(new CustomAccessDeniedHandler()));
		
		// 7. 사용자 정의 로그인 페이지
		http.httpBasic((hbasic)-> hbasic.disable());
		http.formLogin(
			(login) -> login.loginPage("/login")
							// 8. 로그인 성공 시, 로그인 성공 처리자 핸들러 등록
							.successHandler(new CustomLoginSuccessHandler())
							// 로그인 실패 시 
							.failureHandler(new CustomLoginFailureHandler())
							
		);
		
		// 9. 로그아웃 처리
		http.logout(
				(logout)->
						// csrf 비활성화 시, post 방식의 '/logout'이 아닌 모든 http 메소드로 적용된 '/logout'으로도
						// 처리가 가능하다
							logout.logoutUrl("/logout")
									.invalidateHttpSession(true)
									.logoutSuccessUrl("/login")
									.deleteCookies("JSESSION_ID","remember-me")
				);
		
		// 12. 자동 로그인 처리
		http.rememberMe((config)->
			config.tokenValiditySeconds(86400)					// 쿠키 유효 시간 설정
				.tokenRepository(persistentTokenRepository())	// 자동 로그인 처리 핸들러 등록
				);
		
		return http.build();
	}
	
	// 4.로그인 처리
	// 시큐리티 사용자 설정
	// @@ConditionalOnMissingBean 어노테이션은 등록된 빈 중, 동명의 빈이 존재할 때 해당 메소드를 빈 등로갛지 않고
	// 기존에 만들어져있는 빈으로 사용할 수 있도록 합니다. 추후에 데이터베이스 연동한 회원정보를 사용할 때
	// UserDetailsService 객체를 만들어 해당 빈을 대체할 예정
	@Bean
	@ConditionalOnMissingBean(UserDetailsService.class)
	protected InMemoryUserDetailsManager inMemoryUserDetailsManager() {
		// 회원 권한을 가진 계정 생성
		UserDetails member =  User.withUsername("m001")			// 사용자 id 설정
			.password("{noop}1234")			// 사용자 pw 설정
			.authorities("ROLE_MEMBER")		// 사용자 권한 설정
			.build();
		
		// 관리자 권한을 가진 계정 생성
		UserDetails admin = User.withUsername("a001")
			.password("{noop}1234")
			.authorities("ROLE_MEMBER","ROLE_ADMIN")
			.build();
		
		return new InMemoryUserDetailsManager(member,admin);
	}
	
	// 10. UserDetailsService 재정의
	// 인증 관리자 관련 설정
	// 사용자 정보를 가져올 서비스를 재정의하거나, 인증 방법, LDAP/JDBC 기반 인증 등을 설정할 때 사용한다.
	@Bean
	protected AuthenticationManager authenticationManager(
			HttpSecurity http, BCryptPasswordEncoder bCryptPasswordEncoder,UserDetailsService userDetailsService
			) {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider(customUserDetailsService);
		
		// # userDetailsService()
		// - 사용자 정보를 가져올 서비스를 설정한다. 이때 설정하는 클래스는 UserDetailsService 상속받은 클래스
		// # passwordEncoder()
		// - 비밀번호 암호화하기 위한 인코더를 설정한다.
		authProvider.setPasswordEncoder(bCryptPasswordEncoder);
		return new ProviderManager(authProvider);
	}
	
	// 비밀번호 암호와를 위한 재정의
	@Bean
	protected PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	
	// 12. 자동 로그인 설정
	// remember-me 데이터베이스 연결
	@Bean
	protected PersistentTokenRepository persistentTokenRepository() {
		JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
		tokenRepository.setDataSource(dataSource);
		
		// 자동 로그인 처리시에는 자동 로그인 정보를 기록할 테이블 정보가 있어야합니다.
		try {
			// 직접 만들어서 설정할 수도 있지만, 시큐리티가 자동으로 관련 테이블 정보를 create합니다.
			tokenRepository.getJdbcTemplate().execute(JdbcTokenRepositoryImpl.CREATE_TABLE_SQL);
		}catch (BadSqlGrammarException e) {
			log.error("persistent_logins 테이블이 이미 존재합니다.");

		}catch (Exception e) {
			log.error("자동 로그인 테이블 생성중 에러 발생!");
		}
		
		return tokenRepository;
	}
	
	
}