package kr.or.ddit.basic;

public class T10ThreadStateTest {
/*
	스레드의 상태에 대하여...
	
 - NEW : 스레드가 생성되고 아직 start()가 호출되지 않은 상태
 - RUNNERBLE : 실행 중 또는 실행 가능한 상태
 - BLOCKED : 동기화 블럭에 의해서 일시정지된 상태(LOCK 이 풀릴때까지 기다리는 상태)
 - WAITTING, TIMED_WAITING : 스레드의 작업이 종료되지는 않았지만 일시정지된 상태
 				   TIMED_WAITING 상태는 일시정지 시간이 지정된 경우임.
 - TERMINATED : 스레드의 작업이 종료된 상태
 
*/
	public static void main(String[] args) {
		Thread th1 = new TargetThread();
		StatePrintThread th2 = new StatePrintThread(th1);
		th2.start();
	
	}
}

//Target 스레드

class TargetThread extends Thread {
	
	@Override
	public void run() {
		for(long i =1; i<=100000L; i++) {
			for(long j =i;j>=0;j--) {
				
			}
		}
			try {
				Thread.sleep(1500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

//스레드의 상태를 출력하기 위한 스레드

class StatePrintThread extends Thread {
	private Thread target;
	
	public StatePrintThread(Thread target) {
		this.target = target;
	}
	
	@Override
	public void run() {
		while(true) {
			//스레드의 상태값 가져오기
			Thread.State state = target.getState();
			System.out.println("타겟 스레드의 상태값 : " + state);
			//NEW 상태인지 체크
			if(state==Thread.State.NEW) {
				target.start();
			}else if(state == Thread.State.TERMINATED) {
				System.out.println("시스템재시작");
			}
			
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

