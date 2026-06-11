package kr.or.ddit.basic;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/*
	Lock객체를 이용한 동기화 예제
*/

public class T17LockAccountTest {
/*
	Lock (락) 기능을 제공하는 클래스
	
	ReentrantLock : Read 및 Write 작업 구분없이 사용하기 위한 락 클래스
					synchronized 를 이용한 동기화 처리보다 부가적인 기능을 제공함.
					ex) Fairness 설정 등 => 가장 오래 기다린 스레드가 가장 먼저
										  락을 획득하게 함..
*/
	
	
	public static void main(String[] args) {
		Lock lock = new ReentrantLock(true);
		
		LockAccount lA = new LockAccount(lock);
		
		lA.deposit(10000);
		
		BankThread2 bth = new BankThread2(lA);
		BankThread2 bth2 = new BankThread2(lA);
		
		
		bth.start();
		bth2.start();
		
	}
}

// 입출금을 담당하는 클래스

class LockAccount {
	
	private int balance;
	
	//Lock 객체 생성 => 되도록이면 private final 로 만든다.
	
	private final Lock lock;
	
	public LockAccount(Lock lock) {
		this.lock = lock;
	}

	//입금 메서드
	public void deposit(int money) {
/*		
		Lock 객체의 lock()메서드 호출이 동기화 시작이고,
		unlock()메서드 호출이 동기화의 끝을 나타낸다.
		
		lock()메서드로 동기화를 설정한 곳에서는 반드시
		unlock() 메서드로 해제해야한다.
*/		
		lock.lock();	// 락 설정
		balance += money; //동기화 처리 부분
		lock.unlock();	// 락 해제
		
	}
	
	//출금 메서드
	public boolean withdraw(int money) {
		boolean chk = false;
		
		//try ~catch 블럭에서 lock()을 사용할 경우에는
		//반드시 finally 부분에서 unlock()을 호출해 주어야 한다.
		
		try {
			lock.lock();	//락 설정
			
			if(balance >= money) {
				for(int i=1; i<=1000000000; i++) {}
				balance -= money;
				System.out.println("메서드 안에서 balance=" + getBalance());
				chk = true;
			}
		}catch(Exception e) {
			chk = false;
		}finally {
			lock.unlock();	//락 해제
		}
		return chk;
	}
	
	public int getBalance() {
		return balance;
	}
}


class BankThread2 extends Thread{
	private LockAccount lAcc;
	
	public BankThread2(LockAccount lAcc) {
		this.lAcc = lAcc;
	}
	
	@Override
	public void run() {
//		synchronized (lAcc) {
		boolean result = lAcc.withdraw(6000); //6000원 인출
		
		System.out.println("스레드 안에서 result=" + result + ", balance=" + lAcc.getBalance());
//		}
	}
}