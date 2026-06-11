package kr.or.ddit.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.IBookService;

@Controller
@RequestMapping("/book")
public class BookRetrieveController {

	// 콘솔창에 log를 출력하기 위한 객체
	private Logger log = 
				LoggerFactory.getLogger(BookRetrieveController.class);

	@Autowired
	private IBookService bookService;
	
	// 책 목록 화면을 요청
	@GetMapping("/list.do")
	public String bookList() {
		log.info("bookList() 실행...!");
		return "book/list";
	}
	
	// 책 상세보기 화면을 요청
	@GetMapping("/detail.do")
	public ModelAndView bookDetail(int bookId) {
		log.info("bookDetail() 실행...!");
		log.info("# bookId : " + bookId);
		Map<String, Object> detailMap = bookService.selectBook(bookId);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("book", detailMap);
		mav.addObject("bookId", bookId);
		mav.setViewName("book/detail");
		return mav;
	}
}








