package kr.or.ddit.basic;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public class PrintAnnotationTest {
	public static void main(String[] args) {
		
		//Reflection API를 이용한 PrintAnnotation 정보 접근하기...
		Method[] methodArr = Service.class.getDeclaredMethods();
		
		for(Method m : methodArr) {
			System.out.println("메서드명 : " + m.getName());
			System.out.println("메서드 리턴타입 : " + m.getReturnType());

			Annotation[] annos = m.getDeclaredAnnotations();
			for(Annotation anno : annos) {
				String annoName = anno.annotationType().getSimpleName();
				System.out.println(annoName);
				if(annoName.equals("PrintAnnotation")) {
					PrintAnnotation printAnno = (PrintAnnotation) anno;
					
					System.out.println("value : " + printAnno.value());
					System.out.println("count : " + printAnno.count());
					
					for(int i=0; i<printAnno.count();i++) {
						System.out.print(printAnno.value());
					}
					System.out.println();
				}
			}
			System.out.println("--------------------------");
		}
	}
}
