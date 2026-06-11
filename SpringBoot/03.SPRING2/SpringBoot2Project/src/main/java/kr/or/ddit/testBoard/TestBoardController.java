package kr.or.ddit.testBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.testBoard.service.ITestBoardService;
import kr.or.ddit.vo.crud.Board;

@Controller
@RequestMapping("/testBoard")
public class TestBoardController {

	
	@Autowired
	private ITestBoardService service;
	
	
	@GetMapping("/register")
	public String registerForm() {
		
		return "testBoard/register";
	}
	
	@GetMapping("/success")
	public String successPage(Model model, String msg) {
		
		model.addAttribute("msg",msg);
		
		return "testBoard/success";
	}
	
	
	@PostMapping("/register")
	public String registerBoard(Board board, RedirectAttributes redirectAttributes) {
		
		service.registerBoard(board);
		
		redirectAttributes.addAttribute("msg","게시글 등록 완료!");
		
		return "redirect:/testBoard/success";
	}
	
	@GetMapping("/list")
	public String getList(Model model) {
		
		List<Board> boardList =  service.getList();
		
		model.addAttribute("boardList",boardList);
		
		return "testBoard/list";
	}
	
	
	
}
