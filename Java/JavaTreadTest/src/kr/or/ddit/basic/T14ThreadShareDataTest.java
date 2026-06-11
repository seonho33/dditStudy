package kr.or.ddit.basic;

public class T14ThreadShareDataTest {
/*	
	원주율을 계산하는 스레드가 있고, 계산된 원주율을 출력하는 스레드가 있다.
	원주율 계산이 완료되면 이 값을 출력하는 프로그램을 작성하시오
	(이때 원주율 관련 데이터를 저장하기 위한 공유 객체가 필요하다)
*/	
	
	public static void main(String[] args) {
		ShareDataThread sdt = new ShareDataThread();
		
		CalcPIThread th1 = new CalcPIThread(sdt);
		PrintPiThread th2 = new PrintPiThread(sdt);
		
		th1.start();
		th2.start();
	}
}


//원주율 데이터를 관리하기위한 클래스(공유객체 생성용)
class ShareDataThread extends Thread {
	private double result;				// 원주율이 저장될 변수
	volatile private boolean isOk;		// 원주율 계산이 완료되었는지 저장하기위한 변수

/*	
	volatile => 선언된 변수를 컴파일러의 최적화 대상에서 제외시킨다.
				즉, 값이 변경되는 즉시 변수에 적용시킨다.
				멀티스레드 환경에서 '최신값을 메인메모리에서 읽도록'
				보장하는 키워드(일종의 동기화)
*/	
	
	public double getResult() {
		return result;
	}
	public void setResult(double result) {
		this.result = result;
	}
	public boolean isOk() {
		return isOk;
	}
	public void setOk(boolean isOk) {
		this.isOk = isOk;
	}
}

//원주율 계산을 위한 스레드
class CalcPIThread extends Thread{
	private ShareDataThread sdt;
	
	public CalcPIThread(ShareDataThread sdt) {
		this.sdt = sdt;
	}
	
	@Override
	public void run() {
/*
		원주율 = (1/1-1/3+1/5-1/7+1/9 ...)*4;
				 1   3   5   7   9  => 분모값
				 0   1   2   3   4  => 분모값을 2로 나눴을때의 몫
*/
		double sum =0.0;
		for(int i=1; i<15000000; i+=2) {
			if(((i/2)%2)==0) {
				sum += (1.0/i);
			}else {
				sum -= (1.0/i);
			}
		}
		sum = sum*4;
		sdt.setResult(sum);
		sdt.setOk(true);
	}
}

//현재 원주율을 출력하기 위한 스레드
class PrintPiThread extends Thread {
	private ShareDataThread sdt;
	
	public PrintPiThread(ShareDataThread sdt) {
		this.sdt = sdt;
	}

	@Override
	public void run() {
		while(true) {
			//원주율 계산이 완료될때까지 기다린다.
			if(sdt.isOk()) {
				break;
			}
		}
		System.out.println();
		System.out.println("계산된 원주율 : " + sdt.getResult());
		System.out.println("       PI :" + Math.PI);
	}
}