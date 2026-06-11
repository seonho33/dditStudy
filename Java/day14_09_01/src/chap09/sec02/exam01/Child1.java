package chap09.sec02.exam01;

public class Child1 extends Person {
			  //로컬 변수값으로 대입
				  void walk() {
					  System.out.println("산책합니다.");
				  }
				  @Override
				  void wake() {
					  System.out.println("7시에 일어납니다.");
					  walk();
				  }
		  }
