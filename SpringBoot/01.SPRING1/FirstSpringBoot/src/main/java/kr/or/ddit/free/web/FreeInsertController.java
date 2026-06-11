package kr.or.ddit.free.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.free.service.IFreeService;
import kr.or.ddit.vo.ServiceResult;
import kr.or.ddit.vo.FreeVO;

@Controller
@RequestMapping("/free")
public class FreeInsertController {
	
	@Autowired
	private IFreeService freeService;
	
	@GetMapping("/insert.do")
	public String insertFormFreeBoard() {
		
		String goPage = "";
		
		goPage = "free/form";
		
		return goPage;
	}

	
	@PostMapping("/insert.do")
	public String insertFreeBoard(FreeVO freeVO, Model model) {
		
		String goPage = "";
		
		ServiceResult result;
		freeVO.setFreeWriter("b001");
		result = freeService.insertFreeBoard(freeVO);
		
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/free/detail.do?freeNo="+freeVO.getFreeNo();
		}else {
			goPage = "free/form";
		}
		
		
		
		return goPage;
	}


}
