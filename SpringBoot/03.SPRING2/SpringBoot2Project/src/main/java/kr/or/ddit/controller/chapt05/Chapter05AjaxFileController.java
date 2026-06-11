package kr.or.ddit.controller.chapt05;

import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt05/ajax")
public class Chapter05AjaxFileController {

	/*	
		10. 파일 업로드 Ajax 방식 요청 처리
		
	*/	
	// 테스트 페이지
	@GetMapping("/registerFileForm")
	public String ajaxRegisterFileForm() {
		return "chapt05/ajaxRegisterFile";
	}
	
	@PostMapping(value = "/uploadFile", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String,Object>> uploadFile(MultipartFile file){
		log.info("uploadFile() 실행...!");
		
		String originalFileName = file.getOriginalFilename();
		long size = file.getSize();
		String type = file.getContentType();
		
		log.info("originalFileName : " + originalFileName);
		log.info("size : " + size);
		log.info("type : " + type);
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, Object> dataMap = new HashMap<>();
		if(type.startsWith("image/")) {
			resultMap.put("status", HttpStatus.OK);
			dataMap.put("fileName",originalFileName);
			dataMap.put("fileSize",size);
			dataMap.put("fileType",type);
			resultMap.put("data", dataMap);
		}else {
			resultMap.put("status", HttpStatus.BAD_REQUEST);
			resultMap.put("data", null);
		}
		
		
		return new ResponseEntity<Map<String,Object>>(resultMap,HttpStatus.OK);
	}
	
}
