package kr.or.ddit.controller.chapt09.testItem2;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.controller.chapt09.testItem2.service.ITestFileUploadService;

@Controller
@RequestMapping("/test")
public class TestFileUploadController {

	private ITestFileUploadService service;
	
	@GetMapping("/form")
	public String UploadForm() {
		
		return "TEST/register";
	}
	
}
