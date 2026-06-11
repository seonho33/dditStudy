package kr.or.ddit.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;


//@ConfigurationProperties 어노테이션은 .properties 파일 내 구성된
// 	프로퍼티 값을 가져와 사용할 수 있도록 해준다.
//변수 "kr.or.ddit.jwt" 로 시작하는 프로퍼티의 값을 가져와 해당 필드와
//	일치하는 항목에 값을 매핑시켜줍니다.  

@Data
@Component
@ConfigurationProperties("kr.or.ddit.jwt")
public class JwtProperties {
	// 제공자(kr.or.ddit.jwt.issuer > issuer)
	private String issuer;
	// 비밀키(kr.or.ddit.jwt.secret_key > issuerKey)
	private String secretKey;
	
}
 