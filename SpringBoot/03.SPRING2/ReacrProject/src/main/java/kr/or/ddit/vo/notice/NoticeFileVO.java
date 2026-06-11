package kr.or.ddit.vo.notice;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

public class NoticeFileVO {
	private MultipartFile item;
	private Integer boNo;
	private Integer fileNo; 
	private String fileName;
	private Long fileSize;
	private String fileFancysize;
	private String fileMime;
	private String fileSavepath;
	private Integer fileDowncount;
	
	public NoticeFileVO(){}
	
	public NoticeFileVO(MultipartFile item){
		this.item =item;
		fileName=item.getOriginalFilename();
		fileSize=item.getSize();
		fileMime=item.getContentType();
		fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
	}
	public MultipartFile getItem() {
		return item;
	}
	public void setItem(MultipartFile item) {
		this.item = item;
	}
	public Integer getBoNo() {
		return boNo;
	}
	public void setBoNo(Integer boNo) {
		this.boNo = boNo;
	}
	public Integer getFileNo() {
		return fileNo;
	}
	public void setFileNo(Integer fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileFancysize() {
		return fileFancysize;
	}
	public void setFileFancysize(String fileFancysize) {
		this.fileFancysize = fileFancysize;
	}
	public String getFileMime() {
		return fileMime;
	}
	public void setFileMime(String fileMime) {
		this.fileMime = fileMime;
	}
	public String getFileSavepath() {
		return fileSavepath;
	}
	public void setFileSavepath(String fileSavepath) {
		this.fileSavepath = fileSavepath;
	}
	public Integer getFileDowncount() {
		return fileDowncount;
	}
	public void setFileDowncount(Integer fileDowncount) {
		this.fileDowncount = fileDowncount;
	}
	
}
