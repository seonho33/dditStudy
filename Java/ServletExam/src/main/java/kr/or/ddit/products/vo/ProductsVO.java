package kr.or.ddit.products.vo;

public class ProductsVO {
	//Ctrl + Shift + y => 소문자
	//Shift + Alt + a
	//프로퍼티, 멤버변수, 필드
	private String pid;
	private String pname;
	private int    price;
	
	//기본생성자 Shift + Alt + s
	public ProductsVO() {}

	//getter/setter메서드 Shift + Alt + s
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	//toString
	@Override
	public String toString() {
		return "ProductsVO [pid=" + pid + ", pname=" + pname + ", price=" + price + "]";
	}
	
	
}
