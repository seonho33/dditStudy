package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

import java.io.BufferedReader;
import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.sendRedirect("http://localhost/webpro/Login.do");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//전송 데이터 읽기 - 직렬화된 데이터 {"mem_id" : "a001" , "mem_pass" : "asdfasdf"}
		BufferedReader br = request.getReader();
		String line = null;
		StringBuffer buf = new StringBuffer();
		
		while(true) {
			line = br.readLine();
			if(line == null) break;
			
			buf.append(line);
		}
		
		String reqData = buf.toString();
		System.out.println("reqData => " + reqData);
		
		//역직렬화 = 자바객체로 변경 - MemberVO
		Gson gson = new Gson();
		MemberVO mv = gson.fromJson(reqData,MemberVO.class);
		System.out.println("mv => " + mv);
		//service 객체 얻고 
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		//service 메소드 호출 - 결과값 가져오기
		
		MemberVO responsevo = memberService.loginMember(mv);
		
		//결과값을 request에 저장
		
		request.setAttribute("responseMember", responsevo);
		
		//session 에 저장
		HttpSession ses = request.getSession();
		if(responsevo !=null) {
			ses.setAttribute("loginok", responsevo);
		}else {
			ses.setAttribute("loginok", null);
		}
			
		//view로 이동
		request.getRequestDispatcher("/start/login.jsp").forward(request, response);
	}
}
