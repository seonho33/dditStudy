package kr.or.ddit.menu.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.menu.service.IMenuService;
import kr.or.ddit.menu.service.MenuServiceImpl;

/**
 * <pre>
 * 메뉴 삭제 Servlet
 * 
 * Purpose:
 *   - 메뉴 물리 삭제 처리
 * 
 * Mapping:
 *   - URL: /menu/delete.do
 *   - Method: POST
 * 
 * Warning:
 *   - 물리 삭제이므로 복구 불가
 *   - 필요 시 논리 삭제로 변경 권장
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
@WebServlet("/menu/delete.do")
public class MenuDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IMenuService menuService;
    
    @Override
    public void init() throws ServletException {
        this.menuService = MenuServiceImpl.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String menuIdStr = req.getParameter("menuId");
        resp.setContentType("application/json; charset=UTF-8"); // 응답 형식 고정
        
        // 1. 파라미터가 없을 때 리다이렉트 대신 JSON 응답
        if (menuIdStr == null || menuIdStr.trim().isEmpty()) {
            resp.getWriter().write("{\"success\": false, \"message\": \"메뉴 ID가 누락되었습니다.\"}");
            return;
        }
        
        try {
            Long menuId = Long.parseLong(menuIdStr);
            boolean result = menuService.removeMenu(menuId);
            
            // 2. 결과 반환
            if (result) {
                resp.getWriter().write("{\"success\": true}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"DB 삭제 실패\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"서버 에러 발생\"}");
        }
    }
}