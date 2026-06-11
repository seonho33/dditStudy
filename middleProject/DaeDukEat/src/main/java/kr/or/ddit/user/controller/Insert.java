package kr.or.ddit.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.UserServiceImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Servlet implementation class insert
 */
@WebServlet("/insert.do")
public class Insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
    public Insert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		//요청 Parameter 받기
	     String userId = request.getParameter("userId");
		 String password =  request.getParameter("password");
		 String name =  request.getParameter("name");
		
		 String bir = request.getParameter("bir");
		 String mail = request.getParameter("mail");
		 String profile_img = request.getParameter("profile_img");
		 int userNo = Integer.parseInt(request.getParameter("userNum"));
		 
		 
		 //VO 담기
		 UserVO uv = new UserVO();
		 uv.setUserId(userId);
		 uv.setPassword(password);
		 uv.setName(name);	
		
		 MemberVO mv = new MemberVO();
		 mv.setUserId(userId);
		 mv.setUserBir(LocalDate.parse(bir)); 
		 mv.setUserMail(mail);
		 mv.setUserNo(userNo);
		 mv.setProfileImg(profile_img);
		 
		 
		 
		 //Service 호출
		 IUserService service = UserServiceImpl.getInstance();
		 
		 
		 int usercnt = service.insertUser(uv);
		 int membercnt = service.insertMember(mv);
		 
		 
		 
		 
		 // 이동
		response.sendRedirect(request.getContextPath() +"/main.do");
		 }
	}

