package kr.or.ddit.reflection;

import java.lang.reflect.Modifier;

/*
	클래스의 메타데이터 가져오기 예제 
*/

public class T02ClassMetadataTest {
	public static void main(String[] args) {
		
		//클래스 오브젝트 생성하기
		Class<?> clazz = SampleVO.class;
		
		System.out.println("심플클래스명: " + clazz.getSimpleName());
		System.out.println("클래스명: " + clazz.getName());
		System.out.println("상위클래스명: " + clazz.getSuperclass().getName());
		
		//패키지 정보
		System.out.println("패키지 정보: " + clazz.getPackageName());
		
		//해당 클래스에서 구현하고 있는 인터페이스 목록
		Class<?>[] interfaces = clazz.getInterfaces();
		System.out.println("인터페이스 목록");
		for(Class<?> inf : interfaces) {
			System.out.print(inf.getName()+"|");
		}
		System.out.println();
		//클래스의 접근제어자 정보 가져오기
		int modFlag = clazz.getModifiers();
		System.out.println("접근제어자 : " + Modifier.toString(modFlag));
	}
}