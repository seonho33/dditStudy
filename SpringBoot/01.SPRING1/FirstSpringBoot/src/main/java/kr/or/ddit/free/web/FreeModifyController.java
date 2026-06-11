package kr.or.ddit.free.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.free.service.IFreeService;
import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.ServiceResult;

@Controller
@RequestMapping("/free")
public class FreeModifyController {

	@Autowired
	private IFreeService service;
	
	@GetMapping("/update.do")
	public String updateFormFreeBoard(int freeNo, Model model) {
		
		String goPage ="";
		
		FreeVO freeVO = service.selectFreeBoard(freeNo);
		
		model.addAttribute("freeVO",freeVO);
		model.addAttribute("update","update");
		
		goPage = "free/form";
		
		return goPage;
	}
	
	@PostMapping("/update.do")
	public String updateFreeBoard(FreeVO freeVO,Model model) {
		String goPage = "";
		ServiceResult result;
		result = service.updateFreeBoard(freeVO);
		
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/free/detail.do?freeNo="+freeVO.getFreeNo();
		}else {
			goPage = "redirect:/free/update.do?freeNo="+freeVO.getFreeNo();
		}
		
		return goPage;
	}
	
	@PostMapping("/delete.do")
	public String deleteFreeBoard(int freeNo) {
		String goPage = "";
		ServiceResult result;
		result = service.deleteFreeBoard(freeNo);
		
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/free/list.do";
		}else {
			goPage = "redirect:/free/detail.do?freeNo="+freeNo;
		}
		
		return goPage;
	}
}
