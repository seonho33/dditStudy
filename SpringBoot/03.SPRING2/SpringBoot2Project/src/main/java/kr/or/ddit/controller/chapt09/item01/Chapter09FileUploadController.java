package kr.or.ddit.controller.chapt09.item01;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.jspecify.annotations.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.controller.chapt09.item01.service.IItemService;
import kr.or.ddit.vo.Item;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/item")
public class Chapter09FileUploadController {
	/*
		[9장 : 파일업로드]
		
		1. 파일업로드 설명
		- 서블릿 3.0 에서 지원하는 파일 업로드 기능과 스프링 웹에서 제공하는 컴포넌트를 
		사용하여 파일을 업로드 한다
		
			# 파일 업로드 설정
			
			1) 서블릿 3.0 이상
			2) 서블릿 표준 파일 업로드 기능 활성화
			3) 스프링 MVC 와 연계
			4) 업로드 된 파일 저장 위치 설정
	
		# 환경 설정
			1) 의존 관계 정의
			- 파일을 처리하기 위해서 의존 라이브러리를 추가한다.
			> pom.xml commons-io  추가
			> pom.xml commons-fileupload 추가
			
			2) application.properties 설정
			> spring.servlet.multipart.max-file-size=10MB
			> spring.servlet.multipart.max-request-size=20MB
			> spring.servlet.multipart.file.size-threshold=20MB
			
		# 파일 업로드 경로 설정
		
			1) 파일 업로드 외부 local 경로 설정
			-config 패키지 내, FileConfiguration 클래스생성
			> 파일 업로드 외부 local 경로와 웹 경로를 맵핑하기 위한 설정
			
		# 데이터베이스 준비
			- item 테이블 생성(item, item2, item2_attach)
			
		2. 이미지 업로드
		- 한개의 이미지를 업로드 하는 기본 파일 업로드 기능을 구현합니다.
		
		#파일 업로드 구현 설명
		- 파일 업로드 등록화면 컨트롤러 만들기(FileUploadController)
		- 파일 업로드 등록화면 컨트롤러 메소드 만들기(itemRegisterForm:get)
		- 파일 업로드 등록 화면 만들기(item/register.jsp)
		- 여기까지 확인
	
		- 파일 업로드 목록 화면 컨트롤러 메소드 만들기(itemList:get)
		- 파일 업로드 목록 화면 서비스 인터페이스 메소드 만들기
		- 파일 업로드 목록 화면 서비스 클래스 메소드 만들기
		- 파일 업로드 목록 화면 Mapper 인터페이스 메소드 만들기
		- 파일 업로드 목록 화면 Mapper xml 쿼리 만들기
		- 파일 업로드 목록 화면 만들기(item/list.jsp)
		- 여기까지 확인
	
	*/
	@Autowired
	private IItemService service;
	
	@Value("${kr.or.ddit.upload.path}")
	private String localPath;
	
	
	//등로고하면 요청
	@GetMapping("/register")
	public String itemRegisterForm() {
		log.info("itemRegisterForm() 실행...!");
		
		return "chapt09/item/register";
	}

	
	@PostMapping("/register")
	public String itemRegister(Item item,RedirectAttributes redirectAttributes) throws Exception {
		log.info("itemRegister() 실행...!");
		
		// Controller > Service 상품 등록 요청 ( 일반 Data + 파일 Data )
		MultipartFile file = item.getPicture();
		log.info("fileName : " + file.getOriginalFilename());	// 파일명 출력
		
		// 파일 업로드 진행(uploadFile method)
		// 넘겨받은 파일을 이용하여 파일 업로드를 진행 후, 업로드 시 생성한 파일명을 응답으로 받아온다.
		// return UUID + "_" + 원본 파일명
		String createFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		item.setPictureUrl(createFileName);
		service.register(item);
		redirectAttributes.addFlashAttribute("msg","등록완료되었습니다.");
		return "redirect:/item/success";
	}

	@GetMapping("/success")
	public String successPage(Model model) {
		
		return "chapt09/item/success";
	}
	
	// 목록 화면 요청
	@GetMapping("/list")
	public String itemList(Model model) {
		log.info("itemList() 실행...!");
		List<Item> itemList = service.list();
		model.addAttribute("itemList",itemList);
		return "chapt09/item/list";
	}
	
	// 수정 화면 요청
	@GetMapping("/modify")
	public String itemModifyForm(int itemId,Model model) {
		log.info("itemModifyForm()...실..행");
		
		Item item = service.read(itemId);
		
		model.addAttribute("item",item);
		
		return "chapt09/item/modify";
	}
	
