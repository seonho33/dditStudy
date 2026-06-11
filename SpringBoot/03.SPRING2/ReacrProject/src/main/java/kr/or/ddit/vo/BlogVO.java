package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BlogVO {
	private int blogNo;
	private String blogTitle;
	private String blogContent;
	private String blogWriter;
	private String blogDate;
	private int blogHit;
	
	// 목록 데이터 조회 시, 추가 사항
	private String memProfileimg;	// 작성자 프로필이미지
	private int fileCnt;			// 작성된 파일 갯수
	
	private MultipartFile[] blogFile;
	private List<BlogFileVO> blogFileList;
	
	public void setBlogFile(MultipartFile[] blogFile) {
		this.blogFile = blogFile;
		if(blogFile!=null){
			List<BlogFileVO> blogFileList = new ArrayList<BlogFileVO>();
			for (MultipartFile item : blogFile) {
				if (StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				BlogFileVO blogFileVO = new BlogFileVO(item);
				blogFileList.add(blogFileVO);
			}
			this.blogFileList = blogFileList;
		}
	}
}
