package kr.or.ddit.controller;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.view.AbstractView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NoticeDownloadView extends AbstractView {

	// AbstractView 클래스를 상속받아 renderMergedOutputModel 메소드를 재정의 하여
	// 사용하면 해당 클래스가 View 역할을 하는 페이지의 형태가 됩니다.

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> noticeFileMap = (Map<String, Object>)model.get("noticeFileMap");
		File saveFile = new File(noticeFileMap.get("fileSavepath").toString());
		String fileName = noticeFileMap.get("fileName").toString();
		
		String agent = request.getHeader("User-Agent");
		
		if(StringUtils.containsIgnoreCase(agent, "msie")||
				StringUtils.containsIgnoreCase(agent, "trident")) {	//IE, Chrome
			fileName = URLEncoder.encode(fileName, "UTF-8");
		}else {	//fireFox, Chrome
			fileName = new String(fileName.getBytes(),"ISO-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
		response.setHeader("Content-Length", noticeFileMap.get("fileSize").toString());
		
		// try(){} :: try with resource
		// () 안에 명시된 객체는 finally로 최종 열린 객체에 대한 close()를 처리하지 않아도 자동  close()가 이루어진다
		try(
			OutputStream os = response.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);	// 파일데이터를 응답으로 전달
			/*
			try(
			inputStream is = new FileInputStream(saveFile);
			OutputStream os = response.getOutPutStream();
			){
				byte[] buffer = new byte[1024];	
				int rd;
				while((re = is.read(buffer)) != -1){
					os.writer(buffer,0,re);
				}
				os.flush();
			}
			
			*/
		}
	}
}
