package kr.or.ddit.basic;

public class T09ThreadDaemonTest {
	public static void main(String[] args) {
		AutoSaveThread th1 = new AutoSaveThread();
		
		//데몬 스레드로 설정하기(start() 메서드 호출 전에 설정해야한다.)
		
		th1.setDaemon(true);
		
		th1.start();
		
		for(int i=1; i<=20; i++) {
			System.out.println("작업중"+i);
			
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("메인 스레드 작업 종료...");
	}
}


/*
	자동 저장기능을 제공하는 스레드(3초에 한번씩 저장)
*/
class AutoSaveThread extends Thread{

	
	@Override
	public void run() {
		while(true) {
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			save();//
		}
	}
	
	private void save() {
		System.out.println("작업 내용을 저장합니다.");
	}
}