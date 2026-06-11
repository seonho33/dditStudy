package kr.or.ddit.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.IBookService;

// 등록 페이지 및 등록 기능을 처리
@Controller
@RequestMapping("/book")
public class BookInsertController {

	private Logger log = LoggerFactory.getLogger(BookInsertController.class);
	
	@Autowired
	private IBookService bookService;
	
	// 책 등록 페이지
	@GetMapping("/form.do")
	public String bookForm() {
		log.info("bookForm() 실행...!");
		return "book/form";
	}
	
	@PostMapping("/form.do")
	public ModelAndView bookInsert(@RequestParam Map<String, Object> param) {
		log.info("bookInsert() 실행...!");
		
		// ModelAndView는 컨트롤러가 반환할 데이터를 담당하는 모델(Model)과
		// 화면을 담당하는 뷰(View)의 경로를 합쳐놓은 객체입니다.
		// ModelAndView의 생성자에 문자열 타입 파라미터가 입력되면 뷰의 경로라고 간주합니다.
		ModelAndView mav = new ModelAndView();
		// 전달받은 Book 게시판 데이터를 서비스에게 전달 후, 데이터를 저장
		// 저장이 완료되면 Book 게시판 상세보기로 이동
		// 저장이 완료되지 않을 때 다시 등록 페이지로 이동
		String bookId = bookService.insertBook(param);
		if(bookId == null) {
			// 데이터 입력이 실패할 경우 다시 데이터를 입력받아야 하므로 생성 화면으로 redirect한다.
			// ModelAndView 객체는 .setViewName 메소드를 통해 뷰의 경로를 지정할 수 있습니다.
			mav.setViewName("redirect:/book/form.do");
			// 뷰의 경로가 redirect:로 시작하면 스프링은 뷰 파일을 찾아가는 것이 아니라
			// 웹 페이지의 주소(/book/form.do)를 변경한다.
		}else {
			// 데이터 입력이 성공하면 상세 페이지로 이동한다.
			mav.setViewName("redirect:/book/detail.do?bookId=" + bookId);
		}
		
		return mav;
	}
	
}


















