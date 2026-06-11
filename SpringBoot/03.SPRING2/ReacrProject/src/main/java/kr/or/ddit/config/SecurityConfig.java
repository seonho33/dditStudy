package kr.or.ddit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
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
import kr.or.ddit.security.CustomAccessDeniedHandler;
import kr.or.ddit.security.CustomLoginFailureHandler;
import kr.or.ddit.security.CustomLoginSuccessHandler;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.util.TokenProvider;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private TokenProvider tokenProvider;

    private static final String[] PASS_URL = {
            "/",                // ROOT
            "/index.html",      // welcome 페이지 요청
            "/login",           // 로그인 페이지
            "/error",           // 스프링이 제공하는 에러 url 경로
            "/login.do",        // 로그인 페이지 요청
            "/.well-known/**"   // 크롬 개발자 도구로의 요청
    };

    private static final String[] REACT_PASS_URL = {
            "/api/react/checkId.do",
            "/api/react/signup.do",
            "/api/react/signin.do",
            "/api/react/notice/list"
    };

    @Bean
    public WebSecurityCustomizer configure(                                                                                        ){
        return (web) -> web.ignoring()
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                .requestMatchers("/resources/**");
    }

    // 특정 HTTP 요청에 대한 웹 기반 보안 구성
    // REACT 진영에서 넘어오는 요청에 대해서만 처리할 필터 체인
    @Order(value= 1)
    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf((csrf) -> csrf.disable());
        http.formLogin((login)-> login.disable());
        http.httpBasic((basic)-> basic.disable());
        http.headers((config)-> config.frameOptions((fOpt)-> fOpt.sameOrigin()));
        http.sessionManagement((management)-> management.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        http.securityMatcher("/api/react/**")
                .authorizeHttpRequests(
                        (authorize) -> authorize.requestMatchers(REACT_PASS_URL).permitAll()
                                .anyRequest().authenticated());
        http.addFilterBefore(new TokenAuthenticationFilter(tokenProvider),
                UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    // 스프링 진영의 세션 기반으로 동작할 모든 요청에 대해서 처리하는 필터 체인
    @Order(2)
    @Bean
    protected SecurityFilterChain filterChain2(HttpSecurity http) throws Exception {
//      http.csrf((csrf) -> csrf.disable());
        http.securityMatcher("/**")
                .authorizeHttpRequests((authorize) -> authorize.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll()
                        .requestMatchers(PASS_URL).permitAll()
                        .anyRequest().authenticated());
        http.exceptionHandling((exception) -> exception.accessDeniedHandler(new CustomAccessDeniedHandler()));
        http.httpBasic((basic) -> basic.disable());
        http.formLogin(
                (login) -> login.loginPage("/login.do")
                        // 로그인 페이지를 '/login.do'로 설정했다면 인증 시 사용할 로그인 페이지에서도
                        // form 태그 내, action 경로는 loginPage로 설정된 '/login.do'가 설정됨.
                        // 그렇기 때문에 .loginProcessingUrl로 처리를 위한 url을 지정하거나 form태그
                        // 내 경로를 변경합니다.
                        .loginProcessingUrl("/login")
                        .successHandler(new CustomLoginSuccessHandler())
                        .failureHandler(new CustomLoginFailureHandler()));
        http.logout(
                (logout) -> logout.logoutUrl("/logout")
                        .invalidateHttpSession(true)
                        .logoutSuccessUrl("/logout.do")
                        .deleteCookies("JSESSION_ID", "remember-me"));
        return http.build();
    }

    @Bean
    protected AuthenticationManager authenticationManager(
            BCryptPasswordEncoder bCryptPasswordEncoder,
            AuthenticationConfiguration authenticationConfiguration) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(customUserDetailsService);
        authProvider.setPasswordEncoder(bCryptPasswordEncoder);
        return new ProviderManager(authProvider);
    }

    @Bean
    protected PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}