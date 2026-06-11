package kr.or.ddit.basic;

/**
 파란색 범위주석 HellowJava 클래스
 */
public class HellowJava {
	/**
	 * 
	 * @param args 
	 */
	public static void main(String[] args) {
		// 화면에 Hellow Java 출력하기
		// 두번째 주석 라인....
		/*
		 이 부분은 주석입니다.
		 */
		
		System.out.println("Hellow, Java !");
		

		int value =10;
		//double value;
		//변수이름 첫글자는 문자,$,_만
		//다른 특수문자는 아예 X ,대소문자도 구분함
		//(관례)첫문자는 소문자로, 두 단어면 두번째 단어 대문자 낙타표기법 클래스이름은 파스칼표기법(첫글자대문자)
		//문자길이제한x
		//예약어등 기능 X
		int result = value + 10;
		
		System.out.println(result);
		}
}