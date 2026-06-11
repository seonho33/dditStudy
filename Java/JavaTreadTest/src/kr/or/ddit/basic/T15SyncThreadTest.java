package kr.or.ddit.basic;

public class T15SyncThreadTest {
	public static void main(String[] args) {
		
		ShareObject sObj = new ShareObject();
		
		WorkThread th1 = new WorkThread("1번스레드", sObj);
		WorkThread th2 = new WorkThread("2번스레드", sObj);
		
		th1.start();
		th2.start();
		
	}
}

//공유 객체 클래스
class ShareObject{
	private int sum;
	
//		동기화 하는 방법 1 : 메서드 자체에 동기화 설정하기..
//		public synchronized void add() {
		public void add() {
		
		for(int i=0;i<1000000000;i++) {}	//시간벌기용
		
		// 동기화 하는 방법 2 : 동기화 블럭으로 처리하기
		// mutex : Mutual exclusion Object(상호배재 : 동시 접근 차단)
		
		//	synchronized (this) {
			
				int n = sum;
				n += 10;
				sum = n;
			
				System.out.println((Thread.currentThread()).getName() + "합계: " + sum);
			}
		
//		}
	
	public int getSum() {
		return sum;
	}
	
}

//작업 수행을 위한 스레드
class WorkThread extends Thread {
	private ShareObject sObj;
	
	public WorkThread(String name,ShareObject sObj) {
		super(name);
		this.sObj = sObj;
	}
	
	@Override
	public void run() {
		for(int i=1; i<=10; i++) {
			synchronized (sObj) {
			sObj.add();
			}
		}
	}
}