package kr.or.ddit.basic;

public class T13ThreadStopTest {
	public static void main(String[] args) {
		
		ThreadStopEx1 th1 = new ThreadStopEx1();
		th1.start();
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		th1.setStop(true);
		
		//////////////////////////
		
		ThreadStopEx2 th2 = new ThreadStopEx2();
		th2.start();
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		th2.interrupt();
	}
}
//flag를 이용
class ThreadStopEx1 extends Thread {
	private boolean stop;

	public void setStop(boolean stop) {
		this.stop = stop;
	}

	@Override
	public void run() {
		while(!stop) {
			System.out.println("스레드 작업 처리 중 ...");
		}

		System.out.println("자원 정리 중...");
		System.out.println("실행 종료.");
	}
	
	
}

//interrupt() 메서드를 이용한 스레드 중지방법
class ThreadStopEx2 extends Thread {
	
	@Override
	public void run() {
		//방법 1 => sleep()메서드나 join()메서드 등을 사용했을 때 
		//		   interrupt()메서드 호출시 InterruptedException 이
		//		   발생하는 상황을 이용하는 방법
		
		
		/*try {
			while(true) {
				System.out.println("스레드 작업 처리중...");
				Thread.sleep(1);
			}
		}catch(InterruptedException ex) {
			System.out.println("자원 정리중...");
			System.out.println("실행 종료.");
		}
		*/
		
		
		//방법2 => interrupt() 메서드가 호출되었는지 검사하기
		while(true) {
			System.out.println("스레드 작업 처리중 ......?");
/*			//검사방법1 => 스레드의 인스턴스 메서드를 이용하는 방법
			if(this.isInterrupted()) {
				System.out.println("인스턴스 메서드 호출됨...");
				break;
			}
		}
		System.out.println("스레드 작업종료");*/
			if(Thread.interrupted()) {
				System.out.println("정적 메서드 호출됨...!");
				break;
			}
		}
	}
}