package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.ObjFromJson;
import kr.or.ddit.util.ObjJson;

import java.io.BufferedReader;
import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class InsertMember
 */
@WebServlet("/InsertMember.do")
public class InsertMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	
		
		
		
		
	}

	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request의 정보를 BufferedReader를 이용해서 readLine(), 데이터를 append 해서 나온 return 값 
		MemberVO mv = ObjJson.fromJson(request, MemberVO.class);
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		int cnt = memberService.insertMember(mv);
		
		request.setAttribute("cnt", cnt);
		
		request.getRequestDispatcher("/0107/insert.jsp").forward(request, response);
		
	}
}
