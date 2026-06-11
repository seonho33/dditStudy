package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.common.util.ObjJson;

/**
 * Servlet implementation class AdminOwnerApply
 */
@WebServlet("/AdminOwnerApply.do")
public class AdminOwnerApply extends HttpServlet {

	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	          throws ServletException, IOException {

	    Map<String, Object> param = ObjJson.fromJson(request, Map.class);

	    String action = (String) param.get("action");
	    String userId = (String) param.get("userId");

	    String status = "거절";
	    if ("APPROVE".equals(action)) status = "승인";

	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("status", status);

	    IAdminService service = AdminServiceImpl.getInstance();
	    boolean ok = service.updateOwnerStatus(map);

	    response.setContentType("application/json; charset=UTF-8");
	    response.getWriter().write(
	      "{\"success\":" + ok + "}"
	    );
	  }
	}