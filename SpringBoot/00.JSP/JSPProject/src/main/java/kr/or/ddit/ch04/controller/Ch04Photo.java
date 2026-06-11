package kr.or.ddit.ch04.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class Ch04Photo
 */
@WebServlet("/send.do")
public class Ch04Photo extends HttpServlet {
	
	private int no = 0;
	
	private List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getRequestDispatcher("/ch04/test/send.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goPage="";
		String type = request.getParameter("type");//redirect
		String number = request.getParameter("number");//5
		
		int k=0;
		
		if(number != null&&number !="") {
			k = Integer.parseInt(number);//5
		}

		
		if(type==null||type.equals("")) {
			//타입의 값이 존재하지 않는 경우, 에러 메시지를 표시하기 위해 쿼리스트링 구성
			//이때, 페이지 이동방식은 redirect를 구성하기 때문에 헤더에 파라미터를 설정 후 전송
			goPage = request.getContextPath()+"/send.do?err=1";
			response.sendRedirect(goPage);
		}else if(type.equals("forward")&&k>4) {
			goPage = request.getContextPath()+"/send.do?err=0";
			response.sendRedirect(goPage);
		}else{ //redirect
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("number",number);//5
			resultMap.put("type", type);//redirect
			
			resultList.add(resultMap);
			
			System.out.println("Ch04Servlet.doPost->사용자 등록------");
			System.out.println("Ch04Servlet.doPost->type : " + type);//redirect
			System.out.println("Ch04Servlet.doPost->no =="+no);//1
			System.out.println("Ch04Servlet.doPost->number =="+number);//5

			
			if(type.equals("forward")) {
				request.setAttribute("no", ++no);
				request.setAttribute("type", type);
				request.setAttribute("reqResultList", resultList);
				request.getRequestDispatcher("/ch04/test/result.jsp").forward(request, response);
			}else {//redirect
				HttpSession session = request.getSession();
				session.setAttribute("sesResultList", resultList);//*******
				goPage = request.getContextPath()+"/ch04/test/result.do";//request에 못담음
				for(int i=0; i<k; i++) {
					++no;
				}
				session.setAttribute("type", type);
				session.setAttribute("no", no);
				response.sendRedirect(goPage);
			}
		}
	}
}
