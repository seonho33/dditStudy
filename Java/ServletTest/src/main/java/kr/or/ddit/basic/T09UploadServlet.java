package kr.or.ddit.basic;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/upload.do")
public class T09UploadServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String sender = req.getParameter("sender");
		
		System.out.println("sender : " + sender);
		
		for(Part part : req.getParts()) {
			System.out.println(part.getHeader("Content-Disposition"));
			
			String fileName = part.getSubmittedFileName();
			System.out.println("fileName : " + fileName);
			
			if(fileName!=null && !fileName.equals("")) {
				// 폼필드가 아니거나 파일이 비어있지 않은경우(첨부파일이 존재할 경우)
				part.write("d:/D_Other/" + fileName);
		
			}
		}
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/plain");
		
		PrintWriter out = resp.getWriter();
		
		out.print("Upload Success!!");
	
	}
}
