package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ImageUpload {

	@Value("${kr.or.ddit.upload.path}")
	private String uploadPath;
	
	@RequestMapping("/imageUpload.do")
	public String imageUpload(
			HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile) throws Exception {
		// CKEditor4 특정 버전 이후부터 html 형식의 데이터를 리턴하는 방법에서 JSON 데이터를 구성해서
		// 리턴하는 방식으로 변경됨
		JsonObject json = new JsonObject();	// JSON 객체를 만들기 위한 준비
		PrintWriter printWriter = null;		// 외부 응답으로 내보낼 때 사용할 객체
		OutputStream out = null;			// 본문 내용에 추가한 이미지를 파일로 생성할 객체
		long limitSize = 1024*1024*2;		// 업로드 파일 최대 크기 (2MB) 
		
		// CKEditor 본문 내용에 이미지를 업로드 해보면 'upload' 라는 키로 파일 데이터가 전달되는걸 확인할 수 있다.
		MultipartFile file = multiFile.getFile("upload");
		
		// 파일 객체가 null이 아니고, 파일 사이즈가 존재하는 => (파일이 존재할 때)
		if(file != null && file.getSize()>0 && StringUtils.isNotBlank(file.getName())) {
			if(file.getContentType().toLowerCase().startsWith("image/")) {
				if(file.getSize() > limitSize) {	// 업로드 한 파일 사이즈가 최대보다 클 때
					/*
						{
							"uploaded" : 0,
							"error" : [
									{
										"message":"2MB 미만의 이미지만 업로드 가능합니다!"
									}
								]
						}
					*/
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message","2MB 미만의 이미지만 업로드 가능합니다!");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error",jsonArr.get(0));
					
					resp.setCharacterEncoding("UTF-8");
					printWriter = resp.getWriter();
					printWriter.println(json);
					
				}else {
					/*
						{
							"uploaded"	: 1,
							"fileName"	: "UUID_원본파일명",
							"url"		: "/upload/img/UUID_원본파일명"
						}
					*/
					try {
						String originalFileName = file.getOriginalFilename();
						String fileName = UUID.randomUUID().toString()+"_"+originalFileName.replaceAll(" ", "_");
						byte[] bytes = file.getBytes();
						String path = uploadPath+"img";
						File uploadFile = new File(path);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						
						path += "/" + fileName;
						out = new FileOutputStream(new File(path));
						out.write(bytes);
						
						String fileUrl = req.getContextPath()+"/upload/img/" + URLEncoder.encode(fileName,"UTF-8");
						
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						resp.setCharacterEncoding("UTF-8");
						printWriter = resp.getWriter();
						printWriter.println(json);
						
					} catch (Exception e) {
						e.printStackTrace();
					}finally {
						if(out !=null) {
							out.close();
						}
						if(printWriter!=null) {
							printWriter.close();
						}
					}
					
					
				}
			}
		}
		
		return "";
	}
	
}
