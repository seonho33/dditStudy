package kr.or.ddit.store.controller;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.dao.IUserDao;
import kr.or.ddit.store.dao.UserDaoImpl;
import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.IUserService;
import kr.or.ddit.store.service.StoreServiceImpl;
import kr.or.ddit.store.service.UserServiceImpl;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;


@MultipartConfig
@WebServlet("/registerStore.do")
public class RegisterStoreController extends HttpServlet {
    private IStoreService storeService;
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        storeService = new StoreServiceImpl();
        userService = new UserServiceImpl();
		/*
		 * // ✅ SqlSession 한 번만 생성 SqlSession sqlSession = MyBatisUtil.getSqlSession();
		 * IUserDao userDao = new UserDaoImpl(sqlSession); userService = new
		 * UserServiceImpl(userDao);
		 */
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	 req.getRequestDispatcher("/TEST/views/store/storeRegister.jsp")
         .forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 한글 처리
        request.setCharacterEncoding("UTF-8");
        
        // 2. 파일 업로드 처리
        Part storeImgPart = request.getPart("store_img");
        String uploadedFileName = null;
        if (storeImgPart != null && storeImgPart.getSize() > 0) {
            uploadedFileName = storeImgPart.getSubmittedFileName();
            String uploadPath = request.getServletContext().getRealPath("/upload");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            storeImgPart.write(uploadPath + File.separator + uploadedFileName);
        }
        
        // 3. 파라미터 받기
        String userId = request.getParameter("user_id");
        String password = request.getParameter("mem_pass");       // ✅ 수정: mem_pass
        String name = request.getParameter("mem_name");           // ✅ 수정: mem_name
        String ownerEmail = request.getParameter("mem_mail");
        String bizNo = request.getParameter("store_bis_no");
        
        String storeName = request.getParameter("store_name");
        String storeAddr = request.getParameter("store_addr1");
        String storeAddr2 = request.getParameter("store_addr2");
        String storePhone = request.getParameter("store_tel");
        String category = request.getParameter("store_category");
        String storeContent = request.getParameter("store_cont");
        String operationHours = request.getParameter("store_open") + " ~ " + request.getParameter("store_close");
        int deposit = Integer.parseInt(request.getParameter("store_deposit"));
        
        // 4. UserVO 생성
        UserVO user = new UserVO();
        user.setUserId(userId);
        user.setPassword(password);
        user.setName(name);
        user.setDivision("점주");     // ✅ 추가: 사장님
        user.setBlockYn("N");          // ✅ 추가: 차단 안됨
        user.setUseYn("Y");            // ✅ 추가: 사용 중
        
        // 5. StoreVO 생성
        StoreVO store = new StoreVO();
        store.setStoreName(storeName);
        store.setStoreAddr(storeAddr);
        store.setStoreAddr2(storeAddr2);
        store.setStorePhone(storePhone);
        store.setCategory(category);
        store.setStoreContent(storeContent);
        store.setOperationHours(operationHours);
        store.setBizNo(bizNo);
        store.setOwnerEmail(ownerEmail);
        store.setDeposit(deposit);
        store.setUserId(userId);
        
        try {
            // 6. ✅ 순서 중요: USER 먼저 INSERT
            int userResult = userService.register(user);
            
            if (userResult > 0) {
                // 7. ✅ USER 성공 후 STORE INSERT
                int storeResult = storeService.insertStore(store);
                
                if (storeResult > 0) {
                    // 성공
                    response.sendRedirect(request.getContextPath() + "/TEST/views/user/main.jsp");
                } else {
                    request.setAttribute("msg", "가게 등록에 실패했습니다.");
                    request.getRequestDispatcher("/storeRegister.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "회원 등록에 실패했습니다.");
                request.getRequestDispatcher("/storeRegister.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "등록 중 오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/storeRegister.jsp").forward(request, response);
        }
    }
}