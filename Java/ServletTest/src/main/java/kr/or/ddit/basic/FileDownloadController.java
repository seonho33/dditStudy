package kr.or.ddit.basic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * Servlet implementation class FileDownloadController
 */
@WebServlet("/download.do")
public class FileDownloadController extends HttpServlet {

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	/*
		파일 다운로드 처리시 Content-Disposition 헤더 처리에 대하여...
		
		Content-Disposition: inline(default)
		Content-Disposition: attachment
		Content-Disposition: attachment; filename="abc.jpg"
		
		
	*/
		String fileName="한글 파일.jpg";
		response.setHeader("Content-disposition", "attachment; filename=\""//Content-disposition의 defalut는 inline/브라우저에 그냥 띄움/attachment는 다운로드
		+URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20")+"\"");
		
		// URL에는 공백문자를 포함할 수 없다. URLEncoder를 이용하여 인코딩 작업을
		// 하면 공백은 (+)문자로 표시되기 때문에 +를 공백문자인 %20으로 바꿔준다.
		
		//일반적인 바이너리 파일..
		response.setContentType("application/octet-stream");
		
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream("d:/D_Other/치와와.jpg"));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		int data = 0;
		while((data = bis.read()) != -1){
			bos.write(data);
		}
		bis.close();
		bos.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static void main(String[] args) throws UnsupportedEncodingException {
		//공백문자 관련 예제
		System.out.println(URLEncoder.encode("파일 입니다.","UTF-8"));
		System.out.println(URLDecoder.decode("%ED%8C%8C%EC%9D%BC+%EC%9E%85%EB%8B%88%EB%8B%A4.","UTF-8"));
	}
}
