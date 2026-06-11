package kr.or.ddit.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class T03ServletParameterTest extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	/*	
		-getParameter() => 파라미터 값이 한개인 경우에 가져올 때 사용함.
		-getParameterValues() => 파라미터 값이 여러개일 경우에 사용함. ex) 체크박스
		-getParameterNames() => 요청메시지에 존재하는 모든 파라미터 이름을 가져올 때 사용함.
		
	*/	
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String gender = req.getParameter("gender");
		String hobby = req.getParameter("hobby");
		String rlgn = req.getParameter("rlgn");
		
		String[] food = req.getParameterValues("food");
		
		////////////////////
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		
		PrintWriter out = resp.getWriter();
		out.println("<!DOCTYPE html><html><head><title>"+"파라미터 처리결과</title></head>");
		out.println("<body>");
		out.println("<p>username : " + username + "</p>");
		out.println("<p>password : " + password + "</p>");
		out.println("<p>gender : " + gender + "</p>");
		out.println("<p>hobby : " + hobby + "</p>");
		out.println("<p>rlgn : " + rlgn + "</p>");
		if(food !=null) {
			for(String f : food) {
				out.print("<P>food : " + f + "</p>");
			}
		}
		out.print("<hr>"); //수평선 긋기
		
		// 모든 요청 파라미터 이름 가져오기
		Enumeration<String> params = req.getParameterNames();
		while(params.hasMoreElements()) {
			String param = params.nextElement();
			out.print("<p>파라미터 이름 : " + param + "</p>");
		}
		
		out.println("</body></html>");
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}