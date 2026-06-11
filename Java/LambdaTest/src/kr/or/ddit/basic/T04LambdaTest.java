package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

public class T04LambdaTest {
	public static void main(String[] args) {
		
		List<String> list = new ArrayList<String>();
		list.add("도선호");
		list.add("도");
		list.add("도선");
		list.add("선호도");
		
		for(String str:list) {
			System.out.println(str);
		}
		
		System.out.println("--------------------------------------");
		
		list.forEach((nane) -> System.out.println(nane));
		
		System.out.println("--------------------------------------");
		
		list.forEach(System.out::println); 	//메서드참조
		
	/*
		 자바에서 메서드 참조(Method Reference)를 이용하면 람다식을 간단히 표현할 수 있다.
		 메서드 참조는 :: 연산자를 사용하며, 코드의 가독성을 높이는데 도움을 준다.
		 다음과 같이 네가지 주요형태로 나누어 볼 수 있다.
		 
		 1. 정적 메서드 참조(Static Method Reference)
		 2. 임의의 객체의 메서드 참조(Instance Method Reference)
		 3. 특정 객체의 인스턴스 메서드 참조
		 4. 생성자 참조(Constructor Reference)

		메서드 참조의 일반적인 형태
		
		참조변수 :: 인스턴스 메서드
		클래스명 :: 정적 메서드
		클래스명 :: 인스턴스 메서드
		생성자명 :: new
		
	*/
		System.out.println("-----------------");
		System.out.println();
		MyPrint mp = new MyPrint();
		list.forEach(mp::printName);	// 참조변수 ::인스턴스메서드
		
		System.out.println("-----------------");
		System.out.println("클래스명::정적메서드");
		list.forEach(MyPrint::printName2);
		
		System.out.println("-----------------");
		System.out.println("생성자명::new");
		list.forEach(MyPrint::new);
		
	}
}

class MyPrint {
	//생성자1
	public MyPrint() {
	}

	//생성자2
	public MyPrint(String name) {
		System.out.println("name : " + name);
	}
	
	//인스턴스메서드1
	public void printName(String name) {
		System.out.println("인스턴스 메서드 => name : " + name);
	}
	
	//인스턴스메서드2
	public void printName() {
		System.out.println("인스턴스 메서드 => name : 홍길동");
	}
	
	//정적메서드
	public static void printName2(String name) {
		System.out.println("정적 메서드 => name : " +name);
	}
	
}