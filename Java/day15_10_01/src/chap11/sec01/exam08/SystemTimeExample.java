package chap11.sec01.exam08;

public class SystemTimeExample {
	public static void main(String[] args) {
		long time1 = System.currentTimeMillis();
		
		int sum = 0;
		for(int i=1;i<=1000000;i++) {
			sum+=i;
		}
		
		long time2 = System.currentTimeMillis();
		
		System.out.println("1~1000000까지의 합: " + sum);
		System.out.println("계산에 " + (time2-time1) + "밀리초가 소요되었습니다.");
		
		System.out.println(time2);
	}
}