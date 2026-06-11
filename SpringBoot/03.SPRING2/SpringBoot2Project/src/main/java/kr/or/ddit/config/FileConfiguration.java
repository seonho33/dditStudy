package kr.or.ddit.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// @Configuration 어노테이션은 여러 Config 설정을 담당할 클래스 입니다.
// 즉, Bean 을 등록 할 때 사용합니다.
// WebMvcConfigurer 객체는 Spring MVC의 java 기반 설정을 사용자 정의하고 확장하기 위해 제공되는 인터페이스로,
// SpringBoot 는 기본적으로 Spring MVC의 자동 구성이 활성화 되기 때문에 필요한 기능을 추가하거나 변경 할 떄 해당
// 객체의 메서드를 재정의 하여 설정 클래스로 활용할 수 있습니다.
@Configuration
public class FileConfiguration implements WebMvcConfigurer{

	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		// 정적 리소스 경로를 설정할 수 있습니다.
		// 클라이언트로부터 요청 받은 request에 담긴 파일을 업로드 시, 파일을 저장할 공간을 'C:/upload'로 지정하고
		// 해당 local 경로에 접근 할 수 있는 URL 을 '/upload/' 로 설정 합니다.
		registry.addResourceHandler("/upload/**")
					.addResourceLocations("file:///C:/upload/");
		WebMvcConfigurer.super.addResourceHandlers(registry);
	}

}