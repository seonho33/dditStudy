package kr.or.ddit.controller;

import java.util.List;
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

@Controller
@RequestMapping("/book")
public class BookModifyController {

	private Logger log = LoggerFactory.getLogger(BookModifyController.class);
	
	//Di(dependency inject)
	@Autowired
	private IBookService bookService;
	
	@GetMapping("/update.do")
	public ModelAndView updateBookForm(@RequestParam Map<String, Object> map) {
		log.info("updateBookForm() 실행...!");
		log.info("# bookId : " + map.get("bookId"));
		
		String bookId = map.get("bookId").toString();
		Map<String, Object> detailMap = bookService.selectBook(Integer.parseInt(bookId));
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("book",detailMap);
		mav.setViewName("book/update");
		return mav;
	}
	
	@PostMapping("/update.do")
	public ModelAndView updateBook(@RequestParam Map<String,Object> map) {
		log.info("updateBook() 실행...!");
		
		ModelAndView mav = new ModelAndView();
		
		boolean isUpdateSucess = bookService.updateBook(map);
		
		if(isUpdateSucess) {// 수정 성공
			//수정이 완료되었다면 페이지 이동은 수정이 완료된 결과를 확인하기 위해서 상세보기로 이동합니다
			String bookId = map.get("bookId").toString();
			mav.setViewName("redirect:/book/detail.do?bookId="+bookId);
		}else {				// 수정 실패
			mav = this.updateBookForm(map);
			
		}
		return mav;
	}
	

	
	
	@PostMapping("/delete.do")
	public ModelAndView deleteBook(@RequestParam Map<String,Object> map) {
		log.info("deleteBook() 실행...!");
		
		ModelAndView mav = new ModelAndView();
		
		boolean isDeleteSuccess = bookService.removeBook(map);
		if(isDeleteSuccess) {
			mav.setViewName("redirect:/book/list.do");
		}else {
			String bookId = map.get("bookId").toString();
			mav.setViewName("redirect:/book/detail.do?bookId"+bookId);
		}
		return mav;
	}
}
