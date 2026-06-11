package r_07_sec03.exam02;

public class Bird extends Animal {
	public Bird(String kind) {
		super(kind);
	};
	public Bird() {
		this.kind = "조류";
	};
	public void sound() {
		System.out.println("짹스");
	}
}