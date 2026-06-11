package day02_Review;

public class FloatDoubleExample {
	public static void main(String[] args) {
		//실수값 저장
		//float var1 = 3.14; << 실수 리터럴의 기본이 double이기 때문에 float를 쓰고싶다면 끝에 f를 붙여야함
		float var2 = 3.14f;
		double var3 = 3.14;
		
		//정밀도테스트
		float var4 = 0.1234567890123456789f;
		double var5 = 0.1234567890123456789;
		
		System.out.println("var2: " + var2);
		System.out.println("var3: " + var3);
		System.out.println("var4: " + var4);
		System.out.println("var5: " + var5);

		//e 사용하기
		double var6 = 3e6;
		float var7 = 3e6f;
		double var8 = 3e-3;

		System.out.println(var6);
		System.out.println(var7);
		System.out.println(var8);
	}
}