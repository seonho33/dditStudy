package kr.or.ddit.store.controller;

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

import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.StoreServiceImpl;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 가게 정보 수정 컨트롤러
 */
@WebServlet("/store/updateStore.do")
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15,   // 15MB
    fileSizeThreshold = 1024 * 1024 * 1  // 1MB
)
public class UpdateStoreController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        
        // 2. 세션 검증
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        StoreVO loginStore = (StoreVO) session.getAttribute("loginStore");
        
        // 3. 점주 권한 검증
        String division = loginUser.getDivision().trim();
        if(!"점주".equals(division) && !"관리자".equals(division)) {
            request.setAttribute("error", "권한이 없습니다.");
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
            return;
        }
        
        // 4. Form 데이터 추출
        String storeId = loginStore.getStoreId();
        String storeName = request.getParameter("storeName");
        String category = request.getParameter("category");
        String operationHours = request.getParameter("operationHours");
        String depositStr = request.getParameter("deposit");
        String storeAddr = request.getParameter("storeAddr");
        String storeAddr2 = request.getParameter("storeAddr2");
        String storeContent = request.getParameter("storeContent");
        String storePhone = request.getParameter("storePhone");

        
        // 5. 데이터 검증
        if(storeName == null || storeName.trim().isEmpty()) {
            request.setAttribute("error", "가게명은 필수 입력 항목입니다.");
            request.getRequestDispatcher("/TEST/views/store/가게관리_v2.jsp").forward(request, response);
            return;
        }
        
        int deposit = 0;
        try {
            deposit = Integer.parseInt(depositStr);
        } catch(NumberFormatException e) {
            deposit = 0;
        }
        
        // 6. StoreVO 객체 생성
        StoreVO storeVO = new StoreVO();
        storeVO.setStoreId(storeId);
        storeVO.setStoreName(storeName);
        storeVO.setCategory(category);
        storeVO.setOperationHours(operationHours);
        storeVO.setDeposit(deposit);
        storeVO.setStoreAddr(storeAddr);
        storeVO.setStoreAddr2(storeAddr2);
        storeVO.setStoreContent(storeContent);
        storeVO.setUserId(loginUser.getUserId());
        storeVO.setStorePhone(storePhone.trim());

        
        // 7. Service 객체 생성 (생성자 방식)
        IStoreService service = new StoreServiceImpl();
        
        try {
            // 8. 가게 정보 수정
            int result = service.updateStore(storeVO);
            
            if(result <= 0) {
                throw new Exception("가게 정보 수정 실패");
            }
            
            // 9. 이미지 파일 처리
            Part filePart = request.getPart("storeImage");
            
            if(filePart != null && filePart.getSize() > 0) {
                // 업로드 경로 설정
            	String uploadPath = getServletContext().getRealPath("/images/upload/store");
                
                // 디렉토리 생성
                File uploadDir = new File(uploadPath);
                if(!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // 파일명 생성 (UUID + 확장자)
                String originalFilename = getFileName(filePart);
                String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String savedFilename = UUID.randomUUID().toString() + extension;
                
                // 파일 저장
                String fullPath = uploadPath + File.separator + savedFilename;
                filePart.write(fullPath);
                
                // DB에 경로 저장
                String relativePath = "images/upload/store/" + savedFilename; 
                service.saveStorePicture(storeId, relativePath);
            }
            
            // 10. 세션의 loginStore 갱신
            StoreVO updatedStore = service.selectStoreByUserId(loginUser.getUserId());
            session.setAttribute("loginStore", updatedStore);
            
            // 11. 성공 메시지와 함께 리다이렉트
            session.setAttribute("message", "가게 정보가 성공적으로 수정되었습니다.");
            response.sendRedirect(request.getContextPath() + "/store/detail.do");
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "수정 중 오류 발생: " + e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/가게관리_v2.jsp").forward(request, response);
        }
    }
    
    /**
     * Part 객체에서 파일명 추출
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        
        for(String token : tokens) {
            if(token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown";
    }
}