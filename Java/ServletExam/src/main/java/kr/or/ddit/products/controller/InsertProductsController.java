package kr.or.ddit.products.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.products.service.IProductsService;
import kr.or.ddit.products.service.ProductsServiceImpl;
import kr.or.ddit.products.vo.ProductsVO;

@WebServlet("/products/insert.do")
public class InsertProductsController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//									폴더		파일
		req.getRequestDispatcher("/views/products/insertForm.jsp").forward(req, resp);

	}

	/*
	요청URI : /ServletExam/products/insert.do
	요청파라미터 : request{pid=P001, pname=개똥이,price=1200}
	요청방식 : post
	*/
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pid = req.getParameter("pid");//P001
		String pname = req.getParameter("pname");//개똥이
		int    price = Integer.parseInt(req.getParameter("price"));//1200
		
		ProductsVO productsVO = new ProductsVO();
		productsVO.setPid(pid);
		productsVO.setPname(pname);
		productsVO.setPrice(price);
		//productsVO : ProductsVO [pid=P001, pname=개똥이, price=12000]
		System.out.println("productsVO : " + productsVO);
		
		//등록 실행
		IProductsService productsService = 
				ProductsServiceImpl.getInstance();
		
		int cnt = productsService.registerProducts(productsVO);
		System.out.println("cnt : " + cnt);
		
		// 포워딩 처리...
		//req.getRequestDispatcher("/products/insert.do").forward(req, resp);
		
		// 리다이렉트 처리...							
		resp.sendRedirect(req.getContextPath() + "/products/insert.do");		
	}
}





