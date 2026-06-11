package kr.or.ddit.products.service;

import kr.or.ddit.products.dao.IProductsDao;
import kr.or.ddit.products.dao.ProductsDaoImplForMyBatis;
import kr.or.ddit.products.vo.ProductsVO;

public class ProductsServiceImpl implements IProductsService {
	private static IProductsService instance = new ProductsServiceImpl();
	
	//DAO
	private IProductsDao dao;
	
	private        ProductsServiceImpl() {
		dao = ProductsDaoImplForMyBatis.getInstance();
	}
	
	public  static IProductsService getInstance() {
		return instance;
	}

	//등록 실행
	@Override
	public int registerProducts(ProductsVO productsVO) {
		//productsVO : ProductsVO [pid=P001, pname=개똥이, price=12000]
		return this.dao.registerProducts(productsVO);
	}
	
}
