package kr.or.ddit.board.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ServiceResult;

@Controller
@RequestMapping("/board")
public class BoardModifyController {
	
	@Autowired
	private IBoardService boardService;
	
	@GetMapping("/update.do")
	public String boardUpdateForm(int boNo, Model model) {
		BoardVO boardVO = boardService.selectBoard(boNo);
		model.addAttribute("board",boardVO);
		model.addAttribute("status","u");	// 등록과 수정이 같은 form 으로 이동되므로 구별점을 두기 위해서 status 라는 항목을 만듬
		
		return "board/form";
	}

	@PostMapping("/update.do")
	public String boardUpdate(BoardVO boardVO, Model model) {
		ServiceResult  result =  boardService.updateService(boardVO);
		String goPage ="";
		if(result.equals(ServiceResult.OK)) { //update 성공!
			goPage = "redirect:/board/detail.do?boNo="+boardVO.getBoNo();
		}else {
			model.addAttribute("board",boardVO);
			model.addAttribute("status","u");
			goPage = "board/form";
		}
		return goPage;
	}
	
	@PostMapping("delete.do")
	public String boardDelete(int boNo, Model model) {
		String goPage ="";
		ServiceResult result = boardService.deleteBoard(boNo);
		if(result.equals(ServiceResult.OK)) {		// 삭제 성공
			goPage = "redirect:/board/list.do";
		}else {
			goPage = "redirect:/board/detail.do?boNo="+boNo;
		}
		
		return goPage;
	}
	
}
