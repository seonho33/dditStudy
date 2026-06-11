package kr.or.ddit.controller.chapt09.item02;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.chapt09.item02.service.IItem2Service;
import kr.or.ddit.vo.Item2;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/item2")
public class Chapter09FileUploadController2 {
	
	/*
	 * 2.비동기 방식 업로드
	 * 
	 * - 비동기 방식으로 여러개의 이미지를 업로드 하는 파일 업로드 기능을 구현합니다
	 * 
	 * #환경 설정
	 * -의존 관계 등록 (pom.xml) 설정
	 * > commons-io
	 * >imgscalr-lib
	 * 
	 * #파일 업로드 구현 설명
	 * -파일 업로드 등록화면 컨트롤러 만들기(FileUploadController02)
	 * -파일 업로드 등록 화면 컨트롤러 메소드 만들기(item2RegisterForm:get)
	 * -파일 업로드 등록 화면 만들기( item2/register.jsp)
	 * -여기까지 확인
	 * 
	 * -파일 업로드 등록 기능 컨트롤러 메소드 만들기(item2Register:post)
	 * -파일 업로드 등록 기능 서비스 인터페이스 메소드 만들기
	 * -파일 업로드 등록 기능 서비스 클래스 메소드 만들기
	 * -파일 업로드 등록 Mapper 인터페이스 만들기
	 * -파일 업로드 등록 Mapper xml 쿼리 만들기
	 * -파일 업로드 등록 완료 페이지 만들기
	 * -여기까지 확인
	 * 
	*/
	
	@Autowired
	private IItem2Service service;
	
	@Value("${kr.or.ddit.upload.path}")
	private String uploadPath;
	
	
	@GetMapping("/register")
	public String Item2RegisterForm() {
		log.info("registerForm() 실행...!");
		return "chapt09/item2/register";
	}
	
	@PostMapping("/register")
	public String Item2Register(Item2 item, Model model) {
		log.info("Item2Register() 실행됨...!");
		
		service.register(item);
		
		model.addAttribute("msg","등록 성공!");
		
		return "chapt09/item2/success";
	}
	
	@GetMapping("/list")
	public String item2List(Model model) {
		List<Item2> itemList = service.list();
		model.addAttribute("itemList",itemList);
		return "chapt09/item2/list";
	}
	
	@GetMapping("/remove")
	public String item2Remove(int itemId,Model model) {
		Item2 item = service.read(itemId);
		model.addAttribute("item",item);
		return "chapt09/item2/remove";
	}
	
	@GetMapping("/modify")
	public String item2ModifyForm(int itemId,Model model) {
		Item2 item = service.read(itemId);
		model.addAttribute("item",item);
		return "chapt09/item2/modify";
	}

	@PostMapping("/modify")
	public String item2Modify(Item2 item,Model model) {
		service.modify(item);
		model.addAttribute("msg","수정완료");
		return "chapt09/item2/success";
	}
	
	@GetMapping("/getAttach/{itemId}")
	public ResponseEntity<List<String>> getAttach(@PathVariable int itemId){
		return new ResponseEntity<List<String>>(service.getAttach(itemId),HttpStatus.OK);
	}
	
	@PostMapping(value="/uploadFile",produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> uploadFile(MultipartFile file) throws Exception{
		log.info("uploadFile() 실행...!");
		
		//파일 업로드 진행 후 , 응답으로 내보낼 업로드 된 파일의 경로를 리턴
		//리턴값 : '/년/월/일/uuid_원본파일명'
		String savedName = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
		
		return new ResponseEntity<String>(savedName,HttpStatus.OK);
	}
	
	//썸네일 이미지 요청
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		InputStream ins = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			//확장자 추출
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaTye(formatName);
			
			HttpHeaders headers = new HttpHeaders();
			ins = new FileInputStream(uploadPath + File.separator + fileName);
			if(mType != null) {	// 이미지일때, 썸네일 이미지를 볼 수 있도록 헤더 설정
				headers.setContentType(mType);
			}else {				// 일반 파일 일때, 다운로드 기능이 실행 될 수 있도록 헤더 설정
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment;filename=\""+
				new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(ins),headers,HttpStatus.CREATED);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			if(ins!=null)ins.close();
		}
		return entity;
	}
	
}