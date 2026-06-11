package kr.or.ddit.jwt.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.jwt.service.IBlogService;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.BlogVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

// 데이터만 처리할 컨트롤러

@Slf4j
@RestController
@RequestMapping("/api/blog")
public class BlogAPIController {

	@Autowired
	private IBlogService blogService;

	@Autowired
	private PasswordEncoder pe;
	
	@PostConstruct
public void init() {
	log.info("### " + pe.encode("1234"));
	log.info("### " + pe.encode("1234"));
	log.info("### " + pe.encode("1234"));
	log.info("### " + pe.encode("1234"));
	log.info("### " + pe.encode("1234"));
	log.info("### " + pe.encode("1234"));
}
	
	@PostMapping("/idCheck")
	public ResponseEntity<String> blogIdCheck(
			@RequestBody Map<String,String> param){
		
		ServiceResult result = blogService.idCheck(param.get("memId"));
		
		return new ResponseEntity<String>(result.toString(),HttpStatus.OK);
	}
	
	@PostMapping("/signup")
	public ResponseEntity<String> blogSignUp(
			BlogMemberVO memberVO){
		ResponseEntity<String> entity = null;
		ServiceResult result = blogService.signup(memberVO);
		
		if(result.equals(ServiceResult.OK)) {
			entity = new ResponseEntity<String>(result.toString(),HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PostMapping("/signin")
	public ResponseEntity<String> blogLoginCheck(
			@RequestBody BlogMemberVO memberVO){
		ResponseEntity<String> entity = null;
		log.info("메서드실행()");
		String token = blogService.signin(memberVO);
		if(token!=null) {
			entity = new ResponseEntity<String>(token,HttpStatus.OK);
			}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
		return entity;
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@PostMapping("/insert")
	public ResponseEntity<String> blogInsert(BlogVO blogVO){
		ResponseEntity<String> entity = null;
		
		CustomUser user =
				(CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		BlogMemberVO memberVO = user.getMember();
		blogVO.setBlogWriter(memberVO.getMemId());
		
		ServiceResult result = blogService.insert(blogVO);
		
		if(result.equals(ServiceResult.OK)) {
			entity = new ResponseEntity<String>(result.toString(),HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;				
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@GetMapping("/list")
	public ResponseEntity<PaginationInfoVO<BlogVO>> blogList(
			@RequestParam int page
	) {
		PaginationInfoVO<BlogVO> pagingVO = new PaginationInfoVO<>(5,3);
		pagingVO.setCurrentPage(page);
		int totalRecord = blogService.selectBlogCount(pagingVO);	// 총 게시글 수 조회
		pagingVO.setTotalRecord(totalRecord);
		List<BlogVO> blogList = blogService.selectBlogList(pagingVO);
		pagingVO.setDataList(blogList);
		
		return ResponseEntity.ok(pagingVO);
	}
	
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@GetMapping("/detail/{blogNo}")
	public ResponseEntity<BlogVO> blogDetail(
			@PathVariable int blogNo
			){
		return ResponseEntity.ok().body(blogService.detail(blogNo));
	}
}
