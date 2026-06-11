package kr.or.ddit.basic;

public class T02ThreadTest {
	public static void main(String[] args) {
		// 멀티스레드 프로그래밍 방식
		
		// 방법1: Tread 클래스를 상속한 클래스의 인스턴스를 생성한 후 
		//		 이 인스턴스의 start()메서드를 호출한다...
	Thread th1 = new MyThread1();	
	
	th1.start();
	
		// 방법2: Runnable 인터페이스를 구현한 클래스의 인스턴스를 생성한 후
		// 이 인스턴스를 Thread 객체를 생성할 때 생성자의 파라미터로 넘겨준다.
		// 이렇게 생성한 Thread 객체를 start() 메서드를 이용하여 구동시킨다.
	Runnable r = new MyThread2();
	Thread th2 = new Thread(r);
	th2.start();

		// 방법3: 익명구현객체를 이용한 방법
	Thread th3 = new Thread(new Runnable() {
		
		@Override
		public void run() {
			for(int i = 1; i<=200; i++) {
				System.out.print("@");
				try {
					/*	
						Tread.sleep(시간) => 주어진 시간동안 작업을 잠시 멈춘다.
						시간은 밀리세컨드(ms) 단위를 사용한다
						즉, 1000은 1초를 의미한다.
					*/
					Thread.sleep(100);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}	);
	
	th3.start();
	
	
	}
}

class MyThread1 extends Thread {

	@Override
	public void run() {
		for(int i = 1; i<=200; i++) {
			System.out.print("*");
			try {
				/*	
					Tread.sleep(시간) => 주어진 시간동안 작업을 잠시 멈춘다.
					시간은 밀리세컨드(ms) 단위를 사용한다
					즉, 1000은 1초를 의미한다.
				*/
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		super.run();
	}
}
class MyThread2 implements Runnable{

	@Override
	public void run() {
		for(int i = 1; i<=200; i++) {
			System.out.print("$");
			try {
				/*	
					Tread.sleep(시간) => 주어진 시간동안 작업을 잠시 멈춘다.
					시간은 밀리세컨드(ms) 단위를 사용한다
					즉, 1000은 1초를 의미한다.
				*/
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}