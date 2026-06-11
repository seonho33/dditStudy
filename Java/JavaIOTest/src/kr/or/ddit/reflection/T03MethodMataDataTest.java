package kr.or.ddit.reflection;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public class T03MethodMataDataTest {
	public static void main(String[] args) throws ClassNotFoundException {

		Class<?> klass = Class.forName("kr.or.ddit.reflection.SampleVO");
		
		// 클래스에 선언된 모든 메서드의 메타정보 가져오기
		Method[] methodArr = klass.getDeclaredMethods();
		
		for(Method m : methodArr) {
			System.out.println("메서드명:" + m.getName());
			System.out.println("메서드 리턴타입 : " + m.getReturnType());
			
			//해당 메서드에 존재하는 Annotation 정보 가져오기
			Annotation[] annos = m.getDeclaredAnnotations();
			System.out.println("Annotation 타입 : ");
			for(Annotation anno : annos) {
				System.out.print(anno.annotationType().getName() + "|");
			}
			System.out.println();
			System.out.println("---------------------------");
		}
	}
}
