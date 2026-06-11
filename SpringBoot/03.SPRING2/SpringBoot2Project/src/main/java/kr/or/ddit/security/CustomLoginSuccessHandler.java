package kr.or.ddit.security;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache= new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException{
		// 사용자가 입력한 아이디, 비밀번호로 인증 진행 > InMemory 공간에 저장한 admin, member 정보를 이용해서
		// 인증을 진행 > 인증 성공 > SuccessHandler(CustomLoginSuccessHandler) 동작 (요청 넘어옴)
		//
		// 넘어온 요청은 원래 사용자가 가고자 했던 목적지 타겟 URI를 가지고있다.
		// 성공 처리자에서 성공시 진행하려던 프로세스를 진행 후, 타겟 URI로 리 다이렉트
		log.info("## CustomLoginSuccessHandler.onAuthenticationSuccess()  실행...!");
		User user = (User) authentication.getPrincipal();
		
		if(user.isEnabled()) {
			log.info("## username : {}", user.getUsername());
			log.info("## password : {}", user.getPassword());
			
			Collection<GrantedAuthority> grantedAuthority = user.getAuthorities();
			Iterator<GrantedAuthority> ite_authority = grantedAuthority.iterator();
			while(ite_authority.hasNext()) {
				GrantedAuthority authority = ite_authority.next();
				log.info("##auth: {} ",authority.getAuthority());
			}
		}

		//SPRING_SECURITY_EXCEPTION 으로 등록된 에러 정보를 삭제
		clearAuthenticationAttribute(request);
		
		// ## 현상
		// 1) 사용자 : /ssecurity/board/register 요청을 서버로 전송
		// 서버는 인증 페이지를 제공 > 사용자 id, pw를 입력 후 인증 요청 > 인증 진행 > 인증 완료 > 성공 처리자 핸들러
		// 성공 처리자 핸들러 안에는 사용자가 원래 가려고 했던 목적지 Target URI 를 꺼내서 원래 가려고 했던 URI 로 이동시킨다
		// 
		// 2) 사용자 : /login 요청일 경우 
		// 서버는 로그인 페이지를 제공 > 사용자 Id, pw 를 입력 후 인증 요청 > 인증 진행 > 인증 완료 > 성공 처리자 핸들러
		// 성공 처리자 핸들러 안에서 사용자가 원래 가려고 헀던 목적지 Target이 존재하지 않음
		// 캐시 정보 안에 등록되어있던 RedirectUrl의 Target정보가 존재하지 않으므로, 시큐리티는 자동으로 '/' 로 보냄
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = "/";	// 기본 default target은 root
		if(savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();
		}
		log.info("##login success TargetURL(목적지) : "+targetUrl);
//		savedRequest.getRedirectUrl();	// 사용자가 원래 가려고 했던 주 목적지 TarGet!
		response.sendRedirect(targetUrl);
		
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			return;
		}else {
			session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}
	}
}
