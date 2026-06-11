package kr.or.ddit.user.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout.do")
public class Logout extends HttpServlet{
    
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        // 🔐 현재 세션 가져오기 (없으면 새로 만들지 않음)
	        HttpSession session = request.getSession(false);

	        if (session != null) {
	            // 🔥 로그인 정보 포함, 모든 세션 데이터 제거
	            session.invalidate();
	        }

	        // 🏠 로그아웃 후 메인 페이지로 이동
	        response.sendRedirect("/DaeDukEat/TEST/views/user/main.jsp");
	    }
	
}