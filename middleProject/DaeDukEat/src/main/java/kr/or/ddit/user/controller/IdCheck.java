package kr.or.ddit.user.controller;


import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.UserServiceImpl;

/**
 * Servlet implementation class IdCheck
 */
@WebServlet("/IdCheck.do")
public class IdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdCheck() {
        super();
    }  

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. 클라이언트에서 전달받은 id
        String id = request.getParameter("id");

        // 2. DB 조회 (예시는 서비스 호출)
        // UserService는 DB에서 id 존재 여부 확인
        IUserService service = UserServiceImpl.getService();
        boolean exists = service.idCheck(id) != null; // true: 이미 존재, false: 사용 가능
        
        // 3. JSON 반환 준비
        response.setContentType("application/json; charset=UTF-8");
        
        String json;
        if (!exists) {
            json = "{\"flag\":\"사용가능\"}";
        } else {
            json = "{\"flag\":\"사용불가능\"}";
        }

        // 4. JSON 응답
        response.getWriter().write(json);
    	
	}
	

}
