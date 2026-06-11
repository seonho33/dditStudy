package kr.or.ddit.free.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.free.service.IFreeService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping("/free")
public class FreeRetrieveController {
	
	@Autowired
	private IFreeService freeService;
	
	@RequestMapping("/list.do")
	public String listFreeBoard(Model model) {
		
		List<BoardVO> boardVO = freeService.selectFreeBoardList();
		
		model.addAttribute("boardVOList",boardVO);
		
		String goPage = "";
		
		goPage = "free/list";
		
		return goPage;
	}
	
	@GetMapping("/detail.do")
	public String detailFreeBoard(int freeNo, Model model) {
		
		String goPage = "";
		
		FreeVO freeVO = freeService.selectFreeBoard(freeNo);
		
		model.addAttribute("freeVO",freeVO);
		
		goPage ="free/view";
		
		return goPage;
	}
}
