package kr.or.ddit.admin.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.admin.service.GsServiceImpl;
import kr.or.ddit.admin.service.IGSService;

@WebServlet("/gs25/delete.do")
public class GsProductDeleteController extends HttpServlet {

    private IGSService service = GsServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json; charset=UTF-8");

        try {
            int gsId = Integer.parseInt(req.getParameter("gsId"));

            int cnt = service.deleteGsProduct(gsId);

            if (cnt > 0) {
                resp.getWriter().print("{\"success\":true}");
            } else {
                resp.getWriter().print("{\"success\":false,\"message\":\"삭제 실패\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().print(
                "{\"success\":false,\"message\":\"삭제 중 오류 발생\"}"
            );
        }
    }
}
