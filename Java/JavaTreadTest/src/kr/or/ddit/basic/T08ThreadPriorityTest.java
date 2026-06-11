package kr.or.ddit.basic;

public class T08ThreadPriorityTest {
	public static void main(String[] args) {
		System.out.println("최대 우선순위: " + Thread.MAX_PRIORITY);
		System.out.println("보통 우선순위: " + Thread.NORM_PRIORITY);
		System.out.println("최소 우선순위: " + Thread.MIN_PRIORITY);
		
		Thread[] ths = new Thread[] {
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest1(),	
			new ThreadTest2()	
		};
		
		//우선순위는 start()메서드를 호출하기 전에 설정해야한다.
		for(int i=0;i<ths.length;i++) {
			if(i==(ths.length-1)) {
				ths[i].setPriority(10);
			}else {
				ths[i].setPriority(1);
			}
		}

		for(int i =0; i<ths.length;i++) {
			System.out.println(ths[i].getName()+" : "+ths[i].getPriority());
		}
		
		for(Thread th : ths) {
			th.start();
		}
	}
}

// 알파벳 대문자를 출력하기 위한 스레드
class ThreadTest1 extends Thread{

	@Override
	public void run() {
		for(char ch='A'; ch<='Z'; ch++) {
			System.out.println(ch);
			
			//시간 때우기용
			for(long i=1; i<=1000000000L; i++) {
				
			}
		}
	}
}

class ThreadTest2 extends Thread{

	@Override
	public void run() {
		for(char ch='a'; ch<='z'; ch++) {
			System.out.println(ch);
			
			//시간 때우기용
			for(long i=1; i<=1000000000L; i++) {
				
			}
		}
	}
}