	//썸네일 이미지 요청
	@ResponseBody
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(int itemId) throws Exception{
		InputStream ins = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName = service.getPicture(itemId);
		log.info("# fileName : " + fileName);
		
		try {
			//확장자 추출
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = getMediaType(formatName);
			
			HttpHeaders headers = new HttpHeaders();
			ins = new FileInputStream(localPath + File.separator + fileName);
			if(mType != null) {
				headers.setContentType(mType);
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(ins),headers,HttpStatus.CREATED);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			ins.close();
		}
		return entity;
	}
	
	//수정요청 
	@PostMapping("/modify")
	public String itemModify(Item item, RedirectAttributes redirectAtt) throws Exception {
		log.info("itemModify() 실행...!");
		MultipartFile file = item.getPicture();
		
		if(file!=null&&file.getSize()>0) {
			log.info("fileName : " + file.getOriginalFilename());
			
			String createFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
			item.setPictureUrl(createFileName);
		}
		
		service.modify(item);
		
		redirectAtt.addFlashAttribute("msg","수정완료!");
		
		return "redirect:/item/success";
	}
	
	//삭제요청
	@GetMapping("/remove")
	public String itemRemoveForm(int itemId, Model model) {
		
		Item item = service.read(itemId);
		
		model.addAttribute("item",item);
		
		return "chapt09/item/remove";
	}
	
	//삭제요청
	@PostMapping("/remove")
	public String itemRemove(int itemId,RedirectAttributes redirectAtt) {
		
		service.remove(itemId);
		
		redirectAtt.addFlashAttribute("msg","삭제성공!");
		
		return "redirect:/item/success";
	}
	
	
	//이미지 타입 정해주는 함수
	private MediaType getMediaType (String formatName) {
		if(formatName != null) {
			if(formatName.toUpperCase().equals("JPG")) {
				return MediaType.IMAGE_JPEG;
			}
			if(formatName.toUpperCase().equals("JPG")) {
				return MediaType.IMAGE_PNG;
			}
			if(formatName.toUpperCase().equals("GIR")) {
				return MediaType.IMAGE_GIF;
			}
		}
		return null;
	}
	
	// 파일 업로드 함수
	private String uploadFile(String originalFilename, byte[] bytes) throws Exception {
		//수 많은 사람들이 한 공간에 파일 업로드시, 누군가의 파일을 이미 있는 이름을 사용할 수 있습니다.
		// 그렇기 때문에, 파일명 중복을 막기위해 데이터 관리를 해주어야합니다.
		// 그래서 중복된 파일명을 만들지 않도록 UUID를 활용합니다.
		UUID uuid = UUID.randomUUID();
		String createdFileName = uuid + "_" + originalFilename;
		
		File file = new File(localPath);
		
		// Local 경로로 설정한 localPath 변수를 활용하여 폴더 생성을 진행합니다.(C:/upload)
		// 서버 업로드 경로에 폴더가 존재하지 않을 떄 새로 생성합니다.
		if(!file.exists()) {
			file.mkdirs();
		}
		
		//파일 업로드 경로
		//파일 업로드를 진행하기 위한 경로 설정에는 여러가지 방법이 존재하지만, 대표적인 방법 두가지를 살펴보도록 합시다.
		//1) 첫번쨰는 서버 업로드 경로에 파일 업로드 하는 방법입니다.
		// 서버 업로드 경로를 Root('/')의 'resources/upload' 폴더 경로로 설정했다고 가정하면,
		// Source Package에 해당하는 resources/upload 폴더 경로로 파일이 업로드 되지만,  BOOT 에서는
		// 설정 경로가 조금 달라집니다. 서버 업로드 경로는 서버가 배포되어 동작하는 위치인 .metadata/ .plugins로
		// 시작하는 경로로 이어진 경로의 upload 폴더 안에 파일이 생길것 같지만, 실제로는 workspace/내프로젝트/webapp/
		// resuorces/upload로 파일 복사가 이뤄집니다.
		
		//2) 외부 Local 경로에 파일 업로드 하는 방법입니다.
		// C:/upload 경로를 업로드 경로로 설정했다고 가정하면, 파일 업로드 시, 해당 경로에 파일이 복사될 것입니다.
		// 이 때, 외부 Local 경로는 웹 상에서 접근이 불가능합니다. 그렇기 때문에 외부 local 의 경로를 웹 상에서 접속이
		// 가능하도록 설정이 필요합니다.
		// 해당 설정은 @Configuration 어노테이션과 WebMvcConfigurer 객체를 상속받은 해당 클래스의
		// addResourceHandlers() 메소드를 재정의하여 설정 할 수 있습니다. C:/upload 폴더 경로를 웹 상에서는
		// /upload/xxxx.jpg 와 같은 요청으로 파일에 접근 할 수 있습니다.
		File target = new File(localPath, createdFileName);
		FileCopyUtils.copy(bytes,target);
		
		return createdFileName;
	}
}
