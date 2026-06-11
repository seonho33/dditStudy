package kr.or.ddit.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties("kr.or.ddit.jwt")	// 자바 클래스에 프로퍼티값을 가져와서 사용하는 어노테이션
public class JwtProperties {
	// kr.or.ddit.jwt.issuer > issuer 
	private String issuer;
	// kr.or.ddit.jwt.secret_key > secretKey : 시크릿 키
	private String secretKey;
}
