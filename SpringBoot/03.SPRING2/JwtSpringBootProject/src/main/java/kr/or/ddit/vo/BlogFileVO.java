package kr.or.ddit.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BlogFileVO {
	private MultipartFile item;
	private int blogNo;
	private int fileNo; 
	private String fileName;
	private Long fileSize;
	private String fileFancysize;
	private String fileMime;
	private String fileSavepath;
	private Integer fileDowncount;
	
	public BlogFileVO(){}
	
	public BlogFileVO(MultipartFile item){
		this.item =item;
		fileName=item.getOriginalFilename();
		fileSize=item.getSize();
		fileMime=item.getContentType();
		fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}
}
