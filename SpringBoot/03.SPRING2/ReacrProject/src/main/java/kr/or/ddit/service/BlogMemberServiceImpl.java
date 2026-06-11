package kr.or.ddit.service;

import java.io.File;
import java.time.Duration;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.IBlogMemberMapper;
import kr.or.ddit.util.TokenProvider;
import kr.or.ddit.vo.BlogMemberVO;


@Service
public class BlogMemberServiceImpl implements IBlogMemberService {

	@Autowired
	private IBlogMemberMapper mapper;

	@Value("${file.savepath.profile}")
	private String profileSavePath;
	
	@Autowired
	private PasswordEncoder pe;
	
	@Autowired
	private TokenProvider tokenProvider;
	
	@Override
	public ServiceResult checkId(String memId) {
		ServiceResult result = null;
		BlogMemberVO member = mapper.checkId(memId);
		if(member != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

	@Override
	public ServiceResult signup(BlogMemberVO memberVO) {
		
		ServiceResult result = null;
		
		File file = new File(profileSavePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String profileImgInfo = "";
		String savepath = "";
		
		try {
			MultipartFile memFile = memberVO.getMemFile();
			String originalFileName = memFile.getOriginalFilename();
			if(memFile != null && originalFileName.trim() != null) {
				String fileName = UUID.randomUUID().toString()+"_"+originalFileName;
				savepath = profileSavePath + "/" + fileName;
				memFile.transferTo(new File(savepath));
				profileImgInfo = "/upload/profile/" + fileName;
			}
			memberVO.setMemProfileimg(profileImgInfo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		memberVO.setMemPw(pe.encode(memberVO.getMemPw()));
		int status = mapper.signup(memberVO);
		if(status > 0) {
			mapper.addAuth(memberVO.getMemNo());
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		
		return result;
	}

	
	@Override
	public String signin(BlogMemberVO memberVO) {
		String token = null;
		BlogMemberVO member = mapper.signin(memberVO);
		if(member!=null && pe.matches(memberVO.getMemPw(), member.getMemPw())) {
			token = tokenProvider.generateToken(memberVO, Duration.ofMinutes(30));
		}
		
		return token;
	}
	
	
	
	
}
