package kr.or.ddit.controller.chapt08.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.controller.chapt08.board.service.IBoardService;
import kr.or.ddit.vo.crud.Board;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/crud/board")
public class CrudBoardController {

	
	//DI 적용
	@Autowired
	private IBoardService service;
	
	//등록 페이지 요청
	@GetMapping("/register")
	public String crudRegisterForm() {
		log.info("crudRegisterForm()...실행!");
		
		return "chapt08/board/register";
	}
	
	// 등록 기능 요청
	@PostMapping("/register")
	public String crudRegister(Board board, Model model) {
		log.info("crudRegister()...실행!");
		// Controller > Service 등록 요청
		service.register(board);
		model.addAttribute("msg",board.getBoardNo() + "번 게시글 등록이 완료되었습니다.");
		return "chapt08/board/sucess";
	}
	
	
	//목록 페이지 요청
	@GetMapping("/list")
	public String crudList(Model model) {
		log.info("crudRegisterForm()...실행!");
		
		List<Board> boardList = service.list();
		
		model.addAttribute("boardList",boardList);
		
		return "chapt08/board/list";
	}
	
	@GetMapping("/read")
	public String crudRead(
			int boardNo,
			Model model) {
		log.info("crudRead()...실행!");
		Board board = service.read(boardNo);
		
		model.addAttribute("board",board);
		
		return "chapt08/board/detail";
	}
	
	@GetMapping("/modify")
	public String crudModifyForm(
			int boardNo,
			Model model
			) {
		log.info("crudModifyForm()...실행!");
		Board board = service.read(boardNo);
		
		model.addAttribute("board",board);
		model.addAttribute("status","update");
		
		return "chapt08/board/register";
	}
	
	@PostMapping("/modify")
	public String crudModify(Board board, Model model ) {
		log.info("crudModify()...실행!");
		service.modify(board);
		
		model.addAttribute("board",board);
		model.addAttribute("msg","수정이 완료되었습니다.");
		
		return "chapt08/board/sucess";
	}
	
	//삭제기능요청
	@PostMapping("/crudRemove")
	public String crudRemove(int boardNo,Model model) {
		log.info("crudRemove()...실행!");
		service.Remove(boardNo);
		model.addAttribute("msg","삭제했습니다");
		
		return "chapt08/board/sucess";
	}
	
	//검색기능요청
	@PostMapping("/search")
	public String crudSearch(Board board, Model model) {
		
		log.info("crudSearch()...실행!");
		
		List<Board> boardList = service.search(board);

		model.addAttribute("board",board);
		model.addAttribute("boardList",boardList);
		
		return "chapt08/board/list";
	}
}
