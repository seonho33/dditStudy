package kr.or.ddit.basic;

public class FloatDoubleExample {
	public static void main(String[] args) {
		//실수값 저장
		//float var1 = 3.14; < 컴파일 에러(기본은 double)
		float var2 = 3.14f;
		double var3 = 3.14;
		
		//정밀도 테스트
		float var4 = 0.1234567890123456799f;
		double var5 = 0.1234567890123456989;
		
		System.out.println("var2: " + var2);
		System.out.println("var3: " + var3);
		System.out.println("var4: " + var4); //정밀도 소수 7번째 자리까지 8번째 자리는 반올림한 값
		System.out.println("var5: " + var5); //float 타입보다 정밀도가 2배 이상 15자리까지 정밀

		//e 사용하기
		double var6 = 3e6;
		float var7 = 3e6f;
		double var8 = 2e-3;
		System.out.println("var6: " + var6);
		System.out.println("var7: " + var7);
		System.out.println("var8: " + var8);
	}
}
