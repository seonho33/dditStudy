package kr.or.ddit.admin.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.admin.vo.OwnerApplyVO;
import kr.or.ddit.store.vo.StoreVO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class AdminMemberList
 */
@WebServlet("/admin/member.do")
public class AdminMemberPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		IAdminService service = AdminServiceImpl.getInstance();
		
		List<AdminUserBanVO> UserList = service.AdminBanlList();
		
		List<OwnerApplyVO> list = service.ownerApplyList();
		request.setAttribute("ownerApplyList", list);
		request.setAttribute("memberList", UserList);
		
		request.getRequestDispatcher("/TEST/views/admin/admin_member_list.jsp").forward(request, response);
		
	}

	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
