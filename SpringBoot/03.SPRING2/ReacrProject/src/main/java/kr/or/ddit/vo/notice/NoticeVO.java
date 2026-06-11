package kr.or.ddit.vo.notice;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
@Alias("noticeVO")
public class NoticeVO {
	private int boNo;
	private String boTitle;
	private String boContent;
	private String boWriter;
	private String boDate;
	private int boHit;
	
	private Integer[] delFileNo;
	private MultipartFile[] boFile;
	private List<NoticeFileVO> noticeFileList;
	private int fileCount;

	public void setBoFile(MultipartFile[] boFile) {
		this.boFile = boFile;
		if(boFile!=null){
			List<NoticeFileVO> noticeList = new ArrayList<NoticeFileVO>();
			for (MultipartFile item : boFile) {
				if (StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				NoticeFileVO noticeFileVO = new NoticeFileVO(item);
				noticeList.add(noticeFileVO);
			}
			this.noticeFileList = noticeList;
		}
	}
}
