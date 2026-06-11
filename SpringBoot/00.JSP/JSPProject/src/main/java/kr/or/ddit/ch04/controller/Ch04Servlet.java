package kr.or.ddit.ch04.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//등록 결과 페이지 요청
@WebServlet("/ch04/form.do")
public class Ch04Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private int no= 0; //등록된 회원 번호
	// form.jsp 에서 입력한 회원정보를 저장할 memberList
	// 페이지 이동방식 forward, redirect시, 전달할 회원 목록 Data
	private List<Map<String, Object>> memberList = new ArrayList<Map<String,Object>>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/ch04/form.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goPage="";
		
		//클라이언트(form.jsp)에서 전달받은 타입, 아이디, 비밀번호, 이름을 꺼낸다.
		String type = request.getParameter("type");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		
		//타입 값 필터링
		if(type==null||type.equals("")) {
			//타입의 값이 존재하지 않는 경우, 에러 메시지를 표시하기 위해 쿼리스트링 구성
			//이때, 페이지 이동방식은 redirect를 구성하기 때문에 헤더에 파라미터를 설정 후 전송
			goPage = request.getContextPath()+"/ch04/form.do?err=1";
			response.sendRedirect(goPage);
		}else {		//타입을 선택하고 넘어옴
					//결과 화면으로 데이터를 전송하기 위한 Map 구성
			Map<String, Object> memberMap = new HashMap<String, Object>();
			memberMap.put("no", ++no);			//사용자 번호 설정
			memberMap.put("id", id );		//사용자 아이디 설정
			memberMap.put("pw", pw );		//사용자 비밀번호 설정
			memberMap.put("name", name );	//사용자 이름 설정
			
			//새롭게 등록된 회원 정보를 회원 목록에 담는다.
			memberList.add(memberMap);
			
			System.out.println("Ch04Servlet.doPost->사용자 등록------");
			System.out.println("Ch04Servlet.doPost->type : " + type);
			System.out.println("Ch04Servlet.doPost->id"+id);
			System.out.println("Ch04Servlet.doPost->pw"+pw);
			System.out.println("Ch04Servlet.doPost->name"+name);
			
			if(type.equals("forward")) {
				request.setAttribute("reqMemberList", memberList);
				 request.getRequestDispatcher("/ch04/result.jsp").forward(request, response);
			}else {
				//페이지 이동방식 리다이렉트인경우 데이터를 전달하기 위한 scope의 차이에 따라서
				//데이터를 사용하거나 사용하지 못한다. 리다이렉트인 경울면 새로운 request가 만들어져
				//request에서 가용하고있는 데이터를 활용할 수 없다.
				request.setAttribute("reqMemberList", memberList);
				
				HttpSession session= request.getSession();
				session.setAttribute("sesMemberList", memberList);
				goPage = request.getContextPath()+"/ch04/result.do";
				response.sendRedirect(goPage);
			}
			
		}
	}
}
