package day02_Review;

public class CharExample {
	public static void main(String[] args) {
		char c1 = 'a'; // 문자를 직접 저장 출력시 문자가 출력
		int c8 = 'a';
		char c2 = 65; // 10진수 유니코드로 직접 저장 출력시 문자 출력
		char c3 = 0X41; // 16진수 유니코드로 직접 저장 출력시 문자 출력 
		
		char c4 = '가';
		char c5 = 44032;
		char c6 = '\uac00';
		
		System.out.println(c8);
		System.out.println(c1);
		System.out.println(c2);
		System.out.println(c3);
		System.out.println(c4);
		System.out.println(c5);
		System.out.println(c6);
	}
}

// 총평, 한글자를 저장하기 때문에 글자를 저장할때 Spring 보다 효율적, 유니코드 숫자를 알고있다면 정수형처럼 계산가능 ex) A(65)<B(66) 즉 값연산, 변환 정렬시 유리, 다국어 프로그램 가능
/* 문자 리터럴을 쓰고싶다면 ''와 '\\u'를 사용해야함 */
// char은 작은따옴표와 숫자(10진법, 16진법)만 사용가능
