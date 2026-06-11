package java확인문제.P307;

public class ShopService {
		private static ShopService singleton = new ShopService();
		
		private ShopService() {}
		
		static ShopService getInstance() {
			return singleton;
	}
}