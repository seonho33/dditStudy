package kr.or.ddit.exception;

import org.springframework.transaction.annotation.Transactional;


// UnChecked Exception 으로 파일 데이터 처리하는 과정에서 에러로 인한 롤백처리가 함께 이뤄질 수 있도록 함.
// @Transactional 처리가 되어있다는 가정하에
@Transactional
public class CustomFileSizeException extends RuntimeException{
	
	public CustomFileSizeException() {
		super("파일 크기가 허용된 비즈니스 규칙을 초과하였습니다.");
	}
	
	public CustomFileSizeException(String message) {
		super(message);
	}

}
