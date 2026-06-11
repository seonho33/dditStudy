package kr.or.ddit.products.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.products.service.IProductsService;
import kr.or.ddit.products.service.ProductsServiceImpl;
import kr.or.ddit.products.vo.ProductsVO;
import kr.or.ddit.util.MyBatisUtil;

public class ProductsDaoImplForMyBatis implements IProductsDao {
	private static IProductsDao instance = new ProductsDaoImplForMyBatis();
	private        ProductsDaoImplForMyBatis() {} 
	public  static IProductsDao getInstance() {
		return instance;
	}
	
	//등록 실행
	@Override
	public int registerProducts(ProductsVO productsVO) {
		
		SqlSession session = MyBatisUtil.getSqlSession();
		
		//I,U,D 의 리턴타입은 int
		int cnt = 0;
		
		try {
			System.out.println("registerProducts->productsVO : " + productsVO);
			//					 namespace.id				파라미터
			//												//productsVO : ProductsVO [pid=P001, pname=개똥이, price=12000]
			cnt = session.insert("products.insertProducts", productsVO);
			if(cnt>0) {
				session.commit();//트랜잭션 종료 및 새로운 트랜잭션 실행
			}	
		}catch(PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		return cnt;
	}
}








