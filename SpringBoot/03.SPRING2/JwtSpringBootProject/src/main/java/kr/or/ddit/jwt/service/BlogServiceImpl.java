package kr.or.ddit.jwt.service;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.jwt.mapper.IBlogMapper;
import kr.or.ddit.util.TokenProvider;
import kr.or.ddit.vo.BlogFileVO;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.BlogVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class BlogServiceImpl implements IBlogService {

	@Autowired
	private IBlogMapper blogMapper;
	
	@Autowired
	private TokenProvider tokenProvider;
	
	@Value("${upload_profile_path}")
	private String UPLOAD_PROFILE_PATH;
	@Value("${upload_blog_path}")
	private String UPLOAD_BLOG_PATH;
	
	@Autowired
	private PasswordEncoder pe;
	
	@Override
	public ServiceResult idCheck(String memId) {
		
		ServiceResult result= null;
		BlogMemberVO memberVO = blogMapper.idCheck(memId);
		
		if(memberVO != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

	@Override
	public ServiceResult signup(BlogMemberVO memberVO) {
		ServiceResult result = null;
		
		// 프로필 이미지 처리
		File file = new File(UPLOAD_PROFILE_PATH);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String uploadPath = "";
		String profileImg = "";	// 회원정보에 추가될 프로필 이미지 경로
		
		try {
			// 넘겨받은 회원 정보에서 프로필 파일 데이터 가져오기
			MultipartFile profileImgFile = memberVO.getMemFile();
			
			if(profileImgFile != null && profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + profileImgFile.getOriginalFilename();
				
				// /upload/blog/profile/uuid_원본파일명
				uploadPath = UPLOAD_PROFILE_PATH + "/" + fileName;
				profileImgFile.transferTo(new File(uploadPath));	// 파일 복사
				profileImg = "/upload/blog/profile/" + fileName;
			}
			
			memberVO.setMemProfileimg(profileImg);

		}catch(Exception e) {
			e.printStackTrace();
		}

		// 시큐리티 암호화 설정
		String password = memberVO.getMemPw();
		password = pe.encode(password);
		memberVO.setMemPw(password);
		
		int status = blogMapper.signup(memberVO);
		if(status>0) {
			blogMapper.addMemberAuth(memberVO.getMemNo());
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public String signin(BlogMemberVO memberVO) {
		String token = null;
		BlogMemberVO member = blogMapper.signin(memberVO);
		
		// 클라이언트에서 입력받아온 데이터(아이디, 비밀번호) 중, 아이디로만 먼저 회원정보를 조회하고
		// 아이디와 일치하는 회원정보를 이용해서 저장된 비밀번호와 사용자가 입력한 비밀번호가 일치하는지 여부를 확인한다.
		// 클라이언트에서 입력된 비밀번호가 예를들어 '1234' 라고 하고, DB에 저장된 비밀번호가 '$21aRE...' 라고
		// 가정한다면 두 문자열은 일치할 수 없다. 그렇지만 '1234' 평문의 비밀번호를 암호화하고 비교한다면, 시큐리티에서
		// 만들어내는 약 56억개의 다이제스트 목록과 비교할 때 일치여부를 판단할 수 있다.
		// 판단 했을 때 목록에 포함된 비밀번호라면 비밀번호 인증까지 완료된 상태이므로 토큰을 발급한다.
		
		if(member != null && pe.matches(memberVO.getMemPw(), member.getMemPw())) {
			token = tokenProvider.generateToken(member,Duration.ofMinutes(30));
		}
		
		return token;
	}

	@Override
	public ServiceResult insert(BlogVO blogVO) {
		ServiceResult result = null;
		
		int status = blogMapper.insert(blogVO);
		if(status>0) {
			try {
				blogFileUpload(blogVO.getBlogFileList(),blogVO.getBlogNo());
			} catch (IOException e) {
				e.printStackTrace();
			}
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	private void blogFileUpload(List<BlogFileVO> blogFileList, int blogNo) throws IOException {
		if(blogFileList != null && blogFileList.size() > 0) {
			for(BlogFileVO blogFileVO : blogFileList) {
				String saveName = UUID.randomUUID().toString()+"_"+blogFileVO.getFileName().replaceAll(" ", "_");
				
				String saveLocate = UPLOAD_BLOG_PATH + "/" + blogNo;
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				// C:/upload/blog/no/UUID_원본파일명
				saveLocate += "/" + saveName;
				
				blogFileVO.setBlogNo(blogNo);
				blogFileVO.setFileSavepath(saveLocate);
				blogMapper.insertBlogFile(blogFileVO);
				
				File saveFile = new File(saveLocate);
				blogFileVO.getItem().transferTo(saveFile);
			}
		}
	}

	@Override
	public int selectBlogCount(PaginationInfoVO<BlogVO> pagingVO) {
		return blogMapper.selectBlogCount(pagingVO);
	}

	@Override
	public List<BlogVO> selectBlogList(PaginationInfoVO<BlogVO> pagingVO) {
		List<BlogVO> resultList = new ArrayList<>();
		List<BlogVO> blogList = blogMapper.selectBlogList(pagingVO);
		if(blogList !=null && blogList.size()>0)
			for(int i=0; i<blogList.size(); i++) {
				int startRow = pagingVO.getStartRow();
				int endRow = pagingVO.getEndRow();
				if((i+1)>=startRow&& (i+1)<=endRow) {
					resultList.add(blogList.get(i));
				}
			}
		
		return resultList;
	}

	@Override
	public BlogVO detail(int blogNo) {
		blogMapper.incrementHit(blogNo);
		
		return blogMapper.detail(blogNo);
	}
	
	
	
}
