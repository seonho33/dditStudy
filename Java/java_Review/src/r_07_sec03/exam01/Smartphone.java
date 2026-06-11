package r_07_sec03.exam01;

public class Smartphone extends Phone{
	//생성자
	public Smartphone() {
		
	}
	public Smartphone(String owner) {
		super(owner);
	}
	//메소드
	public void internetSearch() {
		System.out.println("인터넷 검색을 합니다.");
	}
}
