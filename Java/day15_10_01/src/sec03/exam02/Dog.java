package sec03.exam02;

public class Dog extends Animal {
	public Dog() {
	this.kind="포유류";
	}

	@Override
	public void sound() {
		System.out.println("멍멍");
	}
	
	public void run() {
		System.out.println("개같이 뜁니다.");
	}
}
