package kr.or.ddit.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private BlogMemberVO member;
	
	public CustomUser(String username, String password,
						Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
		public CustomUser(BlogMemberVO member) {
			// Java 스트림을 사용한 경우(람다표현식)
			// - 자바 버전 9부터 추가된 기능
			// -  map : 컬렉션(List,Map,Set등), 배열 등의 설정되어있는 각 타입의 값들을 하나씩 참조하여
			//			람다식으로 반복 처리할 수 있게 해준다.
			// - collect : Stream() 을 돌려 발생하는 데이터를 가공 처리하고 원하는 형태의 자료형으로 변환을 돕는다.
			super(member.getMemId(), member.getMemPw(),
					member.getAuthList().stream().map(auth ->
						new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
//			
//			for(int i=0;i<member.getAuthList().size(); i++) {
//				String authoriy = member.getAuthList().get(i).getAuth();
//				SimpleGrantedAuthority simpleGrantedAuthority = new SimpleGrantedAuthority(authoriy);
//				Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
//				authorities.add(simpleGrantedAuthority);
//				
//			}
			this.member = member;
			
			
	}
}
