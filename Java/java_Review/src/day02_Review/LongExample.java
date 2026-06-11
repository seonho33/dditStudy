package day02_Review;

public class LongExample {
	public static void main(String[] args) {
		long var1 = 10;
		long var2 = 20L;
/*		long var3 = 10000000000; 기본이 int이기 때문에 int의 범위를 넘어가면 L을 붙여야함 int는 약 21억까지 지원*/
		long var4 = 10000000000L;

		System.out.println(var1);
		System.out.println(var2);
		System.out.println(var4);
	}
}