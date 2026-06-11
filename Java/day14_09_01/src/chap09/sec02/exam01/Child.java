package chap09.sec02.exam01;

public class Child extends Person{
	void study() {
		System.out.println("공부를 합니다.");
	}
	@Override
	void wake() {
		System.out.println("7시 반에 일어납니다.");
		study();
	}
}