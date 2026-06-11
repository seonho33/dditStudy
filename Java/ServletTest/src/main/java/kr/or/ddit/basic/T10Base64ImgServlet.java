package kr.or.ddit.basic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;

/**
 * Servlet implementation class T10Base64ImgServlet
 */
@WebServlet("/base64Img.do")
public class T10Base64ImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		BufferedInputStream bis = new BufferedInputStream(
										new FileInputStream("d:/D_Other/치와와.jpg"));
		int data =0;
		while((data = bis.read())!=-1) {
			baos.write(data);
		}
		
		bis.close();
		/////////////////////////
		
		String base64Str = Base64.getEncoder().encodeToString(baos.toByteArray());
		
		System.out.println("base64Str : " + base64Str);
		
		request.setAttribute("base64Str", base64Str);
		
		request.getRequestDispatcher("/base64img.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
