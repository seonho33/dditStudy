package kr.or.ddit.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class CustomExceptionHandler {
	
	// 커스텀으로 설정한 예외를 해당 컨트롤러에서 예외를 잡아 커스텀 처리
	@ExceptionHandler(CustomFileSizeException.class)
	public String customFileSizeExeption(CustomFileSizeException ex, Model model) {
		log.info("CustomFileSizeException.exceptionMessage->msg : {}",ex.getMessage());
		model.addAttribute("errMsg",ex.getMessage());
		
		return "error/error";
	}
	
}
