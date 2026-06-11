package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.IBookService;

@Controller
@RequestMapping("/book")
public class BookRetrieveController {
	
	private Logger log = LoggerFactory.getLogger(BookRetrieveController.class);
	
	@Autowired
	private IBookService bookService;
	
	// 책 목록 화면을 요청
	@GetMapping("/list.do")
	public ModelAndView bookList(@RequestParam Map<String,Object> map) {
		log.info("bookList() 실행...!");
		
		List<Map<String, Object>> list = bookService.selectBookList(map);
		
		ModelAndView mav = new ModelAndView();
		
		//검색 기능 추가
		if(map.containsKey("keyword")) {
			mav.addObject("keyword",map.get("keyword"));
		}
		
		mav.addObject("bookList",list);
		mav.setViewName("book/list");
		return mav;
	}
	
	
	
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