package kr.or.ddit.basic;

public class T19WaitNotifyTest {
/*
	wait()메서드 => 동기화 영역에서 락을 풀고 Wait-Set영역 (공유객체 별 존재)으로
				  이동시킨다...
	
	notify()와 notifyAll() 메서드 => Wait-Set 영역에 있는 스레드를 깨워서
								   실행 가능한 상태로 만들어준다.
		(notify()는 하나, notifyAll()은 전체를 깨운다.

	==> wait()와 notify(), notifyAll()메서드는 동기화 영역에서만 실행할 수 있고,
		Object 클래스에서 제공하는 메서드이다.
		
*/
	public static void main(String[] args) {
		WorkObject wObj = new WorkObject();
		
		ThreadA thA = new ThreadA(wObj);
		ThreadB thB = new ThreadB(wObj);
		
		thA.start();
		thB.start();
	}
}

// 공유 객체용 클래스

class WorkObject {
	public synchronized void methodA() {
		System.out.println("methodA() 처리중 ...??");
		
		System.out.println(Thread.currentThread().getName()
						+ ": notify()호출" );
		notify();


		try {
		System.out.println(Thread.currentThread().getName()
							+ ": wait() 호출");
			wait();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		
	}
	
	public synchronized void methodB() {
		System.out.println("methodB() 처리중 ...!!");

		System.out.println(Thread.currentThread().getName()
							+ ": notify()호출" );
		notify();


		try {
			System.out.println(Thread.currentThread().getName()
								+ ": wait() 호출");
			wait();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}		
		
		}
	}

//WorkObject의 methodA()만 호출하는 스레드
class ThreadA extends Thread{
	private WorkObject wObj;
	
	public ThreadA(WorkObject wObj) {
		super("ThreadA");
		this.wObj = wObj;
	}
	
	@Override
	public void run() {
		for(int i=1;i<=10;i++) {
		wObj.methodA();
		}
		System.out.println("ThreadA 종료");
	}
}

//WorkObject의 methodB()만 호출하는 스레드
class ThreadB extends Thread{
	private WorkObject wObj;
	
	public ThreadB(WorkObject wObj) {
		super("ThreadB");
		this.wObj = wObj;
	}
	
	@Override
	public void run() {
		for(int i=1;i<=10;i++) {
				wObj.methodB();
		}
		System.out.println("ThreadB 종료");
	}
}