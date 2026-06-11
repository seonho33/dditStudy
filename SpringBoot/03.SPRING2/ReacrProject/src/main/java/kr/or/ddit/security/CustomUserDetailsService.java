package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IBlogMemberMapper;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private IBlogMemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("## CustomUserDetailsService.loadUserByUsername() 실행...!");
		log.info("## username : " + username);
		
		BlogMemberVO member = memberMapper.readByUserInfo(username);
		// 넘겨받은 member가 null인 경우라면 UsernameNotFoundException 에러에 의해 회원정보가 존재하지 않는다는
		// 에러를 응답으로 출력한다.
		return member == null ? null : new CustomUser(member);
	}

}
