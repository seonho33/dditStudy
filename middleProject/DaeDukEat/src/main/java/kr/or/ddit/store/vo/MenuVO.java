package kr.or.ddit.store.vo;

public class MenuVO {
	
	private int menuId;
	private String storeId;
	private String menuName;
	private int menuPrice;
	private String menuPicture;
	private String createDate;
	private String updateDate;
	
			
	//게터세터		
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}
	public String getMenuPicture() {
		return menuPicture;
	}
	public void setMenuPicture(String menuPicture) {
		this.menuPicture = menuPicture;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	
	

}
