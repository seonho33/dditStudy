package kr.or.ddit.basic;

public class T04ThreadTest {
	public static void main(String[] args) {
		
/*
	1~20억 까지의 합계를 구하는데 걸린 시간 체크하기
	전체 합계를 구하는 작업을 단일 스레드로 처리했을때와
	여러개의 스레드를 이용하여 작업을 처리했을 때의 시간을
	확인 해 보기
*/
	Thread th1 = new SumThread(1L,2000000000L);
	
	long startTime = System.currentTimeMillis();
	
	th1.start();
	
	try {
		th1.join();
	} catch (InterruptedException e) {
		e.printStackTrace();
	}
	
	long endTime = System.currentTimeMillis();
	
	System.out.println("단독으로 처리 했을 경우 시간(ms) : " + (endTime-startTime));
	
	SumThread[] sumThs = new SumThread[] {
		new SumThread(		   1L, 500000000L),	
		new SumThread( 500000001L, 1000000000L),	
		new SumThread(1000000001L, 1500000000L),	
		new SumThread(1500000001L, 2000000000L)	
	};
	
	startTime = System.currentTimeMillis();
	long sum = 0;
	for(SumThread sth : sumThs) {
		sth.start();
	}
	
	for(SumThread sth : sumThs) {
		try {
			sth.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sum += sth.getSum();
	}
	System.out.println("총 합 = " + sum);
	
	endTime = System.currentTimeMillis();
	
	System.out.println("여러개(4개)의 스레드로 처리했을 경우 시간(ms) : " + (endTime-startTime));
	}
}

/*
	범위값 합계를 구하기 위한 스레드
*/

class SumThread extends Thread{
	private long min, max, sum;
	
	public long getSum() {
		return sum;
	}

	public SumThread(long min, long max) {
		this.min = min;
		this.max = max;
	}
	
	@Override
	public void run() {
		for(long i=min; i<=max; i++) {
			this.sum += i;
		}
		System.out.println(min + " ~ " + max + " 까지의 합계 : " + sum);
	}
}