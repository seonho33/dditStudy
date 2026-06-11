package kr.or.ddit.basic;

/*
	은행의 입출금 작업을 스레드로 처리하는 예제
	(synchronized 를 이용한 동기화 예제)
*/
public class T16SyncAccountTest {
	public static void main(String[] args) {
		
		SyncAccount sa = new SyncAccount();
		BankThread th1 = new BankThread(sa);
		BankThread th2 = new BankThread(sa);
		
		th1.start();
		th2.start();
		sa.deposit(10000);
		
	}
}

//은행의 입출금을 관리하기 위한 공유 클래스

class SyncAccount{
	private int balance; //잔액변수

	//입금 처리를 위한 메서드 작성
	public void deposit(int money) {
		balance += money;
	}

	//출금 처리를 위한 메서드 작성(출금성공: true, 출금실패 : false )
	public /*synchronized*/ boolean withdraw(int money) {
//			synchronized (this) {
				
		if(balance >= money) { //잔액이 충분한 경우..
			for(int i=1; i<=1000000000; i++) {}
				balance -= money;
				
				System.out.println("메서드 안에서 balance=" + getBalance());
				
				return true;
		}else {
			System.out.println("잔액이 부족합니다.");
			return false;
		}
//			}
	}	
	
	
	public int getBalance() {
		return balance;
	}
}

// 은행 업무를 처리하기 위한 스레드

class BankThread extends Thread{
	private SyncAccount sAcc;
	
	public BankThread(SyncAccount sAcc) {
		this.sAcc = sAcc;
	}
	
	@Override
	public void run() {
//		synchronized (sAcc) {
		boolean result = sAcc.withdraw(6000); //6000원 인출
		
		System.out.println("스레드 안에서 result=" + result + ", balance=" + sAcc.getBalance());
//		}
	}
}