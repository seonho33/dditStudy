package kr.or.ddit.menu.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.menu.service.IMenuService;
import kr.or.ddit.menu.service.MenuServiceImpl;
import kr.or.ddit.menu.vo.MenuVO;

@WebServlet("/menu/update.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class MenuUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IMenuService menuService;
    private static final String UPLOAD_DIR = "images/upload/menu";
    
    @Override
    public void init() throws ServletException {
        this.menuService = MenuServiceImpl.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 0) 세션에서 storeId 꺼내기 (키/타입은 프로젝트에 맞게)
        // 예: sessionScope.loginStore 쓰고 있었다고 했으니 loginStore 가정
        kr.or.ddit.store.vo.StoreVO loginStore =
                (kr.or.ddit.store.vo.StoreVO) req.getSession().getAttribute("loginStore");

        if (loginStore == null) {
            resp.sendError(401, "로그인이 필요합니다.");
            return;
        }
        String storeId = loginStore.getStoreId(); // storeId 타입이 Long/int면 그 타입으로 바꿔

        // 1) menuId 파라미터
        String menuNoStr = req.getParameter("menuId");
        if (menuNoStr == null) menuNoStr = req.getParameter("menuNo");

        if (menuNoStr == null) {
            resp.sendError(400, "메뉴 번호가 없습니다.");
            return;
        }

        Long menuNo = Long.parseLong(menuNoStr);

        // ✅ 2) 복합키 기준 단건조회 (서비스명은 getMenuById에 맞춰서!)
        MenuVO menu = menuService.getMenuById(storeId, menuNo);

        // ✅ 3) null이면 insert 폼으로 착시 안나게 에러로 끊기
        if (menu == null) {
            resp.sendError(404, "해당 가게의 메뉴가 아닙니다. storeId=" + storeId + ", menuId=" + menuNo);
            return;
        }

        req.setAttribute("menu", menu);
        req.getRequestDispatcher("/TEST/views/store/menuForm.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 1. 파라미터 추출 (JSP의 name 속성과 반드시 일치해야 함)
        String menuNoStr = req.getParameter("menuNo");
        if(menuNoStr == null) menuNoStr = req.getParameter("menuId");
        
        String menuName = req.getParameter("menuName");
        String menuPriceStr = req.getParameter("menuPrice");
        String existingPicture = req.getParameter("existingPicture");
        
     // ✅ 혹시 경로가 섞여 있으면 파일명만 잘라서 저장
        if (existingPicture != null && existingPicture.contains("/")) {
            existingPicture = existingPicture.substring(existingPicture.lastIndexOf("/") + 1);
        }
        
        if (menuNoStr == null) {
            resp.getWriter().print("FAIL: NO_ID");
            return;
        }
        
        Long menuNo = Long.parseLong(menuNoStr);
        Long menuPrice = Long.parseLong(menuPriceStr);
        
        // 2. 파일 업로드 처리
        Part filePart = req.getPart("menuPicture");
        String fileName = existingPicture; // 기본값은 기존 이미지
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = getFileName(filePart);
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String savedName = UUID.randomUUID().toString() + extension;
            
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(uploadPath + File.separator + savedName);
            fileName = savedName;
        }
        
        // 3. VO 세팅
        MenuVO menu = new MenuVO();
        menu.setMenuId(menuNo); // 필드명이 menuId이므로 메서드도 setMenuId입니다.
        menu.setMenuName(menuName);
        menu.setMenuPrice(menuPrice);
        menu.setMenuPicture(fileName);
        
        boolean result = menuService.modifyMenu(menu);
        
        // 4. 결과 처리 (AJAX 대응)
        resp.setContentType("text/plain; charset=UTF-8");
        if (result) {
            resp.getWriter().print("SUCCESS");
        } else {
            resp.getWriter().print("FAIL");
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}