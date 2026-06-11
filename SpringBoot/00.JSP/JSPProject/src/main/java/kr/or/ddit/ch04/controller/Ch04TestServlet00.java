package kr.or.ddit.ch04.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/send00.do")
public class Ch04TestServlet00 extends HttpServlet {
	private int cnt = 0;	// 요청 횟수
	// 분할된 이미지가 담길 이미지 목록
	private List<Integer> imgList = new ArrayList<Integer>();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 다시 하기 또는 에러 발생 시, 횟수 및 이미지 횟수 목록 초기화
		cnt = 0;
		imgList = new ArrayList<Integer>();
		request.getRequestDispatcher("/ch04/test/send.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");		// 타입
		String number = request.getParameter("number");	// 횟수
		
		// *** 상황
		// 1. 에러 발생 시, status를 key로 다양한 상태값으로 핸들링한다.
		// - emp : 타입이 비어있을 때
		// - over : max 횟수를 초과했을 때
		// - ing : 페이지 이동방식 forward시, max 횟수가 남아 요청이 진행중
		// - ok : 페이지 이동방식 forward시, max 횟수를 포함해 요청되었을 때
		
		// 2. type에 따른 데이터 전달 항목
		// - forward 시, 총 4가지 데이터 전달
		// > type : forward or redirect
		// > num : 입력 횟수
		// > cnt : 요청 횟수
		// > imgList : 이미지 횟수 목록
		
		// - redirect 시, 총 3가지 데이터 전달
		// > type : forward or redirect
		// > s_num : 입력 횟수 및 요청 횟수
		// > imgList : 이미지 횟수 목록
		
		// 타입을 선택하지 않는 경우라면 send.jsp로 넘어가, 에러 메세지를 출력합니다.
		// 타입을 선택 하는 경우, 각 페이지 이동방식의 특징대로 결과가 출력된다.
		if(type == null || type.equals("")) {
			response.sendRedirect(request.getContextPath() + "/send.do?status=emp");
		}else {
			int num = Integer.parseInt(number);		// 횟수 정수 타입으로 변환
			if(type.equals("forward")) {	// 페이지 이동방식 forward 타입 일 때
				if(num > 4) {	// max 횟수를 초과했을 때
					request.setAttribute("status", "over");	// max 횟수 초과 상태 전달
					request.getRequestDispatcher("/ch04/test/send.jsp").forward(request, response);
				}else{
					cnt++;	// 횟수 증가
					if(num < cnt) {	// 입력 횟수보다 요청 횟수가 많을 때
						request.setAttribute("status", "ok");	// 횟수 달성 상태 전달
					}else {			// 입력 횟수보다 요청 횟수가 적을 때
						// 분할 이미지를 그리기 위한 이미지 목록 횟수 추가
						imgList.add(cnt);
						request.setAttribute("status", "ing");	// 횟수 진행중 상태 전달
					}
					
					request.setAttribute("type", type);			// 타입 설정
					request.setAttribute("num", number);		// 입력 횟수 설정
					request.setAttribute("cnt", cnt);			// 요청 횟수 설정
					request.setAttribute("imgList", imgList);	// 이미지 횟수 목록 설정
					request.getRequestDispatcher("/ch04/test/result.jsp").forward(request, response);
				}
			}else {	// 페이지 이동방식 redirect 타입 일 때
				imgList = new ArrayList<Integer>();		// 이미지 목록 초기화
				// 횟수 초과 시, max 횟수에 맞춰 4번만 설정되도록 조건식 구성
				for(int i = 0; i < (num > 4 ? 4 : num); i++) {
					imgList.add(i+1);
				}
				HttpSession session = request.getSession();
				session.setAttribute("imgList", imgList);		// 이미지 횟수 목록 설정
				response.sendRedirect("/result.do?s_num=" + num + "&type=redirect");
			}
		}
	}

}
