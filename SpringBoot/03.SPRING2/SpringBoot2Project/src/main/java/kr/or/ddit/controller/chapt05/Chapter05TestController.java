package kr.or.ddit.controller.chapt05;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.PostConstruct;
import kr.or.ddit.vo.test.TestMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt05/test02")
public class Chapter05TestController {

	@GetMapping("/form")
	public String testForm() {
		return "chapt05/test02/form";
	}

	@PostMapping("/insert")
	public String testInsert(TestMemberVO memberVO, Model model) throws IOException {

		model.addAttribute("memberVO", memberVO);
		log.info("memberVO : " + memberVO);

		if (memberVO.getAttachFile() != null || memberVO.getAttachFile().getSize() > 0) {
			MultipartFile attachFile = memberVO.getAttachFile();

			String contentType = attachFile.getContentType();

			if (contentType.startsWith("image")) {

				byte[] fileBytes = attachFile.getBytes();

				// base64 인코딩
				String base64 = Base64.getEncoder().encodeToString(fileBytes);

				// img src에 넣을 문자열 생성
				String imageSrc = "data:" + contentType + ";base64," + base64;
				log.info("체킁 : " + contentType);

				model.addAttribute("imageSrc", imageSrc);
			}
		}

		return "chapt05/test02/result";
	}

	@GetMapping("/ajaxForm")
	public String testAjaxForm() {
		return "chapt05/test02/ajaxForm";
	}

	@PostMapping(value = "/upload", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> testUpload(MultipartFile file) {
		Map<String, Object> param = new HashMap<>();
		param.put("code", HttpStatus.OK);
		param.put("fileName", file.getOriginalFilename());
		param.put("fileSize", file.getSize());
		param.put("contentType", file.getContentType());

		return new ResponseEntity<Map<String, Object>>(param, HttpStatus.OK);
	}

	// ===========비동기 테스트 =============


	private List<String> imageList;

	@PostConstruct
	public void init() {
		log.info("메소드시작");
		String[] imageFileName = { "audi01.png", "audi02.png", "audi03.png", "audi04.png", "bmw.png", "bmw01.jpg",
				"bmw02.jpg", "bmw03.jpg", "bmw04.jpg", "bmw05.jpg", "gif01.gif", "gif02.gif", "gif03.gif", "gif04.gif",
				"jeep01.jpg", "jeep02.jpg", "jeep03.jpg", "jeep04.jpg", "jeep05.jpg", "jeep06.jpg" };
		imageList = new ArrayList<>();
		
		for (int i = 0; i < imageFileName.length; i++) {
			imageList.add(imageFileName[i]);
		}
	}
	
	
	@GetMapping("/ajaxForm2")
	public String testAjaxForm2(Model model) {
		
		model.addAttribute("imageFileList", imageList);
		
		return "chapt05/test02/ajaxForm2";
	}
	
	@ResponseBody
	@GetMapping("/typeResult")
	public ResponseEntity<List<String>> typeResult(String typeP,Model model) {
		log.info(typeP);
		init();
		List<String> selectImageList = new ArrayList<>();
		
		for(String imageFileName : imageList) {
			if(imageFileName.substring(imageFileName.lastIndexOf(".")+1).equals(typeP) ) {
				
				selectImageList.add(imageFileName);
			}
		}
		
		if(typeP.equals("all")) {
			selectImageList = imageList;
		}
		
	    return new ResponseEntity<List<String>>(selectImageList,HttpStatus.OK );
	}
}