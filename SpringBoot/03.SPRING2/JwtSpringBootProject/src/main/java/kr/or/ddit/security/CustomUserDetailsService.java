package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.jwt.mapper.ISecMemberMapper;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private ISecMemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("## CustomUserDetailsService.loadUserByUsername() 실행...!");
		log.info("## username : " + username);
		
		BlogMemberVO member = memberMapper.readByUserInfo(username);
		
		return member == null ? null : new CustomUser(member);
	}

}
