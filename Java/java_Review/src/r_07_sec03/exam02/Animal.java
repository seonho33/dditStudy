package r_07_sec03.exam02;

public abstract class Animal {
	public String kind;

	public Animal() {
	}
	public Animal(String kind) {
		this.kind =kind;
	}
	public void breathe() {
		System.out.println("숨을 쉽니다.");
	}
	
	public abstract void sound(); // 모든 상속받는 Animal의 자식클래스에게 주는 제약사항
}
