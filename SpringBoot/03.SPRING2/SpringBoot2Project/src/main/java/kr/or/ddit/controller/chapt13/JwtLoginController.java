package kr.or.ddit.controller.chapt13;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.JwsHeader;
import io.jsonwebtoken.Jwt;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import kr.or.ddit.jwt.JwtProperties;
import kr.or.ddit.vo.jwt.JwtMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/jwt")
public class JwtLoginController {

	@Autowired
	private JwtProperties jwtProperties;
	
	// 로그인
	// 로그인은 사용자의 세션을 얻는 행위와도 같습니다.
	// 세션과 같은 사용자가 로그인을 시도하고 인증이 완료 시, 얻어지는 세션과 같은 기능을 담당할 token 을 발행한다.
	// 해당 토큰은 시크릿키를 기반으로 헤더와 내용이 포함된 JWT Token 을 발행한다.
	@PostMapping("/login")
	public ResponseEntity<?> jwtLogin(
			@RequestBody JwtMemberVO memberVO){
		log.info("username : " + memberVO.getUsername());
		log.info("password : " + memberVO.getPassword());
	
		// application.properties 내, secret_key 가져오기
		// 시크릿키를 바이트로 전환한다.
		// 이후 SHA-256 방식의 암호화를 설정한 서명의 값으로 사용하기 위해 바이트로 전환
		byte[] keyByte = jwtProperties.getSecretKey().getBytes();
		String issuer = jwtProperties.getIssuer();		// 토큰제공자(ddit)
		
		// 토큰 생성
		String jwt = Jwts.builder()
			.setHeaderParam(Header.TYPE, Header.JWT_TYPE)	//헤더 type : JWT
			.setIssuer(issuer)			// payload의 iss(토큰발급자)를 지정할 때 사용
			.setIssuedAt(new Date())	// payload의 iat(토큰 발급시간)을 지정할 때 사용
			.setExpiration(new Date(System.currentTimeMillis()+1000*60*60*24))	//기한은 1일
			.setSubject(memberVO.getUsername())		// 내용 sub : 유저아이디 (or email)
			.claim("uid",memberVO.getUsername())	// 클레임
			.claim("upw",memberVO.getPassword())	// 클레임
			.claim("unm","hongkildong")				// 클레임
			.claim("auth","ROLE_MEMBER")			// 클레임 auth : 유저권한
			// .signWith(알고리즘, 시크릿키)
			// 시크릿키는 application.properties에 설정된 secretKey
			// 서명 : 비밀값과 함께 해시값을 HS256 방식으로 암호화
			// HS256 이란 HMAC의 SHA-256방식으로 암호화를 진행한다는 뜻입니다.
			.signWith(SignatureAlgorithm.HS256,keyByte)
			.compact();
		log.info("## jwt : " + jwt);
		return new ResponseEntity<String>(jwt, HttpStatus.OK);
	}
	
	// 토큰 해석
	// @RequestHeader 어노테이션은 요청에 담긴 헤더 정보들 중, 'Authorization' 키로 들어온 데이터를 가져올 때 사용
	@GetMapping("/userInfo")
	public ResponseEntity<?> userInfo(
			@RequestHeader("Authorization") String header){
		
		String userInfo = "";
		
		if(StringUtils.isNotBlank(header)) {
			log.info("# JwtLoginController.userInfo->Authorization header : " + header);
			
			// Authorization : Bearer ${jwt}
			// token 만을 취득하기 위해서 앞 'Bearer' 식별자를 제거한다
			String jwt = header.replace("Bearer ", "");
			
			// 토큰 해석
			// 토큰 해석은 secretKey 를 이용하여 파싱할 수 있다. (비밀키가 있어야 복호화가 가능)
			// 복호화 된 토큰 내, payload에 해당하는 여러 claim 중 사용자 아이디를 꺼낼 수 있다.
			Jwt<JwsHeader, Claims> parsedToken = Jwts.parser()
				.setSigningKey(jwtProperties.getSecretKey().getBytes()) //비밀키로 복호화
				.parseClaimsJws(jwt);
			
			String uid = parsedToken.getBody().get("uid").toString();
			String upw = parsedToken.getBody().get("upw").toString();
			String unm = parsedToken.getBody().get("unm").toString();
			String auth = parsedToken.getBody().get("auth").toString();
			log.info("# JwtLoginController.userInfo->Authorization uid : " + uid);
			log.info("# JwtLoginController.userInfo->Authorization upw : " + upw);
			log.info("# JwtLoginController.userInfo->Authorization unm : " + unm);
			log.info("# JwtLoginController.userInfo->Authorization auth : " + auth);
			
			userInfo = parsedToken.toString();
		}
		
		return new ResponseEntity<String>(userInfo, HttpStatus.OK);
	}
	
}
