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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import kr.or.ddit.menu.service.IMenuService;
import kr.or.ddit.menu.service.MenuServiceImpl;
import kr.or.ddit.menu.vo.MenuVO;
import kr.or.ddit.store.vo.StoreVO; // StoreVO 임포트 필수

@WebServlet("/menu/insert.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  
    maxFileSize = 1024 * 1024 * 10,       
    maxRequestSize = 1024 * 1024 * 50     
)
public class MenuInsertServlet extends HttpServlet {
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
        // 경로 확인: /TEST/views/store/menuForm.jsp 로 정확히 연결
        req.getRequestDispatcher("/TEST/views/store/menuForm.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        
        // [수정 포인트 1] 세션에서 loginStore 객체를 꺼내 storeId 확보
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");
        
        if (svo == null) {
            System.err.println("[ERROR] 세션에 가게 정보가 없음");
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String storeId = svo.getStoreId();
        String menuName = req.getParameter("menuName");
        String menuPriceStr = req.getParameter("menuPrice");
        
        Long menuPrice = 0L;
        if (menuPriceStr != null && !menuPriceStr.trim().isEmpty()) {
            menuPrice = Long.parseLong(menuPriceStr);
        }
        
        // [수정 포인트 2] 파일 업로드 로직 보강
        Part filePart = req.getPart("menuPicture");
        String fileName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = getFileName(filePart);
            if (originalFileName != null && originalFileName.contains(".")) {
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                fileName = UUID.randomUUID().toString() + extension;
                
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                filePart.write(uploadPath + File.separator + fileName);
            }
        }
        
        MenuVO menu = new MenuVO();
        menu.setStoreId(storeId);
        menu.setMenuName(menuName);
        menu.setMenuPrice(menuPrice);
        menu.setMenuPicture(fileName);  // UUID파일명만
        
        boolean result = menuService.addMenu(menu);
        
        // [수정 포인트 3] AJAX(fetch) 요청 대응
        String isAjax = req.getHeader("X-Requested-With");
        
        if (result) {
            if ("fetch".equals(isAjax)) {
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().print("SUCCESS");
            } else {
                resp.sendRedirect(req.getContextPath() + "/menu/list.do");
            }
        } else {
            if ("fetch".equals(isAjax)) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            } else {
                req.setAttribute("errorMsg", "메뉴 등록에 실패했습니다.");
                req.getRequestDispatcher("/TEST/views/store/menuForm.jsp").forward(req, resp);
            }
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}