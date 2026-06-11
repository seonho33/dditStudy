package kr.or.ddit.user.controller;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.admin.service.GsServiceImpl;
import kr.or.ddit.admin.service.IGSService;
import kr.or.ddit.admin.vo.GsVO;

@WebServlet("/main.do")
public class MainLogin extends HttpServlet {
    private static final long erialVersionUID = 1L;

    private IGSService gsService;

    @Override
    public void init() throws ServletException {
        gsService = GsServiceImpl.getInstance();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ 카드별 최신 1개씩 조회 (STATUS_YN='Y' 조건은 mapper에서)
            GsVO godSale = gsService.selectLatestByDivision("갓세일");
            GsVO endSale = gsService.selectLatestByDivision("마감할인");
            GsVO hotItem = gsService.selectLatestByDivision("핫아이템");

            // ✅ JSP로 전달 (footer에서 꺼내 씀)
            request.setAttribute("godSale", godSale);
            request.setAttribute("endSale", endSale);
            request.setAttribute("hotItem", hotItem);
            
            // 🔍 디버깅 로그
            System.out.println("========== GS Promotion 최신 1개씩 ==========");
            System.out.println("[갓세일] " + (godSale == null ? "없음" : godSale.toString()));
            System.out.println("[마감할인] " + (endSale == null ? "없음" : endSale.toString()));
            System.out.println("[핫아이템] " + (hotItem == null ? "없음" : hotItem.toString()));
            System.out.println("============================================");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("❌ GS 프로모션 조회 중 오류: " + e.getMessage());
        }

        // main.jsp로 포워딩
        request.getRequestDispatcher("/TEST/views/user/main.jsp").forward(request, response);
    }
}
